
`timescale 1ns/1ps

module tb_operand_isolation;

    reg [7:0] b;
    reg enable_b;

    wire [7:0] b_isolated;

    integer passed;

    operand_isolation uut (
        .b(b),
        .enable_b(enable_b),
        .b_isolated(b_isolated)
    );

    task check_result;
        input [7:0] expected;
        input [8*35-1:0] test_name;
        begin
            #1;
            if (b_isolated === expected) begin
                $display("PASS: %0s", test_name);
                passed = passed + 1;
            end else begin
                $display("FAIL: %0s", test_name);
                $display("Expected=%h Actual=%h", expected, b_isolated);
            end
        end
    endtask

    initial begin
        passed = 0;

        // Test 1: Enabled, pass a nonzero value
        b = 8'hA5;
        enable_b = 1;
        check_result(8'hA5, "Enabled passes operand");

        // Test 2: Disabled, force output to zero
        enable_b = 0;
        check_result(8'h00, "Disabled isolates operand");

        // Test 3: Input changes while disabled
        b = 8'hFF;
        check_result(8'h00, "Disabled output stays zero");

        // Test 4: Re-enable with a new value
        enable_b = 1;
        b = 8'h3C;
        check_result(8'h3C, "Enabled passes new operand");

        $display("--------------------------------");
        $display("Tests passed: %0d/4", passed);

        if (passed == 4)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;
    end

endmodule
