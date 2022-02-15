`timescale 1ns / 1ps

module Ram(
    input clk,          //时钟脉冲
    input [5:0] addr,   //对齐
    input [31:0] wdata, //写入数据
    input we,           //写使能
    output [31:0] rdata //读出数据
);
    reg [31:0] data[0:15];              //4B*16=64B
    assign rdata=data[addr[5:2]];       //2^4=16
    always @(posedge clk)
        if(we) data[addr[5:2]]<=wdata;

//    initial
//        $monitor($time,,"ram we=%b wdata=%h",we,wdata);
endmodule