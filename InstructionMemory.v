module InstructionMemory(
    input [31:0] pc,
    output reg [31:0] inst
);
    reg [31:0] instMem [0:15];

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

    assign inst = instMem[pc >> 2];
endmodule
