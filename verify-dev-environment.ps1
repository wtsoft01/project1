Set-StrictMode -Version Latest
$ErrorActionPreference = 'Continue'

$checks = @(
    @{ Name = 'Git'; Command = 'git' },
    @{ Name = 'VS Code'; Command = 'code' },
    @{ Name = 'Node.js'; Command = 'node' },
    @{ Name = 'npm'; Command = 'npm' },
    @{ Name = 'Python'; Command = 'python' },
    @{ Name = 'WSL'; Command = 'wsl' },
    @{ Name = 'Docker'; Command = 'docker' }
)

$failed = 0
foreach ($check in $checks) {
    $command = Get-Command $check.Command -ErrorAction SilentlyContinue
    if ($command) {
        $version = (& $check.Command --version 2>&1 | Select-Object -First 1)
        Write-Host "[OK]   $($check.Name): $version" -ForegroundColor Green
    } else {
        Write-Host "[MISS] $($check.Name): command '$($check.Command)' not found" -ForegroundColor Yellow
        $failed++
    }
}

if ($failed -gt 0) {
    Write-Host "`n$failed tool(s) are missing. Follow DEV-SETUP.md." -ForegroundColor Yellow
    exit 1
}

Write-Host '`nDevelopment environment looks ready.' -ForegroundColor Green
