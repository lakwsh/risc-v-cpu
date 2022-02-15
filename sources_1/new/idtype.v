`timescale 1ns / 1ps

module IDT(
    input [6:0] opcode,
    output R,I,S,B,U,J
);
    //0110011 R
    assign R=~opcode[6]&(&opcode[5:4])&~(|opcode[3:2])&(&opcode[1:0]);
    //00x0011 I
    //1100111 jalr
    assign I=(~(|opcode[6:5])&~(|opcode[3:2])&(&opcode[1:0])) |
             ((&opcode[6:5])&~(|opcode[4:3])&(&opcode[2:0]));   //jalr
    //0100011 S
    assign S=~opcode[6]&opcode[5]&~(|opcode[4:2])&(&opcode[1:0]);
    //1100011 B
    assign B=(&opcode[6:5])&~(|opcode[4:2])&(&opcode[1:0]);
    //0x10111 U
    assign U=~opcode[6]&opcode[4]&~opcode[3]&(&opcode[2:0]);
    //1101111 J
    assign J=(&opcode[6:5])&~opcode[4]&(&opcode[3:0]);
endmodule