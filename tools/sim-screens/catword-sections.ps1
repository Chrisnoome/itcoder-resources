# Real Word 365 screens for catword lesson 14, 'sections' (content/catword/sections.php,
# Grade 11, 9 October 2026). Ms Naidoo's Grade 11 camp report: a Next Page
# section break (Layout > Breaks), one landscape section (Orientation), two
# columns in a section of their own (Columns > More Columns...), a column break
# (Ctrl+Shift+Enter), and a built-in cover page with its content controls.
# Also makes the upload's starter file (Camp report.docx, in
# C:\sims\files\catword-sections\ and G:\My Drive\CAT\Word\) and the done-right
# copy (Camp report done.docx).
#     pwsh -File vm-shots.ps1 catword-sections
$Name = 'catword-sections'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$lines = @(
  'Introduction',
  'In March, 64 Grade 11 pupils and four teachers spent three days at a camp in the Magaliesberg. This report tells the story of the camp, what it cost and what we learnt.',
  'Camp diary',
  'Day 1. The bus left school at 06:30 and reached the camp at 09:15. After a safety talk, each group pitched its tents and cooked lunch on gas stoves.',
  'In the afternoon the groups did a trust walk and a rope course. Supper was pap, wors and salad, cooked by the camp staff.',
  'Day 2. We hiked 12 km to the waterfall and back with a guide, who showed us how to read a map and a compass.',
  'After supper there was a night walk to see the stars. The guide pointed out the Southern Cross and Scorpius.',
  'Day 3. Each group planned and cooked breakfast, then packed up the camp and left it clean.',
  'The bus was back at school at 14:00, with 64 tired pupils and no injuries.',
  'Costs',
  'The camp cost R1 450 a pupil. The table shows where the money went.',
  'What we learnt',
  'Pupils said the hike and the night walk were the best parts of the camp. Next year we will book the camp earlier, and ask for a second guide.',
  ''
)

