
# Run from the project root in Windows PowerShell

$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force build | Out-Null

Write-Host "Synthesizing baseline ALU..."
yosys -s scripts/synthesize_alu.ys 2>&1 |
    Tee-Object -FilePath build/baseline_synthesis.log

if ($LASTEXITCODE -ne 0) {
    throw "Baseline synthesis failed."
}

Write-Host "Synthesizing optimized ALU..."
yosys -s scripts/synthesize_alu_optimized.ys 2>&1 |
    Tee-Object -FilePath build/optimized_synthesis.log

if ($LASTEXITCODE -ne 0) {
    throw "Optimized synthesis failed."
}

Write-Host "Synthesis runs completed."
Write-Host "Check the logs in the build folder."
Write-Host "Compare cell counts and other statistics."
