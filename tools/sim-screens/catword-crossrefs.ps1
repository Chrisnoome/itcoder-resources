# Real Word 365 screens for catword Grade 12 lesson 'crossrefs' (content/catword/
# crossrefs.php, 9 October 2026). Thabo's PAT report on water: a bookmark on
# the meter table (Insert > Bookmark), a cross-reference to its page number
# (Insert > Cross-reference: Bookmark, Page number), the bookmarks shown,
# Go To a bookmark, and updating every field (Ctrl+A, F9). Also makes the
# upload's starter (Water report final.docx) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-crossrefs
$Name = 'catword-crossrefs'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$filler = 'The school uses water for drinking, cleaning, the toilets and the garden. Each use was measured for four weeks with the meter at the gate and a simple tally sheet at each block of toilets.'
function Report ($d, [string]$tableRef, [string]$pageRef, [string]$headRef) {
  $lines = @(
    'Saving water at Phumlani Secondary',
    'A PAT report by Thabo Mokoena, Grade 12',
    'Introduction',
    ('Phumlani Secondary pays for every litre of water it uses. This report asks how the school could use less. The meter readings are in ' + $tableRef + ' on page ' + $pageRef + ', and what the school should do is under ' + $headRef + '.'),
    $filler, $filler,
    'How much water we use',
    'The school uses about 18 000 litres on a school day and about 2 000 litres on a weekend day.',
    $filler, $filler, $filler, $filler,
    'TABLEHERE',
    $filler, $filler,
    'Where the water goes',
    'Flushing uses 60% of the water, the taps 25%, the garden 10% and cleaning 5%.',
    $filler,
    'Recommendations',
    'Fix the leaking cisterns first: it costs little and saves the most.'
  )
  $d.Content.Text = ($lines -join "`r")
  (Para $d 1).Style = -63
  foreach ($p in $d.Paragraphs) { if ($p.Range.Text.Trim() -in 'Introduction', 'How much water we use', 'Where the water goes', 'Recommendations') { $p.Style = -2 } }
  $at = ParaLike $d 'TABLEHERE'
  $at.Text = ''
  $t = $d.Tables.Add($at, 5, 3)
  $cells = @(@('Week', 'School days', 'Weekend'), @('Week 1', '90 500', '4 100'), @('Week 2', '88 900', '3 800'), @('Week 3', '91 200', '4 400'), @('Week 4', '87 600', '3 900'))
  for ($r = 0; $r -lt 5; $r++) { for ($c = 0; $c -lt 3; $c++) { $t.Cell($r + 1, $c + 1).Range.Text = $cells[$r][$c] } }
  $t.Style = 'Table Grid'
  [void]$t.Range.InsertCaption('Table', ' - Meter readings in litres, Term 1', '', 0)   # a real caption (SEQ Table), above the table
  return $t
}

# The X after "on page " in the introduction (found in the paragraph's own text, not with Find).
function PageX ($d) {
  $p = ParaLike $d 'Phumlani Secondary pays'
  $i = $p.Text.IndexOf('on page ')
  if ($i -lt 0) { throw "No 'on page' in: $($p.Text)" }
  return $d.Range($p.Start + $i + 8, $p.Start + $i + 9)
}

