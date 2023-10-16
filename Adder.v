module Adder #(
    parameter N = 32
)(
    input [N-1:0] a, b,
    output reg [N-1:0] out
);
    assign out = a + b;
endmodule