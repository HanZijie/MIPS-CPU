`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/13 16:51:12
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    clk,rst,Enable,instru, pc4,
    instru_out,pc4_out,pc,pc_out
    );
    input clk;
    input rst;
    input Enable;
    input [31:0] instru;
    input [31:0] pc4;
    input [31:0] pc;
    output reg [31:0] instru_out;
    output reg [31:0] pc4_out;
    output reg [31:0] pc_out;
    initial begin
        instru_out <= 0;
        pc4_out <= 0;
        pc_out <= 0;
    end
    always @(posedge clk) begin
        if(Enable) begin
            if(rst) begin
                instru_out <= 0;
                pc4_out <= 0;
                pc_out <= 0;
            end
            else begin
                instru_out <= instru;
                pc4_out <= pc4;
                pc_out <= pc;
            end
        end
        else begin
            instru_out <= instru_out;
            pc4_out <= pc4_out;
            pc_out <= pc_out;
        end
    end
endmodule

