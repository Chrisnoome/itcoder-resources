# Real Word 365 screens for catword lesson 19, 'importing' (content/catword/importing.php,
# Grade 11, 9 October 2026). Mr Botha's price list from other files: Insert > Object >
# Text from File (the Insert File box), Convert Text to Table (commas), Paste Special
# (Ctrl+Alt+V, the box), the Find and Replace box with More, Go To, and Select > Select
# All Text With Similar Formatting. Makes the upload's starter files - Bakery prices.csv
# (real Excel), Price list heading.rtf (real Word, through the clipboard's RTF) and a
# plain .txt - in C:\sims\files\catword-importing\ and G:\My Drive\CAT\Word\, and the
# done-right copy (Price list done.docx).
#     pwsh -File vm-shots.ps1 catword-importing
$Name = 'catword-importing'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')
Add-Type -AssemblyName System.Windows.Forms

$files = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $files | Out-Null
$csv = Join-Path $files 'Bakery prices.csv'
$rtf = Join-Path $files 'Price list heading.rtf'
$txt = Join-Path $files 'Opening times.txt'
$rows = @(@('Item', 'Price', 'Sold last week'), @('White bread', '18.00', '312'), @('Brown bread', '17.00', '205'), @('Choc cake', '45.00', '38'), @('Carrot cake', '45.00', '41'), @('Scones (6)', '30.00', '96'), @('Choc muffin', '12.50', '150'))

