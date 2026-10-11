
`timescale 1ns/1ps

module tb_alu_8bit;

    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] opcode;

    wire [7:0] result;
    wire zero;
    wire carry;

    integer passed;

    alu_8bit uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry)
    );

    task check_result;
        input [7:0] expected_result;
        input expected_zero;
        input expected_carry;
        input [8*35-1:0] test_name;
        begin
            #1;
            if (result === expected_result &&
                zero === expected_zero &&
                carry === expected_carry) begin
                $display("PASS: %0s", test_name);
                passed = passed + 1;
            end else begin
                $display("FAIL: %0s", test_name);
                $display("Expected result=%h zero=%b carry=%b",
                         expected_result, expected_zero, expected_carry);
                $display("Actual   result=%h zero=%b carry=%b",
                         result, zero, carry);
            end
        end
    endtask

    initial begin
        passed = 0;

        a = 8'd10;
        b = 8'd5;

        opcode = 4'b0000;
        check_result(8'd15, 0, 0, "Addition");

        opcode = 4'b0001;
        check_result(8'd5, 0, 1, "Subtraction");

        opcode = 4'b0010;
        check_result(8'd0, 1, 0, "AND");

        opcode = 4'b0011;
        check_result(8'd15, 0, 0, "OR");

        opcode = 4'b0100;
        check_result(8'd15, 0, 0, "XOR");

        opcode = 4'b0101;
        check_result(8'hF5, 0, 0, "NOT A");

        opcode = 4'b0110;
        check_result(8'd64, 0, 0, "Left shift");

        opcode = 4'b0111;
        check_result(8'd1, 0, 0, "Right shift");

        opcode = 4'b1000;
        check_result(8'd0, 1, 0, "Unsigned less-than");

        opcode = 4'b1001;
        check_result(8'd0, 1, 0, "Equality comparison");

        // Test carry on addition: 250 + 10 = 260
        a = 8'd250;
        b = 8'd10;
        opcode = 4'b0000;
        check_result(8'd4, 0, 1, "Addition carry");

        // Test zero flag
        a = 8'd20;
        b = 8'd20;
        opcode = 4'b0001;
        check_result(8'd0, 1, 0, "Zero result");

        $display("--------------------------------");
        $display("Tests passed: %0d/12", passed);

        if (passed == 12)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $finish;
    end

endmodule
