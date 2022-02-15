`timescale 1ns / 1ps

module PC(
    input rst,                  //��λ�ź�
    input clk,                  //ʱ������
    input [31:0] next,          //����ָ���ַ
    output reg [31:0] addr	//��ǰָ���ַ
);
    always @(posedge clk)
        if(rst) addr<=32'h0;
        else addr[31:1]<=next[31:1];

    initial
        $monitor($time,,"pc addr=%h next=%h",addr,next);
endmodule