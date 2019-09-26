`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 19:06:11
// Design Name: 
// Module Name: ram
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


module ram 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10) (
	
	input [(ADDR_WIDTH-1):0] addr,  
	input [(DATA_WIDTH-1):0] data_in,
	input MemWrite,
	input clk,
	input load,
	output   [(DATA_WIDTH-1):0] data_out ) ;
    reg [10:0]i;
	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	initial begin
	   for(i=0;i<2**ADDR_WIDTH;i=i+1)
	   begin
	   ram[i]=32'h00000000;
	   end
	end
	assign data_out = ram[addr];
	always @(posedge clk)begin
        if(MemWrite==1) ram[addr]<=data_in;
    end
endmodule

