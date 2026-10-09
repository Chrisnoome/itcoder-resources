# A probe for the catword Grade 11 lessons (9 October 2026): dumps the ribbon
# tabs and a few menus of Word 365 in the CAT VM, so the lesson scripts can
# name the controls. Pictures only to look at - none goes into a lesson.
#     pwsh -File vm-shots.ps1 catword-g11probe
$Name = 'catword-g11probe'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

function DumpAll ($win, $file) {
  $lines = @()
  if ($win -ne [IntPtr]::Zero) { $lines += foreach ($e in $AE::FromHandle($win).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { $c = $e.Current; if ($c.Name) { "menu`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } } }
  foreach ($type in $T::ListItem, $T::MenuItem, $T::Button, $T::CheckBox) {
    $lines += foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $type)))) { try { $c = $e.Current; if ($c.Name -and -not $c.IsOffscreen) { "desk`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}
function TryMenu ($tab, $names, $file) {
  try {
    Fresh; Tab $tab
    $m = OpenMenu (Ctl $names)
    DumpAll $m $file
    Pic $file $F $h $m
    [Shot]::PostKey($m, 0x1B); Start-Sleep -Milliseconds 600; [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 900
  } catch { "  menu $file : $_"; try { [Shot]::PostKey($h, 0x1B) } catch { } }
}

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc @('Botha''s Bakery price list', 'Breads', 'White bread R18', 'Brown bread R17', 'Cakes', 'Carrot cake R45', '')
  $word.Visible = $true
  WordWindow
  Fresh
  foreach ($t in 'Home', 'Insert', 'Design', 'Layout', 'References', 'Mailings', 'Review', 'View') {
    try { Fresh; Tab $t; Dump "tab-$t"; Pic "tab-$t" $F } catch { "  tab $t : $_" }
  }
  try { $dev = Ctl @('Developer') $T::TabItem; 'Developer tab is there' } catch { 'NO Developer tab' }
  TryMenu 'Layout' @('Breaks') 'breaks'
  TryMenu 'Home' @('Multilevel List') 'multilevel'
  TryMenu 'Insert' @('Page Number') 'pagenumber'
  TryMenu 'Insert' @('Drop Cap') 'dropcap'
  TryMenu 'Insert' @('Quick Parts', 'Explore Quick Parts') 'quickparts'
  TryMenu 'Design' @('Themes') 'themes'
  TryMenu 'Design' @('Colors') 'colors'
  TryMenu 'Design' @('Fonts') 'fonts'
  TryMenu 'Mailings' @('Start Mail Merge') 'startmerge'
  TryMenu 'Mailings' @('Select Recipients') 'recipients'
  # a style tile's right-click menu
  try {
    Tab 'Home'
    $tile = Tile '^Heading 1$'
    "  Heading 1 tile: $((Box $tile) -join ',')"
    $b = Box $tile
    $m = RightClick ($b[0] + 20) ($b[1] + 15)
    DumpAll $m 'tilemenu'
    Pic 'tilemenu' $F $h $m
    [Shot]::PostKey($m, 0x1B); Start-Sleep -Milliseconds 800
  } catch { "  tile menu: $_" }
  # Saving test
  try { SaveDoc $doc 'probe11.docx' $false; 'SAVE OK' } catch { "SAVE FAILED: $_" }
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
