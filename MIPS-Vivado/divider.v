module divider #(parameter N = 1000000 )(clk, clk_N);
    input clk;                     
    output  reg clk_N;                        
    reg [31:0] counter;   
    initial counter<=0;
    initial clk_N<=0;          
    always @(posedge clk)  begin    
        if(counter==(N>>1)-1) begin
            counter <= 32'b0;
            clk_N <= ~clk_N;
            end
        else
            counter <= counter+1;                   
    end                           
endmodule

