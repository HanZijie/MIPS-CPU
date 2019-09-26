module RedirectControl(
    output DataConflict,output [1:0] R1_Forward,output [1:0] R2_Forward,
    output LoadUse, input CLK,input [5:0] op,input [4:0] EX_WSharp,
    input EX_RegWrite,input [4:0] MEM_WSharp,input MEM_RegWrite,input [5:0] func,
    input [4:0] R1Sharp,input [4:0] R2Sharp,input [5:0] EX_op,input [5:0] MEM_op,input Reset
);
    wire R1_Used;
    wire R2_Used;
    wire cmp_1;
    wire cmp_2;
    wire cmp_3;
    wire cmp_4;
    wire cmp_5;
    wire cmp_6;
    wire cmp_7;
    wire cmp_8;
    wire cmp_9;
    wire cmp_10;
    wire cmp_11;
    wire cmp_12;
    wire c1;
    wire c2;
    wire c3;
    wire c4;
    wire c5;
    wire c6;
    wire c7;
    wire c8;
    wire [1:0] rtnPri_1;
    wire [1:0] rtnPri_2;
    wire [1:0] R1_f;
    wire [1:0] R2_f;
    regfileUse _regfileuse(
        .OP0(op[0]),.OP1(op[1]),.OP2(op[2]),.OP3(op[3]),.OP4(op[4]),.OP5(op[5]),
        .F0(func[0]),.F1(func[1]),.F2(func[2]),.F3(func[3]),.F4(func[4]),.F5(func[5]),
        .R1_Used(R1_Used),.R2_Used(R2_Used)
    );
    assign cmp_1 = (R1Sharp == EX_WSharp)? 1:0;
    assign cmp_2 = (EX_WSharp == 0)? 0:1;
    assign cmp_3 = (R1Sharp == MEM_WSharp)? 1:0;
    assign cmp_4 = (MEM_WSharp == 0)? 0:1;
    assign cmp_5 = (R2Sharp == EX_WSharp)? 1:0;
    assign cmp_7 = (R2Sharp == MEM_WSharp)? 1:0;
    assign cmp_9 = (MEM_op == 6'h23)? 1: 0;
    assign cmp_10 = (MEM_op == 6'h24)? 1: 0;
    assign cmp_11 = (EX_op == 6'h23)?1:0;
    assign cmp_12 = (EX_op == 6'h24)?1:0;

    assign c1 = cmp_3 & cmp_4 & MEM_RegWrite;
    assign c2 = cmp_7 & cmp_4 & MEM_RegWrite;
    assign c3 = cmp_1 & cmp_2 & EX_RegWrite;
    assign c4 = cmp_5 & cmp_2 & EX_RegWrite;
    assign c5 = cmp_9 | cmp_10;
    assign c6 = cmp_11 | cmp_12;
    assign c7 = c1 & c5;
    assign c8 = c2 & c5;
    assign DataConflict = ((c1 | c3) & R1_Used)|((c2 | c4) & R2_Used);
    assign LoadUse = c6 & (c3 | c4);

    pri _pri1(
        .a(1),.b(c1),.c(c7),.d(c3),.out(rtnPri_1)
    );
    pri _pri2(
        .a(1),.b(c2),.c(c8),.d(c4),.out(rtnPri_2)
    );
    mux2_1#(2) _mux1(.out1(R1_f),.a(rtnPri_1),.b(2'b00),.sel(LoadUse));
    mux2_1#(2) _mux2(.out1(R2_f),.a(rtnPri_2),.b(2'b00),.sel(LoadUse));

    Register#(2) _register1(
        .clk(CLK),.rst(Reset),.en(1),.indata(R1_f),.outdata(R1_Forward)
    );

    Register#(2) _register2(
        .clk(CLK),.rst(Reset),.en(1),.indata(R2_f),.outdata(R2_Forward)
    );

endmodule