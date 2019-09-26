module logout(
    input clk,input [31:0] cy,input [31:0] jm,
    input [31:0] cj,input [31:0] commandLine,
    input [31:0] R1,input [31:0] R2,input [31:0] Ramout
);
    integer fp_w;
    initial begin
        fp_w = $fopen("data_out.txt", "w");
    end
    always@(commandLine) begin
        $fwrite(fp_w, "%x\n", commandLine);
        if(cy==1545)begin
            $fclose(fp_w);
        end
    end

endmodule // logout  