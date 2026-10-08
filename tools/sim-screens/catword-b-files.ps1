# The upload starter files of catword lessons 6-10, and a done-right copy of
# each (Chris, 8 October 2026: "cat files also must be stored using the cloud
# - google drive"), made by real Word and Excel 365 in the CAT VM and saved in
# C:\sims\files\catword-b-files\ (back to files\catword-b-files\ on the
# host) and G:\My Drive\CAT\Word\. The same documents the screen scripts
# show (catword-pagelayout, -tables, -proofing, -integration).
# Word and Excel run in a job of their own (a separate process, unseen), as the
# PowerPoint writer's WordOutline does: in the screen scripts' own process,
# Word's SaveAs2 waited for ever in the VM (8 October 2026). A job that hangs
# is stopped after six minutes and says so.
#     pwsh -File vm-shots.ps1 catword-b-files
$Name = 'catword-b-files'
$dir = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $dir | Out-Null

$job = Start-Job -ArgumentList $dir {
  param($dir)
  $ErrorActionPreference = 'Stop'
  $Name = 'catword-b-files'
  function OwnStyles ($d) { foreach ($style in $d.Styles) { try { if ($style.QuickStyle -and -not $style.BuiltIn) { $style.QuickStyle = $false } } catch { } } }
  function SaveBoth ($d, $file) {
    $d.SaveAs2((Join-Path $dir $file), 16)
    try { New-Item -ItemType Directory -Force 'G:\My Drive\CAT\Word' | Out-Null; Copy-Item (Join-Path $dir $file) 'G:\My Drive\CAT\Word' -Force; "  saved $file, and in the cloud" } catch { "  saved $file - NO CLOUD COPY: $_" }
  }
  $news = @(
  'Phumlani News',
  'Term 3, 2026 - the newsletter of Phumlani Secondary, Soweto',
  'Our new library',
  'The new library opens on Monday. It has forty computers, a printer and more than two thousand books. Ms Naidoo says the computers are for homework and projects during break and after school, and the librarian will help anyone who gets stuck.',
  'Market day',
  'The Grade 10 market day raised R4 350 for the matric farewell. Thank you to every stall holder and every parent who came. The cupcakes sold out by eleven o''clock, and the boerewors rolls soon after.',
  'Sport',
  'The netball team beat Orlando High 24 to 19 on Saturday, and the soccer team plays in the district semi-final next week. Come and support them at the Dobsonville stadium.',
  'Dates to remember',
  'Reports go home on Friday 25 September. Schools close on 2 October and open again on 13 October.'
)
  function Newsletter ($d) {
  $d.Content.Text = ($news -join "`r")
  $d.Content.ParagraphFormat.Alignment = 0
  $d.Content.Font.Reset()
  OwnStyles $d
  $d.PageSetup.PaperSize = 7                                        # A4
  $d.Paragraphs.Item(1).Style = -63                                 # wdStyleTitle
  foreach ($i in 3, 5, 7, 9) { $d.Paragraphs.Item($i).Style = -2 }  # Heading 1
}

  $items = @(@('White bread', '18.00', '42'), @('Brown bread', '17.00', '35'), @('Cupcakes', '12.00', '60'), @('Koeksisters', '8.00', '48'))
function Fill ($t, $row, $values) { for ($c = 0; $c -lt $values.Count; $c++) { $t.Cell($row, $c + 1).Range.Text = $values[$c] } }

  function Essay ($d, [string[]]$paras) {
  $d.Content.Text = ($paras -join "`r")
  OwnStyles $d
  $d.PageSetup.PaperSize = 7
  $d.Paragraphs.Item(1).Style = -63
}
function Para ($d, $text) { foreach ($p in $d.Paragraphs) { if ($p.Range.Text -like "*$text*") { return $p } }; throw "no paragraph with $text" }
function WordIn ($d, $text) { $r = $d.Content; $f = $r.Find; [void]$f.Execute($text, $true, (-not $text.Contains(' '))); if (-not $f.Found) { throw "no $text" }; return $r }

  $rows = @(@('Item', 'Price (R)', 'Number sold'), @('White bread', '18', '42'), @('Brown bread', '17', '35'), @('Cupcakes', '12', '60'), @('Koeksisters', '8', '48'), @('Rusks', '25', '30'))
function SalesSheet ($wb) {
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Saturday'
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt 3; $c++) { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } }
  $ws.Range('A7').Formula = 'Total'
  $ws.Range('C7').Formula = '=SUM(C2:C6)'
  $ws.Range('A1:C1').Font.Bold = $true
  $ws.Range('A7:C7').Font.Bold = $true
  $ws.Range('B2:B6').NumberFormat = '0.00'
  $ws.Columns.Item('A').ColumnWidth = 14; $ws.Columns.Item('B').ColumnWidth = 11; $ws.Columns.Item('C').ColumnWidth = 13
  return $ws
}



  $word = New-Object -ComObject Word.Application
  $xl = New-Object -ComObject Excel.Application
  $start = $null
  try {
    $word.DisplayAlerts = 0
    $xl.DisplayAlerts = $false
    "--- pagelayout"
    # ---- the starter file, and a done-right copy (upPageLayout)
    $start = $word.Documents.Add()
    Newsletter $start
    SaveBoth $start 'Newsletter.docx'
    $start.PageSetup.TopMargin = $word.CentimetersToPoints(2); $start.PageSetup.BottomMargin = $word.CentimetersToPoints(2)
    $start.PageSetup.LeftMargin = $word.CentimetersToPoints(2); $start.PageSetup.RightMargin = $word.CentimetersToPoints(2)
    $start.Sections.Item(1).Headers.Item(1).Range.Text = 'Phumlani News - Term 3'
    [void]$start.Sections.Item(1).Footers.Item(1).PageNumbers.Add(1, $true)   # centred, on the first page too
    $s = $start.Paragraphs.Item(7).Range.Start
    $start.Range($s, $s).InsertBreak(7)                               # a page break before Sport
    $start.SaveAs2((Join-Path "C:\sims\files\$Name" 'Newsletter-done.docx'), 16)
    $start.Close(0); $start = $null
  
    "--- tables"
    # ---- the starter file, and a done-right copy (upSalesTable)
    $start = $word.Documents.Add()
    OwnStyles $start
    $start.PageSetup.PaperSize = 7
    $start.Content.Text = "Saturday sales`rBotha's Bakery, Centurion - what we sold on Saturday.`r"
    $start.Paragraphs.Item(1).Style = -2
    $t = $start.Tables.Add($start.Paragraphs.Item(3).Range, 7, 3)
    $t.Style = 'Table Grid'
    Fill $t 1 @("Botha's Bakery - Saturday sales", '', '')
    Fill $t 2 @('Item', 'Price (R)', 'Number sold')
    for ($i = 0; $i -lt 4; $i++) { Fill $t ($i + 3) $items[$i] }
    Fill $t 7 @('Total', '', '')
    SaveBoth $start 'SaturdaySales.docx'
    $t.Rows.Item(1).Cells.Merge()
    [void]$t.Rows.Add($t.Rows.Item(7))                                # a row above Total
    Fill $t 7 @('Rusks', '25.00', '30')
    $t.Cell(8, 3).Formula('=SUM(ABOVE)')
    $t.Style = 'Grid Table 4 - Accent 1'
    $start.SaveAs2((Join-Path "C:\sims\files\$Name" 'SaturdaySales-done.docx'), 16)
    $start.Close(0); $start = $null
  
    "--- proofing"
    # ---- the starter file, and a done-right copy (upEssay)
    $start = $word.Documents.Add()
    Essay $start @(
      'My dream job',
      'When I finish school I want to become a software developer. I like solving problems, and I want to recieve a bursary to study at university.',
      'My sister Lerato says the the best developers never stop learning. She is definately right: the tools change every year.',
      'I will practise every day, keep my marks high and finish my projects on time. I beleive nothing will stop me.',
      'Words:')
    SaveBoth $start 'ThaboEssay.docx'
    foreach ($fix in @(@('recieve', 'receive'), @('the the', 'the'), @('definately', 'definitely'), @('beleive', 'believe'))) {
      $r = $start.Content; [void]$r.Find.Execute($fix[0], $true, $false, $false, $false, $false, $true, 0, $false, $fix[1], 2)
    }
    $count = $start.Range($start.Paragraphs.Item(2).Range.Start, $start.Paragraphs.Item(4).Range.End).ComputeStatistics(0)
    "  the essay has $count words"
    $last = $start.Paragraphs.Item(5).Range
    [void]$last.MoveEnd(1, -1)
    $last.InsertAfter(" $count")
    $start.SaveAs2((Join-Path "C:\sims\files\$Name" 'ThaboEssay-done.docx'), 16)
    Set-Content (Join-Path "C:\sims\files\$Name" 'wordcount.txt') "$count"
    $start.Close(0); $start = $null
  
    "--- integration"
    # ---- the starter files, and a done-right copy (upReport)
    $wb = $xl.Workbooks.Add()
    $ws = SalesSheet $wb
    "  saving the sheet"
    $wb.SaveAs((Join-Path "C:\sims\files\$Name" 'SaturdaySales.xlsx'), 51)
    try { New-Item -ItemType Directory -Force 'G:\My Drive\CAT\Word' | Out-Null; Copy-Item (Join-Path "C:\sims\files\$Name" 'SaturdaySales.xlsx') 'G:\My Drive\CAT\Word\' -Force } catch { "  NO CLOUD COPY: $_" }
    $start = $word.Documents.Add()
    OwnStyles $start
    $start.PageSetup.PaperSize = 7
    $start.Content.Text = (@('Saturday report', "Mr Botha asked for Saturday's sales in his weekly report. Here they are:", '', 'Next week we bake twice as many cupcakes.') -join "`r")
    $start.Paragraphs.Item(1).Style = -2
    SaveBoth $start 'SalesReport.docx'
    $ws.Range('A1:C7').Copy()
    $start.Paragraphs.Item(3).Range.Select()
    $word.Selection.Paste()
    Start-Sleep -Milliseconds 800
    $p = Para $start 'Next week'
    $p.Range.InsertParagraphBefore()
    (Para $start 'Next week').Range.Previous(4, 1).InsertBefore('Source: SaturdaySales.xlsx')
    $start.SaveAs2((Join-Path "C:\sims\files\$Name" 'SalesReport-done.docx'), 16)
    $start.Close(0); $start = $null
  
    "done"
  }
  finally {
    if ($start) { try { $start.Saved = $true; $start.Close(0) } catch { } }
    $word.Quit()
    try { foreach ($b in @($xl.Workbooks)) { $b.Saved = $true }; $xl.Quit() } catch { }
  }
}
if (Wait-Job $job -Timeout 360) {
  Receive-Job $job
} else {
  Stop-Job $job
  Receive-Job $job
  Get-Process WINWORD, EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # under the VM lock: only this run's Office is open
  'FAILED: Word hung - not every file was made'
}
Remove-Job $job -Force
Get-ChildItem $dir | ForEach-Object { "  $($_.Name) $($_.Length)" }
