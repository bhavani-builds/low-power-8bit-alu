
# Low-Power 8-Bit ALU Design Using Verilog

A Verilog RTL project implementing an 8-bit Arithmetic Logic Unit (ALU) with arithmetic, logical, shift, and comparison operations.

> **Project status:** Functional RTL and testbench development. Low-power optimization and measurement are future work.

## Features

- 8-bit input operands
- Addition and subtraction
- AND, OR, XOR, and NOT operations
- Logical left and right shifts
- Unsigned comparison and equality detection
- Zero flag and carry output
- Self-checking Verilog testbench

## Architecture

The ALU accepts two 8-bit operands and a 4-bit opcode. Combinational logic selects the requested operation and produces an 8-bit result.

## Opcode Table

| Opcode | Operation |
|---|---|
| `0000` | ADD |
| `0001` | SUB |
| `0010` | AND |
| `0011` | OR |
| `0100` | XOR |
| `0101` | NOT A |
| `0110` | Logical left shift |
| `0111` | Logical right shift |
| `1000` | Unsigned less-than |
| `1001` | Equality |

## Project Structure

```text
low-power-8bit-alu/
├── rtl/
│   └── alu_8bit.v
├── testbench/
│   └── tb_alu_8bit.v
├── docs/
│   └── architecture.md
└── README.md
```

## Simulation

Install Icarus Verilog and run:

```bash
iverilog -g2012 -s tb_alu_8bit -o alu_test rtl/alu_8bit.v testbench/tb_alu_8bit.v
vvp alu_test
```

The testbench checks the implemented operations and status outputs.

## Low-Power Optimization Roadmap

The current design is a functional baseline. Planned work includes:

1. Establish baseline synthesis area and timing.
2. Investigate operand isolation to reduce unnecessary switching.
3. Compare baseline and optimized implementations.
4. Evaluate switching activity and estimated dynamic power using appropriate tools.

No power reduction is claimed until measurements support it.

## Skills Demonstrated

- Verilog HDL
- RTL design
- Combinational logic
- Functional verification
- Digital design simulation
- Synthesis and low-power design concepts

## Future Enhancements

- Add more corner-case tests.
- Measure functional coverage.
- Compare synthesis results before and after optimization.
- Add simulation waveforms and results to the documentation.
