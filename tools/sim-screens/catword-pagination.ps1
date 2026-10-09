# Real Word 365 screens for catword Grade 12 lesson 'pagination' (content/catword/
# pagination.php, 9 October 2026). Thabo's PAT report on water at Phumlani:
# a heading stranded at the foot of a page, the Paragraph box's Line and Page
# Breaks tab (Keep with next, Keep lines together, Page break before,
# Widow/Orphan control), the proofing language (status bar > Language box),
# and the IEB extras: Check Accessibility and the Translate menu. Also makes
# the upload's starter (Water report.docx) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-pagination
$Name = 'catword-pagination'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$filler = 'The school uses water for drinking, cleaning, the toilets and the garden. Each use was measured for four weeks with the meter at the gate and a simple tally sheet at each block of toilets.'
$lines = @(
  'Saving water at Phumlani Secondary',
  'A PAT report by Thabo Mokoena, Grade 12',
  'Introduction',
  'Phumlani Secondary pays for every litre of water it uses. In a dry year the municipality limits how much the school may use, and the toilets have been closed twice. This report asks how the school could use less water.',
  $filler, $filler,
  'How much water we use',
  'The meter readings show that the school uses about 18 000 litres on a school day and about 2 000 litres on a weekend day. Most of the water goes to the toilets.',
  $filler, $filler, $filler,
  'Where the water goes',
  'The tally sheets show that flushing uses 60% of the water, the taps 25%, the garden 10% and cleaning 5%. A leaking cistern can waste 400 litres a day.',
  $filler, $filler, $filler, $filler,
  'Recommendations',
  'Fix the leaking cisterns first: it costs little and saves the most. Then fit push taps in the boys'' and girls'' blocks, and water the garden only in the early morning.',
  $filler,
  'Sources',
  'Naidoo, P. (2026). Water use at Phumlani Secondary: meter readings, Term 1. Phumlani Secondary School.',
  'Department of Water and Sanitation (2025). Save water at school. Pretoria.'
)
function Heads ($d, [bool]$styled) {
  foreach ($p in $d.Paragraphs) {
    $t = $p.Range.Text.Trim()
    if ($t -in 'Introduction', 'How much water we use', 'Where the water goes', 'Recommendations', 'Sources') {
      if ($styled) { $p.Style = -2 } else { $p.Style = -1; $p.Range.Font.Bold = $true; $p.Range.Font.Size = 14; $p.Format.SpaceBefore = 12; $p.Format.KeepWithNext = $false }
    }
  }
}
# Two pages side by side at a small zoom (to see where the pages end).
function TwoPages { $v = $word.ActiveWindow.View; $v.Zoom.PageColumns = 2; $v.Zoom.PageRows = 1; Start-Sleep -Milliseconds 1200 }
function OnePage { $v = $word.ActiveWindow.View; $v.Zoom.Percentage = 100; Start-Sleep -Milliseconds 1000 }
# Push "How much water we use" to the foot of page 1: empty space before it (the starter's fault).
function Strand ($d) {
  $hd = ParaLike $d 'How much water we use'
  for ($i = 0; $i -lt 40; $i++) {
    if ($hd.Information(3) -ge 2) { break }                       # wdActiveEndPageNumber
    $hd.InsertParagraphBefore(); $hd = ParaLike $d 'How much water we use'
  }
  # one Enter back: the heading is the last line of page 1, its text on page 2
  $prev = $hd.Previous(4, 1); if ($prev -and $prev.Text -eq "`r") { $prev.Delete() | Out-Null }
  $hd = ParaLike $d 'How much water we use'
  "  heading on page $($hd.Information(3)); next paragraph on page $($hd.Next(4,1).Information(3))"
}
# The Paragraph box (Home > Paragraph launcher), on the tab Word last showed; Alt+P moves to Line and Page Breaks.
function ParaBox { return (OpenDialog (Ctl @('Paragraph...'))) }

