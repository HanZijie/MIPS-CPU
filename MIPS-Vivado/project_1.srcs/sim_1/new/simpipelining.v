`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 20:13:13
// Design Name: 
// Module Name: simpipelining
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


module simpipelining(
    );
    reg rst;
    reg ck;
    reg GO;
    reg [1:0]mode;
    reg [31:0]sims;
    reg [3:0] memaddr;
    wire [7:0] an;
    wire [7:0] seg;
    
    initial begin
        sims <= 0;
        ck <= 0;
        rst <= 0;
        GO <= 0;
        mode <= 0;
        memaddr <= 0;
    end
    always begin
        #2 ck = ~ck;
    end
    pipelining _pipe(rst,ck,GO,mode,memaddr,an,seg);
endmodule
