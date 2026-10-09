# The upload starter files of catword lessons 6-10, and a done-right copy of
# each (Chris, 8 October 2026: "cat files also must be stored using the cloud
# - google drive"), made by real Word and Excel 365 in the CAT VM and saved in
# C:\sims\files\catword-b-files\ (back to files\catword-b-files\ on the
# host) and G:\My Drive\CAT\Word\. The same documents the screen scripts
# show (catword-pagelayout, -tables, -illustrations, -proofing, -integration).
#
# 9 October 2026 ("complete simulations and marking"): the tasks now ask for -
# and the uploads mark - the newsletter's columns and DRAFT watermark, the
# table's style, the essay's comment, the report's hyperlink; and lesson 8
# (illustrations) has an upload at last: E-waste project.docx and the picture
# e-waste.jpg. The run also remakes three done-right copies of other lessons
# whose checks grew (work\cwin-*.docx in, the same names out without "cwin-"):
# Specials done (fonts: highlight and small caps), Camp form done (templates:
# protected for filling in forms), Water report final done (crossrefs: the
# heading's cross-reference).
#
# Word and Excel run in a job of their own (a separate process, unseen). Word's
# SaveAs2 hangs in the VM (8 October 2026, and again on 9 October), so every
# .docx is packed from Document.WordOpenXML the way the kit's SaveDoc does
# (work/catword11-kit.ps1, FlatToDocx) - no Word save; Excel saves itself. The
# illustrations files (E-waste project) are made by catword-ewaste-files.ps1. Files for the cloud are
# scrubbed of the Office account's name first (as scrub-office.py does).
#     pwsh -File vm-shots.ps1 catword-b-files -TimeoutSec 900
$Name = 'catword-b-files'
$dir = "C:\sims\files\$Name"
$work = Join-Path $PSScriptRoot 'work'
New-Item -ItemType Directory -Force $dir | Out-Null

