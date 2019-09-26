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
	reg [DATA_WIDTH-1:0] rom[255:0];

	initial begin
        rom[0] = 32'h20110001;
        rom[1] = 32'h08000c05;
        rom[2] = 32'h20110001;
        rom[3] = 32'h20120002;
        rom[4] = 32'h20130003;
        rom[5] = 32'h08000c09;
        rom[6] = 32'h20110001;
        rom[7] = 32'h20120002;
        rom[8] = 32'h20130003;
        rom[9] = 32'h08000c0d;
        rom[10] = 32'h20110001;
        rom[11] = 32'h20120002;
        rom[12] = 32'h20130003;
        rom[13] = 32'h08000c11;
        rom[14] = 32'h20110001;
        rom[15] = 32'h20120002;
        rom[16] = 32'h20130003;
        rom[17] = 32'h0c000c14;
        rom[18] = 32'h2002000a;
        rom[19] = 32'h0000000c;
        rom[20] = 32'h20100000;
        rom[21] = 32'h22100001;
        rom[22] = 32'h00102020;
        rom[23] = 32'h20020022;
        rom[24] = 32'h0000000c;
        rom[25] = 32'h22100002;
        rom[26] = 32'h00102020;
        rom[27] = 32'h20020022;
        rom[28] = 32'h0000000c;
        rom[29] = 32'h22100003;
        rom[30] = 32'h00102020;
        rom[31] = 32'h20020022;
        rom[32] = 32'h0000000c;
        rom[33] = 32'h22100004;
        rom[34] = 32'h00102020;
        rom[35] = 32'h20020022;
        rom[36] = 32'h0000000c;
        rom[37] = 32'h22100005;
        rom[38] = 32'h00102020;
        rom[39] = 32'h20020022;
        rom[40] = 32'h0000000c;
        rom[41] = 32'h22100006;
        rom[42] = 32'h00102020;
        rom[43] = 32'h20020022;
        rom[44] = 32'h0000000c;
        rom[45] = 32'h22100007;
        rom[46] = 32'h00102020;
        rom[47] = 32'h20020022;
        rom[48] = 32'h0000000c;
        rom[49] = 32'h22100008;
        rom[50] = 32'h00102020;
        rom[51] = 32'h20020022;
        rom[52] = 32'h20020022;
        rom[53] = 32'h0000000c;
        rom[54] = 32'h03e00008;
    end

	assign	data = rom[read_addr];                         // read
endmodule

