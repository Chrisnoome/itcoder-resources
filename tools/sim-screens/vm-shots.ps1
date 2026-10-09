# Runs one screen script (a .ps1 in this folder) inside the CAT VM
# itcoder-cat (Chris, 8 October 2026: "Clone it for CAT") and brings its
# pictures and places back to out\ here - nothing runs on Chris's desktop.
#     pwsh -File vm-shots.ps1 catword-styles            (PowerShell 7, on the host)
# The script's $Name must be its file name: its pictures are out\<name>-*.png
# and its places out\<name>.json.
#
# One run at a time: a lock file (vm-shots.lock) makes a second caller wait,
# so several writers can share the one VM. The script runs in Windows
# PowerShell 5.1 inside the VM, in the signed-in desktop (the VM's agent),
# so COM, UI Automation and PrintWindow behave as on a real PC.
#
# Files the script needs (a starter document to open) go in work\ here; they
# are copied in to C:\sims\sim-screens\work\. Files the script makes for
# pupils (starter files made in real Office) go in C:\sims\files\<name>\ in
# the VM: they come back to files\<name>\ here. Save them in the cloud as
# well (Chris, 8 October 2026: "cat files also must be stored using the
# cloud - google drive"): G:\My Drive\CAT\<App>\ in the VM.
param([Parameter(Mandatory)][string]$Script, [int]$TimeoutSec = 600)
$ErrorActionPreference = 'Stop'
$here  = $PSScriptRoot
$tools = Split-Path $here
$name  = [IO.Path]::GetFileNameWithoutExtension($Script)
if (-not (Test-Path (Join-Path $here "$name.ps1"))) { throw "No $name.ps1 in $here" }

# The lock: wait up to 90 minutes for another run to finish (seven writers queued on 8 October 2026).
$lockPath = Join-Path $here 'vm-shots.lock'
$lock = $null
for ($i = 0; $i -lt 2700 -and -not $lock; $i++) {
  try { $lock = [IO.File]::Open($lockPath, 'OpenOrCreate', 'ReadWrite', 'None') } catch { Start-Sleep 2 }
}
if (-not $lock) { throw 'The VM is busy (vm-shots.lock held for 90 minutes)' }
try {
  . 'E:\itcoder-videos\host-hv.ps1'
  $vm = 'itcoder-cat'
  if ((Get-VM $vm).State -ne 'Running') { Start-VM $vm; Start-Sleep 60 }
  $s = VmSession
  try {
    Invoke-Command -Session $s -ArgumentList $name {
      param($n)
      foreach ($d in 'C:\sims\sim-screens\out', 'C:\sims\access-screens', 'C:\sims\excel-screens', 'C:\sims\sim-screens\work') { New-Item -ItemType Directory -Force $d | Out-Null }
      Remove-Item "C:\sims\sim-screens\out\$n-*", "C:\sims\sim-screens\out\$n.json", "C:\sims\$n.log" -ErrorAction SilentlyContinue
      Remove-Item "C:\sims\files\$n" -Recurse -ErrorAction SilentlyContinue
      New-Item -ItemType Directory -Force "C:\sims\files\$n" | Out-Null
    }
    # File contents, not Copy-Item: Dropbox's own file attributes (0x80000) make Copy-Item -ToSession fail.
    $put = { param($file, $dir) Invoke-Command -Session $s -ArgumentList (Join-Path $dir (Split-Path $file -Leaf)), ([IO.File]::ReadAllBytes($file)) { param($p, $b) [IO.File]::WriteAllBytes($p, $b) } }
    & $put (Join-Path $here 'office-kit.ps1') 'C:\sims\sim-screens'
    & $put (Join-Path $here "$name.ps1") 'C:\sims\sim-screens'
    & $put (Join-Path $tools 'access-screens\Shot.cs') 'C:\sims\access-screens'
    & $put (Join-Path $tools 'excel-screens\WinRect.cs') 'C:\sims\excel-screens'
    $work = Join-Path $here 'work'
    if (Test-Path $work) { Get-ChildItem $work -File | Where-Object { $_.Extension -notin '.pid', '.laccdb' } | ForEach-Object { & $put $_.FullName 'C:\sims\sim-screens\work' } }
  } finally { Remove-PSSession $s }

  # Run it in the VM's desktop session (the agent), in Windows PowerShell 5.1.
  $job = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File 'C:\sims\sim-screens\$name.ps1' *> 'C:\sims\$name.log'; if (`$LASTEXITCODE) { throw ('exit ' + `$LASTEXITCODE + ': ' + (Get-Content 'C:\sims\$name.log' -Raw)) }"
  # A job that times out or fails on the host keeps running in the VM and holds
  # the agent, so every later run waits behind it (8 October 2026: a hung Word
  # save held the queue for an hour). Stop it - and the Office it opened (under
  # the lock, only this run's Office is open) - before letting go of the lock.
  try { Job "sims-$name" $job $TimeoutSec | Out-Null }
  catch {
    $err = $_
    $k = VmSession
    try {
      Invoke-Command -Session $k -ArgumentList $name {
        param($n)
        Get-CimInstance Win32_Process -Filter "Name='powershell.exe'" | Where-Object { $_.CommandLine -match [regex]::Escape("\sim-screens\$n.ps1") } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
        Get-Process WINWORD, EXCEL, POWERPNT, MSACCESS, notepad++, msedge -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\share\jobs\sims-$n.ps1" -ErrorAction SilentlyContinue
        Get-ChildItem "$env:SystemDrive\Users\pupil\AppData\Roaming\Microsoft\Word" -Filter '~WRA*' -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
      }
    } finally { Remove-PSSession $k }
    throw $err
  }

  $s = VmSession
  try {
    $out = Join-Path $here 'out'
    Remove-Item (Join-Path $out "$name-*"), (Join-Path $out "$name.json") -ErrorAction SilentlyContinue
    $shots = Invoke-Command -Session $s -ArgumentList $name { param($n) (Get-ChildItem 'C:\sims\sim-screens\out' -Filter "$n*").FullName }
    foreach ($f in $shots) { Copy-Item $f -Destination $out -FromSession $s -Force }
    $made = Invoke-Command -Session $s -ArgumentList $name { param($n) (Get-ChildItem "C:\sims\files\$n" -File -ErrorAction SilentlyContinue).FullName }
    if ($made) {
      $dest = Join-Path $here "files\$name"
      New-Item -ItemType Directory -Force $dest | Out-Null
      foreach ($f in $made) { Copy-Item $f -Destination $dest -FromSession $s -Force }
      # The VM's Office is signed in as Chris and writes his name into every file it saves (9 October 2026).
      & python (Join-Path $here 'scrub-office.py') $dest --fix | Select-Object -Last 1
      "$(@($made).Count) made files -> files\$name\"
    }
    Invoke-Command -Session $s -ArgumentList $name { param($n) Get-Content "C:\sims\$n.log" -ErrorAction SilentlyContinue }
    "$(@($shots).Count) files -> out\"
  } finally { Remove-PSSession $s }
} finally { $lock.Dispose() }
