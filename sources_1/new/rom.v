`timescale 1ns / 1ps

module Rom(
    input [31:0] addr,          //指令地址
    output reg [31:0] ins       //字节码
); //硬编码(使用工具Jupiter)
    always @(*)
        case (addr[31:2]) //对齐
            //平方数
            30'd0: ins=32'h04002083;    //lw x1,x0,64
            30'd1: ins=32'h00008133;    //add x2,x1,x0
            30'd2: ins=32'h000001b3;    //add x3,x0,x0
            30'd3: ins=32'h002181b3;    //add x3,x3,x2 (loop)
            30'd4: ins=32'hfff08093;    //addi x1,x1,-1
            30'd5: ins=32'hfe104ce3;    //blt x0,x1,loop
            30'd6: ins=32'h08302023;    //sw x0,x3,128
//            //37条指令
//            //reg
//            30'd0: ins=32'h04200093;    //addi x1,x0,66     x1=66
//            30'd1: ins=32'hfe608113;    //addi x2,x1,-26    x2=40
//            30'd2: ins=32'h001101b3;    //add x3,x2,x1      x3=106
//            30'd3: ins=32'h40208233;    //sub x4,x1,x2      x4=26
//            30'd4: ins=32'h0040f2b3;    //and x5,x1,x4      x5=2
//            30'd5: ins=32'h0040e333;    //or x6,x1,x4       x6=90
//            30'd6: ins=32'h0040c3b3;    //xor x7,x1,x4      x7=88
//            30'd7: ins=32'h00121433;    //sll x8,x4,x1(5b)  x8=104
//            30'd8: ins=32'h001254b3;    //srl x9,x4,x1      x9=6
//            30'd9: ins=32'hfa800213;    //addi x4,x0,-88    x4=-88
//            30'd10: ins=32'h40125533;   //sra x10,x4,x1      x10=-22
//            30'd11: ins=32'h001221b3;   //slt x3,x4,x1      x3=1
//            30'd12: ins=32'h001231b3;   //sltu x3,x4,x1      x3=0
//            30'd13: ins=32'h00657593;   //andi x11,x10,6    x11=2
//            30'd14: ins=32'hff056613;   //ori x12,x10,-16   x12=-6
//            30'd15: ins=32'hfa154693;   //xori x13,x10,-95  x13=75
//            30'd16: ins=32'hfff52193;    //slti x3,x10,-1       x3=1
//            30'd17: ins=32'h00153193;    //sltiu x3,x10,1       x3=0
//            30'd18: ins=32'h00421893;    //slli x17,x4,4        x17=-1408
//            30'd19: ins=32'h00345913;    //srli x18,x8,3        x18=13
//            30'd20: ins=32'h40125993;    //srai x19,x4,1        x19=-44
//            //mem
//            30'd21: ins=32'h0115a123;    //sw x11,x17,2     [4]=-1408
//            30'd22: ins=32'h00458323;    //sb x11,x4,6      [8]=168
//            30'd23: ins=32'hfe859f23;    //sh x11,x8,-2     [0]=104
//            30'd24: ins=32'hffe4a183;   //lw x3,x9,-2       x3=-1408
//            30'd25: ins=32'h00248183;   //lb x3,x9,2        x3=-88
//            30'd26: ins=32'hffa49183;   //lh x3,x9,-6       x3=104
//            30'd27: ins=32'hffe4c183;   //lbu x3,x9,-2      x3=128
//            30'd28: ins=32'hffe4d183;   //lhu x3,x9,-2      x3=64128
//            //U
//            30'd29: ins=32'h1e240a37;   //lui x20,123456    x20=0x1e240000
//            30'd30: ins=32'h1e240a97;   //auipc x21,123456  x21=0x1e240078
//            //jmp
//            30'd31: ins=32'h01c40b67;   //jalr x22,x8,28
//            30'd33: ins=32'hffdffbef;   //jal x23,-4
//            //B
//            30'd32: ins=32'h00558463;   //beq x11,x5,8
//            30'd34: ins=32'h01289463;   //bne x17,x18,8
//            30'd36: ins=32'hff28cee3;   //blt x17,x18,-4
//            30'd35: ins=32'h01196463;   //bltu x18,x17,8
//            30'd37: ins=32'h00005463;   //bge x0,x0,8
//            30'd39: ins=32'h00927463;   //bgeu x4,x9,8
//            //IO
//            30'd41: ins=32'h04002e03;   //lw x28,x0,1000000b
//            30'd42: ins=32'h08a02023;   //sw x0,x10,10000000b
            default: ins=32'hx;
        endcase
endmodule