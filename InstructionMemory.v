module InstructionMemory(
    input [31:0] pc,
    output [31:0] inst
);
    wire [31:0] instMem [0:31];

    assign instMem[0] = 32'b1110_00_1_1101_0_0000_0000_000000010100; 
    assign instMem[1] = 32'b1110_00_1_1101_0_0000_0001_101000000001; 
    assign instMem[2] = 32'b1110_00_1_1101_0_0000_0010_000100000011; 
    assign instMem[3] = 32'b1110_00_0_0100_1_0010_0011_000000000010; 
    assign instMem[4] = 32'b1110_00_0_0101_0_0000_0100_000000000000; 
    assign instMem[5] = 32'b1110_00_0_0010_0_0100_0101_000100000100;
    assign instMem[6] = 32'b1110_00_0_0110_0_0000_0110_000010100000;
    assign instMem[7] = 32'b1110_00_0_1100_0_0101_0111_000101000010;
    assign instMem[8] = 32'b1110_00_0_0000_0_0111_1000_000000000011;
    assign instMem[9] = 32'b1110_00_0_1111_0_0000_1001_000000000110; 
    assign instMem[10] = 32'b1110_00_0_0001_0_0100_1010_000000000101;
    assign instMem[11] = 32'b1110_00_0_1010_1_1000_0000_000000000110;
    assign instMem[12] = 32'b0001_00_0_0100_0_0001_0001_000000000001;
    assign instMem[13] = 32'b1110_00_0_1000_1_1001_0000_000000001000;
    assign instMem[14] = 32'b0000_00_0_0100_0_0010_0010_000000000010; 
    assign instMem[15] = 32'b1110_00_1_1101_0_0000_0000_101100000001;
    assign instMem[16] = 32'b1110_01_0_0100_0_0000_0001_000000000000;
    assign instMem[17] = 32'b1110_01_0_0100_1_0000_1011_000000000000;

    assign inst = instMem[pc >> 2];
endmodule
