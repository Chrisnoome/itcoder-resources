# Starts the control centre server hidden on http://127.0.0.1:8787 (control-centre-design.md).
# Opens nothing: view it in the Claude app's browser pane (launch.json "control-centre").
# Server errors go to logs\control-centre.log (gitignored).
$ErrorActionPreference = 'Stop'
$root = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$server = Join-Path $PSScriptRoot 'server.py'
$logDir = Join-Path $root 'logs'
New-Item -ItemType Directory -Force $logDir | Out-Null

$busy = Get-NetTCPConnection -LocalAddress 127.0.0.1 -LocalPort 8787 -State Listen -ErrorAction SilentlyContinue
if ($busy) {
    Write-Output "Control centre already running (pid $($busy.OwningProcess)) on http://127.0.0.1:8787"
    return
}

$python = (Get-Command python -ErrorAction Stop).Source
Start-Process -FilePath $python -ArgumentList ('"{0}"' -f $server) -WorkingDirectory $root `
    -WindowStyle Hidden -RedirectStandardError (Join-Path $logDir 'control-centre.log') `
    -RedirectStandardOutput (Join-Path $logDir 'control-centre.out.log')
Start-Sleep -Milliseconds 800
Write-Output 'Control centre started on http://127.0.0.1:8787'
