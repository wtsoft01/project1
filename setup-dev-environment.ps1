Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host 'Installing Windows development prerequisites...' -ForegroundColor Cyan

# Install or update WinGet (App Installer) through Microsoft Store before running this script.
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw 'winget is not installed. Install App Installer from Microsoft Store, then rerun this script.'
}

$packages = @(
    @{ Id = 'Microsoft.VisualStudioCode'; Name = 'Visual Studio Code' },
    @{ Id = 'Microsoft.WindowsTerminal'; Name = 'Windows Terminal' },
    @{ Id = 'OpenJS.NodeJS.LTS'; Name = 'Node.js LTS' },
    @{ Id = 'Python.Python.3.12'; Name = 'Python 3.12' },
    @{ Id = 'Git.Git'; Name = 'Git' }
)

foreach ($package in $packages) {
    Write-Host "Installing $($package.Name)..."
    winget install --id $package.Id --exact --source winget --accept-source-agreements --accept-package-agreements
}

Write-Host 'Enabling WSL2...' -ForegroundColor Cyan
wsl --install --no-distribution

# winget updates PATH outside the current PowerShell process. Reload it before checking.
$machinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$env:Path = "$machinePath;$userPath"

Write-Host 'Verifying installed tools...' -ForegroundColor Cyan
$checks = @('git', 'node', 'npm', 'python', 'code', 'wsl')
$missing = @()
foreach ($name in $checks) {
    if (Get-Command $name -ErrorAction SilentlyContinue) {
        & $name --version 2>&1 | Select-Object -First 1
    } else {
        $missing += $name
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Not visible until a new terminal is opened: $($missing -join ', ')" -ForegroundColor Yellow
}
Write-Host 'Done. Restart Windows if WSL requested it, then run: wsl --install -d Ubuntu' -ForegroundColor Green
