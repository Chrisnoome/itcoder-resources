# The helpers shots.ps1 uses (dot-source it: . .\kit.ps1). See shots.ps1 for the
# safety rule: no mouse, no keys - COM, UI Automation on named buttons, PrintWindow.
$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Add-Type -Path (Join-Path $dir 'Shot.cs') -ReferencedAssemblies System.Drawing
Add-Type -AssemblyName UIAutomationClient, UIAutomationTypes
[Shot]::DpiAware()
New-Item -ItemType Directory -Force (Join-Path $dir 'out') | Out-Null

$A = [System.Windows.Automation.AutomationElement]
$C = [System.Windows.Automation.PropertyCondition]
$T = [System.Windows.Automation.ControlType]
$Scope = [System.Windows.Automation.TreeScope]

function Find($root, $name, $type) {
  $cond = New-Object System.Windows.Automation.AndCondition((New-Object $C($A::NameProperty, $name)), (New-Object $C($A::ControlTypeProperty, $type)))
  for ($try = 0; $try -lt 20; $try++) {
    $found = $root.FindFirst($Scope::Descendants, $cond)
    if ($found) { return $found }
    Start-Sleep -Milliseconds 250
  }
  throw "Access has no $($type.ProgrammaticName) called '$name'"
}
# A button's own action: Invoke, or Toggle / Select for the sticky view buttons.
function Press($root, $name) {
  $button = Find $root $name $T::Button
  $pattern = $null
  if ($button.TryGetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern, [ref]$pattern)) { $pattern.Invoke(); return }
  if ($button.TryGetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern, [ref]$pattern)) { $pattern.Toggle(); return }
  if ($button.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern, [ref]$pattern)) { $pattern.Select(); return }
  throw "'$name' can't be pressed: " + (($button.GetSupportedPatterns() | ForEach-Object { $_.ProgrammaticName }) -join ', ')
}
function Pick($root, $name) { (Find $root $name $T::TabItem).GetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern).Select() }


# The SQL a pupil would type, put in through Access's own object model: saved
# as a hidden query called Query1 (so the Navigation Pane looks as a pupil's
# does), opened in Design View and switched to SQL View (its own button). Typing into the SQL
# box by UI Automation did not take (tried 26 September 2026).
function ShowSql($sql) {
  try { $app.DoCmd.Close(1, 'Query1', 2) } catch { }      # acQuery, acSaveNo
  $db = $app.CurrentDb()
  try { $db.QueryDefs.Delete('Query1') } catch { }
  $null = $db.CreateQueryDef('Query1', $sql)
  $app.SetHiddenAttribute(1, 'Query1', $true)
  $app.DoCmd.OpenQuery('Query1', 1)                        # acViewDesign
  Press $root 'SQL View'                                   # the button at the bottom right
  Start-Sleep -Milliseconds 800
}

# A top-level window of Access's by its title (a dialog box), or $null.
function Dialog($title) {
  for ($try = 0; $try -lt 20; $try++) {
    $found = $A::RootElement.FindFirst($Scope::Children, (New-Object $C($A::NameProperty, $title)))
    if ($found) { return $found }
    Start-Sleep -Milliseconds 250
  }
  return $null
}

$app = New-Object -ComObject Access.Application
$h = [IntPtr]::Zero
function Snap($name) {
  Start-Sleep -Milliseconds 1500
  [Shot]::Back($h)
  Start-Sleep -Milliseconds 500
  "$name " + [Shot]::Save($h, (Join-Path $dir "out\$Prefix-$name.png"))
}
