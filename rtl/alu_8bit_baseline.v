
module alu_8bit_baseline (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [3:0] opcode,
    output reg  [7:0] result,
    output reg        zero,
    output reg        carry
);

    always @(*) begin
        result = 8'b0;
        carry  = 1'b0;

        case (opcode)
            4'b0000: begin // ADD
                {carry, result} = {1'b0, a} + {1'b0, b};
            end

            4'b0001: begin // SUBTRACT
                result = a - b;
                carry  = (a >= b);
            end

            4'b0010: result = a & b; // AND
            4'b0011: result = a | b; // OR
            4'b0100: result = a ^ b; // XOR
            4'b0101: result = ~a;    // NOT A

            4'b0110: result = a << b[2:0]; // LEFT SHIFT
            4'b0111: result = a >> b[2:0]; // RIGHT SHIFT

            4'b1000: result = (a < b) ? 8'd1 : 8'd0;
            4'b1001: result = (a == b) ? 8'd1 : 8'd0;

            default: result = 8'b0;
        endcase

        zero = (result == 8'b0);
    end

endmodule
