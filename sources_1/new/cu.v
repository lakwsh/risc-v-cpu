`timescale 1ns / 1ps

module CU(
    input [6:0] opcode,
    input [2:0] func3,
    input func7,
    input c,                 //ALU 是否满足B类指令的跳转条件
    output [1:0] pcs,        //PC  下一条指令地址来源方式  00=顺序执行 01=条件跳转 10=jal 11=jalr
    output rwe,              //Reg 写使能端
    output mwe,              //Ram 写使能端
    output [2:0] ramop,      //Ram 读写控制方式
    output [3:0] aluop,      //ALU 运算类型
    output isimm,            //ALU b是否是立即数
    output is20,             //ALU b是否是20位立即数
    output isfpc,            //ALU a是否来源pc
    output isfm,             //Reg wdata是否来源于mem
    output ispc4             //Reg wdata是否来源于pc+4
);
    wire R,I,S,B,U,J;
    IDT myidt(opcode,R,I,S,B,U,J);      //指令类型识别

    assign pcs={J,c&B} | {2{I&opcode[6]}};      //opcode[6]=1=>jmp
    assign rwe=R|I|J;
    assign mwe=S;
    assign ramop={3{I}}&({1'b0,func3[1:0]}+(3'b011&{3{func3[2]}})) |    //func3[2]=unsigned func3[1:0]=type
                 {3{S}}&(func3+3'b101);
    wire [3:0] b_aluop;
    assign b_aluop={4{~|func3[2:1]}}&{3'b100,func3[0]} |        //beq/bne
                   {4{func3[2]}}&{1'b0,func3[2:1],~func3[0]};   //blt/bltu/bge/bgeu
    assign aluop={4{R}}&{func3,func7}                                       |   //R
                 {4{U}}&{2'b11,opcode[5:4]}                                 |   //U
                 {4{I&opcode[4]}}&{func3,func3[2]&~func3[1]&func3[0]&func7} |	//imm  func3=101(srl/sra)
                 {4{I&~opcode[4]}}&4'b0000                                  |   //load add
                 {4{B}}&b_aluop;                                                //B
    assign isimm=~(R|B);
    assign is20=U|J;
    assign isfpc=U&~opcode[5];          //auipc
    assign isfm=~opcode[4]&(I|S);       //opcode[4]=0=>mem
    assign ispc4=J | I&opcode[6];       //jal/jalr

    initial
        $monitor($time,,"cu pcs=%b ramop=%b aluop=%b",pcs,ramop,aluop);
endmodule