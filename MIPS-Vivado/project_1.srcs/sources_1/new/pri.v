module pri(input a, input b, input c, input d, output reg [1:0] out);
    always@(*)begin
        if(d == 1) begin
            out = 3;
        end
        else if(c == 1)begin
            out = 2;
        end
        else if(b == 1)begin
            out = 1;
        end
        else if(a == 1)begin
            out = 0;
        end
    end
endmodule