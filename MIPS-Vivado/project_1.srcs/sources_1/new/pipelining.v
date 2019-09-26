`timescale 1ns / 1ps
//
// 线路命名方式??
//     1，参考数�????路图中的各条线路命名，基本相�?
//     2. rtn即return，指代器件返回结果；mux的是多路选择??,如rtnMuxb32_1，rtn是它的输出，b代表位数,_1是它的序号；
// R1_sharp指R1#，sharp??'#'的意�????
//     3. 部分命名与图示不同，RamDin，RamDout，RomOut�????但可以直接看出命名的是哪条线�?
//

//
// 如何方便地添加自己的四条指令??
//     1.学习老师给的文件 "流水线调试高级技??.doc" 。将你想要看到的信息，如运行的指令顺序，??16进制打印出来，输出文件命名为logisim.txt??
//     2.打开 "logout.v" 中的模块，更改模块中输出�????，注意输出格�???$fwrite()函数的标准输出格式与C语言中的printf相同??
//     3.输出文件在{$project_dir}/(project_name).sim/sim_1/behav/xsim/data_out.txt??
//     4.将群里提供的脚本文件和以上两个文件放拷贝至同??个文件夹中，双击运行脚本文件，即可比对出指令运行顺序的不�????
//     5.data_out.txt中和logisim.txt中不同的地方应该是data_out.txt中的错误，即仿真错误，但也不排除你的logisim电路图有问题??
//     5.欢乐debug??
//

//module Top(rst,CLK,GO,mode,an,seg,totalCycle,JMPTimes,CJMPTimes,PCout,rtnAdder1,JMP,JR,RegDst,JAL,RegWrite,AluSrcB,RomOut);
 module pipelining(rst,ck,GO,mode,memaddr,an,seg);   
    input rst;
    input ck;
    wire CLK;
    input GO;
    input [1:0]mode;     //选择显示信号
    input [3:0] memaddr;
    output [7:0] an;  //
    output [7:0] seg; //
    wire [15:0] totalCycle;  //总周期数
    wire [15:0] JMPTimes;    //无条件跳转分支数
    wire [15:0] CJMPTimes;   //条件跳转分支??
    wire [31:0] rtnAdder1;
    wire EX_JR;
    wire EX_RegDst;
    wire EX_JAL;
    wire EX_RegWrite;
    wire EX_AluSrcB;
    wire [3:0] EX_AluOP;
    wire EX_MemWrite;
    wire EX_MemToReg;
    wire EX_Bne;
    wire EX_Beq;
    wire EX_SignedExt;
    wire EX_Syscall;
    wire EX_BLEZ;
    wire EX_LBU;
    wire EX_SRAV;
    wire EX_JMP;
    wire [31:0] EX_PC;
    wire EX_PCr;
    wire [4:0] EX_WSharp;
    wire [31:0]EX_IR;
    wire [31:0]EX_imm;
    wire [31:0]EX_Address;
    wire [4:0]EX_shamt;
    wire [31:0] rtnMuxb32_4;
    wire [31:0] rtnMuxb32_5;
    wire [31:0] rtnMuxb32_7;
    wire [4:0] W_Sharp;
    wire [31:0] RegfileDin;
    wire ID_rst;
    wire halt;
    wire Stop;
    wire WB_RegWrite;
    reg [9:0] RamAddr;
    localparam sys_2 = 5'h2;
    localparam sys_4 = 5'h4;
    localparam sys_hex2 = 32'h22;
    localparam signExt_2 = 5'h2;
    localparam sys_1f = 5'b11111;
    localparam load = 1'b1;
//    同理，下方看到的控制器输出信号也应改成wire类型
    

// 全局总线
    wire Enable; // 运行/停机 指令指示

// 取指阶段相关总线
    wire [31:0] RomOut;
    wire [31:0] rtnMuxb32_1;
    wire [31:0] rtnMuxb32_2;
    wire [31:0]PCout;
    wire PC_En;
    wire LoadUse;
    wire IF_rst;
    wire JMP;
    wire branchSel;
    wire [31:0]ID_IR;
    wire [31:0] ID_PC4;
    wire [31:0] ID_PC;
    localparam pc_4 = 32'h4;
    assign PC_En = ~LoadUse & Enable; 
    assign rtnAdder1 = PCout + pc_4;
    assign IF_rst = EX_JMP | rst | branchSel;
    Register _register(
        .clk(CLK),.rst(rst),
        .en(PC_En),.indata(rtnMuxb32_2),
        .outdata(PCout)
    );
    rom _rom(
        .read_addr(PCout[11:2]),.data(RomOut)
    );
    IF_ID _ifid(
        .clk(CLK),.rst(IF_rst),.Enable(PC_En),.instru(RomOut),.pc4(rtnAdder1),
        .instru_out(ID_IR),.pc4_out(ID_PC4),.pc(PCout),.pc_out(ID_PC)
    );

    
//译码阶段
    wire JR;
    wire RegDst;
    wire JAL;
    wire RegWrite;
    wire AluSrcB;
    wire [3:0] AluOP;
    wire MemWrite;
    wire MemToReg;
    wire Bne;
    wire Beq;
    wire SignedExt;
    wire Syscall;
    wire BLEZ;
    wire LBU;
    wire SRAV;
    wire [31:0] ZeroExtRtn;
    wire [31:0] SignedExtRtn_1;
    wire [31:0] SignedExtRtn_2;
    wire [4:0] rtnMuxb5_1;
    wire [4:0] rtnMuxb5_2;
    wire [4:0] rtnMuxb5_3;
    wire [4:0] rtnMuxb5_4;
    wire [31:0] LeftShifter_1;
    wire [31:0]R1;
    wire [31:0]R2;
    wire [31:0]EX_R1;
    wire [31:0]EX_R2;
   
    assign ID_rst = IF_rst | LoadUse;
    assign halt = Stop & EX_Syscall;
    
    regfile _regfile(
        .R1_in(rtnMuxb5_1),.R2_in(rtnMuxb5_2),
        .W(W_Sharp),.Din(RegfileDin),
        .RegWrite(WB_RegWrite),.clk(CLK),
        .R1(R1),.R2(R2)
    );
    // RegfileDin，W_Sharp 在后面给�?
    
    
    ID_EX _idex(
        .CLK(CLK),.Reset(ID_rst),.SRAV_in(SRAV),
        .SRAV_out(EX_SRAV),.BLEZ_in(BLEZ),.BLEZ_out(EX_BLEZ),.LBU_in(LBU),
        .LBU_out(EX_LBU),.JR_in(JR),.JR_out(EX_JR),.JMP_in(JMP),
        .JMP_out(EX_JMP),.BEQ_in(Beq),.BEQ_out(EX_Beq),.BNE_in(Bne),
        .BNE_out(EX_Bne),.MemToReg_in(MemToReg),.MemToReg_out(EX_MemToReg),.MemWrite_in(MemWrite),
        .MemWrite_out(EX_MemWrite),.AluOP_in(AluOP),.AluOP_out(EX_AluOP),.AluSrcB_in(AluSrcB),
        .AluSrcB_out(EX_AluSrcB),.RegWrite_in(RegWrite),.RegWrite_out(EX_RegWrite),.JAL_in(JAL),
        .JAL_out(EX_JAL),.RegDst_in(RegDst),.RegDst_out(EX_RegDst),.Syscall_in(Syscall),
        .Syscall_out(EX_Syscall),.R1_in(R1),.R1_out(EX_R1),.R2_in(R2),
        .R2_out(EX_R2),.PCr_in(ID_PC),.PCr_out(EX_PCr),.IR_in(ID_IR),
        .IR_out(EX_IR),.WSharp_in(rtnMuxb5_4),.WSharp_out(EX_WSharp),.PC_in(ID_PC4),
        .PC_out(EX_PC),.imm_in(rtnMuxb32_4),.imm_out(EX_imm),.Address_in(LeftShifter_1),
        .Address_out(EX_Address),.shamt_in(ID_IR[10:6]),.shamt_out(EX_shamt),.Enable(Enable)
    );
    
    main_control _mainControl(
        .op_code(ID_IR[31:26]),.func(ID_IR[5:0]),
        .alu_op(AluOP),.MemtoReg(MemToReg),
        .MemWrite(MemWrite),.ALU_SRC(AluSrcB),
        .RegWrite(RegWrite),.SYSCALL(Syscall),
        .SignedExt(SignedExt),.RegDst(RegDst),
        .BEQ(Beq),.BNE(Bne),.JR(JR),
        .JMP(JMP),.JAL(JAL),.LBU(LBU),
        .BLEZ(BLEZ),.SRAV(SRAV)
    );
    Muxb5 _muxb5_1(
        .out(rtnMuxb5_1),.a(ID_IR[25:21]),
        .b(sys_4),.sel(Syscall)
    );
    Muxb5 _muxb5_2(
        .out(rtnMuxb5_2),.a(ID_IR[20:16]),
        .b(sys_2),.sel(Syscall)
    );
    Muxb5 _muxb5_3(
        .out(rtnMuxb5_3),.a(ID_IR[20:16]),
        .b(ID_IR[15:11]),.sel(RegDst)
    );
    Muxb5 _muxb5_4(
        .out(rtnMuxb5_4),.a(rtnMuxb5_3),
        .b(sys_1f),.sel(JAL)
    );
    movzx _zeroExt(
        .indata(ID_IR[15:0]),.outdata(ZeroExtRtn)
    );
    movsx _signExt(
        .indata(ID_IR[15:0]),.outdata(SignedExtRtn_1)
    );
    movsx#(26,32) _signExt_2(
        .indata(ID_IR[25:0]),.outdata(SignedExtRtn_2)
    );
    shifter _leftshifter_1(
        .data_in(SignedExtRtn_2),.data_out(LeftShifter_1)
    );
    Muxb32 _muxb32_4(
        .out(rtnMuxb32_4),.a(ZeroExtRtn),
        .b(SignedExtRtn_1),.sel(SignedExt)
    );

// 执行指令阶段
    
    wire [31:0] R;
    wire MEM_LBU;
    wire MEM_MemToReg;
    wire MEM_MemWrite;
    wire MEM_RegWrite;
    wire MEM_JAL;
    wire MEM_RegDst;
    wire MEM_Syscall;
    wire [31:0] MEM_R2_in;
    wire [31:0] MEM_PCr;
    wire [31:0] MEM_IR;
    wire [4:0] MEM_WSharp;
    wire [31:0]MEM_PC;
    wire [1:0] R1_Forward;
    wire [1:0] R2_Forward;
    wire [31:0] WB_AluR;
    wire [31:0] WB_MemD;
    wire [31:0] MEM_AluR;
    wire [31:0] rtnMux4b32_1;
    wire [31:0] rtnMux4b32_2;
    wire [4:0] rtnMuxb5_5;
    wire CallType;
    wire [31:0] LeftShifter_2;
    wire [31:0] rtnAdder2;
    wire [31:0] MEM_R2;
    wire [31:0] rtnMuxb32_6;
    wire cmp;
    wire ifEqual;
    wire MEM_halt;

    assign cmp = ($signed(rtnMux4b32_1) <= 0) ? 1:0;
    assign rtnAdder2 = LeftShifter_2 + EX_PC;
    assign CallType = (rtnMux4b32_2 == sys_hex2)? 1:0;
    assign Stop = ~CallType;
    assign branchSel = ((cmp & EX_BLEZ)| (EX_Beq & ifEqual) | (~ifEqual & EX_Bne)) & Enable;

    Mux4b32 _selAluSrcA(
        .sel(R1_Forward),.a(EX_R1),.b(WB_AluR),
        .c(WB_MemD),.d(MEM_AluR),.out(rtnMux4b32_1)
    );
    Mux4b32 _selAluSrcB(
        .sel(R2_Forward),.a(EX_R2),.b(WB_AluR),
        .c(WB_MemD),.d(MEM_AluR),.out(rtnMux4b32_2)
    );
    ALU _alu(
        .AluOP(EX_AluOP),.A(rtnMux4b32_1),
        .B(rtnMuxb32_6),.shamt(rtnMuxb5_5),
        .clk(CLK),.equal(ifEqual),
        .R(R)
    );
    Muxb32 _muxb32_6(
        .out(rtnMuxb32_6),.a(rtnMux4b32_2),
        .b(EX_imm),.sel(EX_AluSrcB)
    );
    Muxb5 _muxb5_5(
        .out(rtnMuxb5_5),.a(EX_shamt),
        .b(rtnMux4b32_1[4:0]),.sel(EX_SRAV)
    );
    shifter _leftshifter_2(
        .data_in(EX_imm),.data_out(LeftShifter_2)
    );
    EX_MEM _exmem(
        .CLK(CLK),.Reset(rst),.Enable(Enable),
        .LBU_in(EX_LBU),.LBU_out(MEM_LBU),.MemToReg_in(EX_MemToReg),.MemToReg_out(MEM_MemToReg),
        .MemWrite_in(EX_MemWrite),.MemWrite_out(MEM_MemWrite),.RegWrite_in(EX_RegWrite),.RegWrite_out(MEM_RegWrite),
        .JAL_in(EX_JAL),.JAL_out(MEM_JAL),.RegDst_in(EX_RegDst),.RegDst_out(MEM_RegDst),
        .Syscall_in(EX_Syscall),.Syscall_out(MEM_Syscall),.AluR_in(R),.AluR_out(MEM_AluR),
        .R2_in(rtnMux4b32_2),.R2_out(MEM_R2),.PCr_in(EX_PCr),.PCr_out(MEM_PCr),
        .IR_in(EX_IR),.IR_out(MEM_IR),.WSharp_in(EX_WSharp),.WSharp_out(MEM_WSharp),
        .PC_in(EX_PC),.PC_out(MEM_PC),.halt_in(halt),.halt_out(MEM_halt)
    );

// mem阶段
    reg RamLoad=0;
    wire [31:0] RamDout;
    wire WB_MemToReg;
    wire WB_JAL;
    wire [31:0]WB_PCr;
    wire [31:0] WB_PC;
    wire WB_halt;
    wire [7:0] sldRamDout;
    wire [31:0] ExtSldRamDout;
    wire [31:0] rtnMuxb32_8;

    ram _ram(
        .addr(RamAddr),.data_in(MEM_R2),
        .MemWrite(MEM_MemWrite),.clk(CLK),
        .load(RamLoad),.data_out(RamDout)
    );

    Mux4 _muxofDout(
        .out(sldRamDout),.data(RamDout),.sel(MEM_AluR[1:0])
    );

    movzx#(8,32) _ZroExtsleRD(
        .indata(sldRamDout),.outdata(ExtSldRamDout)
    );

    Muxb32 _muxb32_8(
        .out(rtnMuxb32_8),.a(RamDout),
        .b(ExtSldRamDout),.sel(MEM_LBU)
    );

    MEM_WB _memwb(
        .CLK(CLK),.Reset(rst),.Enable(Enable),
        .MemToReg_in(MEM_MemToReg),.MemToReg_out(WB_MemToReg),
        .RegWrite_in(MEM_RegWrite),.RegWrite_out(WB_RegWrite),
        .JAL_in(MEM_JAL),.JAL_out(WB_JAL),.AluR_in(MEM_AluR),.AluR_out(WB_AluR),
        .MemD_in(rtnMuxb32_8),.MemD_out(WB_MemD),.PCr_in(MEM_PCr),.PCr_out(WB_PCr),
        .WSharp_in(MEM_WSharp),.WSharp_out(W_Sharp),.PC_in(MEM_PC),.PC_out(WB_PC),
        .halt_in(MEM_halt),.halt_out(WB_halt)
    );
    Muxb32 _muxb32_5(
        .out(rtnMuxb32_5),.a(rtnMuxb32_7),
        .b(WB_PC),.sel(WB_JAL)
    );
    Muxb32 _muxb32_7(
        .out(rtnMuxb32_7),.a(WB_AluR),
        .b(WB_MemD),.sel(WB_MemToReg)
    );
    assign RegfileDin = rtnMuxb32_5;

    wire [31:0]LedData;

    wire [31:0] rtnMuxb32_3;

    wire LedControl;


// 常量

///////////////////////////////////////////////////main module Initial/////////////////////////////////////////////



    //ledData寄存??
    Register _ledRegister(
        .clk(CLK),.rst(rst),
        .en(LedControl),.indata(R1),
        .outdata(LedData)
    );

    
    // 总周期数计数??
    counter _cycleCounter(
        .en(Enable),.clk(CLK),
        .out(totalCycle),.rst(rst)
    );

    // 无条件跳转计数器
    counter _JMPCounter(
        .en(EX_JMP),.clk(CLK),
        .out(JMPTimes),.rst(rst)
    );

    // 有条件跳转计数器
    counter _CJMPCounter(
        .en(branchSel),.clk(CLK),
        .out(CJMPTimes),.rst(rst)
    );
    divider _divider(.clk(ck),.clk_N(CLK));
    // 数码显示??
    display _display(
        .clk(ck),.mode(mode),.mem(RamDout),
        .leddata(LedData),.totaltimes(totalCycle),
        .JMP(JMPTimes),.CJMP(CJMPTimes),
        .SEG(seg),.AN(an)
    );
    
    always@(R or mode or memaddr) begin
        if(mode == 3) begin
            RamLoad = 1;
            case(memaddr)
                0:RamAddr = 0;
                1:RamAddr = 1;
                2:RamAddr = 2;
                3:RamAddr = 3;
                4:RamAddr = 4;
                5: RamAddr = 5;
                6: RamAddr = 6;
                7: RamAddr = 7;
                8: RamAddr = 8;
                9: RamAddr = 9;
                10:RamAddr = 10;
                11:RamAddr = 11;
                12:RamAddr = 12;
                13:RamAddr = 13;
                14:RamAddr = 14;
                15: RamAddr = 15;     
             endcase
         end
         else begin
             RamAddr = MEM_AluR[11:2];
             RamLoad = MemToReg;
         end
    end   

    wire DataConflict;
///////////////////////////////////////////////////main module Connect/////////////////////////////////////////////

    RedirectControl _rcontrol(
        .DataConflict(DataConflict),.CLK(CLK),.R1_Forward(R1_Forward),.R2_Forward(R2_Forward),
        .LoadUse(LoadUse),.op(ID_IR[31:26]),.EX_WSharp(EX_WSharp),.EX_RegWrite(EX_RegWrite),
        .MEM_WSharp(MEM_WSharp),.MEM_RegWrite(MEM_RegWrite),.func(ID_IR[5:0]),.R1Sharp(rtnMuxb5_1),
        .R2Sharp(rtnMuxb5_2),.EX_op(EX_IR[31:26]),.MEM_op(MEM_IR[31:26]),.Reset(rst)
    );
    assign Enable = ~WB_halt | rst | GO;
    assign LedControl = Syscall & CallType;

    //复杂逻辑、时序电??

    Muxb32 _muxb32_1(
        .out(rtnMuxb32_1),.a(rtnAdder1),
        .b(rtnAdder2),.sel(branchSel)
    );
    Muxb32 _muxb32_2(
        .out(rtnMuxb32_2),.a(rtnMuxb32_1),
        .b(rtnMuxb32_3),.sel(EX_JMP)
    );
    Muxb32 _muxb32_3(
        .out(rtnMuxb32_3),.a(EX_Address),
        .b(rtnMux4b32_1),.sel(EX_JR)
    );
    logout _log(
        .clk(CLK),.cy(totalCycle),.jm(JMPTimes),
        .cj(CJMPTimes),.commandLine(RomOut),
        .R1(R1),.R2(R2),.Ramout(RamDout)
    );

endmodule