`timescale 100ns / 1ps

module CPU(
    input clk,              //ʱ������
    input rst,              //��λ�ź�
    input [3:0] switch,     //n
    output [7:0] result     //f(n)
);
    //����wire���ߣ��������Ӹ���ģ��
    wire [31:0] next,ip,ins,rdata1,rdata2,pc4,f,mdata,imm,tmp,jmp;
    wire [19:0] imm20;
    wire [11:0] imm12;
    wire [6:0] opcode;
    wire [4:0] rd,rs1,rs2;
    wire [3:0] aluop;
    wire [2:0] func3,ramop;
    wire [1:0] pcs;
    wire func7,c,rwe,mwe,isimm,is20,isfpc,isfm,ispc4;

    //ʵ����PC
    PC mypc(.rst(rst),.clk(clk),.next(next),.addr(ip));
    //ʵ����ROM
    Rom myrom(.addr(ip),.ins(ins));
    //ʵ����ָ��������
    ID myid(.ins(ins),.opcode(opcode),.func3(func3),.func7(func7),.rd(rd),.rs1(rs1),.rs2(rs2),.imm12(imm12),.imm20(imm20));
    //ʵ�������Ƶ�Ԫ
    CU mycu(
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .c(c),
        .pcs(pcs),
        .rwe(rwe),
        .mwe(mwe),
        .ramop(ramop),
        .aluop(aluop),
        .isimm(isimm),
        .is20(is20),
        .isfpc(isfpc),
        .isfm(isfm),
        .ispc4(ispc4)
    );
    assign pc4=ip+4;
    //ʵ�����Ĵ�����
    Regs myregs(
        .clk(clk),
        .raddr1(rs1),
        .raddr2(rs2),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .we(rwe),
        .waddr(rd),
        .wdata(ispc4?pc4:(isfm?mdata:f))
    );
    assign imm=is20?{{12{imm20[19]}},imm20}:{{20{imm12[11]}},imm12};    //������չ��32bit
    //ʵ����ALU
    ALU myalu(.a(isfpc?ip:rdata1),.b(isimm?imm:rdata2),.op(aluop),.f(f),.c(c));
    //ʵ����IOManager
    assign result=tmp[7:0];     //f(n)
    IOManger myio(.clk(clk),.op(ramop),.addr(f),.we(mwe),.wdata(rdata2),.rdata(mdata),.switch(switch),.result(tmp));
    assign jmp=ip+(imm<<1);     //����
    assign next=pcs[1]?(pcs[0]?f:jmp):(pcs[0]?jmp:pc4); //����pcsѡ������ָ���ַ��Դ
endmodule