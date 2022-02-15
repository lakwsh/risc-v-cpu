`timescale 1ns / 1ps

module Ram(
    input clk,          //ʱ������
    input [5:0] addr,   //����
    input [31:0] wdata, //д������
    input we,           //дʹ��
    output [31:0] rdata //��������
);
    reg [31:0] data[0:15];              //4B*16=64B
    assign rdata=data[addr[5:2]];       //2^4=16
    always @(posedge clk)
        if(we) data[addr[5:2]]<=wdata;

//    initial
//        $monitor($time,,"ram we=%b wdata=%h",we,wdata);
endmodule