`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 17:21:54
// Design Name: 
// Module Name: main_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 -&File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_control(
input [5:0]op_code,
input [5:0]func,
output  [3:0]alu_op,
output  MemtoReg,
output	MemWrite,
output 	ALU_SRC,
output 	RegWrite,
output  SYSCALL,
output 	SignedExt,
output 	RegDst,
output 	BEQ,
output  BNE,
output 	JR,
output 	JMP,
output  JAL,
output  BLEZ,
output  SRAV,
output  LBU
    );
    /*
    initial begin
        alu_op = 0;
        MemtoReg = 0;
        MemWrite = 0;
        ALU_SRC = 0;
        RegWrite = 0;
        SYSCALL = 0;
        SignedExt = 0;
        RegDst = 0;
        BEQ = 0;
        BNE = 0;
        JR = 0;
        JMP = 0;
        JAL = 0;
    end
    */
assign     alu_op[0]=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&~op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0]|op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0];
assign     alu_op[1]=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0];
assign     alu_op[2]=op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0]|op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&op_code[0];
assign     alu_op[3]=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0];
assign     MemtoReg=op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&op_code[0];
assign     MemWrite=op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&op_code[0];
assign     ALU_SRC=op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0]|op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0];
assign     RegWrite=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&op_code[2]&~op_code[1]&op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&op_code[0];
assign     SYSCALL=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&func[3]&func[2]&~func[1]&~func[0];
assign     SignedExt=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0]|op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&~op_code[1]&op_code[0]|~op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&~op_code[0] | op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0] | op_code[5]&~op_code[4]&op_code[3]&~op_code[2]&op_code[1]&op_code[0];

assign     RegDst=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&func[5]&~func[4]&func[3]&~func[2]&func[1]&func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0];
assign     BEQ=~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0];
assign     BNE=~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&op_code[0];
assign     JR=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0];
assign     JMP=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&~op_code[0]|~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0];
assign     JAL=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&op_code[1]&op_code[0];
assign     BLEZ=~op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&op_code[1]&~op_code[0];
assign     LBU=op_code[5]&~op_code[4]&~op_code[3]&op_code[2]&~op_code[1]&~op_code[0];
assign     SRAV=~op_code[5]&~op_code[4]&~op_code[3]&~op_code[2]&~op_code[1]&~op_code[0]&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0];

endmodule
