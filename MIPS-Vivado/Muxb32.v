module Muxb32(out,a,b,sel);
    input [31:0] a;
    input [31:0] b;
    input sel;
    output [31:0] out;
    mux2_1#(32) _mux32(
        .out1(out),.a(a),
        .b(b),.sel(sel)
    );
endmodule