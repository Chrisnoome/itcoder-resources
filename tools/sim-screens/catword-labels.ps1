# Real Word 365 screens for catword lesson 18, 'labels' (content/catword/labels.php,
# Grade 11, 9 October 2026). Address labels for the Grade 11 parents: Start Mail
# Merge > Labels (the Label Options box), the fields in the first label, Update
# Labels, Check for Errors, Rules > If...Then...Else (the Insert Word Field: IF box),
# Send Email Messages (the Merge to E-mail box), and a Word table as the data source.
# Uses work\Grade 11 parents.xlsx (made by catword-mailmerge.ps1 in real Excel).
# Makes the starter file Grade 11 parents table.docx (the same list as a Word table,
# for the CAPS part) in C:\sims\files\catword-labels\ and G:\My Drive\CAT\Word\, and
# the done-right copy (Parent labels done.docx: the merged labels).
#     pwsh -File vm-shots.ps1 catword-labels
$Name = 'catword-labels'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$files = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $files | Out-Null
$xlsx = Join-Path $files 'Grade 11 parents.xlsx'
$src = Join-Path $PSScriptRoot 'work\Grade 11 parents.xlsx'
if (-not (Test-Path $src)) { $src = 'G:\My Drive\CAT\Word\Grade 11 parents.xlsx' }
Copy-Item $src $xlsx -Force

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0

  # ---- 0. The same list as a Word table (CAPS: a Word table as the data source)
  $xl = New-Object -ComObject Excel.Application
  $data = @()
  try {
    $wb = $xl.Workbooks.Open($xlsx, 0, $true)
    $ws = $wb.Worksheets.Item(1)
    $ur = $ws.UsedRange
    for ($r = 1; $r -le $ur.Rows.Count; $r++) { $row = @(); for ($c = 1; $c -le 8; $c++) { $row += [string]$ws.Cells.Item($r, $c).Text }; $data += ,$row }
    $wb.Close($false)
  } finally { $xl.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl) }
  "  rows read: $($data.Count)"
  $td = $word.Documents.Add()
  $td.PageSetup.PaperSize = 7
  $td.PageSetup.Orientation = 1
  $tt = $td.Tables.Add($td.Range(0, 0), $data.Count, 8)
  for ($r = 0; $r -lt $data.Count; $r++) { for ($c = 0; $c -lt 8; $c++) { $tt.Cell($r + 1, $c + 1).Range.Text = $data[$r][$c] } }
  $tt.Style = 'Table Grid'
  $tt.Rows.Item(1).Range.Font.Bold = $true
  SaveDoc $td 'Grade 11 parents table.docx' $true
  $word.Visible = $true
  $h = [IntPtr]$word.ActiveWindow.Hwnd
  WordWindow
  Fresh
  $td.Range(0, 0).Select()
  P 'wt-1' $A
  $td.Saved = $true; $td.Close(0)

  # ---- 1. Labels: a new document, Start Mail Merge > Labels, the Label Options box
  $doc = $word.Documents.Add()
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  WordWindow
  Fresh
  Tab 'Mailings'
  Dump 'mailings'
  P 'l-1' $A
  $smm = Ctl @('Start Mail Merge') $T::MenuItem
  Pct 'startMerge' 'l-1' (Box $smm)
  try {
    $menu = Menu $smm
    P 'l-2' $A $h $menu
    $lb = FindAny $menu @('Labels...', 'Labels')
    Pct 'labels' 'l-2' (BoxIn $lb $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($lb)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1500
      DumpWin $dlg 'labeloptions'
      P 'l-3' $null $dlg
      [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
    } else { '  NO Label Options box'; Esc $menu }
  } catch { "  labels menu: $_"; Esc $null }
  Fresh
  # the labels by COM: Avery A4/A5 L7160 (21 a sheet, 3 x 7)
  $made = $false
  foreach ($nm in 'L7160', 'Avery A4/A5 L7160', 'L7160 Address') {
    try { $null = $word.MailingLabel.CreateNewDocument($nm); $made = $true; "  label document by name '$nm'"; break } catch { "  label name '$nm' refused: $($_.Exception.Message)" }
  }
  if (-not $made) { foreach ($cl in $word.MailingLabel.CustomLabels) { } ; try { "  label names: " + (@($word.MailingLabel.CustomLabels | ForEach-Object { $_.Name }) -join ', ') } catch { } }
  if ($made) { $doc.Saved = $true; $doc.Close(0); $doc = $word.ActiveDocument }
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  $doc.MailMerge.MainDocumentType = 1                                   # wdMailingLabels
  WordWindow
  Fresh
  $word.ActiveWindow.View.TableGridlines = $true
  "  tables: $($doc.Tables.Count) rows $($doc.Tables.Item(1).Rows.Count) cols $($doc.Tables.Item(1).Columns.Count)"

  # ---- 2. The list (Use an Existing List), then the fields in the first label
  Tab 'Mailings'
  $joined = $false
  try { $joined = UseList $xlsx @($null, $null, $null) } catch { "  use list: $_" }
  Fresh
  try { "  data source: $($doc.MailMerge.DataSource.Name) records $($doc.MailMerge.DataSource.RecordCount)" } catch { }
  if (-not $doc.MailMerge.DataSource.Name) {
    '  data source by COM (another process)'
    ComLater "`$d.MailMerge.OpenDataSource('$xlsx', 0, `$false, `$true, `$true, `$false, '', '', `$false, '', '', 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=$xlsx;Mode=Read;Extended Properties=""HDR=YES;IMEX=1;"";', 'SELECT * FROM ``Parents$``', '', `$false, 1)"
    for ($i = 0; $i -lt 40 -and -not $doc.MailMerge.DataSource.Name; $i++) {
      Start-Sleep -Milliseconds 500
      foreach ($line in [Later]::Windows($script:wpid)) { $parts = $line -split "`t"; if ($parts[1] -in 'bosa_sdm_msword', '#32770') { [Shot]::PostKey([IntPtr][long]$parts[0], 0x0D) } }
    }
    try { "  data source now: $($doc.MailMerge.DataSource.Name) records $($doc.MailMerge.DataSource.RecordCount)" } catch { }
  }

  $first = $doc.Tables.Item(1).Cell(1, 1).Range
  $doc.Range($first.Start, $first.Start).InsertAfter("[Title] [FirstName] [LastName]`r[Address]`r[Town] [PostalCode]")
  foreach ($tag in 'Title', 'FirstName', 'LastName', 'Address', 'Town', 'PostalCode') {
    $r = $doc.Tables.Item(1).Cell(1, 1).Range
    $fd = $r.Find; $fd.ClearFormatting()
    if (-not $fd.Execute("[$tag]")) { "  no [$tag]"; continue }
    $r.Text = ''
    try { [void]$doc.MailMerge.Fields.Add($r, $tag) } catch { "  field $($tag): $_" }
  }
  $first = $doc.Tables.Item(1).Cell(1, 1).Range
  "  first label: $($first.Text)"
  $doc.Range($first.Start, $first.Start).Select()
  $word.ActiveWindow.ScrollIntoView($doc.Range(0, 0), $true)
  P 'u-1' $A
  $ul = Ctl @('Update Labels')
  Pct 'updateLabels' 'u-1' (Box $ul)
  try { Press $ul } catch { [void](ClickEl $ul) }
  Start-Sleep -Milliseconds 2000
  P 'u-2' $A
  "  cell 2: $($doc.Tables.Item(1).Cell(1, 3).Range.Text)"

  # ---- 3. Check for Errors (the box), Rules > If...Then...Else (the box), Send Email Messages (the box)
  try {
    $ce = Ctl @('Check for Errors...')
    $dlg = OpenDialog $ce
    DumpWin $dlg 'checkerrors'
    P 'ce-1' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  check for errors: $_" }
  Fresh
  try {
    $ru = Ctl @('Rules') $T::MenuItem
    P 'ru-1' $A
    Pct 'rules' 'ru-1' (Box $ru)
    $menu = Menu $ru
    DumpMenu $menu 'rulesmenu'
    P 'ru-2' $A $h $menu
    $ite = FindAny $menu @('If...Then...Else...', 'If...Then...Else')
    Pct 'ifThen' 'ru-2' (BoxIn $ite $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($ite)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'ifbox'; P 'ru-3' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  rules: $_"; Esc $null }
  Fresh
  try {
    $fm = Ctl @('Finish & Merge') $T::MenuItem
    $menu = Menu $fm
    DumpMenu $menu 'finishmenu'
    P 'em-0' $F $h $menu
    $se = FindAny $menu @('Send Email Messages...', 'Send E-mail Messages...', 'Send Email Messages')
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($se)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'mergeemail'; P 'em-1' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  e-mail: $_"; Esc $null }
  Fresh

  # ---- 4. Preview, then the merge to a new document: the done-right copy
  try { $doc.MailMerge.ViewMailMergeFieldCodes = 0 } catch { }
  try { Press (Ctl @('Preview Results') $T::Button) } catch { }
  Start-Sleep -Milliseconds 1500
  P 'pv-1' $A
  $doc.MailMerge.Destination = 0
  $doc.MailMerge.SuppressBlankLines = $true
  $doc.MailMerge.Execute($false)
  Start-Sleep -Milliseconds 3000
  $merged = $word.ActiveDocument
  WordWindow
  Fresh
  $word.ActiveWindow.View.TableGridlines = $true
  $merged.Range(0, 0).Select()
  P 'pv-2' $A
  "  merged: tables $($merged.Tables.Count) rows $($merged.Tables.Item(1).Rows.Count) cols $($merged.Tables.Item(1).Columns.Count)"
  SaveDoc $merged 'Parent labels done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
