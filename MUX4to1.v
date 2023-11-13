
module MUX4to1 #(
    parameter N = 32
)(
    input [N-1:0] input00, input01, input10, input11,
    input [1:0] sel,
    output [N-1:0] out
);
    assign out = (sel == 2'b00) ? input00 :
                 (sel == 2'b01) ? input01 :
                 (sel == 2'b10) ? input10 : input11;
endmodule