# Stops any Excel or Word left running in the CAT VM by a catexcel screen
# script that failed with a dialog box open (catexcel-printing.ps1, 8 October
# 2026). Runs under vm-shots.ps1's lock, so no other writer's run is going.
#     pwsh -File vm-shots.ps1 catexcel-cleanup        (from the host)
$Name = 'catexcel-cleanup'
Get-Process EXCEL, WINWORD -ErrorAction SilentlyContinue | ForEach-Object { "stopping $($_.Name) $($_.Id) (started $($_.StartTime))"; Stop-Process -Id $_.Id -Force }
'done'
