`timescale 1ns / 1ps

module ID(
    input [31:0] ins,           //操作码
    output [6:0] opcode,
    output [2:0] func3,
    output func7,
    output [4:0] rd,            //目的寄存器
    output [4:0] rs1,           //源寄存器1(alu-a)
    output [4:0] rs2,           //源寄存器2(alu-b)
    output [11:0] imm12,        //12位立即数
    output [19:0] imm20         //20位立即数
);
    assign opcode=ins[6:0];
    assign func3=ins[14:12];
    assign func7=ins[30];
    assign rd=ins[11:7];
    assign rs1=ins[19:15];
    assign rs2=ins[24:20];

    wire R,I,S,B,U,J;
    IDT myidt(opcode,R,I,S,B,U,J);      //指令类型识别

    assign imm12={12{I}}&ins[31:20] |                                   //11:0
                 {12{S}}&{ins[31:25],ins[11:7]} |                       //11:5 4:0
                 {12{B}}&{ins[31],ins[7],ins[30:25],ins[11:8]};         //12 10:5 4:1 11
    assign imm20={20{U}}&ins[31:12] |                                   //31:12
                 {20{J}}&{ins[31],ins[19:12],ins[20],ins[30:21]};       //20 10:1 11 19:12

    initial
        $monitor($time,,"id ins=%h i12=%h i20=%h rd=%d rs1=%d rs2=%d",ins,imm12,imm20,rd,rs1,rs2);
endmodule