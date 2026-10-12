
# Low-Power 8-Bit ALU Using Verilog HDL

## Overview

This project implements an 8-bit Arithmetic Logic Unit (ALU)
using Verilog HDL and explores operand isolation as a
low-power design technique.

The design includes a baseline ALU and an optimized ALU
with operand isolation logic. Both versions are tested
using identical input patterns.

## Features

- 8-bit arithmetic and logic operations
- Addition and subtraction
- AND, OR, XOR, and NOT operations
- Left and right shift operations
- Unsigned comparison and equality checking
- Zero and carry outputs
- Operand isolation logic
- Baseline-versus-optimized functional comparison
- Switching activity experiment

## Supported Operations

| Opcode | Operation |
|---|---|
| 0000 | Addition |
| 0001 | Subtraction |
| 0010 | AND |
| 0011 | OR |
| 0100 | XOR |
| 0101 | NOT A |
| 0110 | Left shift |
| 0111 | Right shift |
| 1000 | Unsigned less-than |
| 1001 | Equality |

## Project Structure

```text
low-power-8bit-alu/
├── rtl/
│   ├── alu_8bit.v
│   ├── alu_8bit_baseline.v
│   └── operand_isolation.v
├── testbench/
│   ├── tb_alu_8bit.v
│   ├── tb_operand_isolation.v
│   ├── tb_alu_activity.v
│   ├── tb_alu_comparison.v
│   └── tb_switching_activity.v
├── docs/
│   └── architecture.md
├── .gitignore
└── README.md
```

## Operand Isolation

Operand isolation reduces unnecessary switching in a
selected datapath by forcing an unused operand to zero.

In this implementation, the B operand is isolated during
the NOT-A operation. The isolation behavior is verified
using a dedicated switching activity testbench.

## Verification

The testbenches cover:

- ALU arithmetic and logic operations
- Operand isolation behavior
- Baseline and optimized output comparison
- Switching activity on the operand path

## Simulation

Install Icarus Verilog and run commands from the project root.

### Compare ALU outputs

```bash
iverilog -g2012 -s tb_alu_comparison -o compare_test rtl/operand_isolation.v rtl/alu_8bit.v rtl/alu_8bit_baseline.v testbench/tb_alu_comparison.v
vvp compare_test
```

### Check switching activity

```bash
iverilog -g2012 -s tb_switching_activity -o switching_test rtl/operand_isolation.v rtl/alu_8bit.v rtl/alu_8bit_baseline.v testbench/tb_switching_activity.v
vvp switching_test
```

## Power Evaluation

The switching activity experiment measures transitions
on selected operand signals. It does not establish total
power consumption or prove overall power savings.

A complete power evaluation would require synthesis and
appropriate power analysis under comparable constraints
and workloads.

## Future Improvements

- Add clocked low-power datapath experiments
- Evaluate synthesis area and timing
- Compare switching activity across more operations
- Use a supported ASIC or FPGA power-analysis flow

## Tools

- Verilog HDL
- Icarus Verilog
- GTKWave (optional)
- Git and GitHub

## Author

Digital Design and VLSI Learning Project
