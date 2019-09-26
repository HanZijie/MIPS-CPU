`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/13 16:54:34
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
input CLK,input Reset,input SRAV_in,output reg SRAV_out,input BLEZ_in,output reg BLEZ_out,
input LBU_in,output reg LBU_out,input JR_in,output reg JR_out,input JMP_in,output reg JMP_out,
input BEQ_in,output reg BEQ_out,input BNE_in,output reg BNE_out,input MemToReg_in,output reg MemToReg_out,
input MemWrite_in,output reg MemWrite_out,input [3:0] AluOP_in,output reg [3:0] AluOP_out,
input AluSrcB_in,output reg AluSrcB_out,input RegWrite_in,output reg RegWrite_out,input JAL_in,output reg JAL_out,
input RegDst_in,output reg RegDst_out,input Syscall_in,output reg Syscall_out,
input [31:0] R1_in,output reg [31:0] R1_out,input [31:0] R2_in,output reg [31:0] R2_out,
input [31:0] PCr_in,output reg [31:0] PCr_out,input [31:0] IR_in,output reg [31:0] IR_out,
input [4:0] WSharp_in,output reg [4:0] WSharp_out,input [31:0] PC_in,output reg [31:0] PC_out,
input [31:0] imm_in,output reg [31:0] imm_out,input [31:0] Address_in,output reg [31:0] Address_out,
input [4:0] shamt_in,output reg [4:0] shamt_out,input Enable
    );
    initial begin
        SRAV_out <= 0;
        BLEZ_out <= 0;
        LBU_out <= 0;
        JR_out <= 0;
        JMP_out <= 0;
        BEQ_out <= 0;
        BNE_out <= 0;
        MemToReg_out <= 0;
        MemWrite_out <= 0;
        AluOP_out <= 4'b0000;
        AluSrcB_out <= 0;
        RegWrite_out <= 0;
        JAL_out <= 0;
        R1_out <= 32'h00000000;
        R2_out <= 32'h00000000;
        PCr_out <= 32'h00000000;
        IR_out <= 32'h00000000;
        WSharp_out <= 5'b00000;
        PC_out <= 32'h00000000;
        imm_out <= 32'h00000000;
        Address_out <= 32'h00000000;
        shamt_out <= 5'b00000;
        Syscall_out <= 0;
    end
    
always @(posedge CLK) begin
    if(Enable) begin
        if(Reset) begin
            SRAV_out <= 0;
            BLEZ_out <= 0;
            LBU_out <= 0;
            JR_out <= 0;
            JMP_out <= 0;
            BEQ_out <= 0;
            BNE_out <= 0;
            MemToReg_out <= 0;
            MemWrite_out <= 0;
            AluOP_out <= 4'b0000;
            AluSrcB_out <= 0;
            RegWrite_out <= 0;
            JAL_out <= 0;
            R1_out <= 32'h00000000;
            R2_out <= 32'h00000000;
            PCr_out <= 32'h00000000;
            IR_out <= 32'h00000000;
            WSharp_out <= 5'b00000;
            PC_out <= 32'h00000000;
            imm_out <= 32'h00000000;
            Address_out <= 32'h00000000;
            shamt_out <= 5'b00000;
            Syscall_out <= 0;
        end
        else begin
            SRAV_out <= SRAV_in;
            BLEZ_out <= BLEZ_in;
            LBU_out <= LBU_in;
            JR_out <= JR_in;
            JMP_out <= JMP_in;
            BEQ_out <= BEQ_in;
            BNE_out <= BNE_in;
            MemToReg_out <= MemToReg_in;
            MemWrite_out <= MemWrite_in;
            AluOP_out <= AluOP_in;
            AluSrcB_out <= AluSrcB_in;
            RegWrite_out <= RegWrite_in;
            JAL_out <= JAL_in;
            R1_out <= R1_in;
            R2_out <= R2_in;
            PCr_out <= PCr_in;
            IR_out <= IR_in;
            WSharp_out <= WSharp_in;
            PC_out <= PC_in;
            imm_out <= imm_in;
            shamt_out <= shamt_in;
            Address_out <= Address_in;
            Syscall_out <= Syscall_in;
        end
    end
    else begin
        SRAV_out <= SRAV_out;
        BLEZ_out <= BLEZ_out;
        LBU_out <= LBU_out;
        JR_out <= JR_out;
        JMP_out <= JMP_out;
        BEQ_out <= BEQ_out;
        BNE_out <= BNE_out;
        MemToReg_out <= MemToReg_out;
        MemWrite_out <= MemWrite_out;
        AluOP_out <= AluOP_out;
        AluSrcB_out <= AluSrcB_out;
        RegWrite_out <= RegWrite_out;
        JAL_out <= JAL_out;
        R1_out <= R1_out;
        R2_out <= R2_out;
        PCr_out <= PCr_out;
        IR_out <= IR_out;
        WSharp_out <= WSharp_out;
        PC_out <= PC_out;
        imm_out <= imm_out;
        shamt_out <= shamt_out;
        Address_out <= Address_out;
        Syscall_out <= Syscall_out;
    end
end
endmodule
