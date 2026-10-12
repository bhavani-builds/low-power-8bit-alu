
`timescale 1ns/1ps

module tb_alu_comparison;

    reg  [7:0] a;
    reg  [7:0] b;
    reg  [3:0] opcode;

    wire [7:0] baseline_result;
    wire [7:0] optimized_result;

    wire baseline_zero;
    wire optimized_zero;

    wire baseline_carry;
    wire optimized_carry;

    integer i;
    integer errors;

    alu_8bit_baseline baseline (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(baseline_result),
        .zero(baseline_zero),
        .carry(baseline_carry)
    );

    alu_8bit optimized (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(optimized_result),
        .zero(optimized_zero),
        .carry(optimized_carry)
    );

    task check_outputs;
        begin
            #10;

            if ((baseline_result !== optimized_result) ||
                (baseline_zero !== optimized_zero) ||
                (baseline_carry !== optimized_carry)) begin

                $display("FAIL: opcode=%b a=%d b=%d",
                         opcode, a, b);

                $display("Baseline: result=%d zero=%b carry=%b",
                         baseline_result,
                         baseline_zero,
                         baseline_carry);

                $display("Optimized: result=%d zero=%b carry=%b",
                         optimized_result,
                         optimized_zero,
                         optimized_carry);

                errors = errors + 1;
            end
        end
    endtask

    initial begin
        a = 0;
        b = 0;
        opcode = 0;
        errors = 0;

        // Test every supported opcode
        for (i = 0; i <= 9; i = i + 1) begin
            opcode = i;
            a = 8'd25;
            b = 8'd10;
            check_outputs;
        end

        // Test changing operands
        for (i = 0; i < 50; i = i + 1) begin
            a = (i * 7) & 255;
            b = (i * 13 + 3) & 255;
            opcode = i % 10;
            check_outputs;
        end

        // Test boundary values
        a = 8'd255;
        b = 8'd1;
        opcode = 4'b0000;
        check_outputs;

        a = 8'd0;
        b = 8'd255;
        opcode = 4'b0001;
        check_outputs;

        if (errors == 0)
            $display("PASS: Baseline and optimized ALUs match.");
        else
            $display("FAIL: %0d mismatches found.", errors);

        $finish;
    end

endmodule
