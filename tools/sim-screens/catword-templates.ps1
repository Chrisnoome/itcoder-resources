# Real Word 365 screens for catword lesson 20, 'templates' (content/catword/templates.php,
# Grade 11, 9 October 2026). Ms Naidoo's camp permission form: Save As (F12) with Save as
# type Word Template, the Developer tab's content controls (Plain Text, Date Picker,
# Drop-Down List, Check Box) and their Properties box, the Legacy Tools (Legacy Forms),
# and Restrict Editing (Filling in forms). Makes the upload's starter file (Camp form.docx,
# in C:\sims\files\catword-templates\ and G:\My Drive\CAT\Word\) and the done-right copy
# (Camp form done.docx).
#
# The Developer tab is off in the VM's Word: this run turns it on in Word's ribbon file
# (%LOCALAPPDATA%\Microsoft\Office\Word.officeUI) and puts the file back as it was at the end.
#     pwsh -File vm-shots.ps1 catword-templates
$Name = 'catword-templates'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$ui = Join-Path $env:LOCALAPPDATA 'Microsoft\Office\Word.officeUI'
$uiWas = $null
if (Test-Path $ui) { $uiWas = [IO.File]::ReadAllText($ui) }
"  ribbon file was: $(if ($uiWas) { $uiWas.Length.ToString() + ' characters' } else { 'none' })"
$dev = '<mso:tab idQ="mso:TabDeveloper" visible="true"/>'
if ($uiWas -and $uiWas -match 'TabDeveloper') { $uiNew = $uiWas }
elseif ($uiWas -and $uiWas -match '<mso:tabs>') { $uiNew = $uiWas -replace '<mso:tabs>', ('<mso:tabs>' + $dev) }
elseif ($uiWas -and $uiWas -match '</mso:ribbon>') { $uiNew = $uiWas -replace '</mso:ribbon>', ('<mso:tabs>' + $dev + '</mso:tabs></mso:ribbon>') }
else { $uiNew = '<mso:customUI xmlns:mso="http://schemas.microsoft.com/office/2009/07/customui"><mso:ribbon><mso:qat/><mso:tabs>' + $dev + '</mso:tabs></mso:ribbon></mso:customUI>' }
[IO.File]::WriteAllText($ui, $uiNew)

