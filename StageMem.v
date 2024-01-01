module StageMem(
    input clk, rst,
    input wbEnIn, memREnIn, memWEnIn,
    input [31:0] aluResIn, valRm,
    input [3:0] destIn,
    output wbEnOut, memREnOut,
    output [31:0] aluResOut, memOut,
    output [3:0] destOut,
    output freeze,
    inout [15:0] SRAM_DQ,
    output [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N
);
    wire sramReady;
    wire [63:0] sramReadData;
    wire sramWrEn, sramRdEn;
    assign memREnOut = memREnIn;
    assign aluResOut = aluResIn;
    assign destOut = destIn;

    wire ready;
    assign freeze = ~ready;

    SramController sramcontroller(
        .clk(clk), 
        .rst(rst),
        .wrEn(sramWrEn),
        .rdEn(sramRdEn),
        .address(aluResIn),
        .writeData(valRm),
        .readData(sramReadData),
        .ready(sramReady),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_UB_N(SRAM_UB_N),
        .SRAM_LB_N(SRAM_LB_N),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_CE_N(SRAM_CE_N),
        .SRAM_OE_N(SRAM_OE_N)
    );
    
    CacheController cacheController(
        .clk(clk), 
        .rst(rst),
        .rdEn(memREnIn), 
        .wrEn(memWEnIn),
        .address(aluResIn),
        .writeData(valRm),
        .readData(memOut),
        .ready(ready),
        .sramReady(sramReady),
        .sramReadData(sramReadData),
        .sramWrEn(sramWrEn), 
        .sramRdEn(sramRdEn)
    );

    // DataMemory mem(
    //     .clk(clk),
    //     .rst(rst),
    //     .memAdr(aluResIn),
    //     .writeData(valRm),
    //     .memRead(memREnIn),
    //     .memWrite(memWEnIn),
    //     .readData(memOut)
    // );

    MUX2to1 #(1) ramWbEn(
        .input1(wbEnIn),
        .input2(1'b0),
        .sel(freeze),
        .out(wbEnOut)
    );
endmodule
