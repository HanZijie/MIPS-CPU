//
// 绾胯矾鍛藉悕鏂瑰紡锛?
//     1锛屽弬鑰冩暟鎹?氳矾鍥句腑鐨勫悇鏉＄嚎璺懡鍚嶏紝鍩烘湰鐩稿悓
//     2. rtn鍗硆eturn锛屾寚浠ｅ櫒浠惰繑鍥炵粨鏋滐紱mux鐨勬槸澶氳矾閫夋嫨鍣?,濡俽tnMuxb32_1锛宺tn鏄畠鐨勮緭鍑猴紝b浠ｈ〃浣嶆暟,_1鏄畠鐨勫簭鍙凤紱
// R1_sharp鎸嘡1#锛宻harp鏄?'#'鐨勬剰鎬濄??
//     3. 閮ㄥ垎鍛藉悕涓庡浘绀轰笉鍚岋紝RamDin锛孯amDout锛孯omOut绛夈?備絾鍙互鐩存帴鐪嬪嚭鍛藉悕鐨勬槸鍝潯绾胯矾
//

//
// 濡備綍鏂逛究鍦版坊鍔犺嚜宸辩殑鍥涙潯鎸囦护锛?
//     1.瀛︿範鑰佸笀缁欑殑鏂囦欢 "娴佹按绾胯皟璇曢珮绾ф妧宸?.doc" 銆傚皢浣犳兂瑕佺湅鍒扮殑淇℃伅锛屽杩愯鐨勬寚浠ら『搴忥紝浠?16杩涘埗鎵撳嵃鍑烘潵锛岃緭鍑烘枃浠跺懡鍚嶄负logisim.txt銆?
//     2.鎵撳紑 "logout.v" 涓殑妯″潡锛屾洿鏀规ā鍧椾腑杈撳嚭鐨勫?硷紝娉ㄦ剰杈撳嚭鏍煎紡锛?$fwrite()鍑芥暟鐨勬爣鍑嗚緭鍑烘牸寮忎笌C璇█涓殑printf鐩稿悓銆?
//     3.杈撳嚭鏂囦欢鍦▄$project_dir}/(project_name).sim/sim_1/behav/xsim/data_out.txt銆?
//     4.灏嗙兢閲屾彁渚涚殑鑴氭湰鏂囦欢鍜屼互涓婁袱涓枃浠舵斁鎷疯礉鑷冲悓涓?涓枃浠跺す涓紝鍙屽嚮杩愯鑴氭湰鏂囦欢锛屽嵆鍙瘮瀵瑰嚭鎸囦护杩愯椤哄簭鐨勪笉鍚屻??
//     5.data_out.txt涓拰logisim.txt涓笉鍚岀殑鍦版柟搴旇鏄痙ata_out.txt涓殑閿欒锛屽嵆浠跨湡閿欒锛屼絾涔熶笉鎺掗櫎浣犵殑logisim鐢佃矾鍥炬湁闂銆?
//     5.娆箰debug銆?
//

//module Top(rst,CLK,GO,mode,an,seg,totalCycle,JMPTimes,CJMPTimes,PCout,rtnAdder1,JMP,JR,RegDst,JAL,RegWrite,AluSrcB,RomOut);
 module Top(rst,ck,GO,mode,memaddr,an,seg);   
    input rst;
    input ck;
    wire CLK;
    input GO;
    input [1:0]mode;     //閫夋嫨鏄剧ず淇″彿
    input [3:0] memaddr;
    output [7:0] an;  //
    output [7:0] seg; //
    wire [15:0] totalCycle;  //鎬诲懆鏈熸暟
    wire [15:0] JMPTimes;    //鏃犳潯浠惰烦杞垎鏀暟
    wire [15:0] CJMPTimes;   //鏉′欢璺宠浆鍒嗘敮鏁?
    wire [31:0] rtnAdder1;
    
//    浠ヤ笂totalCycle,JMPTimes,CJMPTimes,rtnAdder1鏄皟璇曠敤output锛岀患鍚堟椂闇?鏀规垚wire绫诲瀷銆?
//    鍚岀悊锛屼笅鏂圭湅鍒扮殑鎺у埗鍣ㄨ緭鍑轰俊鍙蜂篃搴旀敼鎴恮ire绫诲瀷
    

// 鍏ㄥ眬鎬荤嚎
    wire Enable; // 杩愯/鍋滄満 鎸囦护鎸囩ず

// 鎸囦护瀵勫瓨鍣ㄧ浉鍏虫?荤嚎
    wire [31:0] RomOut;

// 鎺у埗鍣ㄧ浉鍏虫?荤嚎
    wire JMP;
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
//    wire OP;
//    wire Func;

