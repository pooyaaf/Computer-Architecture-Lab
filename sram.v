module Sram(
    input clk, rst,
    input SRAM_WE_N,
    input [17:0] SRAM_ADDR,
    inout [15:0] SRAM_DQ
);
    reg [15:0] memory [0:511];
    reg [15:0] ss;

    always @(posedge clk) begin
        if (SRAM_WE_N == 1'b0) begin
            memory[SRAM_ADDR] = SRAM_DQ;
        end
        else begin
            ss = memory[SRAM_ADDR];
        end
    end
    assign SRAM_DQ = SRAM_WE_N ? ss : 16'dz;
endmodule
