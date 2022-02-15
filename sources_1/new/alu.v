`timescale 1ns / 1ps

module ALU(
    input [31:0] a,         //运算值a
    input [31:0] b,         //运算值b
    input [3:0] op,         //指令
    output reg [31:0] f,    //结果
    output c                //是否满足跳转条件
);
    assign c=~(|f);
    always @(*)
        case(op)
            //func3+func7
            4'b0000: f=a+b;									//add
            4'b0001: f=a-b;                                 //sub
            4'b0010: f=a<<b[4:0];                           //sll
            4'b0100: f=$signed(a)<$signed(b)?32'b1:32'b0;   //slt/bge
            4'b0110: f=a<b?32'b1:32'b0;                     //sltu/bgeu
            4'b1000: f=a^b;                                 //xor/beq
            4'b1010: f=a>>b[4:0];                           //srl
            4'b1011: f=$signed(a)>>>b[4:0];                 //sra
            4'b1100: f=a|b;                                 //or
            4'b1110: f=a&b;                                 //and
            //11+opcode[5:4]
            4'b1101: f=a+(b<<12);                           //auipc
            4'b1111: f=b<<12;                               //lui
            //B-type
            4'b1001: f={31'b0,~|(a^b)};                     //bne
            4'b0101: f=$signed(a)>=$signed(b)?32'b1:32'b0;  //blt
            4'b0111: f=a>=b?32'b1:32'b0;                    //bltu
            default: f=32'bx;
        endcase

    initial
        $monitor($time,,"alu op=%b f=%h a=%h b=%h c=%b",op,f,a,b,c);
endmodule