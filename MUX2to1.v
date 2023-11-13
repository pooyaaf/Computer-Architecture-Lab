
module MUX2to1 #(
    parameter N = 32
)(
    input [N-1:0] input1, input2,
    input sel,
    output [N-1:0] out
);
    assign out = sel ? input2 : input1;
endmodule
