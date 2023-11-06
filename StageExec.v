module StageEx(
    input clk, rst,
    input wbEnIn, memREnIn, memWEnIn, branchTakenIn, ldStatus, imm, carryIn,
    input [3:0] exeCmd,
    input [31:0] val1, valRm, pc,
    input [11:0] shifterOperand,
    input [23:0] signedImm24,
    input [3:0] dest,
    output wbEnOutEX, memREnOut, memWEnOut, branchTakenOut,
    output [31:0] aluRes, exeValRm, branchAddr,
    output [3:0] exeDest,
    output [3:0] status
);
    assign wbEnOutEX = wbEnIn;
    assign memREnOut = memREnIn;
    assign memWEnOut = memWEnIn;
    assign branchTakenOut = branchTakenIn;
    assign exeDest = dest;

    wire [31:0]  val2;
    assign exeValRm = valRm;

    Val2Generator val2Generator(
        .memInst(memREnIn | memWEnIn),
        .imm(imm),
        .valRm(valRm),
        .shifterOperand(shifterOperand),
        .val2(val2)
    );

    wire [3:0] statusBits;
    RegisterNegEdge #(4) statusRegister(
        .clk(clk),
        .rst(rst),
        .ld(ldStatus),
        .clr(1'b0),
        .in(statusBits),
        .out(status)
    );

    ALU #(32) alu(
        .a(val1),
        .b(val2),
        .carryIn(carryIn),
        .EXE_CMD(exeCmd),
        .out(aluRes),
        .status(statusBits)
    );

    wire [31:0] imm24SignExt;
    assign imm24SignExt = {{6{signedImm24[23]}}, signedImm24, 2'b00};
    Adder #(32) branchCalculator(
        .a(pc),
        .b(imm24SignExt),
        .out(branchAddr)
    );

endmodule