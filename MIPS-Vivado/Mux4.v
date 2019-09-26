`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 00:48:15
// Design Name: 
// Module Name: Mux4
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


module Mux4(out,data,sel);
    input [31:0] data;
    input [1:0]sel;
    output reg [7:0] out;
    always @(sel or data)
    begin
        case (sel)
            2'b00 :  out = data[7:0];
            2'b01 :  out = data[15:8];
            2'b10 :  out = data[23:16];
            2'b11 : out = data[31:24];
            
            default;
        endcase
    end
endmodule