$word = New-Object -ComObject Word.Application
$doc = $null
try {
  $word.DisplayAlerts = 0
  LocalUser
  # The starter: [table], [page] and [heading] where the cross-references go; a manual page break before Where the water goes
  $start = $word.Documents.Add()
  $start.PageSetup.PaperSize = 7
  [void](Report $start '[table]' '[page]' '[heading]')
  $w = ParaLike $start 'Where the water goes'
  $start.Range($w.Start, $w.Start).InsertBreak(7)
  Flat $start 'Water report final.docx'
  SaveDoc12 $start 'Water report final.docx' $true
  $start.Saved = $true; $start.Close(0)

  # The lesson's document: the same report, "page X" to be filled in
  $doc = $word.Documents.Add()
  $doc.PageSetup.PaperSize = 7
  $tbl = Report $doc 'Table 1' 'X' 'Recommendations'
  $word.Visible = $true
  WordWindow
  $word.ActiveWindow.View.ShowBookmarks = $true

  # ---- 1. A bookmark on the table's caption (simulation: Insert tab, Bookmark, type the name, Add)
  $cap = ParaLike $doc 'Table 1'
  Show $cap
  $doc.Range($cap.Start, $cap.End - 1).Select()
  Pic 'b-1' $F
  TryPct 'insertTab' 'b-1' { Box (Ctl @('Insert') $T::TabItem) }
  Tab 'Insert'
  Dump 'insert'
  Pic 'b-2' $F
  TryPct 'bookmark' 'b-2' { Box (Ctl @('Bookmark...', 'Bookmark')) }
  TryPct 'crossRef' 'b-2' { Box (Ctl @('Cross-reference...', 'Cross-reference')) }
  TryPct 'link' 'b-2' { Box (Ctl @('Link')) }
  try {
    $dlg = OpenDialog (Ctl @('Bookmark...', 'Bookmark'))
    Pic 'b-3' $null $dlg
    DumpWin $dlg 'bmbox'
    CloseDialog $dlg; CloseAll                                        # nothing posted to the box: the bookmark is added through Word
    [void]$doc.Bookmarks.Add('MeterTable', $doc.Range($cap.Start, $cap.End - 1))
    $dlg = OpenDialog (Ctl @('Bookmark...', 'Bookmark'))
    Pic 'b-4' $null $dlg                                               # the box again: MeterTable in its list
    CloseDialog $dlg; CloseAll
  } catch { "  bookmark box: $_"; CloseAll }
  "  caption now: $($cap.Text)"
  for ($u = 0; $u -lt 5 -and -not ($cap.Text -like 'Table 1*'); $u++) { [void]$doc.Undo(); "  undo: $($cap.Text)" }
  $cap = ParaLike $doc 'Table 1'
  if (-not $doc.Bookmarks.Exists('MeterTable')) { '  bookmark by COM'; [void]$doc.Bookmarks.Add('MeterTable', $doc.Range($cap.Start, $cap.End - 1)) }
  Show $cap
  Pic 'b-5' $F

  # ---- 2. A cross-reference to the bookmark's page (simulation: Cross-reference, Bookmark, Page number, Insert)
  $intro = ParaLike $doc 'Phumlani Secondary pays'
  "  intro: $($intro.Text)"
  $x = PageX $doc
  $x.Select()
  Show $intro
  Pic 'x-1' $F
  TryPct 'theX' 'x-1' { TextBox $x }
  TryPct 'crossRef' 'x-1' { Box (Ctl @('Cross-reference...', 'Cross-reference')) }
  try {
    $dlg = OpenDialog (Ctl @('Cross-reference...', 'Cross-reference'))
    Pic 'x-2' $null $dlg
    DumpWin $dlg 'xrbox'
    CloseDialog $dlg; CloseAll
  } catch { "  cross-reference box: $_"; CloseAll }
  $x = PageX $doc
  $x.InsertCrossReference('Bookmark', 7, 'MeterTable', $false, $false) # wdPageNumber
  Show $intro
  Pic 'x-5' $F
  "  intro now: $($intro.Text)"

  # ---- 3. A page break moves the table; Ctrl+A, F9 updates the page number (simulation: keys)
  $hw = ParaLike $doc 'How much water we use'
  $hw.ParagraphFormat.PageBreakBefore = $true
  $doc.Repaginate()
  Show $intro
  $doc.Range($intro.Start, $intro.Start).Select()
  Pic 'u-1' $F
  $doc.Content.Select()
  Pic 'u-2' $F
  [void]$doc.Fields.Update()
  $doc.Range($intro.Start, $intro.Start).Select()
  Pic 'u-3' $F
  "  intro after F9: $($intro.Text)"

  # ---- 4. Go To a bookmark (figure: Ctrl+G, the Go To tab, Bookmark)
  try {
    $before = [Later]::Windows($script:wpid)
    $cmd = "`$d = [Runtime.InteropServices.Marshal]::GetActiveObject('Word.Application').Dialogs.Item(896); `$d.Show() | Out-Null"   # wdDialogEditGoTo
    Start-Process powershell.exe -WindowStyle Hidden -ArgumentList '-NoProfile', '-Command', $cmd
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 60
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; Pic 'g-1' $null $dlg; [C12]::Chars($dlg, 'B'); Start-Sleep -Milliseconds 1000; Pic 'g-2' $null $dlg; CloseDialog $dlg; CloseAll }
  } catch { "  go to: $_"; CloseAll }

  # ---- 5. A hyperlink to a place in the document (figure: Insert Link box, Place in This Document)
  try {
    $doc.Range($intro.Start, $intro.Start).Select()
    $dlg = OpenDialog (Ctl @('Link') $T::SplitButton)
    Start-Sleep -Milliseconds 1000
    [C12]::Alt($dlg, 0x41); Start-Sleep -Milliseconds 1200            # Alt+A: Place in This Document
    Pic 'h-1' $null $dlg
    DumpWin $dlg 'linkbox'
    CloseDialog $dlg; CloseAll
  } catch { "  link box: $_"; CloseAll }

  # ---- 6. The done-right copy: the starter, its three cross-references, the page break replaced by Page break before
  $done = $word.Documents.Add()
  $done.PageSetup.PaperSize = 7
  [void](Report $done '[table]' '[page]' '[heading]')
  $w = ParaLike $done 'Where the water goes'; $w.ParagraphFormat.PageBreakBefore = $true
  $cap = ParaLike $done 'Table 1'
  [void]$done.Bookmarks.Add('MeterTable', $done.Range($cap.Start, $cap.End - 1))
  $r = Words12 $done '[table]'; $r.Text = ''; $r.InsertCrossReference('Table', 3, 1, $false, $false)          # wdOnlyLabelAndNumber
  $r = Words12 $done '[page]'; $r.Text = ''; $r.InsertCrossReference('Bookmark', 7, 'MeterTable', $false, $false)
  $r = Words12 $done '[heading]'; $r.Text = ''
  $items = $done.GetCrossReferenceItems(1)                                                                       # wdRefTypeHeading
  $k = 0; for ($i = 1; $i -le $items.Count; $i++) { if ($items[$i - 1] -match 'Recommendations') { $k = $i } }
  if ($k -gt 0) { $r.InsertCrossReference('Heading', -1, $k, $false, $false) } else { $r.Text = 'Recommendations' }   # wdContentText
  [void]$done.Fields.Update()
  "  done intro: $((ParaLike $done 'Phumlani Secondary pays').Text)"
  "  table caption page: $($cap.Information(3))"
  Flat $done 'Water report final done.docx'
  SaveDoc12 $done 'Water report final done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  RestoreUser
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
