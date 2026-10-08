# Screen for Web Design (HTML) lesson 4, Bold, italic and underline
# (AIPascalCourse/content/cathtml/formatting.php - courses/cat-practical-
# writing.md, Chris, 8 October 2026): Notepad++ showing a page with mistakes
# in it - a misspelt tag and a closing tag with no partner - to see how
# Notepad++ colours them. Nothing is installed; nothing clicks or types.
# Run from the host:  pwsh -File vm-shots.ps1 cathtml-formatting
$Name = 'cathtml-formatting'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$page = @'
<html>
<head>
<titel>Botha's Bakery - Specials</titel>
</head>
<body>
<h1>This week's specials</h1>
<p><b>Koeksisters</b> - R8 each</p>
<p><b><i>Closed on Sundays</b></i></p>
<p>Order a cake <b>two days before.</p>
</bodi>
</html>
'@

$dir = 'C:\sims\files\cathtml-formatting'
New-Item -ItemType Directory -Force $dir | Out-Null
$file = Join-Path $dir 'specials-mistakes.html'
[IO.File]::WriteAllText($file, $page.Replace("`r`n", "`n").Replace("`n", "`r`n"), (New-Object System.Text.UTF8Encoding($false)))

$npp = @('C:\Program Files\Notepad++\notepad++.exe', 'C:\Program Files (x86)\Notepad++\notepad++.exe') | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $npp) { throw 'No Notepad++ in the VM' }

function WindowOf ([string[]]$procs, [string]$like, [int]$tries = 60) {
  for ($i = 0; $i -lt $tries; $i++) {
    $p = Get-Process -Name $procs -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 -and $_.MainWindowTitle -like $like } | Select-Object -First 1
    if ($p) { return [IntPtr]$p.MainWindowHandle }
    Start-Sleep -Milliseconds 500
  }
  throw "No window like '$like'"
}

try {
  Start-Process $npp -ArgumentList '-multiInst', '-nosession', '-notabbar', "`"$file`"" | Out-Null
  $h = WindowOf @('notepad++') '*specials-mistakes.html*'
  [Shot]::Place($h, 40, 40, 900, 470); Start-Sleep -Milliseconds 1500
  Snap 1
} finally {
  Get-Process notepad++ -ErrorAction SilentlyContinue | Stop-Process -Force
}
SaveMarks
