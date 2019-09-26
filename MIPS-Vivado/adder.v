`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/05 11:33:50
// Design Name: 
// Module Name: adder
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



module add(a,b,c,g,p,s);
	input wire  a,b,c;
	output wire g,p,s;
	assign s = a^b^c;
	assign g = a & b;
	assign p = a | b;
 
endmodule
 
module gp_generator(g,p,c_in,g_out,p_out,c_out);
	input wire  [1:0]g,p;
	input wire       c_in;
	output wire g_out,p_out,c_out;
	assign g_out = g[1] | (p[1] & g[0]);
	assign p_out = g[0]&p[1];
	assign c_out = g[0] | (p[0] & c_in);
endmodule
 
module cal_2(a,b,s,c_in,g_out,p_out);
	input wire   [1:0] a,b;
	input wire         c_in;
	output wire        g_out,p_out;
	output wire  [1:0] s;
	wire               c_out;
	wire         [1:0] g,p;
	add a0(a[0],b[0],c_in,g[0],p[0],s[0]);
	add a1(a[1],b[1],c_out,g[1],p[1],s[1]);
	gp_generator gp0(g,p,c_in,g_out,p_out,c_out);
endmodule
 
module cal_4(a,b,s,c_in,g_out,p_out);
	input        [3:0] a,b;
	input              c_in;
	output             g_out,p_out;
	output       [3:0] s;
	wire         [3:0] a,b;
	wire               c_in;
	wire               c_out;
	wire         [1:0] g,p;
	wire               g_out,p_out;
	wire         [3:0] s;
	cal_2 c0(a[1:0],b[1:0],s[1:0],c_in,g[0],p[0]);
	cal_2 c1(a[3:2],b[3:2],s[3:2],c_out,g[1],p[1]);
	gp_generator gp0(g,p,c_in,g_out,p_out,c_out);
endmodule
 
module cal_8(a,b,s,c_in,g_out,p_out);
	input        [7:0] a,b;
	input              c_in;
	output             g_out,p_out;
	output       [7:0] s;
	wire         [7:0] a,b;
	wire               c_in;
	wire               c_out;
	wire         [1:0] g,p;	
	wire               g_out,p_out;
	wire         [7:0] s;
	cal_4 c0(a[3:0],b[3:0],s[3:0],c_in, g[0],p[0]);
	cal_4 c1(a[7:4],b[7:4],s[7:4],c_out,g[1],p[1]);
	gp_generator gp0(g,p,c_in,g_out,p_out,c_out);
endmodule
 
module cal_16(a,b,s,c_in,g_out,p_out);
	input        [15:0]a,b;
	input              c_in;
	output             g_out,p_out;
	output       [15:0]s;
	wire         [15:0]a,b;
	wire               c_in;
	wire         [1:0] g,p;	
	wire               c_out;
	wire               g_out,p_out;
	wire         [15:0]s;
	cal_8 c0(a[7:0], b[7:0], s[7:0], c_in, g[0],p[0]);
	cal_8 c1(a[15:8],b[15:8],s[15:8],c_out,g[1],p[1]);
	gp_generator gp0(g,p,c_in,g_out,p_out,c_out);
endmodule
 
module cal_32(a,b,s,c_in,g_out,p_out);
	input        [31:0]a,b;
	input              c_in;
	output             g_out,p_out;
	output       [31:0]s;
	wire         [31:0]a,b;
	wire               c_in;
	wire         [1:0] g,p;
	wire               c_out;
	wire               g_out,p_out;
	wire         [31:0]s;
	cal_16 c0(a[15:0], b[15:0], s[15:0],c_in, g[0],p[0]);
	cal_16 c1(a[31:16],b[31:16],s[31:16], c_out,g[1],p[1]);
	gp_generator gp0(g,p,c_in,g_out,p_out,c_out);
endmodule