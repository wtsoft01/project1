param(
    [Parameter(Mandatory = $true)]
    [string]$Email
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$sshDir = Join-Path $env:USERPROFILE '.ssh'
$keyPath = Join-Path $sshDir 'id_ed25519'

New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
if (Test-Path -LiteralPath $keyPath) {
    Write-Host "Existing key found at $keyPath; nothing was overwritten." -ForegroundColor Yellow
    exit 0
}

ssh-keygen -t ed25519 -C $Email -f $keyPath
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
ssh-add $keyPath
Write-Host "Public key (add this to GitHub > Settings > SSH keys):" -ForegroundColor Green
Get-Content -LiteralPath "$keyPath.pub"
