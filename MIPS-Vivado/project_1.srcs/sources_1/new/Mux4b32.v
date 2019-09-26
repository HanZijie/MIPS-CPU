module Mux4b32(
    input [1:0] sel,input [31:0] a,input [31:0] b,input [31:0] c,input [31:0] d,output reg [31:0] out
);
    always@(*)begin
        case(sel)
            2'b00:
                begin 
                out <= a;
                end
            2'b01:
                begin  
                out <= b;
                end
            2'b10:
                 begin 
                 out <= c;
                 end
            2'b11: 
                begin
                out <= d;
                end
        endcase
    end
endmodule