# Real Word 365 screens for catword Grade 12 lesson 'macros' (content/catword/
# macros.php, IEB, 9 October 2026). Thabo records a macro that types his
# sign-off: View > Macros (the menu), the Record Macro box (name, Store macro
# in this document, Keyboard), the Customize Keyboard box, recording (the
# status bar's Stop button), Stop Recording, the Macros box (View Macros:
# Run, Edit, Delete) and the macro's code in the Visual Basic editor (Edit).
# The macro is stored in the screen document only, which is closed without
# saving - Normal.dotm is not changed (its Saved flag is set so nothing is
# written). Nothing from another file is run. Also makes the upload's
# starter (Committee letter.docx) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-macros
$Name = 'catword-macros'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$letter = @(
  'Phumlani Secondary Matric Farewell Committee',
  'Dear Mr Botha',
  'Thank you for your quote for the farewell meal and cake. The committee accepts it, for 180 people, on Friday 13 November 2026.',
  'We will pay the deposit of R2 000 by Friday 23 October 2026.',
  ''
)
$signOff = 'Kind regards'
$signName = 'Thabo Mokoena, Committee chairperson'

$word = New-Object -ComObject Word.Application
$doc = $null
try {
  $word.DisplayAlerts = 0
  LocalUser
  # The starter and the done-right copy (the sign-off typed, as the macro would type it)
  $st = NewDoc $letter
  (Para $st 1).Style = -63
  SaveDoc12 $st 'Committee letter.docx' $true
  $last = $st.Paragraphs.Item($st.Paragraphs.Count).Range
  $st.Range($last.Start, $last.Start).InsertAfter("$signOff`r$signName")
  SaveDoc12 $st 'Committee letter done.docx' $false
  $st.Saved = $true; $st.Close(0)

  $doc = NewDoc $letter
  (Para $doc 1).Style = -63
  $word.Visible = $true
  WordWindow
  $end = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  $doc.Range($end.Start, $end.Start).Select()

  # ---- 1. View > Macros > Record Macro (simulation: View tab, the Macros arrow, type the name in the Record Macro box)
  # The Macros split button's menu does not open through UI Automation (9 October 2026), so the Record Macro box
  # is shown by Word itself (Dialogs 214, wdDialogToolsMacroRecord) from another process, as catword-kit does for Tabs.
  Pic 'r-1' $F
  TryPct 'viewTab' 'r-1' { Box (Ctl @('View') $T::TabItem) }
  Tab 'View'
  Dump 'view'
  Pic 'r-2' $F
  TryPct 'macrosSplit' 'r-2' { Box (Ctl @('Macros') $T::SplitButton) }
  TryPct 'viewMacros' 'r-2' { Box (Ctl @('View Macros') $T::Button) }
  $recDone = $false
  try {
    $dlg = ShowWordDialog 214
    Pic 'r-4' $null $dlg
    DumpWin $dlg 'recordbox'
    [C12]::Chars($dlg, 'SignOff'); Start-Sleep -Milliseconds 900
    Pic 'r-5' $null $dlg
    # Keyboard (Alt+K): the Customize Keyboard box - pictured, then closed (Close starts the recording)
    $before = [Later]::Windows($script:wpid)
    [C12]::Alt($dlg, 0x4B); Start-Sleep -Milliseconds 1800
    $kb = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 30
    if ($kb -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1200
      Pic 'r-7' $null $kb
      DumpWin $kb 'keybox'
      [C12]::Close($kb); Start-Sleep -Milliseconds 1800
    } else { '  no Customize Keyboard box - OK instead'; [Shot]::PostKey($dlg, 0x0D); Start-Sleep -Milliseconds 1800 }
    $recDone = $true
  } catch { "  record box: $_"; CloseAll }
  "  recording started: $recDone"
  Fresh12

  # ---- 2. Recording: type the sign-off into the document (the recorder writes it down), then stop on the status bar
  if ($recDone) {
    $doc.Activate()
    $end = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
    $wwg = [Shot]::Child($h, '_WwG')
    [C12]::Chars($wwg, $signOff); [C12]::Chars($wwg, [string][char]13); [C12]::Chars($wwg, $signName)
    Start-Sleep -Milliseconds 1500
    Pic 's-1' $F
    Dump 'recording'
    $stop = $null
    foreach ($e in $root.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { $nm = $e.Current.Name; if ($nm -match 'Macro Recording|Stop Recording|recording' ) { "  found: $nm $((Box $e) -join ',')"; if ((Box $e)[1] -gt 600) { $stop = $e } } } catch { } }
    if ($stop) { Pct 'statusStop' 's-1' (Box $stop); try { Press $stop; Start-Sleep -Milliseconds 1500; '  stopped from the status bar' } catch { "  stop press: $_" } }
    else { '  no stop button on the status bar' }
    "  doc now ends: $($doc.Paragraphs.Item($doc.Paragraphs.Count).Range.Text)"
  }
  Fresh12
  Pic 's-3' $F

  # ---- 3. View Macros: the Macros box (Run, Edit, Delete); Edit shows the Visual Basic editor
  try {
    $dlg = OpenDialog (Ctl @('View Macros') $T::Button)
    Start-Sleep -Milliseconds 1500
    Pic 'v-1' $null $dlg
    DumpWin $dlg 'macrosbox'
    [C12]::Alt($dlg, 0x45); Start-Sleep -Milliseconds 3500                 # Alt+E: Edit
    $vbe = [IntPtr]::Zero
    foreach ($line in [Later]::Windows($script:wpid)) { $p = $line -split "`t"; if ($p[1] -eq 'wndclass_desked_gsk') { $vbe = [IntPtr][long]$p[0] } }
    if ($vbe -ne [IntPtr]::Zero) {
      [Shot]::Place($vbe, 40, 40, 1300, 700); Start-Sleep -Milliseconds 2000
      [void][Shot]::Save($vbe, (Join-Path $out "$Name-b-1.png"))
      '  picture b-1 (the Visual Basic editor, whole window: crop off its title bar)'
      [C12]::Close($vbe); Start-Sleep -Milliseconds 1500
    } else { '  no Visual Basic editor window'; CloseAll }
  } catch { "  macros box: $_"; CloseAll }
  Fresh12
  CloseAll
  [Shot]::Back($h)
  Pic 'v-2' $F

  # ---- 4. Run it: a second copy of the sign-off at the end (the macro run from the Macros box)
  try {
    $e2 = $doc.Content; $e2.Collapse(0); $e2.Select()
    $word.Run('SignOff')
    Start-Sleep -Milliseconds 1200
    Pic 'v-3' $F
  } catch { "  run: $_" }
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  RestoreUser
  try { $word.NormalTemplate.Saved = $true } catch { }
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.NormalTemplate.Saved = $true } catch { }
  try { $word.Quit(0) } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
