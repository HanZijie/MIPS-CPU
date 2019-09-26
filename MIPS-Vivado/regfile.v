`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 19:06:49
// Design Name: 
// Module Name: regfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile
(
	input [4:0] R1_in,
	input [4:0] R2_in,
	input [4:0] W,
	input [31:0] Din,
	input RegWrite,
	input clk,
	output  [31:0] R1,
	output  [31:0] R2
);
	reg [31:0] regfile [0:31];
    initial begin
    regfile[0]=32'h00000000;
    regfile[1]=32'h00000000;
    regfile[2]=32'h00000000;
    regfile[3]=32'h00000000;
    regfile[4]=32'h00000000;
    regfile[5]=32'h00000000;
    regfile[6]=32'h00000000;
    regfile[7]=32'h00000000;
    regfile[8]=32'h00000000;
    regfile[9]=32'h00000000;
    regfile[10]=32'h00000000;
    regfile[11]=32'h00000000;
    regfile[12]=32'h00000000;
    regfile[13]=32'h00000000;
    regfile[14]=32'h00000000;
    regfile[15]=32'h00000000;
    regfile[16]=32'h00000000;
    regfile[17]=32'h00000000;
    regfile[18]=32'h00000000;
    regfile[19]=32'h00000000;
    regfile[20]=32'h00000000;
    regfile[21]=32'h00000000;
    regfile[22]=32'h00000000;
    regfile[23]=32'h00000000;
    regfile[24]=32'h00000000;
    regfile[25]=32'h00000000;
    regfile[26]=32'h00000000;
    regfile[27]=32'h00000000;
    regfile[28]=32'h00000000;
    regfile[29]=32'h00000000;
    regfile[30]=32'h00000000;
    regfile[31]=32'h00000000;
    end
    assign R1 = regfile [R1_in];
    assign R2 = regfile [R2_in];
	always @(negedge clk)
	begin
	   if((RegWrite==1) && (W!=32'b0)) regfile[W]<=Din;
	end
endmodule

