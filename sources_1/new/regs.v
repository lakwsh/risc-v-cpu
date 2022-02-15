`timescale 1ns / 1ps

module Regs(
    input clk,                  //ʱ������
    input [4:0] raddr1,         //Դ�Ĵ�����1
    input [4:0] raddr2,         //Դ�Ĵ�����2
    output [31:0] rdata1,       //�Ĵ���1����
    output [31:0] rdata2,       //�Ĵ���2����
    input we,                   //дʹ��
    input [4:0] waddr,          //Ŀ�ļĴ�����
    input [31:0] wdata          //д������
);
    reg [31:0] regs[1:31];
    assign rdata1=(raddr1==5'b0)?32'b0:regs[raddr1];    //x0=0
    assign rdata2=(raddr2==5'b0)?32'b0:regs[raddr2];
    always @(posedge clk)
        if(we && waddr!=5'b0) regs[waddr]<=wdata;       //������, ����д�뵽x0������

    initial
        $monitor($time,,"reg r1=%d data1=%h r2=%d data2=%h",raddr1,rdata1,raddr2,rdata2);
    initial
        $monitor($time,,"reg write addr=%d data=%h",waddr,wdata);
endmodule