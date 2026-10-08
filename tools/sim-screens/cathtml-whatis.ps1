# Screens for Web Design (HTML) lesson 1, What HTML is (AIPascalCourse/
# content/cathtml/whatis.php - courses/cat-practical-writing.md, Chris,
# 8 October 2026). Thabo's first page for Botha's Bakery: (1) the HTML in the
# editor - Notepad++ if the VM has it, else Notepad (nothing is installed);
# (2) the same file opened in Microsoft Edge, its title on the tab.
# Run from the host:  pwsh -File vm-shots.ps1 cathtml-whatis
# Read office-kit.ps1's safety rules: nothing clicks or types at the desktop.
$Name = 'cathtml-whatis'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$page = @'
<html>
<head>
<title>Botha's Bakery</title>
</head>
<body>
<h1>Botha's Bakery</h1>
<p>Fresh bread every morning, in Centurion.</p>
</body>
</html>
'@

# The page, saved where a pupil would keep it: a folder of its own.
$dir = 'C:\sims\files\cathtml-whatis'
New-Item -ItemType Directory -Force $dir | Out-Null
$file = Join-Path $dir 'botha.html'
[IO.File]::WriteAllText($file, $page.Replace("`r`n", "`n").Replace("`n", "`r`n"), (New-Object System.Text.UTF8Encoding($false)))
$cloud = 'G:\My Drive\CAT\HTML'
if (Test-Path 'G:\My Drive') { New-Item -ItemType Directory -Force $cloud | Out-Null; Copy-Item $file $cloud -Force; "copied to $cloud" } else { 'NO G:\My Drive - the cloud copy was not made' }

# The shots open the cloud copy, as a pupil would (G: drive, My Drive, CAT, HTML, botha.html).
if (Test-Path (Join-Path $cloud 'botha.html')) { $file = Join-Path $cloud 'botha.html' }

Add-Type -Namespace Kit -Name Msg -MemberDefinition @'
[DllImport("user32.dll")] public static extern bool PostMessage(IntPtr h, uint m, IntPtr w, IntPtr l);
'@

# Which editor the VM has.
$npp = @('C:\Program Files\Notepad++\notepad++.exe', 'C:\Program Files (x86)\Notepad++\notepad++.exe') | Where-Object { Test-Path $_ } | Select-Object -First 1
"editor: $(if ($npp) { $npp } else { 'Notepad (no Notepad++ in the VM)' })"

# The first visible top-level window of a process whose title has this in it.
function WindowOf ([string[]]$procs, [string]$like, [int]$tries = 60) {
  for ($i = 0; $i -lt $tries; $i++) {
    $p = Get-Process -Name $procs -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 -and $_.MainWindowTitle -like $like } | Select-Object -First 1
    if ($p) { return [IntPtr]$p.MainWindowHandle }
    Start-Sleep -Milliseconds 500
  }
  throw "No window like '$like' ($($procs -join ', '))"
}

# 1. The editor.
$editor = $null
try {
  if ($npp) {
    $editor = Start-Process $npp -ArgumentList '-multiInst', '-nosession', '-notabbar', "`"$file`"" -PassThru
    $h = WindowOf @('notepad++') '*botha.html*'
  } else {
    $editor = Start-Process 'notepad.exe' -ArgumentList "`"$file`"" -PassThru
    $h = WindowOf @('notepad', 'Notepad') '*botha*'
  }
  [Shot]::Place($h, 40, 40, 900, 520); Start-Sleep -Milliseconds 1500
  Snap 1
  Dump 'editor'
  if ($npp) {
    # 3. File > Save As (Notepad++'s menu command 41008, posted to its window - nothing is clicked).
    [void][Kit.Msg]::PostMessage($h, 0x0111, [IntPtr]41008, [IntPtr]::Zero)
    $dialog = $null
    for ($i = 0; $i -lt 80 -and -not $dialog; $i++) {
      Start-Sleep -Milliseconds 250
      $dialog = $AE::RootElement.FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'Save As')))
      if (-not $dialog) { $dialog = $AE::FromHandle($h).FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'Save As'))) }
    }
    if (-not $dialog) { foreach ($w in $AE::RootElement.FindAll($Scope::Children, [System.Windows.Automation.Condition]::TrueCondition)) { '  window: ' + $w.Current.Name + ' / ' + $w.Current.ClassName + ' / ' + $w.Current.ProcessId } }
    if ($dialog) {
      $dh = [IntPtr]$dialog.Current.NativeWindowHandle
      [Shot]::Place($dh, 60, 60, 960, 600); Start-Sleep -Milliseconds 1500
      # The folders pane shows the VM's account name: hide it.
      try { Press (Find $dialog @('Hide Folders') $null -tries 8); Start-Sleep -Milliseconds 1200 } catch { '  MISSING Hide Folders' }
      Guard; [void][Shot]::Save($dh, (Join-Path $out "$Name-3.png")); 'picture 3 (Save As)'
      $saveDump = foreach ($e in $dialog.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { $c = $e.Current; if ($c.Name) { $c.Name + "`t" + $c.ControlType.ProgrammaticName } } catch { } }
      $saveDump | Set-Content (Join-Path $out "$Name-saveas.txt") -Encoding utf8
      try { Press (Find $dialog @('Cancel') $T::Button -tries 4) } catch { [void][Kit.Msg]::PostMessage($dh, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) }
      Start-Sleep -Milliseconds 800
    } else { 'NO Save As dialog' }
  }
} finally {
  if ($npp) { Get-Process notepad++ -ErrorAction SilentlyContinue | Stop-Process -Force }
  else { Get-Process notepad -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*botha*' } | Stop-Process -Force }
}

# 2. The browser: a fresh Edge profile, so no account, no sign-in and no welcome pages.
$profileDir = 'C:\sims\edge-cathtml'
Remove-Item $profileDir -Recurse -Force -ErrorAction SilentlyContinue
$edge = @('C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe', 'C:\Program Files\Microsoft\Edge\Application\msedge.exe') | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $edge) { throw 'No Microsoft Edge in the VM' }
try {
  Start-Process $edge -ArgumentList "--user-data-dir=$profileDir", '--no-first-run', '--no-default-browser-check', '--disable-sync', '--new-window', "file:///$($file.Replace('\', '/').Replace(' ', '%20'))" | Out-Null
  $h = WindowOf @('msedge') "*Botha*"
  [Shot]::Place($h, 40, 40, 900, 520); Start-Sleep -Milliseconds 3000
  Snap 2
} finally {
  Get-CimInstance Win32_Process -Filter "Name = 'msedge.exe'" | Where-Object { $_.CommandLine -like "*edge-cathtml*" } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
}
SaveMarks
