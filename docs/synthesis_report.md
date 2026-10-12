
# Synthesis and Power Evaluation Report

## 1. Objective

Evaluate the baseline 8-bit ALU and the operand-isolated
ALU using equivalent design constraints and input workloads.

The objective is to examine functional correctness, cell
area, timing, and power-related metrics.

## 2. Designs Under Evaluation

### Baseline ALU

The baseline ALU uses the original B operand directly
in its combinational datapath.

### Optimized ALU

The optimized ALU uses operand isolation to force B to
zero during the NOT-A operation.

## 3. Functional Verification

| Test | Status |
|---|---|
| ALU operations | Pending simulation |
| Operand isolation | Pending simulation |
| Baseline/optimized equivalence | Pending simulation |

Update each status only after running the corresponding
testbench successfully.

## 4. Synthesis Results

| Metric | Baseline ALU | Optimized ALU |
|---|---|---|
| Technology/library | Not measured | Not measured |
| Cell area | Not measured | Not measured |
| Critical path delay | Not measured | Not measured |
| Dynamic power | Not measured | Not measured |
| Leakage power | Not measured | Not measured |

## 5. Measurement Method

1. Use the same synthesis tool and technology library.
2. Apply equivalent timing constraints.
3. Synthesize both designs under comparable settings.
4. Use the same input workload for power estimation.
5. Use switching activity data where supported.
6. Record tool versions, constraints, and results.

## 6. Interpretation

Operand isolation can reduce switching on a gated
operand path when that operand is not needed.

However, the isolation logic introduces additional hardware.
Its effect on total area, timing, and power depends on
the implementation and workload.

No overall power savings should be claimed until
measurements support the conclusion.

## 7. Conclusion

This project provides a baseline ALU, an operand-isolated
implementation, and testbenches for functional and
switching-activity experiments.

Synthesis and power results will be added after the
designs are evaluated with appropriate tools.
