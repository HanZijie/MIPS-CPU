`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 10:51:12
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input CLK,input Reset,input Enable,
    input MemToReg_in,output reg MemToReg_out,input RegWrite_in,output reg RegWrite_out,
    input JAL_in,output reg JAL_out,input [31:0] AluR_in,output reg [31:0] AluR_out,
    input [31:0] MemD_in,output reg [31:0] MemD_out,input [31:0] PCr_in,output reg [31:0] PCr_out,
    input [31:0] WSharp_in,output reg [31:0] WSharp_out,input [31:0] PC_in,output reg [31:0] PC_out,
    input halt_in,output reg halt_out
);

    initial begin
        MemToReg_out <= 0;
        RegWrite_out <= 0;
        JAL_out <= 0;
        AluR_out <= 0;
        MemD_out <= 0;
        PCr_out <= 0;
        WSharp_out <= 0;
        PC_out <= 0;
        halt_out <= 0;
    end

    always @(posedge CLK) begin
        if(Enable) begin
            if(Reset) begin
                MemToReg_out <= 0;
                RegWrite_out <= 0;
                JAL_out <= 0;
                AluR_out <= 0;
                MemD_out <= 0;
                PCr_out <= 0;
                WSharp_out <= 0;
                PC_out <= 0;
                halt_out <= 0;
            end
            else begin
                MemToReg_out <= MemToReg_in;
                RegWrite_out <= RegWrite_in;
                JAL_out <= JAL_in;
                AluR_out <= AluR_in;
                PCr_out <= PCr_in;
                WSharp_out <= WSharp_in;
                PC_out <= PC_in;
                halt_out <= halt_in;
                MemD_out <= MemD_in;
            end
        end
        else begin
            MemToReg_out <= MemToReg_out;
            RegWrite_out <= RegWrite_out;
            JAL_out <= JAL_out;
            AluR_out <= AluR_out;
            PCr_out <= PCr_out;
            WSharp_out <= WSharp_out;
            PC_out <= PC_out;
            halt_out <= halt_out;
            MemD_out <= MemD_out;
        end
    end
endmodule
