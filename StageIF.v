module StageIF (
    input clk,rst,
    input freeze, branchTaken,
    input[31:0] branchAddr,
    output [31:0] pc, instruction
);
    wire clr = 1'b0;
    wire [31:0] pcRegOut, lastPc, pcAdderOut, instructionOut;

    MUX2to1 #(32) PC_Mux(
        .input1(pcAdderOut),
        .input2(branchAddr),
        .sel(branchTaken),
        .out(lastPc)
    );

    Register #(32) PC_Reg(
        .clk(clk),
        .rst(rst),
        .in(lastPc),
        .ld(~freeze),
        .clr(clr),
        .out(pcRegOut)
    );

    InstructionMemory Inst_Mem(
        .pc(pcRegOut),
        .inst(instructionOut)
    );

    Adder #(32) PC_Adder(
        .a(pcRegOut),
        .b(32'd4),
        .out(pcAdderOut)
    );

    assign pc = pcAdderOut;
    assign instruction = instructionOut;
endmodule

