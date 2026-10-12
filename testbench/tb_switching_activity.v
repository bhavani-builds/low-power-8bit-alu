
`timescale 1ns/1ps

module tb_switching_activity;

    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] opcode;

    wire [7:0] baseline_result;
    wire [7:0] optimized_result;
    wire baseline_zero, optimized_zero;
    wire baseline_carry, optimized_carry;

    integer i;
    integer baseline_b_transitions;
    integer isolated_b_transitions;

    reg [7:0] previous_b;
    reg [7:0] previous_isolated_b;

    alu_8bit_baseline baseline (
        .a(a), .b(b), .opcode(opcode),
        .result(baseline_result),
        .zero(baseline_zero), .carry(baseline_carry)
    );

    alu_8bit optimized (
        .a(a), .b(b), .opcode(opcode),
        .result(optimized_result),
        .zero(optimized_zero), .carry(optimized_carry)
    );

    initial begin
        a = 0;
        b = 0;
        opcode = 4'b0101; // NOT A

        baseline_b_transitions = 0;
        isolated_b_transitions = 0;

        previous_b = 0;
        previous_isolated_b = 0;

        // Allow combinational signals to settle.
        #10;
        previous_b = b;
        previous_isolated_b = optimized.b_isolated;

        // Change B while NOT-A is selected.
        for (i = 0; i < 32; i = i + 1) begin
            a = (i * 7) & 255;
            b = (i * 13 + 5) & 255;
            #10;

            baseline_b_transitions =
                baseline_b_transitions +
                $countones(b ^ previous_b);

            isolated_b_transitions =
                isolated_b_transitions +
                $countones(optimized.b_isolated ^
                           previous_isolated_b);

            previous_b = b;
            previous_isolated_b = optimized.b_isolated;
        end

        $display("NOT-A operation switching activity");
        $display("Baseline B transitions: %0d",
                 baseline_b_transitions);
        $display("Isolated B transitions: %0d",
                 isolated_b_transitions);

        if (isolated_b_transitions == 0)
            $display("PASS: B operand is isolated during NOT-A.");
        else
            $display("CHECK: Isolated B changed during NOT-A.");

        $finish;
    end

endmodule