// 瀵勫瓨鍣ㄧ粍鐩稿叧鎬荤嚎
    wire [4:0]R1_Sharp;
    wire [4:0]R2_Sharp;
    wire [4:0]w_Sharp;
    wire [31:0]RegfileDin;
    wire [31:0]R1;
    wire [31:0]R2;
    //wire WE; = 'RegWrite'

// PC鐩稿叧鎬荤嚎
    wire [31:0]PCin;
    wire [31:0]PCout;
    
// Alu鐩稿叧鎬荤嚎
    wire ifEqual;

// 鏁版嵁瀵勫瓨鍣ㄧ浉鍏虫?荤嚎
    reg RamLoad=0;
    reg [9:0] RamAddr = 0;
    wire [31:0] RamDin;
    wire [31:0] RamDout;
    //wire str;   included in main controler, use directly as 鈥楳emWrite鈥??

// 鏁扮爜绠＄浉鍏虫?荤嚎
    //wire mode;
    wire [31:0]LedData;

// 鍏朵粬绾胯矾
    wire [31:0] rtnMuxb32_1;
    wire [31:0] rtnMuxb32_2;
    wire [31:0] rtnMuxb32_3;
    wire [31:0] rtnMuxb32_4;
    wire [31:0] rtnMuxb32_5;
    wire [31:0] rtnMuxb32_6;
    wire [31:0] rtnMuxb32_7;
    wire [31:0] rtnMuxb32_8;
    wire [4:0] rtnMuxb5_1;
    wire [4:0] rtnMuxb5_2;
    wire [4:0] rtnMuxb5_3;
    wire [4:0] rtnMuxb5_4;
    wire [31:0] ZeroExtRtn;
    wire [31:0] SignedExtRtn_1;
    wire [31:0] SignedExtRtn_2;
    wire [31:0] LeftShifter_1;
    wire [31:0] LeftShifter_2;
    wire [31:0] rtnAdder2;
    wire [31:0] R;
    wire [7:0] sldRamDout;
    wire [31:0] ExtSldRamDout;
    wire CallType;
    wire branchSel;
    wire LedControl;
    wire Stop;
    wire rtnCmp;


// 甯搁噺
    localparam sys_2 = 5'h2;
    localparam sys_4 = 5'h4;
    localparam sys_hex2 = 32'h22;
    localparam pc_4 = 32'h4;
    localparam signExt_2 = 5'h2;
    localparam sys_1f = 5'b11111;
    localparam load = 1'b1;

///////////////////////////////////////////////////main module Initial/////////////////////////////////////////////

    //PC
    Register _register(
        .clk(CLK),.rst(rst),
        .en(Enable),.indata(PCin),
        .outdata(PCout)
    );

    //ledData瀵勫瓨鍣?
    Register _ledRegister(
        .clk(CLK),.rst(rst),
        .en(LedControl),.indata(R1),
        .outdata(LedData)
    );

    //鎸囦护瀛樺偍鍣?
    rom _rom(
        .read_addr(PCout[11:2]),.data(RomOut)
    );

    //鍐呭瓨
    ram _ram(
        .addr(RamAddr),.data_in(R2),
        .MemWrite(MemWrite),.clk(CLK),
        .load(RamLoad),.data_out(RamDout)
    );

    //鎺у埗鍣?
    main_control _mainControl(
        .op_code(RomOut[31:26]),.func(RomOut[5:0]),
        .alu_op(AluOP),.MemtoReg(MemToReg),
        .MemWrite(MemWrite),.ALU_SRC(AluSrcB),
        .RegWrite(RegWrite),.SYSCALL(Syscall),
        .SignedExt(SignedExt),.RegDst(RegDst),
        .BEQ(Beq),.BNE(Bne),.JR(JR),
        .JMP(JMP),.JAL(JAL),.LBU(LBU),
        .BLEZ(BLEZ),.SRAV(SRAV)
    );

    // regfile
    regfile _regfile(
        .R1_in(R1_Sharp),.R2_in(R2_Sharp),
        .W(w_Sharp),.Din(RegfileDin),
        .RegWrite(RegWrite),.clk(CLK),
        .R1(R1),.R2(R2)
    );

    // alu
    ALU _alu(
        .AluOP(AluOP),.A(R1),
        .B(rtnMuxb32_6),.shamt(RomOut[10:6]),
        .clk(CLK),.equal(ifEqual),
        .R(R)
    );
    
    // 鎬诲懆鏈熸暟璁℃暟鍣?
    counter _cycleCounter(
        .en(Enable),.clk(CLK),
        .out(totalCycle),.rst(rst)
    );

    // 鏃犳潯浠惰烦杞鏁板櫒
    counter _JMPCounter(
        .en(JMP),.clk(CLK),
        .out(JMPTimes),.rst(rst)
    );

    // 鏈夋潯浠惰烦杞鏁板櫒
    counter _CJMPCounter(
        .en(branchSel),.clk(CLK),
        .out(CJMPTimes),.rst(rst)
    );
    divider _divider(.clk(ck),.clk_N(CLK));
    // 鏁扮爜鏄剧ず绠?
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
             RamAddr = R[11:2];
             RamLoad = MemToReg;
         end
    end   

