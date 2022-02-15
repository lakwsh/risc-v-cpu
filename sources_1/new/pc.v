`timescale 1ns / 1ps

module PC(
    input rst,                  //复位信号
    input clk,                  //时钟脉冲
    input [31:0] next,          //下条指令地址
    output reg [31:0] addr	//当前指令地址
);
    always @(posedge clk)
        if(rst) addr<=32'h0;
        else addr[31:1]<=next[31:1];

    initial
        $monitor($time,,"pc addr=%h next=%h",addr,next);
endmodule