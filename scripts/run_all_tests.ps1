
$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force build | Out-Null

function Run-VerilogTest {
    param (
        [string]$Name,
        [string[]]$Sources
    )

    Write-Host "`n========== $Name =========="

    & iverilog -g2012 -s $Name -o "build/$Name" $Sources

    if ($LASTEXITCODE -ne 0) {
        throw "Compilation failed: $Name"
    }

    & vvp "build/$Name"

    if ($LASTEXITCODE -ne 0) {
        throw "Simulation failed: $Name"
    }
}

$aluSources = @(
    "rtl/operand_isolation.v",
    "rtl/alu_8bit.v"
)

Run-VerilogTest "tb_alu_8bit" (
    $aluSources + @("testbench/tb_alu_8bit.v")
)

Run-VerilogTest "tb_operand_isolation" @(
    "rtl/operand_isolation.v",
    "testbench/tb_operand_isolation.v"
)

$comparisonSources = @(
    "rtl/alu_8bit_baseline.v",
    "rtl/operand_isolation.v",
    "rtl/alu_8bit.v"
)

Run-VerilogTest "tb_alu_comparison" (
    $comparisonSources + @("testbench/tb_alu_comparison.v")
)

Run-VerilogTest "tb_switching_activity" (
    $comparisonSources + @("testbench/tb_switching_activity.v")
)

Write-Host "`nAll simulations completed successfully."
