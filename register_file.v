module RegisterFile #(
    parameter WordLen = 32
)(
    input clk, rst,
    input [3:0] readRegister1, readRegister2, writeRegister,
    input [WordLen-1:0] writeData,
    input writeEn,   
    output [WordLen-1:0] readData1, readData2
);
    reg [WordLen-1:0] regFile [0:14];

    //read
    assign readData1 = regFile[readRegister1];
    assign readData2 = regFile[readRegister2];

    integer i;
    initial begin
        for (i = 0; i < 15; i = i + 1)
            regFile[i] <= i;
    end

    //write
    always @(negedge clk or posedge rst) begin
        if (rst)
            for (i = 0; i < 15; i = i + 1)
                regFile[i] <= i;
        else if (writeEn)
            regFile[writeRegister] <= writeData;
    end
endmodule