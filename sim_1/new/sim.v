`timescale 1ns / 1ps

module sim( );
    reg clk=1'b0,rst=1'b0;
    always #5
        clk=~clk;       //模拟时钟脉冲
    initial
    begin
        #4 rst=1'b1;    //模拟按下复位键
        #2 rst=1'b0;
    end
    reg[3:0] n=4'b1111; //取n为15
    wire[7:0] result;
    CPU mycpu(.clk(clk),.rst(rst),.switch(n),.result(result));
endmodule