`timescale 1ns / 1ps

module Regs(
    input clk,                  //时钟脉冲
    input [4:0] raddr1,         //源寄存器号1
    input [4:0] raddr2,         //源寄存器号2
    output [31:0] rdata1,       //寄存器1数据
    output [31:0] rdata2,       //寄存器2数据
    input we,                   //写使能
    input [4:0] waddr,          //目的寄存器号
    input [31:0] wdata          //写入数据
);
    reg [31:0] regs[1:31];
    assign rdata1=(raddr1==5'b0)?32'b0:regs[raddr1];    //x0=0
    assign rdata2=(raddr2==5'b0)?32'b0:regs[raddr2];
    always @(posedge clk)
        if(we && waddr!=5'b0) regs[waddr]<=wdata;       //非阻塞, 丢弃写入到x0的数据

    initial
        $monitor($time,,"reg r1=%d data1=%h r2=%d data2=%h",raddr1,rdata1,raddr2,rdata2);
    initial
        $monitor($time,,"reg write addr=%d data=%h",waddr,wdata);
endmodule