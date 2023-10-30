`timescale 1ns/1ns
module TB();
    reg clk = 1'b0, rst = 1'b0;

    Top top(
        .clk(clk),
        .rst(rst)
    );


    
    initial begin
        #50 rst = 1'b1;
        #50 rst = 1'b0;

        #10000;
	    $stop;
    end

    always #50 clk = ~clk;
endmodule