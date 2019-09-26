`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 20:16:23
// Design Name: 
// Module Name: movzx
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

module movzx
#(parameter IN_WIDTH=16,parameter OUT_WIDTH=32)(
    input wire [(IN_WIDTH-1):0] indata,
    output wire [(OUT_WIDTH-1):0] outdata
);
    assign outdata = {{(OUT_WIDTH-IN_WIDTH){0}},indata};
endmodule
