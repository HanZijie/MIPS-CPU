module EX_MEM(
    input CLK,input Reset,input Enable,
    input LBU_in,output reg LBU_out,input MemToReg_in,output reg MemToReg_out,
    input MemWrite_in,output reg MemWrite_out,input RegWrite_in,output reg RegWrite_out,
    input JAL_in,output reg JAL_out,input RegDst_in,output reg RegDst_out,
    input Syscall_in,output reg Syscall_out,input [31:0] AluR_in,output reg [31:0] AluR_out,
    input [31:0] R2_in,output reg [31:0] R2_out,input [31:0] PCr_in,output reg [31:0] PCr_out,
    input [31:0] IR_in,output reg [31:0] IR_out,input [31:0] WSharp_in,output reg [31:0] WSharp_out,
    input [31:0] PC_in,output reg [31:0] PC_out,input halt_in,output reg halt_out
);
    initial begin
        LBU_out <= 0;
        MemToReg_out <= 0;
        MemWrite_out <= 0;
        RegWrite_out <= 0;
        JAL_out <= 0;
        RegDst_out <= 0;
        Syscall_out <= 0;
        AluR_out <= 0;
        R2_out <= 0;
        PCr_out <= 0;
        IR_out <= 0;
        WSharp_out <= 0;
        PC_out <= 0;
        halt_out <= 0;
    end
    always @(posedge CLK) begin
        if(Enable) begin
            if(Reset) begin
                LBU_out <= 0;
                MemToReg_out <= 0;
                MemWrite_out <= 0;
                RegWrite_out <= 0;
                JAL_out <= 0;
                RegDst_out <= 0;
                Syscall_out <= 0;
                AluR_out <= 0;
                R2_out <= 0;
                PCr_out <= 0;
                IR_out <= 0;
                WSharp_out <= 0;
                PC_out <= 0;
                halt_out <= 0;
            end
            else begin
                LBU_out <= LBU_in;
                MemToReg_out <= MemToReg_in;
                MemWrite_out <= MemWrite_in;
                RegWrite_out <= RegWrite_in;
                JAL_out <= JAL_in;
                RegDst_out <= RegDst_in;
                Syscall_out <= Syscall_in;
                AluR_out <= AluR_in;
                R2_out <= R2_in;
                PCr_out <= PCr_in;
                IR_out <= IR_in;
                WSharp_out <= WSharp_in;
                PC_out <= PC_in;
                halt_out <= halt_in;
            end
        end
        else begin
            LBU_out <= LBU_out;
            MemToReg_out <= MemToReg_out;
            MemWrite_out <= MemWrite_out;
            RegWrite_out <= RegWrite_out;
            JAL_out <= JAL_out;
            RegDst_out <= RegDst_out;
            Syscall_out <= Syscall_out;
            AluR_out <= AluR_out;
            R2_out <= R2_out;
            PCr_out <= PCr_out;
            IR_out <= IR_out;
            WSharp_out <= WSharp_out;
            PC_out <= PC_out;
            halt_out <= halt_out;
        end
    end
endmodule