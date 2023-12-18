`timescale 1ns/1ns
module TB();
    reg clk = 1'b0, rst = 1'b0, forwardEn = 1'b1;
    
    wire SRAM_WE_N;
    wire [17:0] SRAM_ADDR;
    wire [15:0] SRAM_DQ;
    
    Sram sram(
        .clk(clk), .rst(rst),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_DQ(SRAM_DQ)
    );

    Top top(
        .clk(clk),
        .rst(rst),
        .forwardingEn(forwardEn),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_UB_N(),
        .SRAM_LB_N(),
        .SRAM_CE_N(),
        .SRAM_OE_N()
    );

    initial begin
        #50 rst = 1'b1;
        #50 rst = 1'b0;

        #100000;
	    $stop;
    end

    always #50 clk = ~clk;
endmodule
