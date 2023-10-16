module Top(
    input clk, rst,
    output [31:0] pc, instruction
);
    StageIF IF(
        .clk(clk),
        .rst(rst),
        .freeze(1'b0),
        .branchTaken(1'b0),
        .branchAddr(32'd0),
        .pc(pc),
        .instruction(instruction)
    );
endmodule
