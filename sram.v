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
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            memory[0] = 16'd0;
            memory[1] = 16'd0;
            memory[2] = 16'd0;
            memory[3] = 16'd0;
            memory[4] = 16'd0;
            memory[5] = 16'd0;
            memory[6] = 16'd0;
            memory[7] = 16'd0;
            memory[8] = 16'd0;
            memory[9] = 16'd0;
            memory[10] = 16'd0;
            memory[11] = 16'd0;
            memory[12] = 16'd0;
            memory[13] = 16'd0;
            memory[14] = 16'd0;
            memory[15] = 16'd0;
            memory[16] = 16'd0;
            memory[17] = 16'd0;
            memory[18] = 16'd0;
            memory[19] = 16'd0;
            memory[20] = 16'd0;
        end
    end

    assign SRAM_DQ = SRAM_WE_N ? ss : 16'dz;
endmodule
