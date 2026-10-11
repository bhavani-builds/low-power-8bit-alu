
# 8-Bit ALU Architecture

## 1. Overview

This project implements an 8-bit Arithmetic Logic Unit (ALU)
using Verilog HDL. The ALU performs arithmetic, logical,
shift, and comparison operations on two 8-bit inputs.

The design is intended for RTL design practice and functional
verification. Low-power improvements will be evaluated in
future synthesis and power-analysis experiments.

## 2. Architecture

The ALU accepts two operands, A and B, and a 4-bit opcode.

```text
       Input A (8-bit) ─────┐
                            │
       Input B (8-bit) ─────┤
                            ▼
                    ┌──────────────┐
       Opcode ─────►│  ALU Control │
                    │  and Logic   │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ Result Select│
                    └──────┬───────┘
                           │
                  Result (8-bit)
                           │
                     Zero / Carry
```

## 3. Supported Operations

| Opcode | Operation | Description |
|---|---|---|
| 0000 | ADD | A + B |
| 0001 | SUB | A - B |
| 0010 | AND | Bitwise AND |
| 0011 | OR | Bitwise OR |
| 0100 | XOR | Bitwise XOR |
| 0101 | NOT | Bitwise inversion of A |
| 0110 | SLL | Logical left shift |
| 0111 | SRL | Logical right shift |
| 1000 | SLTU | Unsigned less-than |
| 1001 | EQ | Equality comparison |

## 4. Input and Output Signals

- `a`: First 8-bit operand.
- `b`: Second 8-bit operand.
- `opcode`: Selects the operation.
- `result`: 8-bit operation result.
- `zero`: High when the result is zero.
- `carry`: Carry-out for addition; subtraction indicates
  no borrow when A is greater than or equal to B.

## 5. Verification

The testbench checks arithmetic and logic operations,
shift behavior, carry output, and the zero flag.

Simulation can be performed using Icarus Verilog:

```bash
iverilog -g2012 -s tb_alu_8bit -o alu_test rtl/alu_8bit.v testbench/tb_alu_8bit.v
vvp alu_test
```

## 6. Future Improvements

- Add operand isolation to reduce unnecessary switching.
- Compare synthesized area and timing before and after optimization.
- Estimate dynamic power using switching activity and a supported
  synthesis or power-analysis flow.
- Add more corner-case tests and coverage measurements.

## 7. Learning Outcomes

- Verilog combinational logic design.
- RTL coding and opcode-based operation selection.
- Self-checking testbench development.
- Functional simulation and preparation for synthesis.
