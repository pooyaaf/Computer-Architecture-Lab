module RegIDEX(
    input clk, rst,
    input [31:0] pcIn,
    input [3:0] aluCmdIn,
    input memReadIn, memWriteIn, wbEnIn, branchIn, sIn,
    input [31:0] regRnIn, regRmIn,
    input immIn,
    input [11:0] shiftOperandIn,
    input signed [23:0] imm24In,
    input [3:0] destIn,
    input [3:0] src1In, src2In,
    input flush,
    output [31:0] pcOut,
    output [3:0] aluCmdOut,
    output memReadOut, memWriteOut, wbEnOut, branchOut, sOut,
    output [31:0] regRnOut, regRmOut,
    output immOut,
    output [11:0] shiftOperandOut,
    output signed [23:0] imm24Out,
    output [3:0] destOut,
    output [3:0] src1Out, src2Out

);
    Register #(32) pcReg(
        .clk(clk), .rst(rst),
        .in(pcIn), .ld(1'b1), .clr(flush),
        .out(pcOut)
    );

    Register #(4) aluCmdReg(
        .clk(clk), .rst(rst),
        .in(aluCmdIn), .ld(1'b1), .clr(flush),
        .out(aluCmdOut)
    );

    Register #(1) memReadReg(
        .clk(clk), .rst(rst),
        .in(memReadIn), .ld(1'b1), .clr(flush),
        .out(memReadOut)
    );
    Register #(1) memWriteReg(
        .clk(clk), .rst(rst),
        .in(memWriteIn), .ld(1'b1), .clr(flush),
        .out(memWriteOut)
    );
    Register #(1) wbEnReg(
        .clk(clk), .rst(rst),
        .in(wbEnIn), .ld(1'b1), .clr(flush),
        .out(wbEnOut)
    );
    Register #(1) branchReg(
        .clk(clk), .rst(rst),
        .in(branchIn), .ld(1'b1), .clr(flush),
        .out(branchOut)
    );
    Register #(1) sReg(
        .clk(clk), .rst(rst),
        .in(sIn), .ld(1'b1), .clr(flush),
        .out(sOut)
    );

    Register #(32) regRn(
        .clk(clk), .rst(rst),
        .in(regRnIn), .ld(1'b1), .clr(flush),
        .out(regRnOut)
    );

    Register #(32) regRm(
        .clk(clk), .rst(rst),
        .in(regRmIn), .ld(1'b1), .clr(flush),
        .out(regRmOut)
    );

    Register #(1) immReg(
        .clk(clk), .rst(rst),
        .in(immIn), .ld(1'b1), .clr(flush),
        .out(immOut)
    );

    Register #(12) shiftOperandReg(
        .clk(clk), .rst(rst),
        .in(shiftOperandIn), .ld(1'b1), .clr(flush),
        .out(shiftOperandOut)
    );

    Register #(24) imm24Reg(
        .clk(clk), .rst(rst),
        .in(imm24In), .ld(1'b1), .clr(flush),
        .out(imm24Out)
    );

    Register #(4) destReg(
        .clk(clk), .rst(rst),
        .in(destIn), .ld(1'b1), .clr(flush),
        .out(destOut)
    );
    
    Register #(4) src1Reg(
        .clk(clk), .rst(rst),
        .in(src1In), .ld(1'b1), .clr(flush),
        .out(src1Out)
    );

     Register #(4) src2Reg(
        .clk(clk), .rst(rst),
        .in(src2In), .ld(1'b1), .clr(flush),
        .out(src2Out)
    );

endmodule

