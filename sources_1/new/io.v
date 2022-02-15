`timescale 1ns / 1ps

module IOManger(
    input clk,                  //ʱ������
    input [2:0] op,             //ָ��
    input [7:0] addr,           //��ַ addr[6]=1(����) addr[7]=1(���)
    input we,                   //дʹ��
    input [31:0] wdata,         //д������
    output [31:0] rdata,        //��������
    input [3:0] switch,         //���� n
    output reg [31:0] result    //��� f(n)
);
    wire lb,lh,lw,lbu,lhu,sb,sh,sw;
    //����ָ����ʶ��ָ��
    assign lb=~(|op);               //000
    assign lh=~(|op[2:1])&op[0];    //001
    assign lw=~op[2]&op[1]&~op[0];  //010
    assign lbu=~op[2]&(&op[1:0]);   //011
    assign lhu=op[2]&~(|op[1:0]);   //100
    assign sb=op[2]&~op[1]&op[0];   //101
    assign sh=(&op[2:1])&~op[0];    //110
    assign sw=&op;                  //111

    wire [31:0] data,tmp;
    assign data=({24'b0,{8{sb}}}|{16'b0,{16{sh}}}|{32{sw}})&wdata;  //0-extend
    always @(posedge clk)
        if(we&&addr[7]) result<=wdata;  //led

    //ʵ����RAM
    Ram myram(.clk(clk),.addr(addr),.wdata(data),.we(~(|addr[7:6])&we),.rdata(tmp));

    //����ָ�����ʹ����������
    assign rdata=addr[6]?{28'b0,switch}:(
                 {32{lb}}&{{24{tmp[7]}},tmp[7:0]}       |       //8bit  ������չ
                 {32{lh}}&{{16{tmp[15]}},tmp[15:0]}     |       //16bit ������չ
                 {32{lw}}&tmp                           |       //32bit ���账��
                 {32{lbu}}&{24'b0,tmp[7:0]}             |       //8bit  0��չ
                 {32{lhu}}&{16'b0,tmp[15:0]});                  //16bit 0��չ

    initial
        $monitor($time,,"io addr=%h op=%b rdata=%h",addr,op,rdata);
endmodule