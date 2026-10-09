# Real Word 365 screens for catword lesson 15, 'headers' (content/catword/headers.php,
# Grade 11, 9 October 2026). Lerato's history project, two sections (the cover
# and introduction; the chapters): Different First Page, Next (to the next
# section's header) and Link to Previous, Document Info > File Name, Page Number
# > Format Page Numbers... (Start at), the Date and Time box, and Quick Parts
# (Insert tab). Also makes the upload's starter file (History project.docx, in
# C:\sims\files\catword-headers\ and G:\My Drive\CAT\Word\) and the done-right
# copy (History project done.docx).
#     pwsh -File vm-shots.ps1 catword-headers
$Name = 'catword-headers'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$lines = @(
  'The 1976 Soweto Uprising',
  'A history project by Lerato Mokoena, Grade 11, 2027',
  'Introduction',
  'On 16 June 1976, thousands of Soweto school pupils marched against being taught in Afrikaans. This project tells how the march was planned, what happened on the day, and what changed afterwards. Today 16 June is Youth Day, a public holiday.',
  'Chapter 1: The pupils'' plan',
  'In 1974 the government ordered that half of the subjects in black schools be taught in Afrikaans. Pupils and teachers objected, and in May 1976 pupils at some Soweto schools began to stay away from classes.',
  'Student leaders met in secret and planned a peaceful march for 16 June, from Naledi High School and Morris Isaacson High School to Orlando Stadium.',
  'Chapter 2: 16 June 1976',
  'Thousands of pupils joined the march. Police blocked the road near Orlando West High School, and opened fire. Hector Pieterson, aged 12, was among the first to be killed.',
  'Chapter 3: What changed',
  'The protests spread across the country. The Afrikaans order was dropped, and the uprising became a turning point in the struggle against apartheid.',
  ''
)
function FindPara ($like) { foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like $like) { return $p.Range } }; throw "no paragraph like $like" }
function Seek ($v) { $word.ActiveWindow.ActivePane.View.SeekView = $v; Start-Sleep -Milliseconds 900 }   # 0 main, 9 current page header, 10 current page footer

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  (Para $doc 1).Style = -63
  foreach ($like in 'Introduction*', 'Chapter 1:*', 'Chapter 2:*', 'Chapter 3:*') { (FindPara $like).Style = -2 }
  (FindPara 'Introduction*').ParagraphFormat.PageBreakBefore = $true
  (FindPara 'Chapter 2:*').ParagraphFormat.PageBreakBefore = $true
  (FindPara 'Chapter 3:*').ParagraphFormat.PageBreakBefore = $true
  $c1 = FindPara 'Chapter 1:*'
  $doc.Range($c1.Start, $c1.Start).InsertBreak(2)                         # a Next Page section break before Chapter 1
  $props = $doc.BuiltInDocumentProperties
  foreach ($kv in @(@('Title', 'The 1976 Soweto Uprising'), @('Author', 'Lerato Mokoena'))) {
    try { $pr = [System.__ComObject].InvokeMember('Item', [Reflection.BindingFlags]::GetProperty, $null, $props, @($kv[0])); [void][System.__ComObject].InvokeMember('Value', [Reflection.BindingFlags]::SetProperty, $null, $pr, @($kv[1])) } catch { "  property $($kv[0]): $_" }
  }
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'History project.docx' $true
  "  sections: $($doc.Sections.Count)"

  # page numbers in the footer of both sections (Insert > Page Number > Bottom of Page > Plain Number 2, by COM)
  [void]$doc.Sections.Item(1).Footers.Item(1).PageNumbers.Add(1, $true)    # wdAlignPageNumberCenter, on the first page too

  # ---- 1. Different First Page: open the header (double-click the top margin), then the tick box
  $word.ActiveWindow.VerticalPercentScrolled = 0
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 800
  P 'fp-1' $F
  $tb = TextBox ((Para $doc 1).Duplicate)
  Pct 'topMargin' 'fp-1' @(($tb[0] - 10), ($tb[1] - 95), 560, 60)
  Seek 9
  $doc.Range(0, 0) | Out-Null
  Dump 'hftab'
  P 'fp-2' $F
  foreach ($k in @(@('firstPage', @('Different First Page'), $T::CheckBox), @('oddEven', @('Different Odd & Even Pages'), $T::CheckBox), @('next', @('Next'), $null), @('previous', @('Previous'), $null), @('link', @('Link to Previous'), $null), @('docInfo', @('Document Info'), $null), @('dateTime', @('Date & Time...', 'Date & Time'), $null), @('pageNumber', @('Page Number'), $null), @('quickParts', @('Quick Parts'), $null), @('close', @('Close Header and Footer'), $null), @('goFooter', @('Go to Footer'), $null))) {
    try { Pct $k[0] 'fp-2' (Box (Ctl $k[1] $k[2])) } catch { "  MISSING $($k[0])" }
  }
  $doc.Sections.Item(1).PageSetup.DifferentFirstPageHeaderFooter = -1
  Start-Sleep -Milliseconds 1200
  P 'fp-3' $F

  # ---- 2. Next, then Link to Previous off, in the header of section 2
  Seek 0
  $doc.Range((FindPara 'Introduction*').Start, (FindPara 'Introduction*').Start).Select()
  Seek 9
  P 'lk-1' $F
  try { Pct 'next' 'lk-1' (Box (Ctl @('Next'))) } catch { '  MISSING next' }
  Seek 0
  $c1 = FindPara 'Chapter 1:*'
  $doc.Range($c1.Start, $c1.Start).Select()
  Seek 9
  P 'lk-2' $F
  try { Pct 'link' 'lk-2' (Box (Ctl @('Link to Previous'))) } catch { '  MISSING link' }
  $h2 = $doc.Sections.Item(2).Headers.Item(1)
  $h2.LinkToPrevious = $false
  $h2.Range.Text = 'The 1976 Soweto Uprising'
  Start-Sleep -Milliseconds 1000
  $end = $h2.Range; $end.Collapse(0); $end.Select()
  P 'lk-3' $F

  # ---- 3. Document Info > File Name in the same header, after a tab (the menu pictured; the field put in by COM)
  $end = $h2.Range; $end.Collapse(0); $end.InsertAfter("`t")
  $end = $h2.Range; $end.Collapse(0); $end.Select()
  P 'f-1' $F
  try {
    $di = Ctl @('Document Info')
    Pct 'docInfo' 'f-1' (Box $di)
    $menu = Menu $di
    DumpMenu $menu 'docinfomenu'
    P 'f-2' $F $h $menu
    $fn = FindAny $menu @('File Name')
    Pct 'fileName' 'f-2' (BoxIn $fn $h)
    try { Pct 'filePath' 'f-2' (BoxIn (FindAny $menu @('File Path')) $h) } catch { }
    Esc $menu
  } catch { "  document info: $_"; Esc $null }
  Fresh
  $end = $h2.Range; $end.Collapse(0)
  [void]$h2.Range.Fields.Add($end, 29)                                     # wdFieldFileName
  "  header 2: $($h2.Range.Text) fields $($h2.Range.Fields.Count); header 1: '$($doc.Sections.Item(1).Headers.Item(1).Range.Text.Trim())'"
  $end = $h2.Range; $end.Collapse(0); $end.Select()
  P 'f-3' $F

  # ---- 4. Section 2's page numbers start at 1: Page Number > Format Page Numbers... > Start at
  Seek 10
  $doc.Sections.Item(2).Footers.Item(1).LinkToPrevious = $true
  P 'pn-1' $F
  $pn = Ctl @('Page Number')
  Pct 'pageNumber' 'pn-1' (Box $pn)
  try {
    $menu = Menu $pn
    P 'pn-2' $F $h $menu
    $fmt = FindAny $menu @('Format Page Numbers...', 'Format Page Numbers')
    Pct 'format' 'pn-2' (BoxIn $fmt $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($fmt)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'pageformat'; P 'pn-3' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  page number menu: $_"; Esc $null }
  Fresh
  $pns = $doc.Sections.Item(2).Footers.Item(1).PageNumbers
  $pns.RestartNumberingAtSection = $true
  $pns.StartingNumber = 1
  Start-Sleep -Milliseconds 1000
  P 'pn-4' $F

  # ---- 5. The date in the footer: the Date and Time box (a figure), then a DATE field that updates
  $f2 = $doc.Sections.Item(1).Footers.Item(1)
  $fe = $f2.Range; $fe.Collapse(0); $fe.InsertAfter("`t")
  $fe = $f2.Range; $fe.Collapse(0); $fe.Select()
  try {
    $dt = Ctl @('Date & Time...', 'Date & Time')
    $dlg = OpenDialog $dt
    DumpWin $dlg 'datetime'
    P 'dt-1' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  date and time: $_" }
  Fresh
  $fe = $f2.Range; $fe.Collapse(0)
  [void]$f2.Range.Fields.Add($fe, 31, '\@ "d MMMM yyyy"', $false)        # wdFieldDate
  Start-Sleep -Milliseconds 800
  P 'dt-2' $F
  Seek 0

  # ---- 6. Quick Parts (Insert tab): the menu and Document Property (figures, IEB)
  Tab 'Insert'
  try {
    $qp = Ctl @('Quick Parts', 'Explore Quick Parts')
    $menu = Menu $qp
    DumpMenu $menu 'quickmenu'
    P 'qp-1' $F $h $menu
    try {
      $dp = FindAny $menu @('Document Property')
      [Later]::Expand($dp); Start-Sleep -Milliseconds 1500
      $sub = NewWindow ([Later]::Windows($script:wpid)) @() 4
      P 'qp-2' $F $h $menu
    } catch { "  document property: $_" }
    Esc $menu; Esc $null
  } catch { "  quick parts: $_"; Esc $null }
  Fresh
  Tab 'Home'

  # ---- 7. The done-right copy: section 1 different first page, page numbers, section 2 header unlinked with the
  # title and the file name, the footer with the page number and the date, section 2 numbered from 1
  foreach ($s in $doc.Sections) { "  section $($s.Index): first $($s.PageSetup.DifferentFirstPageHeaderFooter) header '$($s.Headers.Item(1).Range.Text.Trim())' linked $($s.Headers.Item(1).LinkToPrevious) footer '$($s.Footers.Item(1).Range.Text.Trim())'" }
  SaveDoc $doc 'History project done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
