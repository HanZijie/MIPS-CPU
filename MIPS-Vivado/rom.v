`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 19:04:24
// Design Name: 
// Module Name: rom
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


module rom 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10) (
	
	input [(ADDR_WIDTH-1):0] read_addr,  
	output  [(DATA_WIDTH-1):0] data ) ;

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[512:0];
	
    initial begin
        $readmemh("C:/b.txt",rom);
    end
	assign	data = rom[read_addr];                         // read
endmodule

