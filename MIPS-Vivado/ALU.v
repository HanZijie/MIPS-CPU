`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 16:06:55
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 -&File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
   input  [3:0]AluOP,
   input [31:0]A,
   input [31:0]B,
   input [4:0]shamt,
   input clk,
 // output wire equal,
  //output wire [31:0]R
  output  equal,
  output reg [31:0]R
    );
        initial begin
    R=0;
    end
    /*
    x=a,y=b;
    0000	0	Result = X << Y   �߼����� ��Yȡ����λ��  Result2=0
    0001	1	Result = X >>>Y  �������� ��Yȡ����λ��  Result2=0
    0010	2	Result = X >> Y   �߼����� ��Yȡ����λ��  Result2=0
    0011	3	Result = (X * Y)[31:0];  Result2 = (X * Y)[63:32] �޷��ų˷�
    0100	4	Result = X/Y;   Result2 = X%Y  �޷��ų���
    0101	5	Result = X + Y    (Set&OF/UOF)
    0110	6	Result = X - Y    (Set&OF/UOF)
    0111	7	Result = X & Y   ��λ��
    1000	8	Result = X | Y    ��λ��
    1001	9	Result = X?Y    ��λ���
    1010	10	Result =&~(X |Y)  ��λ���
    1011	11	Result = (X < Y) ? 1 : 0 ���űȽ�
    1100	12	Result = (X < Y) ? 1 : 0 �޷��űȽ�
    */
    wire signed[31:0]a;
    wire signed[31:0]b;
    assign equal=(A==B)?1:0;
    
    /*
        assign R = (AluOP==4'b0000)?A<<B:0;
    assign R = (AluOP==4'b0001)?A>>>B:0;
    assign R = (AluOP==4'b0010)?A>>B:0;
    assign R = (AluOP==4'b0011)?A*B:0;
    assign R = (AluOP==4'b0100)?A/B:0;
    assign R = (AluOP==4'b0101)?(A+B):0;
    assign R = (AluOP==4'b0110)?A-B:0;
    assign R = (AluOP==4'b0111)?A&B:0;
    assign R = (AluOP==4'b1000)?A|B:0;
    assign R = (AluOP==4'b1001)?A^B:0;
    assign R = (AluOP==4'b1010)?~(A|B):0;
    assign R = (AluOP==4'b1011)?((a<b)?1:0):0;
    assign R = (AluOP==4'b1100)?((A<B)?1:0):0;
    */
   // assign R = (AluOP==4'b0000)?A<<B:(AluOP==4'b0001)?A>>>B:(AluOP==4'b0010)?A>>B:(AluOP==4'b0011)?A*B:(AluOP==4'b0100)?A/B:(AluOP==4'b0101)?(A+B):(AluOP==4'b0110)?A-B:(AluOP==4'b0111)?A&B:(AluOP==4'b1000)?A|B:(AluOP==4'b1001)?A^B:(AluOP==4'b1010)?~(A|B):(AluOP==4'b1011)?((a<b)?1:0):(AluOP==4'b1100)?((A<B)?1:0):0;
    
    always @(A or B or AluOP or shamt) begin
    case(AluOP)
        4'b0000: R=B<<shamt;//�߼�����
        4'b0001: R=$signed(B)>>>A;//�������� 
        4'b0010: R=B>>shamt;//�߼�����
        4'b0011: R = A*B;//�޷��ų˷�
        4'b0100: R=A/B;//�޷��ų���
        4'b0101: R=A+B;//X + Y
        4'b0110: R=A-B;//X - Y
        4'b0111: R=A&B;//X & Y 
        4'b1000: R=A|B;//��λ��
        4'b1001: R=A^B;//��λ���
        4'b1010: R=~(A|B);//��λ���
        4'b1011: R=($signed(A)<$signed(B))?1:0;//���űȽ�
        4'b1100: R=(A<B)?1:0;//�޷��űȽ�
        default: begin
                  R = A+B;
                  end
    endcase
    end
endmodule