///////////////////////////////////////////////////main module Connect/////////////////////////////////////////////

    //绠?鍗曠粍鍚堥?昏緫
    assign rtnAdder1 = PCout + pc_4;
    assign rtnAdder2 = LeftShifter_2 + rtnAdder1;
    assign R1_Sharp = rtnMuxb5_1;
    assign R2_Sharp = rtnMuxb5_2;
    assign w_Sharp = rtnMuxb5_4;
    assign RamDin = R2;
    assign RegfileDin = rtnMuxb32_5;
    assign PCin = rtnMuxb32_2;
    assign CallType = R2 == 32'b0000_0000_0000_0000_0000_0000_0010_0010 ? 1 : 0;
    assign branchSel = (ifEqual & Beq)|(~ifEqual & Bne)|(BLEZ & rtnCmp);
    assign Enable = (~(Stop & Syscall)) ^ GO;
    assign Stop = !CallType;
    assign LedControl = Syscall & CallType;
    assign rtnCmp = ($signed(R1) <= 0)?1:0;

    //澶嶆潅閫昏緫銆佹椂搴忕數璺?
    movzx _zeroExt(
        .indata(RomOut[15:0]),.outdata(ZeroExtRtn)
    );
    movsx _signExt(
        .indata(RomOut[15:0]),.outdata(SignedExtRtn_1)
    );
    movsx#(26,32) _signExt_2(
        .indata(RomOut[25:0]),.outdata(SignedExtRtn_2)
    );

    shifter _leftshifter_1(
        .data_in(SignedExtRtn_2),.data_out(LeftShifter_1)
    );

    shifter _leftshifter_2(
        .data_in(rtnMuxb32_4),.data_out(LeftShifter_2)
    );

    Muxb32 _muxb32_1(
        .out(rtnMuxb32_1),.a(rtnAdder1),
        .b(rtnAdder2),.sel(branchSel)
    );
    Muxb32 _muxb32_2(
        .out(rtnMuxb32_2),.a(rtnMuxb32_1),
        .b(rtnMuxb32_3),.sel(JMP)
    );
    Muxb32 _muxb32_3(
        .out(rtnMuxb32_3),.a({rtnAdder1[31:28],LeftShifter_1[27:0]}),
        .b(R1),.sel(JR)
    );
    Muxb32 _muxb32_4(
        .out(rtnMuxb32_4),.a(ZeroExtRtn),
        .b(SignedExtRtn_1),.sel(SignedExt)
    );
    Muxb32 _muxb32_5(
        .out(rtnMuxb32_5),.a(rtnMuxb32_7),
        .b(rtnAdder1),.sel(JAL)
    );
    Muxb32 _muxb32_6(
        .out(rtnMuxb32_6),.a(R2),
        .b(rtnMuxb32_4),.sel(AluSrcB)
    );
    Muxb32 _muxb32_7(
        .out(rtnMuxb32_7),.a(R),
        .b(rtnMuxb32_8),.sel(MemToReg)
    );
    Muxb32 _muxb32_8(
        .out(rtnMuxb32_8),.a(RamDout),
        .b(ExtSldRamDout),.sel(LBU)
    );

    Muxb5 _muxb5_1(
        .out(rtnMuxb5_1),.a(RomOut[25:21]),
        .b(sys_4),.sel(Syscall)
    );
    Muxb5 _muxb5_2(
        .out(rtnMuxb5_2),.a(RomOut[20:16]),
        .b(sys_2),.sel(Syscall)
    );
    Muxb5 _muxb5_3(
        .out(rtnMuxb5_3),.a(RomOut[20:16]),
        .b(RomOut[15:11]),.sel(RegDst)
    );
    Muxb5 _muxb5_4(
        .out(rtnMuxb5_4),.a(rtnMuxb5_3),
        .b(sys_1f),.sel(JAL)
    );
    Mux4 _muxofDout(
        .out(sldRamDout),.data(RamDout),.sel(R[1:0])
    );
    movzx#(8,32) _ZroExtsleRD(
        .indata(sldRamDout),.outdata(ExtSldRamDout)
    );
    logout _log(
        .clk(CLK),.cy(totalCycle),.jm(JMPTimes),
        .cj(CJMPTimes),.commandLine(RomOut),
        .R1(R1),.R2(R2),.Ramout(RamDout)
    );

endmodule