module InstructionMemory(
    input [31:0] pc,
    output reg [31:0] inst
);
    reg [31:0] instMem [0:7];

    assign instMem[0] = 32'b000000_00001_00010_00000_00000000000; 
    assign instMem[1] = 32'b000000_00011_00100_00000_00000000000; 
    assign instMem[2] = 32'b000000_00101_00110_00000_00000000000; 
    assign instMem[3] = 32'b000000_00111_01000_00010_00000000000; 
    assign instMem[4] = 32'b000000_01001_01010_00011_00000000000; 
    assign instMem[5] = 32'b000000_01011_01100_00000_00000000000;
    assign instMem[6] = 32'b000000_01101_01110_00000_00000000000;

    assign inst = instMem[pc >> 2];
endmodule