$lines = @(
  'Phumlani Secondary School',
  'Grade 11 camp: permission form',
  'Pupil''s name: ',
  'Class: ',
  'Date of birth: ',
  'Medical aid: ',
  'Deposit of R500 paid: ',
  'I give permission for my child to attend the Grade 11 camp from 18 to 20 March 2027.',
  'Parent''s signature: ______________________',
  ''
)
# The Developer tab on or off through File > Options > Customize Ribbon (Word Options shows its controls to UI Automation).
function SetDeveloper ([bool]$on) {
  try {
    $before = [Later]::Windows($script:wpid)
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList '-NoProfile', '-Command', "[Runtime.InteropServices.Marshal]::GetActiveObject('Word.Application').Dialogs.Item(974).Show() | Out-Null"
    $dlg = NewWindow $before @() 60
    if ($dlg -eq [IntPtr]::Zero) { '  no Word Options window'; return $false }
    "   options window: $(([Later]::Windows($script:wpid) | Where-Object { $before -notcontains $_ }) -join ' | ')"
    Start-Sleep -Milliseconds 2500
    $w = $AE::FromHandle($dlg)
    $cr = $null
    foreach ($e in $w.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -eq 'Customize Ribbon') { $cr = $e; break } } catch { } }
    if ($cr) { try { Press $cr } catch { [Later]::Invoke($cr) }; Start-Sleep -Milliseconds 2500 } else { '  no Customize Ribbon' }
    $dev = $null
    foreach ($e in $w.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -eq 'Developer') { $dev = $e; "   developer item: $($e.Current.ControlType.ProgrammaticName)"; $p = $null; if ($e.TryGetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern, [ref]$p)) { break } } } catch { } }
    if ($dev) {
      $p = $null
      if ($dev.TryGetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern, [ref]$p)) {
        $isOn = ($p.Current.ToggleState -eq 'On')
        if ($isOn -ne $on) { $p.Toggle(); Start-Sleep -Milliseconds 800 }
        "   developer state now: $($p.Current.ToggleState)"
        if (($p.Current.ToggleState -eq 'On') -ne $on) {
          # a click on its tick box: the mouse messages to the window that draws the tree, at the box's place
          $walker = [System.Windows.Automation.TreeWalker]::RawViewWalker
          $e2 = $dev; $hw = 0
          while ($e2 -and $hw -eq 0) { try { $hw = $e2.Current.NativeWindowHandle } catch { }; if ($hw -eq 0) { $e2 = $walker.GetParent($e2) } }
          $target = [IntPtr][int64]$hw
          $r = $dev.Current.BoundingRectangle
          $pt = New-Object K11+PT; $pt.X = [int]($r.X + 12); $pt.Y = [int]($r.Y + $r.Height / 2)
          [void][K11]::ScreenToClient($target, [ref]$pt)
          [void][K11]::PostMessage($target, 0x0201, [IntPtr]1, [K11]::Lp($pt.X, $pt.Y)); Start-Sleep -Milliseconds 100
          [void][K11]::PostMessage($target, 0x0202, [IntPtr]0, [K11]::Lp($pt.X, $pt.Y)); Start-Sleep -Milliseconds 800
          "   after a click: $($p.Current.ToggleState)"
        }
      } else { '   developer has no toggle' }
    } else { '  no Developer item' }
    DumpWin $dlg 'wordoptions'
    $ok = $null
    foreach ($e in $w.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))) { try { if ($e.Current.Name -eq 'OK') { $ok = $e; break } } catch { } }
    if ($ok) { [Later]::Invoke($ok) } else { [Shot]::PostKey($dlg, 0x0D) }
    Start-Sleep -Milliseconds 4000
    Fresh
    return $true
  } catch { "  SetDeveloper: $_"; return $false }
}
function FindPara ($like) { foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like $like) { return $p.Range } }; throw "no paragraph like $like" }
function EndOf ($like) { $p = FindPara $like; return $doc.Range($p.End - 1, $p.End - 1) }

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  (Para $doc 1).Style = -63
  (Para $doc 2).Style = -2
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'Camp form.docx' $true
  try { [void](Ctl @('Developer') $T::TabItem); '  Developer tab: on' } catch { '  Developer tab: off (pictures without it)' }
  try { [void](Ctl @('Developer') $T::TabItem); '  Developer tab: on now' } catch { '  Developer tab: STILL OFF' }

  # ---- 1. Save as a template: F12 (Save As box), the Save as type list
  $doc.Range(0, 0).Select()
  P 't-1' $A
  $before = [Later]::Windows($script:wpid)
  ComLater '$w.Dialogs.Item(84).Show() | Out-Null'                     # wdDialogFileSaveAs - the box F12 opens
  $dlg = NewWindow $before @('#32770', 'bosa_sdm_msword', 'NUIDialog') 60
  if ($dlg -ne [IntPtr]::Zero) {
    Start-Sleep -Milliseconds 2500
    DumpWin $dlg 'saveas'
    P 't-2' $null $dlg
    PaintOut 't-2' @(@(14, 232, 178, 36), @(170, 470, 200, 26))          # the OneDrive account in the folder list, Authors
    [Shot]::PostKey($dlg, 0x1B); Start-Sleep -Milliseconds 2000
  } else { '  NO Save As box' }
  Fresh
  # again, with the type set to Word Template (14) and the name: the box after the choice
  $before = [Later]::Windows($script:wpid)
  ComLater '$x = $w.Dialogs.Item(84); try { $x.Format = 14 } catch { }; try { $x.Name = ''Camp form'' } catch { }; $x.Show() | Out-Null'
  $dlg = NewWindow $before @('#32770', 'bosa_sdm_msword', 'NUIDialog') 60
  if ($dlg -ne [IntPtr]::Zero) {
    Start-Sleep -Milliseconds 2500
    P 't-3' $null $dlg
    PaintOut 't-3' @(@(14, 232, 178, 36), @(170, 470, 200, 26))
    DumpWin $dlg 'saveas2'
    [Shot]::PostKey($dlg, 0x1B); Start-Sleep -Milliseconds 2000
  }
  Fresh

  # ---- 2. Content controls (by COM - the VM's Word will not show the Developer tab): the form, pictured
  Tab 'Home'
  $hasDev = $true
  try { [void](Ctl @('Developer') $T::TabItem) } catch { $hasDev = $false }
  "  developer tab there: $hasDev"
  $cc1 = $doc.ContentControls.Add(1, (EndOf 'Pupil*'))                 # wdContentControlText
  $cc2 = $doc.ContentControls.Add(1, (EndOf 'Class:*'))
  $cc3 = $doc.ContentControls.Add(6, (EndOf 'Date of birth:*'))        # wdContentControlDate
  $cc3.DateDisplayFormat = 'd MMMM yyyy'
  $cc4 = $doc.ContentControls.Add(4, (EndOf 'Medical aid:*'))          # wdContentControlDropdownList
  [void]$cc4.DropdownListEntries.Add('Yes', 'Yes'); [void]$cc4.DropdownListEntries.Add('No', 'No')
  try { $cc5 = $doc.ContentControls.Add(8, (EndOf 'Deposit*')) } catch { "  check box control: $_" }   # wdContentControlCheckBox
  Start-Sleep -Milliseconds 1000
  $doc.Range($cc3.Range.Start, $cc3.Range.Start).Select()
  P 'd-3' $A
  foreach ($p in $doc.Paragraphs) { "  $($p.Range.Text.Trim())" }

  # ---- 4. Restrict Editing from the Review tab: the pane, Allow only this type of editing, Filling in forms
  $doc.Range(0, 0).Select()
  P 'r-0' $A
  Pct 'reviewTab' 'r-0' (Box (Ctl @('Review') $T::TabItem))
  Tab 'Review'
  Dump 'review'
  P 'r-1' $F
  try {
    $prot = Ctl @('Protect') $T::MenuItem
    Pct 'protect' 'r-1' (Box $prot)
    $menu = Menu $prot
    DumpMenu $menu 'protectmenu'
    P 'r-1b' $F $h $menu
    $rs = FindAny $menu @('Restrict Editing')
    Pct 'restrict' 'r-1b' (BoxIn $rs $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($rs); Start-Sleep -Milliseconds 2500
    $pane = NewWindow $before @() 8
    "  restrict pane window: $pane"
    Dump 'restrictpane'
    if ($pane -ne [IntPtr]::Zero) {
      DumpWin $pane 'restrictwin'
      P 'r-2' $null $pane
      $allow = $null
      foreach ($e in $AE::FromHandle($pane).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -match '^Allow only this type of editing') { $allow = $e; break } } catch { } }
      if ($allow) { PctIn 'allow' 'r-2' $allow $pane; $tp = $null; if ($allow.TryGetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern, [ref]$tp)) { $tp.Toggle(); Start-Sleep -Milliseconds 1000 } } else { '  MISSING allow' }
      P 'r-3' $null $pane
    } else {
      P 'r-2' $F
      try { $allow = Ctl @('Allow only this type of editing in the document:', 'Allow only this type of editing in the document'); Pct 'allow' 'r-2' (Box $allow); Press $allow; Start-Sleep -Milliseconds 1000 } catch { '  MISSING allow' }
      P 'r-3' $F
    }
  } catch { "  restrict editing: $_" }
  Fresh
  try { $doc.Protect(2, $false, '') ; '  protected for forms' } catch { "  protect: $_" }   # wdAllowOnlyFormFields
  Start-Sleep -Milliseconds 1000
  P 'r-4' $F
  try { $doc.Unprotect('') } catch { }

  # ---- 5. The done-right copy: the content controls in (protection taken off - the reader does not need it)
  SaveDoc $doc 'Camp form done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  if ($script:devByOptions) { try { SetDeveloper $false | Out-Null; '  Developer tab off again' } catch { } }
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
  Start-Sleep 2
  if ($uiWas) { [IO.File]::WriteAllText($ui, $uiWas) } else { Remove-Item $ui -ErrorAction SilentlyContinue }
  '  ribbon file put back'
}
