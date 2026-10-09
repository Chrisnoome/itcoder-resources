# Real Word 365 screens for catword lesson 16, 'footnotes' (content/catword/footnotes.php,
# Grade 11, 9 October 2026). Thabo's report "Saving water at Phumlani Secondary":
# Insert Footnote (References tab), Insert Caption for a table, Insert Table of
# Figures, Mark Entry (Alt+Shift+X) and Insert Index, plus figures of the Equation
# gallery and the Table of Authorities group. Also makes the upload's starter file
# (Saving water report.docx, in C:\sims\files\catword-footnotes\ and G:\My Drive\CAT\Word\)
# and the done-right copy (Saving water report done.docx).
#     pwsh -File vm-shots.ps1 catword-footnotes
$Name = 'catword-footnotes'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$lines = @(
  'Saving water at Phumlani Secondary',
  'List of tables',
  '',
  'Introduction',
  'Gauteng had a drought in 2024, and the school''s water bill doubled. This report looks at where the school uses water, and how it could use less.',
  'Where the water goes',
  'The caretaker read the water meter every morning for two weeks. The table shows the average use per day.',
  'Most of the water is flushed away: the toilets use about 60% of it. One leaking toilet can waste 1 000 litres a day.',
  'Using less',
  'Fixing leaks is the cheapest saving. Rainwater tanks can water the garden: a tank of 5 000 litres costs about R6 500.',
  'Conclusion',
  'With the leaks fixed and two rainwater tanks, the school could use a third less water.',
  'Index',
  ''
)
function FindPara ($like) { foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like $like) { return $p.Range } }; throw "no paragraph like $like" }

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  (Para $doc 1).Style = -63
  foreach ($like in 'List of tables*', 'Introduction*', 'Where the water goes*', 'Using less*', 'Conclusion*', 'Index*') { (FindPara $like).Style = -2 }
  (FindPara 'Introduction*').ParagraphFormat.PageBreakBefore = $true
  (FindPara 'Index*').ParagraphFormat.PageBreakBefore = $true
  # the table after "The caretaker read..."
  $tp = FindPara 'Most of the water*'
  $doc.Range($tp.Start, $tp.Start).InsertParagraphBefore()
  $tr = $doc.Range($tp.Start - 1, $tp.Start - 1)                  # inside the new empty paragraph
  $tbl = $doc.Tables.Add($tr, 6, 2)
  $cells = @(@('Where', 'Litres a day'), @('Toilets', '4 200'), @('Taps', '1 300'), @('Garden', '900'), @('Kitchen', '400'), @('Total', '6 800'))
  for ($r = 1; $r -le 6; $r++) { for ($c = 1; $c -le 2; $c++) { $tbl.Cell($r, $c).Range.Text = $cells[$r - 1][$c - 1] } }
  $tbl.Style = 'Table Grid'
  $tbl.Rows.Item(1).Range.Font.Bold = $true
  $tbl.PreferredWidthType = 2; $tbl.PreferredWidth = 50
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'Saving water report.docx' $true
  foreach ($p in $doc.Paragraphs) { $tx = $p.Range.Text.Trim(); "  [$($p.Style.NameLocal)] $tx" }

  # ---- 1. A footnote after "2024": References > Insert Footnote, then the text
  $intro = FindPara 'Gauteng had a drought*'
  $at = $intro.Start + 'Gauteng had a drought in 2024'.Length
  $doc.Range($at, $at).Select()
  Show $intro
  P 'f-1' $F
  Pct 'refTab' 'f-1' (Box (Ctl @('References') $T::TabItem))
  Tab 'References'
  Dump 'references'
  P 'f-2' $F
  foreach ($k in @(@('insertFootnote', @('Insert Footnote...', 'Insert Footnote')), @('insertEndnote', @('Insert Endnote...', 'Insert Endnote')), @('insertCaption', @('Insert Caption...', 'Insert Caption')), @('tableOfFigures', @('Insert Table of Figures...', 'Insert Table of Figures')), @('markEntry', @('Mark Entry')), @('insertIndex', @('Insert Index...', 'Insert Index')), @('markCitation', @('Mark Citation...', 'Mark Citation')), @('tableOfAuthorities', @('Insert Table of Authorities...', 'Insert Table of Authorities')), @('crossRef', @('Cross-reference...', 'Cross-reference')))) {
    try { Pct $k[0] 'f-2' (Box (Ctl $k[1])) } catch { "  MISSING $($k[0])" }
  }
  [void]$doc.Footnotes.Add($doc.Range($at, $at))
  Start-Sleep -Milliseconds 1500
  $fn = $doc.Footnotes.Item(1)
  $fr = $fn.Range
  $fr.Select()
  Start-Sleep -Milliseconds 800
  P 'f-3' $F
  try { Pct 'noteText' 'f-3' (TextBox $fr) } catch { "  footnote place: $_" }
  $fr.Text = 'The drought lasted from October 2023 to March 2024 (South African Weather Service).'
  Start-Sleep -Milliseconds 800
  P 'f-4' $F

  # ---- 2. A caption for the table: References > Insert Caption (label Table)
  $tbl = $doc.Tables.Item(1)
  $tbl.Range.Select()
  [void]$word.Selection.InsertCaption('Table', ': Water used per day', '', 0)    # once by COM, so the box remembers the label Table - then undone
  $doc.Undo() | Out-Null
  $tbl = $doc.Tables.Item(1)
  $tbl.Range.Select()
  Show $tbl.Range
  P 'c-1' $F
  try {
    $ic = Ctl @('Insert Caption...', 'Insert Caption')
    Pct 'insertCaption' 'c-1' (Box $ic)
    $dlg = OpenDialog $ic
    DumpWin $dlg 'caption'
    P 'c-2' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  caption box: $_" }
  Fresh
  $tbl = $doc.Tables.Item(1)
  $tbl.Range.Select()
  [void]$word.Selection.InsertCaption('Table', ': Water used per day', '', 0)   # wdCaptionPositionAbove
  Start-Sleep -Milliseconds 1000
  $doc.Range($tbl.Range.Start, $tbl.Range.Start).Select()
  Show $tbl.Range
  P 'c-3' $F
  foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like 'Table 1*') { "  caption: [$($p.Style.NameLocal)] $($p.Range.Text.Trim())" } }

  # ---- 3. The table of figures on the empty line under List of tables
  $lt = FindPara 'List of tables*'
  $empty = $doc.Paragraphs.Item(3).Range
  $doc.Range($empty.Start, $empty.Start).Select()
  Show $doc.Range(0, 0)
  P 'tf-1' $F
  try {
    $tf = Ctl @('Insert Table of Figures...', 'Insert Table of Figures')
    Pct 'tableOfFigures' 'tf-1' (Box $tf)
    $dlg = OpenDialog $tf
    DumpWin $dlg 'tablefigures'
    P 'tf-2' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  table of figures box: $_" }
  Fresh
  $empty = $doc.Paragraphs.Item(3).Range
  [void]$doc.TablesOfFigures.Add($doc.Range($empty.Start, $empty.Start), 'Table')
  Start-Sleep -Milliseconds 1200
  $doc.Range(0, 0).Select()
  Show $doc.Range(0, 0)
  P 'tf-3' $F

  # ---- 4. Index: select "rainwater tanks", Mark Entry (Alt+Shift+X), Mark All; then Insert Index under Index
  $ru = FindPara 'Fixing leaks*'
  $i0 = $ru.Text.IndexOf('Rainwater tanks')
  $sel = $doc.Range($ru.Start + $i0, $ru.Start + $i0 + 'Rainwater tanks'.Length)
  $sel.Select()
  Show $ru
  P 'ix-1' $F
  try {
    $me = Ctl @('Mark Entry...', 'Mark Entry')
    Pct 'markEntry' 'ix-1' (Box $me)
    $dlg = OpenDialog $me
    DumpWin $dlg 'markentry'
    P 'ix-2' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  mark entry box: $_" }
  Fresh
  # entries: rainwater tanks (Mark All), leaks, toilets, water meter, drought
  foreach ($kv in @(@('Fixing leaks*', 'Rainwater tanks', 'rainwater tanks'), @('Fixing leaks*', 'leaks', 'leaks'), @('Most of the water*', 'toilets', 'toilets'), @('The caretaker read*', 'water meter', 'water meter'), @('Gauteng had a drought*', 'drought', 'drought'))) {
    $p = FindPara $kv[0]; $i = $p.Text.IndexOf($kv[1])
    if ($i -ge 0) { [void]$doc.Indexes.MarkEntry($doc.Range($p.Start + $i, $p.Start + $i + $kv[1].Length), $kv[2]) }
  }
  $word.ActiveWindow.View.ShowAll = $true
  $ru = FindPara 'Fixing leaks*'
  $doc.Range($ru.Start, $ru.Start).Select()
  Show $ru
  P 'ix-3' $F
  $word.ActiveWindow.View.ShowAll = $false
  $ix = FindPara 'Index*'
  $last = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  $doc.Range($last.Start, $last.Start).Select()
  Show $last
  P 'ix-4' $F
  try {
    $ii = Ctl @('Insert Index...', 'Insert Index')
    Pct 'insertIndex' 'ix-4' (Box $ii)
    $dlg = OpenDialog $ii
    DumpWin $dlg 'insertindex'
    P 'ix-5' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  insert index box: $_" }
  Fresh
  $last = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  [void]$doc.Indexes.Add($doc.Range($last.Start, $last.Start), 1, 1)        # wdHeadingSeparatorBlankLine, right-aligned page numbers
  Start-Sleep -Milliseconds 1200
  Show $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  P 'ix-6' $F

  # ---- 5. Figures: the Equation gallery (Insert tab), the Insert Endnote place
  Tab 'Insert'
  try {
    $eq = Ctl @('Equation')
    $menu = OpenMenu $eq
    DumpMenu $menu 'equationmenu'
    P 'eq-1' $F $h $menu
    Esc $menu
  } catch { "  equation gallery: $_"; Esc $null }
  Fresh
  Tab 'Home'

  # ---- 6. The done-right copy: footnote, caption above the table, table of figures, index entries and the index
  $doc.TablesOfFigures.Item(1).Update()
  foreach ($p in $doc.Paragraphs) { $tx = $p.Range.Text.Trim(); if ($tx) { "  [$($p.Style.NameLocal)] $($tx.Substring(0, [math]::Min(60, $tx.Length)))" } }
  SaveDoc $doc 'Saving water report done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
