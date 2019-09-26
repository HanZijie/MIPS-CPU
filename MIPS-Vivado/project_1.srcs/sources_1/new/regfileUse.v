module regfileUse(
    input OP0,input OP1,input OP2,input OP3,input OP4,input OP5,
    input F0,input F1,input F2,input F3,input F4,input F5,
    output R1_Used,output R2_Used
);
    assign R1_Used = ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&~F2&~F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&F2&~F1&~F0|~OP5&~OP4&~OP3&OP2&~OP1&~OP0|~OP5&~OP4&~OP3&OP2&~OP1&OP0|~OP5&~OP4&OP3&~OP2&~OP1&~OP0|~OP5&~OP4&OP3&OP2&~OP1&~OP0|~OP5&~OP4&OP3&~OP2&~OP1&OP0|~OP5&~OP4&OP3&~OP2&OP1&~OP0|~OP5&~OP4&OP3&OP2&~OP1&OP0|OP5&~OP4&~OP3&~OP2&OP1&OP0|OP5&~OP4&OP3&~OP2&OP1&OP0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0|~OP5&~OP4&OP3&~OP2&OP1&OP0|OP5&~OP4&~OP3&~OP2&~OP1&OP0|~OP5&~OP4&~OP3&OP2&OP1&~OP0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&F0;
    assign R2_Used = ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&~F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&F2&~F1&~F0|~OP5&~OP4&~OP3&OP2&~OP1&~OP0|~OP5&~OP4&~OP3&OP2&~OP1&OP0|OP5&~OP4&OP3&~OP2&OP1&OP0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&~F0|~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&F0;

endmodule