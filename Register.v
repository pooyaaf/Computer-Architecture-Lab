module Register #(
    parameter N = 32
)(
    input clk, rst,
    input [N-1:0] in,
    input ld,
    output reg [N-1:0] out
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= {N{1'b0}};
        else if (ld)
            out <= in;
    end
endmodule