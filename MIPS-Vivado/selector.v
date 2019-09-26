`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 19:03:42
// Design Name: 
// Module Name: selector
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


module mux2_1(out1, a, b, sel) ;
    parameter WIDTH = 8;
    output  reg [WIDTH:0] out1;
    input   [WIDTH:0] a, b;
    input   sel;
    always @(sel or a or b)
    begin
        case (sel)
            1'b0 :  out1 = a;
            1'b1 :  out1 = b;
            default;
        endcase
    end
endmodule

