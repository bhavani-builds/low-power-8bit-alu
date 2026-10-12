
module operand_isolation (
    input  wire [7:0] b,
    input  wire       enable_b,
    output wire [7:0] b_isolated
);

    // Pass operand B only when the selected operation needs it.
    // Otherwise, hold the internal operand at zero.
    assign b_isolated = enable_b ? b : 8'b0;

endmodule
