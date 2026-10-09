# Real Word 365 screens for catword Grade 12 lesson 'linking' (content/catword/
# linking.php, 9 October 2026). Mr Botha's quarterly report in Word and his
# sales workbook in Excel: the Paste menu and the Paste Special box (Paste /
# Paste link), Insert > Object (Create from File, Link to file, Display as
# icon), the right-click menu of a linked table (Update Link), and the result
# of a linked and an embedded table. Also makes the upload's starter files
# (Botha report.docx, Botha sales.xlsx) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-linking
$Name = 'catword-linking'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$files = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $files | Out-Null
$book = Join-Path $files 'Botha sales.xlsx'
$report = @(
  'Botha''s Bakery - first quarter 2026',
  'Sales this quarter',
  'The table below shows the sales of each kind of item, in rand.',
  '',
  'What the numbers say',
  'Bread is still the biggest seller. March was the best month, because of the Easter orders.',
  'Prepared by Mr J. Botha'
)

Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force
$xl = New-Object -ComObject Excel.Application
$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  LocalUser
  $xl.DisplayAlerts = $false
  # ---- The workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Sales'
  $data = @(@('Item', 'January', 'February', 'March', 'Total'), @('Bread', '4500', '4200', '4800'), @('Rolls', '1800', '1650', '1900'), @('Cakes', '2400', '2900', '3100'), @('Pies', '3200', '3000', '3350'))
  for ($r = 0; $r -lt 5; $r++) { for ($c = 0; $c -lt $data[$r].Count; $c++) { $ws.Cells.Item($r + 1, $c + 1).Formula = [string]$data[$r][$c] } }
  for ($r = 2; $r -le 5; $r++) { $ws.Range("E$r").Formula = "=SUM(B${r}:D${r})" }
  $ws.Range('A6').Formula = 'Total'
  foreach ($col in 'B', 'C', 'D', 'E') { $ws.Range("${col}6").Formula = "=SUM(${col}2:${col}5)" }
  $ws.Range('B2:E6').NumberFormat = '0'
  $ws.Range('A1:E1').Font.Bold = $true; $ws.Range('A6:E6').Font.Bold = $true
  $ws.Columns.Item('A:E').AutoFit() | Out-Null
  if (Test-Path $book) { Remove-Item $book -Force }
  $wb.SaveAs($book, 51)
  "  workbook saved"
  try { Copy-Item $book 'G:\My Drive\CAT\Word\Botha sales.xlsx' -Force } catch { "  xlsx NOT in the cloud: $_" }

  # ---- The report (the starter)
  $doc = NewDoc $report
  $doc.PageSetup.PaperSize = 7
  (Para $doc 1).Style = -63
  (Para $doc 2).Style = -2; (Para $doc 5).Style = -2
  SaveDoc12 $doc 'Botha report.docx' $true
  $word.Visible = $true
  WordWindow

  # ---- 1. Paste Special > Paste link (simulation: the Paste arrow, Paste Special, Paste link, Formatted Text (RTF), OK)
  $ws.Range('A1:E6').Copy() | Out-Null
  Start-Sleep -Milliseconds 800
  $at = Para $doc 4
  $doc.Range($at.Start, $at.Start).Select()
  Tab 'Home'
  Dump 'home'
  Pic 'p-1' $F
  TryPct 'pasteArrow' 'p-1' { Box (Ctl @('Paste') $T::MenuItem) }
  TryPct 'pasteButton' 'p-1' { Box (Ctl @('Paste') $T::Button) }
  $menu = MenuPic @('Paste') $T::MenuItem 'p-2' $F
  if ($menu -ne [IntPtr]::Zero) {
    TryPct 'pasteSpecial' 'p-2' { BoxIn (FindAny $menu @('Paste Special...', 'Paste Special')) $h }
    try {
      $before = [Later]::Windows($script:wpid)
      [Later]::Invoke((FindAny $menu @('Paste Special...', 'Paste Special')))
      $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
      if ($dlg -ne [IntPtr]::Zero) {
        Start-Sleep -Milliseconds 1500
        Pic 'p-3' $null $dlg
        DumpWin $dlg 'pastebox'
        try { $rb = FindIn $dlg @('Paste link:', 'Paste link'); Press $rb; Start-Sleep -Milliseconds 900 } catch { "  no Paste link control: $_"; [C12]::Alt($dlg, 0x4C) }
        Pic 'p-4' $null $dlg
        DumpWin $dlg 'pastebox2'
        try { $it = FindIn $dlg @('Formatted Text (RTF)'); $sp = $null; if ($it.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern, [ref]$sp)) { $sp.Select() }; Start-Sleep -Milliseconds 900 } catch { "  no RTF item: $_" }
        Pic 'p-5' $null $dlg
        CloseDialog $dlg; CloseAll
      }
    } catch { "  paste special box: $_"; CloseAll }
  }
  EscMenu $menu
  $ws.Range('A1:E6').Copy() | Out-Null
  Start-Sleep -Milliseconds 600
  $at = Para $doc 4
  $doc.Range($at.Start, $at.Start).Select()
  $word.Selection.PasteSpecial(0, $true, 0, $false, 1)                 # Link, Formatted Text (RTF)
  Start-Sleep -Milliseconds 2000
  "  fields: $($doc.Fields.Count)  tables: $($doc.Tables.Count)"
  $doc.Range(0, 0).Select()
  Pic 'p-6' $F

  # ---- 2. Change Excel, update the link (right-click > Update Link; F9)
  $ws.Range('D2').Formula = '5200'
  $wb.Save()
  Start-Sleep -Milliseconds 800
  $tbl = $doc.Tables.Item(1)
  $cellBox = TextBox ($tbl.Cell(2, 4).Range)
  Pic 'u-1' $F
  TryPct 'marchBread' 'u-1' { $cellBox }
  $tbl.Cell(2, 4).Range.Select()
  try {
    $m = RightClick12 ($cellBox[0] + 10) ($cellBox[1] + 8)
    if ($m -ne [IntPtr]::Zero) { DumpMenu $m 'rightmenu'; Pic 'u-2' $F $h $m; TryPct 'updateLink' 'u-2' { BoxIn (FindAny $m @('Update Link', 'Update Field')) $h }; EscMenu $m }
  } catch { "  right-click: $_"; EscMenu ([IntPtr]::Zero) }
  [void]$doc.Fields.Update()
  Start-Sleep -Milliseconds 1500
  $doc.Range(0, 0).Select()
  Pic 'u-3' $F
  "  after update: $($doc.Tables.Item(1).Range.Text -replace "[`r`a]", ' | ')"
  SaveDoc12 $doc 'Botha report done.docx' $false

  # ---- 3. Insert > Object > Create from File (simulation: Object, Create from File, Link to file, Display as icon, OK)
  $last = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  $doc.Range($last.Start, $last.Start).Select()
  Tab 'Insert'
  Dump 'insert'
  Pic 'o-1' $F
  TryPct 'object' 'o-1' { Box (Ctl @('Object') $T::MenuItem) }
  TryPct 'objectBtn' 'o-1' { Box (Ctl @('Object...', 'Object') $T::Button) }
  try {
    $menu = MenuPic @('Object') $T::MenuItem 'o-2' $F
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke((FindAny $menu @('Object...')))
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1500
      Pic 'o-3' $null $dlg
      DumpWin $dlg 'objectbox'
      try { $tb = FindIn $dlg @('Create from File'); Press $tb; Start-Sleep -Milliseconds 1200 } catch { "  no Create from File tab: $_" }
      Pic 'o-4' $null $dlg
      DumpWin $dlg 'objectbox2'
      try { $e = FindIn $dlg @('File name:', 'File name'); $vp = $null; if ($e.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$vp)) { $vp.SetValue($book) } } catch { "  no file name box: $_" }
      try { Press (FindIn $dlg @('Link to file')); Start-Sleep -Milliseconds 600 } catch { "  no Link to file: $_" }
      try { Press (FindIn $dlg @('Display as icon')); Start-Sleep -Milliseconds 900 } catch { "  no Display as icon: $_" }
      Pic 'o-5' $null $dlg
      CloseDialog $dlg; CloseAll
    }
  } catch { "  object box: $_"; CloseAll }
  EscMenu ([IntPtr]::Zero)
  try {
    $doc.Range($last.Start, $last.Start).Select()
    [void]$doc.InlineShapes.AddOLEObject('Excel.Sheet.12', $book, $true, $true)
    Start-Sleep -Milliseconds 2000
    Show $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
    Pic 'o-6' $F
  } catch { "  icon object: $_" }

  # ---- 4. An embedded table (figure): Paste Special > Microsoft Excel Worksheet Object, not linked; double-click opens Excel inside Word
  try {
    $ws.Range('A1:E6').Copy() | Out-Null; Start-Sleep -Milliseconds 600
    $doc.Range($last.Start, $last.Start).Select()
    $word.Selection.PasteSpecial(0, $false, 0, $false, 0)             # embedded OLE object
    Start-Sleep -Milliseconds 1500
    Show $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
    Pic 'e-1' $F
  } catch { "  embedded: $_" }
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  RestoreUser
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
  try { foreach ($b in @($xl.Workbooks)) { $b.Saved = $true; $b.Close($false) }; $xl.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  # the cloud and the files keep the starter workbook: put March bread back to 4800
  try {
    $x2 = New-Object -ComObject Excel.Application; $x2.DisplayAlerts = $false
    $b2 = $x2.Workbooks.Open($book); $b2.Worksheets.Item(1).Range('D2').Formula = '4800'; $b2.Save(); $b2.Close($false); $x2.Quit()
    Copy-Item $book 'G:\My Drive\CAT\Word\Botha sales.xlsx' -Force
    '  workbook put back (March bread 4800)'
  } catch { "  workbook put back: $_" }
}
