`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 19:12:00
// Design Name: 
// Module Name: shifter
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


module shifter
#(parameter DATA_WIDTH=32)
(
	input [DATA_WIDTH-1:0] data_in,
	output [DATA_WIDTH-1:0] data_out
);

assign data_out[1:0]=2'b0;
assign data_out[DATA_WIDTH-1:2]=data_in[DATA_WIDTH-3:0];
endmodule
