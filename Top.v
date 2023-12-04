module Top(
    input clk, rst,
    input forwardingEn
);
    wire [31:0] pcOutIf,instOutIF,pcOutIfPipe,instOutIfpipe;
   
    // ID
    wire [31:0] pcOut,regRn,regRm;
    wire [3:0] aluCmd, dest, hazardRn, hazardRdm;
    wire memRead, memWriteEn, wbEn, branch, s,imm,hazardTwoSrc;
    wire [11:0] shiftOperand;
    wire [23:0] imm24;
    wire [3:0] src1OutId, src2OutId;

    // ID-EX
    wire [31:0] pcOutIdEx;
    wire [3:0] aluCmdOutIdEx;
    wire memReadOutIdEx, memWriteOutIdEx, wbEnOutIdEx, branchOutIdEx, sOutIdEx;
    wire [31:0] regRnOutIdEx, regRmOutIdEx;
    wire immOutIdEx;
    wire [11:0] shiftOperandOutIdEx;
    wire [23:0] imm24OutIdEx;
    wire [3:0] destOutIdEx;
    wire [3:0] src1OutIdEx, src2OutIdEx;
    // EXE
    wire memReadOutEx, memWriteOutEx, wbEnOutEx;
    wire branchTakenEX;
    wire [31:0] branchAddrEX;
    wire [31:0] aluResOutEx, reg2OutEx;
    wire [3:0] destOutEx;
    wire [3:0] statusEX; // N Z C V
    wire carryIn;
    assign carryIn = statusEX[1];
    // EX-MEM
    wire memReadOutExMem, memWriteOutExMem, wbEnOutExMem;
    wire [31:0] aluResOutExMem, reg2OutExMem;
    wire [3:0] destOutExMem;
    // Memory
    wire wbEnOutMem, memREnOutMem;
    wire [31:0] aluResOutMem, memOutMem;
    wire [3:0] destOutMem;
    // MEM-WB
    wire wbEnOutMemWb, memREnOutMemWb;
    wire [31:0] aluResOutMemWb, memDataOutMemWb;
    wire [3:0] destOutMemWb;
    // WB
    wire[31:0] WbValue;
    // Hazard
    wire hazard;
    // Forwarding
    wire [1:0] selSrc1, selSrc2;

    StageIF IF(
        .clk(clk),
        .rst(rst),
        .freeze(hazard),
        .branchTaken(branchTakenEX),
        .branchAddr(branchAddrEX),
        .pc(pcOutIf),
        .instruction(instOutIF)
    );

    RegIFID regIFID(
        .clk(clk),
        .rst(rst),
        .freeze(hazard),
        .flush(branchTakenEX),
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
        .status(statusEX),
        .wbWbEn(wbEnOutMemWb),
        .wbValue(WbValue),
        .wbDest(destOutMemWb),
        .hazard(hazard),
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
        .hazardTwoSrc(hazardTwoSrc),
        .hazardRn(hazardRn),
        .hazardRdm(hazardRdm),
        .src1(src1OutId), 
        .src2(src2OutId)
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
        .src1In(src1OutId), 
        .src2In(src2OutId),
        .flush(branchTakenEX), 
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
        .destOut(destOutIdEx),        
        .src1Out(src1OutIdEx), 
        .src2Out(src2OutIdEx)
    );

    StageEx stageEx(
        .clk(clk),
        .rst(rst),
        .wbEnIn(wbEnOutIdEx),
        .memREnIn(memReadOutIdEx),
        .memWEnIn(memWriteOutIdEx),
        .branchTakenIn(branchOutIdEx),
        .ldStatus(sOutIdEx),
        .imm(immOutIdEx),
        .carryIn(carryIn),
        .exeCmd(aluCmdOutIdEx),
        .val1(regRnOutIdEx),
        .valRm(regRmOutIdEx),
        .pc(pcOutIdEx),
        .shifterOperand(shiftOperandOutIdEx),
        .signedImm24(imm24OutIdEx),
        .dest(destOutIdEx),
        .wbEnOutEX(wbEnOutEx),
        .memREnOut(memReadOutEx),
        .memWEnOut(memWriteOutEx),
        .branchTakenOut(branchTakenEX),
        .aluRes(aluResOutEx),
        .exeValRm(reg2OutEx),
        .branchAddr(branchAddrEX),
        .exeDest(destOutEx),
        .status(statusEX),
        .selSrc1(selSrc1), 
        .selSrc2(selSrc2),
        .valMem(aluResOutExMem),
        .valWb(WbValue)
    );

    RegsExMem regsExMem(
        .clk(clk),
        .rst(rst),
        .wbEnIn(wbEnOutEx),
        .memREnIn(memReadOutEx),
        .memWEnIn(memWriteOutEx),
        .aluResIn(aluResOutEx),
        .valRmIn(reg2OutEx),
        .destIn(destOutEx),
        .wbEnOut(wbEnOutExMem),
        .memREnOut(memReadOutExMem),
        .memWEnOut(memWriteOutExMem),
        .aluResOut(aluResOutExMem),
        .valRmOut(reg2OutExMem),
        .destOut(destOutExMem)
    );

    StageMem stageMem(
        .clk(clk),
        .rst(rst),
        .wbEnIn(wbEnOutExMem),
        .memREnIn(memReadOutExMem),
        .memWEnIn(memWriteOutExMem),
        .aluResIn(aluResOutExMem),
        .valRm(reg2OutExMem),
        .destIn(destOutExMem),
        .wbEnOut(wbEnOutMem),
        .memREnOut(memREnOutMem),
        .aluResOut(aluResOutMem),
        .memOut(memOutMem),
        .destOut(destOutMem)
    );

    RegsMemWb regsMemWb(
        .clk(clk),
        .rst(rst),
        .wbEnIn(wbEnOutMem),
        .memREnIn(memREnOutMem),
        .aluResIn(aluResOutMem),
        .memDataIn(memOutMem),
        .destIn(destOutMem),
        .wbEnOut(wbEnOutMemWb),
        .memREnOut(memREnOutMemWb),
        .aluResOut(aluResOutMemWb),
        .memDataOut(memDataOutMemWb),
        .destOut(destOutMemWb)
    );

    MUX2to1 #(32) writeBackStage(
        .input1(aluResOutMemWb),
        .input2(memDataOutMemWb),
        .sel(memREnOutMemWb),
        .out(WbValue)
    );

    HazardUnit hzrd(
        .rn(src1OutId), 
        .rdm(src2OutId),
        .twoSrc(hazardTwoSrc),
        .destEx(destOutEx), 
        .destMem(destOutMem),
        .wbEnEx(wbEnOutEx), 
        .wbEnMem(wbEnOutMem),
        .memREn(memReadOutEx),
        .forwardEn(forwardingEn),
        .hazard(hazard)
    );

    ForwardingUnit forwardUnit(
        .forwardEn(forwardingEn),
        .src1(src1OutIdEx),
        .src2(src2OutIdEx),
        .wbEnMem(wbEnOutExMem),
        .wbEnWb(wbEnOutMemWb),
        .destMem(destOutExMem),
        .destWb(destOutMemWb),
        .selSrc1(selSrc1),
        .selSrc2(selSrc2)
    );



endmodule
