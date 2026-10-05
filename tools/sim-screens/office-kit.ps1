# Shared helpers for the CAT simulation screens (cat-excel.ps1, cat-word.ps1,
# cat-access.ps1 - Chris, 5 October 2026: "sample lessons for excel, word,
# access - lots of software simulation"). Dot-source it after setting $Name:
#     $Name = 'cat-excel'; . (Join-Path $PSScriptRoot 'office-kit.ps1')
#
# THE SAFETY RULES (as ..\access-screens\README.md): nothing clicks and nothing
# types at the desktop. The programs are driven through COM, UI Automation on
# their own named controls, and keys posted to one window by its handle. The
# pictures come from PrintWindow (only that program's own drawing). The
# window sits at the back of the stack. NOBODY MAY USE THE KEYBOARD OR MOUSE
# WHILE THE PROGRAM IS IN FRONT: any input while it is (or was, at the last
# check) the window in front stops the run and deletes its pictures.
$ErrorActionPreference = 'Stop'
$kitDir = $PSScriptRoot
Add-Type -Path (Join-Path $kitDir '..\access-screens\Shot.cs') -ReferencedAssemblies System.Drawing
Add-Type -Path (Join-Path $kitDir '..\excel-screens\WinRect.cs')
Add-Type -AssemblyName UIAutomationClient, UIAutomationTypes
[Shot]::DpiAware()
$out = Join-Path $kitDir 'out'
New-Item -ItemType Directory -Force $out | Out-Null
Remove-Item (Join-Path $out "$Name-*") -ErrorAction SilentlyContinue

$AE    = [System.Windows.Automation.AutomationElement]
$PropCond = [System.Windows.Automation.PropertyCondition]   # not $C: PowerShell names ignore case, and a run's $c loop would overwrite it
$T     = [System.Windows.Automation.ControlType]
$Scope = [System.Windows.Automation.TreeScope]

$h = [IntPtr]::Zero
$script:lastInput = [Shot]::LastInput()
$script:wasFront  = $false
$script:marks     = [ordered]@{}

function Guard {
  $front = ($h -ne [IntPtr]::Zero) -and ([Shot]::FrontPid() -eq [Shot]::Pid($h))
  $now   = [Shot]::LastInput()
  if ($now -ne $script:lastInput -and ($front -or $script:wasFront)) {
    Remove-Item (Join-Path $out "$Name-*") -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used while the program was in front - every picture was deleted. Run it again.'
  }
  $script:lastInput = $now
  $script:wasFront  = $front
}

# The first element with this name (any of the names given), optionally of one control type.
function Find($root, [string[]]$names, $type = $null, [int]$tries = 16) {
  for ($try = 0; $try -lt $tries; $try++) {
    foreach ($name in $names) {
      $cond = New-Object $PropCond($AE::NameProperty, $name)
      if ($type) { $cond = New-Object System.Windows.Automation.AndCondition($cond, (New-Object $PropCond($AE::ControlTypeProperty, $type))) }
      $found = $root.FindFirst($Scope::Descendants, $cond)
      if ($found -and -not $found.Current.IsOffscreen) { return $found }
    }
    Start-Sleep -Milliseconds 250
  }
  throw "No control called '$($names -join "' or '")'"
}

# Press a control by its own pattern: Invoke, Select (a tab or gallery item), Toggle.
function Press($element) {
  $pattern = $null
  if ($element.TryGetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern, [ref]$pattern)) { $pattern.Invoke(); return }
  if ($element.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern, [ref]$pattern)) { $pattern.Select(); return }
  if ($element.TryGetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern, [ref]$pattern)) { $pattern.Toggle(); return }
  throw "'$($element.Current.Name)' can't be pressed"
}

# Where a control is on the picture: [x, y, w, h] in window pixels.
function Box($element) {
  $r   = $element.Current.BoundingRectangle
  $win = [WinRect]::Of($h)
  return @([int]($r.X - $win[0]), [int]($r.Y - $win[1]), [int]$r.Width, [int]$r.Height)
}

# Remember a place on the pictures (window pixels) for the lesson's targets.
function Mark($key, $box) { $script:marks[$key] = $box; "  $key = $($box -join ', ')" }

# Every named control and where it is - to find names and places when writing a run.
function Dump($file) {
  $win = [WinRect]::Of($h)
  $lines = foreach ($e in $AE::FromHandle($h).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
    try {
      $c = $e.Current
      if ($c.Name -and -not $c.IsOffscreen) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" }
    } catch { }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}

function Snap($n) {
  Guard
  Start-Sleep -Milliseconds 900
  [Shot]::Back($h)
  Start-Sleep -Milliseconds 500
  [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png"))
  Guard
  "picture $n"
}

function SaveMarks {
  (@{ window = [WinRect]::Of($h); marks = $script:marks } | ConvertTo-Json -Depth 5) | Set-Content (Join-Path $out "$Name.json") -Encoding utf8
  "places -> out\$Name.json"
}

# Mark a control's place if it is there; say so if not (the run goes on - the Dump shows the real names).
function TryMark($key, $root, [string[]]$names, $type = $null) {
  try { Mark $key (Box (Find $root $names $type -tries 6)) } catch { "  MISSING $key ($($names -join ' / '))" }
}
