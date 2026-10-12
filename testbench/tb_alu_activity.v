
`timescale 1ns/1ps

module tb_alu_activity;

    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] opcode;

    wire [7:0] result;
    wire zero;
    wire carry;

    integer i;

    alu_8bit uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry)
    );

    initial begin
        a = 0;
        b = 0;
        opcode = 0;

        // Create repeatable operand switching.
        // NOT-A does not logically require operand B.
        for (i = 0; i < 32; i = i + 1) begin
            #5;
            a = i * 7;
            b = i * 13;
            opcode = 4'b0101;
        end

        // Exercise operations that use operand B.
        for (i = 0; i < 32; i = i + 1) begin
            #5;
            a = i * 3;
            b = 255 - i * 5;
            opcode = 4'b0000;
        end

        #10;
        $display("Activity simulation completed.");
        $finish;
    end

endmodule