$word = New-Object -ComObject Word.Application
$doc = $null
try {
  $word.DisplayAlerts = 0
  LocalUser
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  (Para $doc 1).Style = -63
  Heads $doc $false
  $doc.Content.LanguageID = 1033                                   # English (United States): the language the pupil changes
  $word.Visible = $true
  WordWindow
  Strand $doc
  # The starter's other fault: a manual page break before Recommendations
  $rec = ParaLike $doc 'Recommendations'
  $doc.Range($rec.Start, $rec.Start).InsertBreak(7)                 # wdPageBreak
  Flat $doc 'Water report.docx'
  SaveDoc12 $doc 'Water report.docx' $true

  # ---- 1. The stranded heading (figure: two pages)
  $hd = ParaLike $doc 'How much water we use'
  Show $hd
  TwoPages
  Pic 's-1' $F
  OnePage

  # ---- 2. Keep with next (simulation: click in the heading, Paragraph launcher, Line and Page Breaks tab, Keep with next, OK)
  $hd = ParaLike $doc 'How much water we use'
  Show $hd
  $doc.Range($hd.Start + 4, $hd.Start + 4).Select()
  Tab 'Home'
  Pic 'k-1' $F
  TryPct 'heading' 'k-1' { TextBox $hd }
  TryPct 'paraLauncher' 'k-1' { Box (Ctl @('Paragraph...')) }
  try {
    $dlg = ParaBox
    Pic 'k-2' $null $dlg
    DumpWin $dlg 'parabox1'
    [C12]::Alt($dlg, 0x50); Start-Sleep -Milliseconds 1200          # Alt+P: Line and Page Breaks
    Pic 'k-3' $null $dlg
    DumpWin $dlg 'parabox2'
    CloseDialog $dlg; CloseAll
    $word.Selection.ParagraphFormat.KeepWithNext = $true
    $dlg = ParaBox
    Pic 'k-4' $null $dlg
    CloseDialog $dlg; CloseAll
  } catch { "  paragraph box: $_"; CloseAll }
  $hd = ParaLike $doc 'How much water we use'
  "  after keep with next: heading on page $($hd.Information(3))"
  Show $hd
  TwoPages
  Pic 'k-5' $F
  OnePage

  # ---- 3. Page break before (simulation in the box: Page break before, OK) - on Recommendations, after the manual break is deleted
  $rec = ParaLike $doc 'Recommendations'
  $pb = $doc.Range($rec.Start - 1, $rec.Start)
  if ($pb.Text -eq [string][char]12) { $pb.Delete() | Out-Null }
  $rec = ParaLike $doc 'Recommendations'
  Show $rec
  $doc.Range($rec.Start + 2, $rec.Start + 2).Select()
  try {
    $dlg = ParaBox
    Pic 'b-1' $null $dlg
    CloseDialog $dlg; CloseAll
    $word.Selection.ParagraphFormat.PageBreakBefore = $true
    $dlg = ParaBox
    Pic 'b-2' $null $dlg
    CloseDialog $dlg; CloseAll
  } catch { "  page break before box: $_"; CloseAll }
  # Show/Hide: the little square that marks a paragraph with a Line and Page Breaks setting
  $word.ActiveWindow.View.ShowAll = $true
  $rec = ParaLike $doc 'Recommendations'
  Show $rec
  Pic 'b-3' $F
  TryPct 'recHead' 'b-3' { TextBox $rec }
  $word.ActiveWindow.View.ShowAll = $false

  # ---- 4. Widow and orphan (figure: Widow/Orphan control off, a lonely line at the top of a page)
  # (a figure of the box only: Widow/Orphan control is on by default)

  # ---- 5. Proofing language: the status bar's language, then the Language box
  $doc.Range(0, 0).Select()
  Show $doc.Range(0, 0)
  Pic 'l-1' $F
  $lang = $null
  foreach ($e in $root.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -match 'Language|English' -and (Box $e)[1] -gt 680) { $lang = $e; "  status: $($e.Current.Name)" } } catch { } }
  if ($lang) { Pct 'statusLang' 'l-1' (Box $lang) } else { '  MISSING status bar language' }
  Tab 'Review'
  Pic 'l-2' $F
  TryPct 'language' 'l-2' { Box (Ctl @('Language')) }
  $menu = MenuPic @('Language') $null 'l-3' $F
  if ($menu -ne [IntPtr]::Zero) { TryPct 'setProofing' 'l-3' { BoxIn (FindAny $menu @('Set Proofing Language...', 'Set Proofing Language')) $h } }
  try {
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke((FindAny $menu @('Set Proofing Language...', 'Set Proofing Language')))
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; Pic 'l-4' $null $dlg; DumpWin $dlg 'langbox'; CloseDialog $dlg; CloseAll }
  } catch { "  language box: $_"; EscMenu $menu }
  $word.Selection.WholeStory()
  $word.Selection.LanguageID = 7177                                # English (South Africa)
  $doc.Range(0, 0).Select()
  try {
    $menu = OpenMenu (Ctl @('Language'))
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke((FindAny $menu @('Set Proofing Language...', 'Set Proofing Language')))
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; Pic 'l-5' $null $dlg; CloseDialog $dlg; CloseAll }
  } catch { "  language box 2: $_"; CloseAll }
  Pic 'l-6' $F
  # The Translate menu (IEB)
  $menu = MenuPic @('Translate') $null 't-1' $F
  EscMenu $menu

  # ---- 6. Check Accessibility (IEB): a picture with no alt text, then the Accessibility pane
  try {
    $pic = ParaLike $doc 'Where the water goes'
    $at = $pic.Next(4, 1)
    $shape = $doc.InlineShapes.AddPicture((Join-Path $PSScriptRoot 'work\catword-ewaste.jpg'), $false, $true, $doc.Range($at.End - 1, $at.End - 1))
    $shape.Width = 160; $shape.Height = 107
    $shape.AlternativeText = ''
    Show $shape.Range
    TryPct 'access' 'l-2' { Box (Ctl @('Check Accessibility')) }
    Press (Ctl @('Check Accessibility')); Start-Sleep -Milliseconds 3500
    Pic 'a-1' $F
    Dump 'access'
  } catch { "  accessibility: $_" }
  try { $word.ActiveWindow.ActivePane.View.Type = 3 } catch { }
  try { $shape.Delete() } catch { }

  # ---- 7. The done-right copy: heading styles (which keep with next), no manual breaks, page break before Recommendations and Sources, South African English
  $done = $word.Documents.Add()
  $done.Content.Text = ($lines -join "`r")
  (Para $done 1).Style = -63
  Heads $done $true
  foreach ($t in 'Recommendations', 'Sources') { (ParaLike $done $t).ParagraphFormat.PageBreakBefore = $true }
  $done.Content.LanguageID = 7177
  foreach ($p in $done.Paragraphs) { "  | [$($p.Style.NameLocal)] keep=$($p.KeepWithNext) pbb=$($p.PageBreakBefore) $($p.Range.Text.Trim().Substring(0, [Math]::Min(30, $p.Range.Text.Trim().Length)))" }
  Flat $done 'Water report done.docx'
  SaveDoc12 $done 'Water report done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  RestoreUser
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
