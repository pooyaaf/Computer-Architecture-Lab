module Top(
    input clk, rst,
    output [31:0] pc, instruction
);
    wire [31:0] pcOutIf,instOutIF;

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
        .pcOut(pc),
        .instructionOut(instruction)
    );
  

endmodule
