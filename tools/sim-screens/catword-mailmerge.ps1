# Real Word 365 screens for catword lesson 17, 'mailmerge' (content/catword/mailmerge.php,
# Grade 11, 9 October 2026). Ms Naidoo's letter inviting the Grade 11 parents to a
# parents' evening: Mailings > Start Mail Merge > Letters, Select Recipients > Use an
# Existing List (the Select Data Source box and the Select Table box), Edit Recipient
# List (the Mail Merge Recipients box), Insert Merge Field, Preview Results, Finish &
# Merge > Edit Individual Documents (the Merge to New Document box).
# Makes the upload's starter files - Parents evening letter.docx (real Word) and
# Grade 11 parents.xlsx (real Excel) - in C:\sims\files\catword-mailmerge\ and
# G:\My Drive\CAT\Word\, and the done-right copy (Parents evening letters done.docx:
# the merged letters for class 11A).
#     pwsh -File vm-shots.ps1 catword-mailmerge
$Name = 'catword-mailmerge'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$files = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $files | Out-Null
$xlsx = Join-Path $files 'Grade 11 parents.xlsx'
$rows = @(
  @('Title', 'FirstName', 'LastName', 'Child', 'Class', 'Address', 'Town', 'PostalCode', 'Email', 'Paid'),
  @('Mrs', 'Nomsa', 'Khumalo', 'Sipho', '11A', '14 Mooki Street', 'Orlando East', '1804', 'nomsa.khumalo@example.co.za', 'Yes'),
  @('Mr', 'Pieter', 'Venter', 'Anja', '11A', '7 Kliptown Road', 'Kliptown', '1811', 'pventer@example.co.za', 'No'),
  @('Ms', 'Ayesha', 'Pillay', 'Kiran', '11B', '22 Jasmine Avenue', 'Lenasia', '1827', 'ayesha.pillay@example.co.za', 'Yes'),
  @('Mr', 'Thomas', 'Molefe', 'Kagiso', '11B', '5 Vundla Drive', 'Rockville', '1818', 'tmolefe@example.co.za', 'Yes'),
  @('Mrs', 'Grace', 'Zulu', 'Ayanda', '11A', '31 Ngwenya Street', 'Dube', '1801', 'grace.zulu@example.co.za', 'Yes'),
  @('Mr', 'Sizwe', 'Nkosi', 'Lindiwe', '11B', '9 Masupha Street', 'Meadowlands', '1852', 'snkosi@example.co.za', 'No'),
  @('Ms', 'Refilwe', 'Mahlangu', 'Tumelo', '11A', '18 Khumalo Street', 'Orlando West', '1804', 'refilwe.m@example.co.za', 'No'),
  @('Mrs', 'Fatima', 'Ebrahim', 'Zaid', '11B', '3 Crescent Road', 'Mayfair', '2092', 'fatima.ebrahim@example.co.za', 'Yes')
)

# ---- the data source, made by real Excel
$xl = New-Object -ComObject Excel.Application
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Parents'
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { $ws.Cells.Item($r + 1, $c + 1).NumberFormat = '@'; $ws.Cells.Item($r + 1, $c + 1).Value2 = [string]$rows[$r][$c] } }
  $ws.Rows.Item(1).Font.Bold = $true
  [void]$ws.UsedRange.Columns.AutoFit()
  if (Test-Path $xlsx) { Remove-Item $xlsx -Force }
  $wb.SaveAs($xlsx, 51)
  $wb.Close($false)
  "  saved Grade 11 parents.xlsx"
} finally { $xl.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl) }
try { Copy-Item $xlsx 'G:\My Drive\CAT\Word\Grade 11 parents.xlsx' -Force; '  and in the cloud' } catch { "  NOT in the cloud: $_" }