function At ($n, $k = 0) { $doc.Range((Para $doc $n).Start + $k, (Para $doc $n).Start + $k).Select() }
function FindPara ($like) { foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like $like) { return $p.Range } }; throw "no paragraph like $like" }

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  foreach ($i in 1, 3, 10, 12) { (Para $doc $i).Style = -2 }
  # the costs table, after paragraph 11 - wide, so it needs a landscape page
  $after = Para $doc 11
  $doc.Range($after.End, $after.End).InsertParagraphAfter()
  $tr = $doc.Range((Para $doc 12).Start, (Para $doc 12).Start)
  $tbl = $doc.Tables.Add($tr, 5, 7)
  $cells = @(
    @('Item', 'Bus', 'Camp fees', 'Food', 'Guide', 'Insurance', 'Total'),
    @('Per pupil', 'R320', 'R600', 'R380', 'R90', 'R60', 'R1 450'),
    @('64 pupils', 'R20 480', 'R38 400', 'R24 320', 'R5 760', 'R3 840', 'R92 800'),
    @('Paid by parents', 'R20 480', 'R38 400', 'R24 320', 'R5 760', 'R3 840', 'R92 800'),
    @('Paid by school', 'R0', 'R0', 'R0', 'R0', 'R0', 'R0')
  )
  for ($r = 1; $r -le 5; $r++) { for ($c = 1; $c -le 7; $c++) { $tbl.Cell($r, $c).Range.Text = $cells[$r - 1][$c - 1] } }
  $tbl.Range.Style = -1                                               # Normal (it took the heading's style)
  $tbl.Style = 'Table Grid'
  $tbl.Rows.Item(1).Range.Font.Bold = $true
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'Camp report.docx' $true
  Dump 'home'

  # ---- 1. A Next Page section break before Costs (Layout > Breaks > Next Page)
  $costs = FindPara 'Costs*'
  $doc.Range($costs.Start, $costs.Start).Select()
  Show $costs
  P 's-1' $A
  Pct 'layoutTab' 's-1' (Box (Ctl @('Layout') $T::TabItem))
  Tab 'Layout'
  Dump 'layout'
  P 's-2' $A
  $brk = Ctl @('Breaks')
  Pct 'breaks' 's-2' (Box $brk)
  foreach ($k in @(@('orientation', @('Orientation')), @('columns', @('Columns')), @('margins', @('Margins')))) { try { Pct $k[0] 's-2' (Box (Ctl $k[1])) } catch { "  MISSING $($k[0])" } }
  try {
    $menu = Menu $brk
    DumpMenu $menu 'breaksmenu'
    P 's-3' $A $h $menu
    $np = FindAny $menu @('Next Page')
    Pct 'nextPage' 's-3' (BoxIn $np $h)
    try { Pct 'continuous' 's-3' (BoxIn (FindAny $menu @('Continuous')) $h) } catch { }
    try { Pct 'columnBreak' 's-3' (BoxIn (FindAny $menu @('Column')) $h) } catch { }
    [Later]::Invoke($np); Start-Sleep -Milliseconds 2000
  } catch { "  breaks menu: $_"; Esc $null }
  Fresh
  if ($doc.Sections.Count -lt 2) { '  break by COM'; $costs = FindPara 'Costs*'; $doc.Range($costs.Start, $costs.Start).InsertBreak(2) }
  $word.ActiveWindow.View.ShowAll = $true
  $costs = FindPara 'Costs*'
  Show $costs
  $doc.Range($costs.Start, $costs.Start).Select()
  P 's-4' $A
  $word.ActiveWindow.View.ShowAll = $false

  # ---- 2. Only that section landscape: a second break after the table, then Orientation > Landscape
  $learnt = FindPara 'What we learnt*'
  $doc.Range($learnt.Start, $learnt.Start).InsertBreak(2)                   # wdSectionBreakNextPage
  $costs = FindPara 'Costs*'
  $doc.Range($costs.Start + 2, $costs.Start + 2).Select()
  Show $costs
  P 'o-1' $A
  $ori = Ctl @('Orientation')
  Pct 'orientation' 'o-1' (Box $ori)
  try {
    $menu = Menu $ori
    P 'o-2' $A $h $menu
    $land = FindAny $menu @('Landscape')
    Pct 'landscape' 'o-2' (BoxIn $land $h)
    [Later]::Invoke($land); Start-Sleep -Milliseconds 2000
  } catch { "  orientation menu: $_"; Esc $null }
  Fresh
  "  sections: $($doc.Sections.Count); orientations: $(($doc.Sections | ForEach-Object { $_.PageSetup.Orientation }) -join ',')"
  if ($doc.Sections.Item(2).PageSetup.Orientation -ne 1) { '  landscape by COM'; $doc.Sections.Item(2).PageSetup.Orientation = 1 }
  $zoom = $word.ActiveWindow.View.Zoom
  $zoom.PageColumns = 3; $zoom.PageRows = 1
  Start-Sleep -Milliseconds 800
  $zoom.Percentage = 33
  Start-Sleep -Milliseconds 1500
  Show $doc.Range(0, 0)
  P 'o-3' $A
  $word.ActiveWindow.View.Zoom.Percentage = 100
  Start-Sleep -Milliseconds 1200

  # ---- 3. The diary in two columns: continuous breaks round it, Columns > More Columns... > Two, line between
  $d1 = FindPara 'Day 1.*'
  $d9 = FindPara 'The bus was back*'
  $doc.Range($d1.Start, $d9.End).Select()
  Show $d1
  P 'c-1' $A
  $col = Ctl @('Columns')
  Pct 'columns' 'c-1' (Box $col)
  try {
    $menu = Menu $col
    DumpMenu $menu 'columnsmenu'
    P 'c-2' $A $h $menu
    $more = FindAny $menu @('More Columns...', 'More Columns')
    Pct 'moreColumns' 'c-2' (BoxIn $more $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($more)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'columnsbox'; P 'c-3' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  columns menu: $_"; Esc $null }
  Fresh
  $d1 = FindPara 'Day 1.*'
  $doc.Range($d1.Start, $d1.Start).InsertBreak(3)                           # wdSectionBreakContinuous
  $costs = FindPara 'Costs*'
  $doc.Range($costs.Start, $costs.Start).Select()
  # the diary ends in a Next Page break already (before Costs): its section is the second one
  $diary = $doc.Sections.Item(2)
  $diary.PageSetup.TextColumns.SetCount(2)
  $diary.PageSetup.TextColumns.LineBetween = -1
  "  sections now: $($doc.Sections.Count) - starts: $(($doc.Sections | ForEach-Object { $_.PageSetup.SectionStart }) -join ',') columns: $(($doc.Sections | ForEach-Object { $_.PageSetup.TextColumns.Count }) -join ',')"
  $d1 = FindPara 'Day 1.*'
  $doc.Range($d1.Start, $d1.Start).Select()
  Show (FindPara 'Introduction*')
  P 'c-4' $A

  # ---- 4. A column break before Day 3 (Ctrl+Shift+Enter)
  $d3 = FindPara '*Day 3.*'
  $doc.Range($d3.Start, $d3.Start).Select()
  Show (FindPara 'Introduction*')
  P 'k-1' $A
  $doc.Range($d3.Start, $d3.Start).InsertBreak(8)                           # wdColumnBreak
  $d3 = FindPara '*Day 3.*'
  $doc.Range($d3.Start, $d3.Start).Select()
  Show (FindPara 'Introduction*')
  P 'k-2' $A

  # ---- 5. A cover page: Insert > Cover Page > a design; then its title box
  $doc.Range(0, 0).Select()
  Tab 'Home'
  P 'v-1' $A
  Pct 'insertTab' 'v-1' (Box (Ctl @('Insert') $T::TabItem))
  Tab 'Insert'
  P 'v-2' $A
  $cp = Ctl @('Cover Page')
  Pct 'coverPage' 'v-2' (Box $cp)
  try { Pct 'blankPage' 'v-2' (Box (Ctl @('Blank Page'))) } catch { }
  $coverDone = $false
  try {
    $menu = Menu $cp
    DumpMenu $menu 'covermenu'
    P 'v-3' $A $h $menu
    $pick = $null
    foreach ($r in @($AE::FromHandle($menu), $AE::RootElement)) {
      $items = @($r.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))))
      foreach ($want in 'Facet', 'Retrospect', 'Ion', 'Banded', 'Grid', 'Austin') { foreach ($e in $items) { try { if (-not $e.Current.IsOffscreen -and $e.Current.Name -match "^$want") { $pick = $e; break } } catch { } }; if ($pick) { break } }
      if ($pick) { break }
    }
    if ($pick) { "  cover item: $($pick.Current.Name)"; Pct 'design' 'v-3' (BoxIn $pick $h); [Later]::Invoke($pick); Start-Sleep -Milliseconds 3000; $coverDone = $true }
    else { '  MISSING cover design'; Esc $menu }
  } catch { "  cover menu: $_"; Esc $null }
  Fresh
  "  content controls: $($doc.ContentControls.Count)"
  foreach ($cc in $doc.ContentControls) { "   cc: type $($cc.Type) title '$($cc.Title)' tag '$($cc.Tag)' text '$($cc.Range.Text)' placeholder $($cc.ShowingPlaceholderText)" }
  $word.ActiveWindow.View.Zoom.PageFit = 1                              # wdPageFitFullPage
  Start-Sleep -Milliseconds 1200
  P 'v-4' $A
  $word.ActiveWindow.View.Zoom.Percentage = 100
  # the title box: where it is (a content control titled Title), then typed in
  $titleCc = $null
  foreach ($cc in $doc.ContentControls) { if ($cc.Title -eq 'Title') { $titleCc = $cc; break } }
  if (-not $titleCc) { foreach ($sr in $doc.StoryRanges) { foreach ($cc in $sr.ContentControls) { if ($cc.Title -eq 'Title') { $titleCc = $cc } } } }
  if ($titleCc) {
    try { Pct 'titleBox' 'v-4' (TextBox $titleCc.Range) } catch { "  title box place: $_" }
    $titleCc.Range.Select()
    P 'v-5' $A
    $titleCc.Range.Text = 'Grade 11 camp report'
    Start-Sleep -Milliseconds 800
    P 'v-6' $A
  } else { '  NO Title content control' }
  try { foreach ($cc in $doc.ContentControls) { if ($cc.Title -eq 'Author') { $cc.Range.Text = 'Ms P. Naidoo' } } } catch { }

  # ---- 6. The done-right copy
  foreach ($p in $doc.Paragraphs) { $t = $p.Range.Text.Trim(); if ($t) { "  [$($p.Style.NameLocal)] $($t.Substring(0, [math]::Min(50, $t.Length)))" } }
  SaveDoc $doc 'Camp report done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
