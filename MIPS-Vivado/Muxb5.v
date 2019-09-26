module Muxb5(out,a,b,sel);
    input [4:0] a;
    input [4:0] b;
    input sel;
    output [4:0] out;
    mux2_1#(5) _mux5(
        .out1(out),.a(a),
        .b(b),.sel(sel)
    );
endmodule