$lines = @(
  'Phumlani Secondary School',
  '12 Vilakazi Street, Orlando West, Soweto, 1804',
  '[Title] [FirstName] [LastName]',
  '[Address]',
  '[Town]',
  '[PostalCode]',
  '14 October 2027',
  'Dear [Title] [LastName]',
  'Parents'' evening for Grade 11',
  'You are invited to a parents'' evening on Thursday 28 October 2027 at 18:00 in the school hall. You can meet [Child]''s teachers and see the subject choices for Grade 12.',
  'Please reply to Ms Naidoo by 21 October.',
  'Yours sincerely',
  'Ms P. Naidoo',
  'Grade 11 head',
  ''
)
function FindPara ($like) { foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like $like) { return $p.Range } }; throw "no paragraph like $like" }
# A ribbon control clicked with posted mouse messages (for buttons whose menu UI Automation does not open).
function ClickEl ($element) {
  $walker = [System.Windows.Automation.TreeWalker]::RawViewWalker
  $e = $element; $hw = 0
  while ($e -and $hw -eq 0) { try { $hw = $e.Current.NativeWindowHandle } catch { }; if ($hw -eq 0) { $e = $walker.GetParent($e) } }
  $target = [IntPtr][int64]$hw
  $r = $element.Current.BoundingRectangle
  $pt = New-Object K11+PT; $pt.X = [int]($r.X + $r.Width / 2); $pt.Y = [int]($r.Y + $r.Height / 2)
  [void][K11]::ScreenToClient($target, [ref]$pt)
  $before = [Later]::Windows($script:wpid)
  [void][K11]::PostMessage($target, 0x0201, [IntPtr]1, [K11]::Lp($pt.X, $pt.Y)); Start-Sleep -Milliseconds 100
  [void][K11]::PostMessage($target, 0x0202, [IntPtr]0, [K11]::Lp($pt.X, $pt.Y))
  $m = NewWindow $before @() 16
  Start-Sleep -Milliseconds 900
  return $m
}
function Menu ($element) { $m = OpenMenu $element; if ($m -eq [IntPtr]::Zero) { $m = ClickEl $element }; return $m }
# A Word COM call made from another process (it may open a box and wait): fire and forget.
function ComLater ([string]$code) {
  $cmd = "`$w = [Runtime.InteropServices.Marshal]::GetActiveObject('Word.Application'); `$d = `$w.ActiveDocument; $code"
  Start-Process powershell.exe -WindowStyle Hidden -ArgumentList '-NoProfile', '-Command', $cmd
}

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  (Para $doc 1).Font.Bold = $true; (Para $doc 1).Font.Size = 16
  foreach ($i in 3, 4, 5) { (Para $doc $i).ParagraphFormat.SpaceAfter = 0 }
  (Para $doc 9).Font.Bold = $true
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'Parents evening letter.docx' $true

  # ---- 1. Start Mail Merge > Letters
  $doc.Range(0, 0).Select()
  P 's-1' $A
  Pct 'mailingsTab' 's-1' (Box (Ctl @('Mailings') $T::TabItem))
  Tab 'Mailings'
  Dump 'mailings'
  P 's-2' $A
  $smm = Ctl @('Start Mail Merge') $T::MenuItem
  Pct 'startMerge' 's-2' (Box $smm)
  foreach ($k in @(@('selectRecipients', @('Select Recipients'), $T::MenuItem), @('editList', @('Edit Recipient List...'), $null), @('addressBlock', @('Address Block...'), $null), @('greeting', @('Greeting Line...'), $null), @('insertField', @('Insert Merge Field'), $T::SplitButton), @('rules', @('Rules'), $T::MenuItem), @('preview', @('Preview Results'), $T::Button), @('findRecipient', @('Find Recipient...'), $null), @('checkErrors', @('Check for Errors...'), $null), @('finish', @('Finish & Merge'), $T::MenuItem), @('labels', @('Labels...'), $null), @('updateLabels', @('Update Labels'), $null))) {
    try { Pct $k[0] 's-2' (Box (Ctl $k[1] $k[2])) } catch { "  MISSING $($k[0])" }
  }
  $letters = $false
  try {
    $menu = Menu $smm
    "  start menu window: $menu"
    DumpMenu $menu 'startmenu'
    P 's-3' $A $h $menu
    $lt = FindAny $menu @('Letters')
    Pct 'letters' 's-3' (BoxIn $lt $h)
    [Later]::Invoke($lt); Start-Sleep -Milliseconds 1500; $letters = $true
  } catch { "  start mail merge menu: $_"; Esc $null }
  Fresh
  if ($doc.MailMerge.MainDocumentType -ne 0) { '  letters by COM'; $doc.MailMerge.MainDocumentType = 0 }

  # ---- 2. Select Recipients > Use an Existing List... > the file > the Select Table box
  P 'r-1' $A
  $sr = Ctl @('Select Recipients') $T::MenuItem
  Pct 'selectRecipients' 'r-1' (Box $sr)
  try { UseList $xlsx @('r-2', 'r-3', 'r-4') | ForEach-Object { "$_" } } catch { "  use list: $_" }
  Fresh
  Start-Sleep -Milliseconds 2000
  try { "  data source: $($doc.MailMerge.DataSource.Name) records $($doc.MailMerge.DataSource.RecordCount)" } catch { "  no data source yet: $_" }
  if (-not $doc.MailMerge.DataSource.Name) {
    '  data source by COM (another process)'
    ComLater "`$d.MailMerge.OpenDataSource('$xlsx', 0, `$false, `$true, `$true, `$false, '', '', `$false, '', '', 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=$xlsx;Mode=Read;Extended Properties=""HDR=YES;IMEX=1;"";', 'SELECT * FROM ``Parents$``', '', `$false, 1)"
    for ($i = 0; $i -lt 40 -and -not $doc.MailMerge.DataSource.Name; $i++) {
      Start-Sleep -Milliseconds 500
      foreach ($line in [Later]::Windows($script:wpid)) { $parts = $line -split "`t"; if ($parts[1] -in 'bosa_sdm_msword', '#32770') { [Shot]::PostKey([IntPtr][long]$parts[0], 0x0D) } }
    }
    try { "  data source now: $($doc.MailMerge.DataSource.Name) records $($doc.MailMerge.DataSource.RecordCount)" } catch { }
  }
  P 'r-5' $A

  # ---- 3. Edit Recipient List: the Mail Merge Recipients box (a figure), then the filter by COM: class 11A
  try {
    $el = Ctl @('Edit Recipient List...')
    $dlg = OpenDialog $el
    DumpWin $dlg 'recipients'
    P 'e-1' $null $dlg
    [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
  } catch { "  recipients box: $_" }
  Fresh
  try { $doc.MailMerge.DataSource.QueryString = 'SELECT * FROM `Parents$` WHERE `Class` = ''11A'''; "  filtered: $($doc.MailMerge.DataSource.RecordCount) records" } catch { "  filter: $_" }

  # ---- 4. Insert Merge Field: replace each [placeholder] with its field; the simulation is LastName after Dear
  function NextTag ($tag) { $r = $doc.Content; $f = $r.Find; $f.ClearFormatting(); if ($f.Execute("[$tag]")) { return $r } else { return $null } }
  function FieldFor ($tag, $field) { $r = NextTag $tag; if (-not $r) { "  no [$tag]"; return }; $r.Text = ''; [void]$doc.MailMerge.Fields.Add($r, $field) }
  foreach ($tg in 'Title', 'FirstName', 'LastName', 'Address', 'Town', 'PostalCode', 'Title', 'Child') { try { FieldFor $tg $tg } catch { "  field $($tg): $_" } }
  $ph = NextTag 'LastName'
  if ($ph) { $ph.Select() } else { '  no [LastName] left for the simulation' }
  Show $doc.Range(0, 0)
  P 'i-1' $A
  $imf = Ctl @('Insert Merge Field') $T::SplitButton
  $arrow = $null
  foreach ($e in $imf.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -match 'More Options|Insert Merge Field' -and $e.Current.ControlType -eq $T::MenuItem) { $arrow = $e } } catch { } }
  if (-not $arrow) { $arrow = $imf }
  Pct 'insertField' 'i-1' (Box $arrow)
  try {
    $menu = Menu $arrow
    DumpMenu $menu 'fieldmenu'
    P 'i-2' $A $h $menu
    $ln = FindAny $menu @('LastName')
    Pct 'lastName' 'i-2' (BoxIn $ln $h)
    [Later]::Invoke($ln); Start-Sleep -Milliseconds 1500
  } catch { "  field menu: $_"; Esc $null }
  Fresh
  if (NextTag 'LastName') { '  LastName by COM'; FieldFor 'LastName' 'LastName' }
  Show $doc.Range(0, 0)
  $doc.Range(0, 0).Select()
  P 'i-3' $A
  foreach ($p in $doc.Paragraphs) { "  $($p.Range.Text.Trim())" }

  # ---- 5. Preview Results, then Finish & Merge > Edit Individual Documents > All > OK
  P 'p-1' $F
  $pv = Ctl @('Preview Results') $T::Button
  Pct 'preview' 'p-1' (Box $pv)
  $doc.MailMerge.ViewMailMergeFieldCodes = 0
  try { [Later]::Invoke($pv) } catch { }
  Start-Sleep -Milliseconds 1500
  P 'p-2' $F
  foreach ($k in @(@('first', @('First Record')), @('prev', @('Previous Record')), @('next', @('Next Record')), @('last', @('Last Record')), @('finish', @('Finish & Merge')))) {
    try { Pct $k[0] 'p-2' (Box (Ctl $k[1])) } catch { "  MISSING $($k[0])" }
  }
  try {
    $fm = Ctl @('Finish & Merge') $T::MenuItem
    $menu = Menu $fm
    DumpMenu $menu 'finishmenu'
    P 'p-3' $F $h $menu
    $ed = FindAny $menu @('Edit Individual Documents...', 'Edit Individual Documents')
    Pct 'editDocs' 'p-3' (BoxIn $ed $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($ed)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'mergenew'; P 'p-4' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  finish menu: $_"; Esc $null }
  Fresh

  # the merge, by COM: a new document of the letters for 11A
  $doc.MailMerge.Destination = 0                                      # wdSendToNewDocument
  $doc.MailMerge.SuppressBlankLines = $true
  $doc.MailMerge.DataSource.FirstRecord = 1
  $doc.MailMerge.DataSource.LastRecord = -16                          # wdDefaultLastRecord
  $doc.MailMerge.Execute($false)
  Start-Sleep -Milliseconds 3000
  $merged = $word.ActiveDocument
  "  merged: $($merged.Name) sections $($merged.Sections.Count)"
  WordWindow
  Fresh
  $merged.Range(0, 0).Select()
  P 'p-5' $A
  foreach ($p in $merged.Paragraphs) { $t = $p.Range.Text.Trim(); if ($t -like 'Dear*') { "  $t" } }
  SaveDoc $merged 'Parents evening letters done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