# ---- the .csv, by real Excel
$xl = New-Object -ComObject Excel.Application
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1)
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt 3; $c++) { $ws.Cells.Item($r + 1, $c + 1).NumberFormat = '@'; $ws.Cells.Item($r + 1, $c + 1).Value2 = $rows[$r][$c] } }
  if (Test-Path $csv) { Remove-Item $csv -Force }
  $wb.SaveAs($csv, 6)                                                  # xlCSV
  $wb.Close($false)
  '  saved Bakery prices.csv'
} finally { $xl.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl) }
Get-Content $csv | ForEach-Object { "   csv: $_" }
[IO.File]::WriteAllText($txt, "Botha's Bakery is open Monday to Friday from 06:00 to 18:00, and on Saturday from 06:00 to 13:00.`r`n", [Text.Encoding]::UTF8)

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  # ---- the .rtf: a formatted heading and line, made in Word, copied as RTF
  $hd = $word.Documents.Add()
  $hd.Content.Text = "Botha's Bakery - price list`rAll prices include VAT. Prices from 1 November 2027."
  $p1 = $hd.Paragraphs.Item(1).Range
  $p1.Style = -2
  $p1.Font.Color = (0x30 * 65536) + (0x50 * 256) + 0x80                # R80 G50 B30 -> BGR
  $hd.Paragraphs.Item(2).Range.Font.Italic = $true
  $hd.Content.Copy()
  Start-Sleep -Milliseconds 800
  $data = $null
  for ($i = 0; $i -lt 10 -and -not $data; $i++) { try { $data = [Windows.Forms.Clipboard]::GetData('Rich Text Format') } catch { }; if (-not $data) { Start-Sleep -Milliseconds 400 } }
  if ($data) { [IO.File]::WriteAllText($rtf, [string]$data, [Text.Encoding]::ASCII); '  saved Price list heading.rtf (Word''s RTF)' }
  else { '  NO RTF on the clipboard' }
  $hd.Saved = $true; $hd.Close(0)
  foreach ($one in $csv, $rtf, $txt) { try { Copy-Item $one (Join-Path 'G:\My Drive\CAT\Word' (Split-Path $one -Leaf)) -Force } catch { "  not in the cloud: $one" } }

  # ---- 1. Insert > Object > Text from File (the box): the heading .rtf into a new document
  $doc = $word.Documents.Add()
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  $doc.PageSetup.PaperSize = 7
  $word.Visible = $true
  WordWindow
  Fresh
  P 'o-1' $A
  Pct 'insertTab' 'o-1' (Box (Ctl @('Insert') $T::TabItem))
  Tab 'Insert'
  Dump 'insert'
  P 'o-2' $F
  $obj = Ctl @('Object...') $T::SplitButton
  $arrow = $null
  foreach ($e in $obj.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -eq 'More Options') { $arrow = $e } } catch { } }
  if ($arrow) { Pct 'objectArrow' 'o-2' (Box $arrow) } else { $ob = Box $obj; Pct 'objectArrow' 'o-2' @(($ob[0] + 30), $ob[1], 30, $ob[3]) }
  try {
    $menu = Menu $obj
    if ($menu -eq [IntPtr]::Zero -and $arrow) { $menu = Menu $arrow }
    DumpMenu $menu 'objectmenu'
    P 'o-3' $F $h $menu
    $tf = FindAny $menu @('Text from File...', 'Text from File')
    Pct 'textFromFile' 'o-3' (BoxIn $tf $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($tf)
    $dlg = NewWindow $before @('#32770', 'bosa_sdm_msword', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 2500
      $fn = $null
      foreach ($e in $AE::FromHandle($dlg).FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Edit)))) { try { if ($e.Current.Name -match '^File name') { $fn = $e; break } } catch { } }
      if ($fn) { $vp = $null; [void]$fn.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$vp); $vp.SetValue($files); [Shot]::PostKey($dlg, 0x0D); Start-Sleep -Milliseconds 2500 }
      DumpWin $dlg 'insertfile'
      P 'o-4' $null $dlg
      [Shot]::PostKey($dlg, 0x1B); Start-Sleep -Milliseconds 1500
    } else { Esc $menu }
  } catch { "  object menu: $_"; Esc $null }
  Fresh
  $doc.Range(0, 0).InsertFile($rtf, '', $false, $false, $false)
  Start-Sleep -Milliseconds 1000
  $end = $doc.Content; $end.Collapse(0); $end.InsertParagraphAfter()
  $end = $doc.Content; $end.Collapse(0)
  $end.InsertFile($csv, '', $false, $false, $false)
  Start-Sleep -Milliseconds 1000
  foreach ($p in $doc.Paragraphs) { "  [$($p.Style.NameLocal)] $($p.Range.Text.Trim())" }
  $doc.Range(0, 0).Select()
  P 'o-5' $A

  # ---- 2. Convert Text to Table: the csv lines selected, Insert > Table > Convert Text to Table... > Commas
  $first = $null; $last = $null
  foreach ($p in $doc.Paragraphs) { $tx = $p.Range.Text; if ($tx -like 'Item,*') { $first = $p.Range }; if ($tx -like 'Choc muffin*') { $last = $p.Range } }
  $sel = $doc.Range($first.Start, $last.End)
  $sel.Select()
  P 'c-1' $A
  $tb = Ctl @('Table') $T::MenuItem
  Pct 'table' 'c-1' (Box $tb)
  try {
    $menu = Menu $tb
    DumpMenu $menu 'tablemenu'
    P 'c-2' $A $h $menu
    $ct = FindAny $menu @('Convert Text to Table...', 'Convert Text to Table')
    Pct 'convert' 'c-2' (BoxIn $ct $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($ct)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'converttable'; P 'c-3' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  table menu: $_"; Esc $null }
  Fresh
  $sel = $doc.Range($first.Start, $last.End)
  $tbl = $sel.ConvertToTable(',', 7, 3)                                 # separator, rows, columns
  $tbl.Style = 'Table Grid'
  $tbl.Rows.Item(1).Range.Font.Bold = $true
  $doc.Range(0, 0).Select()
  P 'c-4' $A
  "  table: $($doc.Tables.Count) - $($doc.Tables.Item(1).Rows.Count) x $($doc.Tables.Item(1).Columns.Count)"

  # ---- 3. Find and Replace with More: Choc -> Chocolate (Match case, Find whole words only)
  $doc.Range(0, 0).Select()
  Tab 'Home'
  P 'r-1' $A
  try {
    $rp = Ctl @('Replace...', 'Replace')
    $dlg = OpenDialog $rp
    DumpWin $dlg 'replace'
    P 'r-2' $null $dlg
    $script:replaceBox = $dlg
  } catch { "  replace box: $_"; $dlg = [IntPtr]::Zero }
  # More >> : clicked where the picture shows it (bottom left of the box) - tried, then pictured either way
  if ($dlg -ne [IntPtr]::Zero) {
    $wr = [WinRect]::Of($dlg)
    "  replace box size: $($wr[2]) x $($wr[3])"
    ClickPic $dlg 'r-2' 88 259                                          # More >> (read off r-2)
    Start-Sleep -Milliseconds 1200
    Fresh
    P 'r-3' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  }
  Fresh
  $fnd = $doc.Content.Find
  [void]$fnd.Execute('Choc', $true, $true, $false, $false, $false, $true, 0, $false, 'Chocolate', 2)   # MatchCase, WholeWord, ..., ReplaceAll
  $doc.Range(0, 0).Select()
  P 'r-4' $A

  # ---- 4. Editing group: Select > Select All Text With Similar Formatting (the menu), Go To (the box)
  try {
    $sl = Ctl @('Select') $T::MenuItem
    $menu = Menu $sl
    DumpMenu $menu 'selectmenu'
    P 'e-1' $F $h $menu
    Esc $menu
  } catch { "  select menu: $_"; Esc $null }
  Fresh
  try {
    $dlg = ShowWordDialog 896                                            # wdDialogEditGoTo
    DumpWin $dlg 'goto'
    P 'g-1' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  go to: $_" }
  Fresh

  # ---- 5. Paste Special: copy the Excel prices, then Ctrl+Alt+V in Word (the box)
  $xl = New-Object -ComObject Excel.Application
  try {
    $xl.DisplayAlerts = $false
    $wb = $xl.Workbooks.Open($csv)
    $wb.Worksheets.Item(1).Range('A1:C7').Copy() | Out-Null
    Start-Sleep -Milliseconds 800
    $end = $doc.Content; $end.Collapse(0); $end.Select()
    Show $doc.Content
    P 'ps-0' $A
    try {
      $dlg = ShowWordDialog 111                                          # wdDialogEditPasteSpecial
      DumpWin $dlg 'pastespecial'
      P 'p-1' $null $dlg
      [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
    } catch { "  paste special: $_" }
    Fresh
    # Paste link (a linked Excel object) - the result, pictured; then taken out again (the done copy has no link)
    try {
      $end = $doc.Content; $end.Collapse(0); $end.InsertParagraphAfter(); $end = $doc.Content; $end.Collapse(0); $end.Select()
      $word.Selection.PasteSpecial(0, $true, 0, $false, 0)            # IconIndex, Link, Placement (in line), DisplayAsIcon, DataType OLE object
      Start-Sleep -Milliseconds 2500
      try { Show $doc.InlineShapes.Item(1).Range } catch { Show $doc.Content }
      P 'p-2' $A
      "  inline shapes after paste link: $($doc.InlineShapes.Count) fields: $($doc.Fields.Count)"
      foreach ($fl in @($doc.Fields)) { "   field type $($fl.Type) code '$($fl.Code.Text)'" }
      $doc.Undo(2) | Out-Null
      Start-Sleep -Milliseconds 800
    } catch { "  paste link: $_" }
    $wb.Close($false)
  } finally { $xl.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl) }
  Fresh

  # ---- 6. The done-right copy: the heading from the .rtf, the table from the .csv, Choc -> Chocolate
  foreach ($p in $doc.Paragraphs) { $tx = $p.Range.Text.Trim(); if ($tx) { "  [$($p.Style.NameLocal)] $tx" } }
  SaveDoc $doc 'Price list done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
