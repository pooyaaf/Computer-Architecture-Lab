module Top(
    input clk, rst
);
    wire [31:0] pcOutIf,instOutIF,pcOutIfPipe,instOutIfpipe;

    // ID
    wire [31:0] pcOut,regRn,regRm;
    wire [3:0] aluCmd,dest;
    wire memRead, memWriteEn, wbEn, branch, s,imm,hazardTwoSrc;
    wire [11:0] shiftOperand;
    wire [23:0] imm24;
    //IDEX
    wire [31:0] pcOutIdEx;
    wire [3:0] aluCmdOutIdEx;
    wire memReadOutIdEx, memWriteOutIdEx, wbEnOutIdEx, branchOutIdEx, sOutIdEx;
    wire [31:0] regRnOutIdEx, regRmOutIdEx;
    wire immOutIdEx;
    wire [11:0] shiftOperandOutIdEx;
    wire [23:0] imm24OutIdEx;
    wire [3:0] destOutIdEx;

    StageIF IF(
        .clk(clk),
        .rst(rst),
        .freeze(1'b0),
        .branchTaken(1'b0),
        .branchAddr(32'd0),
        .pc(pcOutIf),
        .instruction(instOutIF)
    );

    RegIFID regIFID(
        .clk(clk),
        .rst(rst),
        .freeze(1'b0),
        .flush(1'b0),
        .pcIn(pcOutIf),
        .instructionIn(instOutIF),
        .pcOut(pcOutIfPipe),
        .instructionOut(instOutIfpipe)
    );

    StageId Stageid(
        .clk(clk),
        .rst(rst),
        .pcIn(pcOutIfPipe),
        .inst(instOutIfpipe),
        .status(4'b0),
        .wbWbEn(1'b0),
        .wbValue(32'b0),
        .wbDest(4'b0),
        .hazard(1'b0),
        .pcOut(pcOut),
        .aluCmd(aluCmd),
        .memRead(memRead),
        .memWriteEn(memWriteEn),
        .wbEn(wbEn),
        .branch(branch),
        .s(s),
        .regRn(regRn),
        .regRm(regRm),
        .imm(imm),
        .shiftOperand(shiftOperand),
        .imm24(imm24),
        .dest(dest),
        .hazardTwoSrc(hazardTwoSrc)
    );

    RegIDEX regIDEX(
        .clk(clk),
        .rst(rst),
        .pcIn(pcOut),
        .aluCmdIn(aluCmd),
        .memReadIn(memRead),
        .memWriteIn(memWriteEn),
        .wbEnIn(wbEn), 
        .branchIn(branch), 
        .sIn(s),
        .regRnIn(regRn), 
        .regRmIn(regRm),
        .immIn(imm), 
        .shiftOperandIn(shiftOperand), 
        .imm24In(imm24), 
        .destIn(dest),
        .flush(1'b0), 
        .freeze(1'b0),
        .pcOut(pcOutIdEx),
        .aluCmdOut(aluCmdOutIdEx), 
        .memReadOut(memReadOutIdEx), 
        .memWriteOut(memWriteOutIdEx),
        .wbEnOut(wbEnOutIdEx), 
        .branchOut(branchOutIdEx), 
        .sOut(sOutIdEx),
        .regRnOut(regRnOutIdEx), 
        .regRmOut(regRmOutIdEx),
        .immOut(immOutIdEx), 
        .shiftOperandOut(shiftOperandOutIdEx), 
        .imm24Out(imm24OutIdEx), 
        .destOut(destOutIdEx)
    );
endmodule
