`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 19:08:02
// Design Name: 
// Module Name: counter
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


module counter
(
	input en,
	input clk,
	input rst,
	output reg [15:0] out
);
    initial begin
        out = 0;
    end
	always @(posedge clk)
	begin
	if(rst==1) out<=0;
	else begin
	if(en==1) out<=out+1;
	if(out==16'hffff) out<=0;
	end
	end
endmodule