$job = Start-Job -ArgumentList $dir, $work {
  param($dir, $work)
  $ErrorActionPreference = 'Stop'
  Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
  $cloud = 'G:\My Drive\CAT\Word'
  # The Office account's name out of a saved file (docProps, comments, people) - as scrub-office.py.
  function Scrub ($path) {
    $zip = [System.IO.Compression.ZipFile]::Open($path, 'Update')
    try {
      foreach ($e in @($zip.Entries)) {
        if ($e.FullName -notmatch '\.xml$|\.rels$') { continue }
        $r = New-Object IO.StreamReader($e.Open()); $text = $r.ReadToEnd(); $r.Dispose()
        if ($text -notmatch '(?i)noome') { continue }
        $text = $text -replace '(<dc:creator>|<cp:lastModifiedBy>)[^<]*(</)', '$1BestLessons$2' -replace '(?i)chris\.noome|chris noome|noome', 'BestLessons'
        $name = $e.FullName; $e.Delete()
        $n = $zip.CreateEntry($name); $w = New-Object IO.StreamWriter($n.Open(), (New-Object Text.UTF8Encoding($false))); $w.Write($text); $w.Dispose()
      }
    } finally { $zip.Dispose() }
  }
  # A flat OPC string (Document.WordOpenXML) -> a .docx file at $path.
  function FlatToDocx ([string]$flat, [string]$path) {
    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true
    $xml.LoadXml($flat)
    $ns = New-Object System.Xml.XmlNamespaceManager $xml.NameTable
    $ns.AddNamespace('pkg', 'http://schemas.microsoft.com/office/2006/xmlPackage')
    if (Test-Path $path) { Remove-Item $path -Force }
    $fs = [IO.File]::Open($path, 'Create')
    $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
    $types = New-Object System.Text.StringBuilder
    [void]$types.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">')
    foreach ($part in $xml.SelectNodes('//pkg:part', $ns)) {
      $name = $part.GetAttribute('name', 'http://schemas.microsoft.com/office/2006/xmlPackage').TrimStart('/')
      $ct   = $part.GetAttribute('contentType', 'http://schemas.microsoft.com/office/2006/xmlPackage')
      [void]$types.Append(('<Override PartName="/{0}" ContentType="{1}"/>' -f $name, $ct))
      $entry = $zip.CreateEntry($name)
      $s = $entry.Open()
      $data = $part.SelectSingleNode('pkg:xmlData', $ns)
      if ($data) {
        $inner = $data.FirstChild
        while ($inner -and $inner.NodeType -ne [System.Xml.XmlNodeType]::Element) { $inner = $inner.NextSibling }
        $bytes = [Text.Encoding]::UTF8.GetBytes('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "`r`n" + $inner.OuterXml)
      } else {
        $bytes = [Convert]::FromBase64String(($part.SelectSingleNode('pkg:binaryData', $ns).InnerText -replace '\s', ''))
      }
      $s.Write($bytes, 0, $bytes.Length); $s.Dispose()
    }
    [void]$types.Append('</Types>')
    $entry = $zip.CreateEntry('[Content_Types].xml')
    $s = $entry.Open(); $b = [Text.Encoding]::UTF8.GetBytes($types.ToString()); $s.Write($b, 0, $b.Length); $s.Dispose()
    $zip.Dispose(); $fs.Dispose()
  }
  
  function SaveAt ($d, $file, [int]$format = 16) {
    $p = Join-Path $dir $file
    if ($format -eq 16) { FlatToDocx $d.WordOpenXML $p } else { $d.SaveAs2($p, $format) }
    "  saved $file"
  }
  function SaveBoth ($d, $file) {
    SaveAt $d $file | Out-Null
    $copy = Join-Path $env:TEMP $file
    Copy-Item (Join-Path $dir $file) $copy -Force
    Scrub $copy
    try { New-Item -ItemType Directory -Force $cloud | Out-Null; Copy-Item $copy $cloud -Force; "  saved $file, and in the cloud" } catch { "  saved $file - NO CLOUD COPY: $_" }
  }
  function OwnStyles ($d) { foreach ($style in $d.Styles) { try { if ($style.QuickStyle -and -not $style.BuiltIn) { $style.QuickStyle = $false } } catch { } } }
  function Para ($d, $text) { foreach ($p in $d.Paragraphs) { if ($p.Range.Text -like "*$text*") { return $p } }; throw "no paragraph with $text" }
  function Find ($d, $text) { $r = $d.Content; $f = $r.Find; $f.ClearFormatting(); [void]$f.Execute($text, $true); if (-not $f.Found) { throw "no $text" }; return $r }
  function Fill ($t, $row, $values) { for ($c = 0; $c -lt $values.Count; $c++) { $t.Cell($row, $c + 1).Range.Text = $values[$c] } }
  # A building block (a watermark: DRAFT 1) from Word's own Built-In Building Blocks.
  function Block ([string]$name) {
    try { $word.Templates.LoadBuildingBlocks() } catch { }
    foreach ($tpl in $word.Templates) {
      if ($tpl.Name -notlike '*Building Blocks*') { continue }
      $type = $tpl.BuildingBlockTypes.Item(8)                       # wdTypeWatermarks
      for ($c = 1; $c -le $type.Categories.Count; $c++) {
        try { return $type.Categories.Item($c).BuildingBlocks.Item($name) } catch { }
      }
    }
    throw "no building block $name"
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
  $items = @(@('White bread', '18.00', '42'), @('Brown bread', '17.00', '35'), @('Cupcakes', '12.00', '60'), @('Koeksisters', '8.00', '48'))
  $rows = @(@('Item', 'Price (R)', 'Number sold'), @('White bread', '18', '42'), @('Brown bread', '17', '35'), @('Cupcakes', '12', '60'), @('Koeksisters', '8', '48'), @('Rusks', '25', '30'))

  $word = New-Object -ComObject Word.Application
  $xl = New-Object -ComObject Excel.Application
  $start = $null
  try {
    $word.DisplayAlerts = 0
    $xl.DisplayAlerts = $false
    try { $oldLocal = $word.Options.UseLocalUserInfo; $oldUser = $word.UserName; $oldInit = $word.UserInitials
          $word.Options.UseLocalUserInfo = $true; $word.UserName = 'Ms Naidoo'; $word.UserInitials = 'PN' } catch { "  user name: $_" }

    "--- pagelayout"
    $start = $word.Documents.Add()
    $start.Content.Text = ($news -join "`r")
    $start.Content.ParagraphFormat.Alignment = 0
    OwnStyles $start
    $start.PageSetup.PaperSize = 7                                    # A4
    $start.Paragraphs.Item(1).Style = -63                             # Title
    foreach ($i in 3, 5, 7, 9) { $start.Paragraphs.Item($i).Style = -2 }
    SaveBoth $start 'Newsletter.docx'
    foreach ($m in 'TopMargin', 'BottomMargin', 'LeftMargin', 'RightMargin') { $start.PageSetup.$m = $word.CentimetersToPoints(2) }
    $start.Sections.Item(1).Headers.Item(1).Range.Text = 'Phumlani News - Term 3'
    [void]$start.Sections.Item(1).Footers.Item(1).PageNumbers.Add(1, $true)
    $s = (Para $start 'Sport').Range.Start
    $start.Range($s, $s).InsertBreak(7)                               # a page break before Sport
    $s = (Para $start 'Our new library').Range.Start
    $start.Range($s, $s).InsertBreak(3)                               # a continuous section break: the stories in a section of their own
    $cols = $start.Sections.Item(2).PageSetup.TextColumns
    $cols.SetCount(2); $cols.LineBetween = -1
    try { $wm = Block 'DRAFT 1'; $hr = $start.Sections.Item(1).Headers.Item(1).Range; $hr.Collapse(1); [void]$wm.Insert($hr, $true); '  watermark DRAFT 1' } catch { "  NO WATERMARK: $_" }
    SaveAt $start 'Newsletter-done.docx'
    $start.Close(0); $start = $null

    "--- tables"
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
    SaveAt $start 'SaturdaySales-done.docx'
    $start.Close(0); $start = $null

    # illustrations (E-waste project): catword-ewaste-files.ps1, a run of its own.

    "--- proofing"
    $start = $word.Documents.Add()
    $start.Content.Text = (@(
      'My dream job',
      'When I finish school I want to become a software developer. I like solving problems, and I want to recieve a bursary to study at university.',
      'My sister Lerato says the the best developers never stop learning. She is definately right: the tools change every year.',
      'I will practise every day, keep my marks high and finish my projects on time. I beleive nothing will stop me.',
      'Words:') -join "`r")
    OwnStyles $start
    $start.PageSetup.PaperSize = 7
    $start.Paragraphs.Item(1).Style = -63
    SaveBoth $start 'ThaboEssay.docx'
    foreach ($fix in @(@('recieve', 'receive'), @('the the', 'the'), @('definately', 'definitely'), @('beleive', 'believe'))) {
      $r = $start.Content; [void]$r.Find.Execute($fix[0], $true, $false, $false, $false, $false, $true, 0, $false, $fix[1], 2)
    }
    $count = $start.Range($start.Paragraphs.Item(2).Range.Start, $start.Paragraphs.Item(4).Range.End).ComputeStatistics(0)
    "  the essay has $count words (Word's own count)"
    $last = $start.Paragraphs.Item(5).Range
    [void]$last.MoveEnd(1, -1)
    $last.InsertAfter(" $count")
    [void]$start.Comments.Add((Find $start 'software developer'), 'Find out which bursaries there are.')
    SaveAt $start 'ThaboEssay-done.docx'
    Set-Content (Join-Path $dir 'wordcount.txt') "$count"
    $start.Close(0); $start = $null

    "--- integration"
    $wb = $xl.Workbooks.Add()
    $ws = $wb.Worksheets.Item(1)
    $ws.Name = 'Saturday'
    for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt 3; $c++) { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } }
    $ws.Range('A7').Formula = 'Total'
    $ws.Range('C7').Formula = '=SUM(C2:C6)'
    $ws.Range('A1:C1').Font.Bold = $true
    $ws.Range('A7:C7').Font.Bold = $true
    $ws.Range('B2:B6').NumberFormat = '0.00'
    $ws.Columns.Item('A').ColumnWidth = 14; $ws.Columns.Item('B').ColumnWidth = 11; $ws.Columns.Item('C').ColumnWidth = 13
    $wb.SaveAs((Join-Path $dir 'SaturdaySales.xlsx'), 51)
    $copy = Join-Path $env:TEMP 'SaturdaySales.xlsx'; Copy-Item (Join-Path $dir 'SaturdaySales.xlsx') $copy -Force; Scrub $copy
    try { Copy-Item $copy $cloud -Force } catch { "  NO CLOUD COPY: $_" }
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
    $h = $start.Paragraphs.Item(1).Range; [void]$h.MoveEnd(1, -1)
    [void]$start.Hyperlinks.Add($h, 'https://bestlessons.co.za')
    SaveAt $start 'SalesReport-done.docx'
    $start.Close(0); $start = $null
    $wb.Close($false)

    "--- fonts (Specials done): the birthday line highlighted and in small caps"
    $start = $word.Documents.Open((Join-Path $work 'cwin-Specials done.docx'), $false, $false, $false)
    $r = (Para $start 'birthday').Range; [void]$r.MoveEnd(1, -1)
    $r.HighlightColorIndex = 7                                        # wdYellow
    $r.Font.SmallCaps = -1
    SaveAt $start 'Specials done.docx'
    $start.Close(0); $start = $null

    "--- templates (Camp form done): protected for filling in forms"
    $start = $word.Documents.Open((Join-Path $work 'cwin-Camp form done.docx'), $false, $false, $false)
    $start.Protect(2, $true, '')                                      # wdAllowOnlyFormFields, no password
    SaveAt $start 'Camp form done.docx'
    $start.Close(0); $start = $null

    "--- crossrefs (Water report final done): [heading] as a cross-reference to the heading"
    $start = $word.Documents.Open((Join-Path $work 'cwin-Water report final done.docx'), $false, $false, $false)
    $items = $start.GetCrossReferenceItems(1)                         # wdRefTypeHeading
    $idx = 0
    $i = 0; foreach ($it in $items) { $i++; if ("$it" -match 'Recommendations') { $idx = $i } }   # a 1-based array: count, not index
    if (-not $idx) { throw "no Recommendations heading in $($items -join ' | ')" }
    $intro = (Para $start 'meter readings are in').Range
    $f = $intro.Duplicate; [void]$f.Find.Execute('under Recommendations.', $true)
    if (-not $f.Find.Found) { throw 'no "under Recommendations." in the introduction' }
    $w = $start.Range($f.Start + 6, $f.End - 1)                       # the word Recommendations
    $w.Text = ''
    $w.InsertCrossReference(1, -1, $idx, $false)                      # Heading, its text
    $start.Fields.Update() | Out-Null
    "  intro now: $((Para $start 'meter readings are in').Range.Text)"
    SaveAt $start 'Water report final done.docx'
    $start.Close(0); $start = $null

    "done"
  }
  finally {
    if ($start) { try { $start.Saved = $true; $start.Close(0) } catch { } }
    try { $word.Options.UseLocalUserInfo = $oldLocal; $word.UserName = $oldUser; $word.UserInitials = $oldInit } catch { }
    $word.Quit()
    try { foreach ($b in @($xl.Workbooks)) { $b.Saved = $true }; $xl.Quit() } catch { }
  }
}
if (Wait-Job $job -Timeout 780) {
  Receive-Job $job
} else {
  Stop-Job $job
  Receive-Job $job
  Get-Process WINWORD, EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # under the VM lock: only this run's Office is open
  'FAILED: Word hung - not every file was made'
}
Remove-Job $job -Force
Get-ChildItem $dir | ForEach-Object { "  $($_.Name) $($_.Length)" }
