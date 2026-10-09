# Real Word 365 screens for catword Grade 12 lesson 'mergesources' (content/catword/
# mergesources.php, 9 October 2026). Ms Naidoo's matric farewell letters, merged
# from different sources: the Mailings tab, Select Recipients (its menu, and
# Use an Existing List's Select Data Source box), Edit Recipient List (the Mail
# Merge Recipients box, Filter and Sort), Insert Merge Field, Preview Results,
# Finish & Merge > Edit Individual Documents and Send Email Messages. The data
# source for the screens is a Word table (Farewell guests table.docx). Also
# makes the upload's starter files (Farewell invitation.docx and Farewell
# guests.csv) and the done-right merged letters.
#     pwsh -File vm-shots.ps1 catword-mergesources
$Name = 'catword-mergesources'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$guests = @(
  @('FirstName', 'Surname', 'Class', 'Paid', 'Email'),
  @('Ayanda', 'Zulu', '12A', 'Yes', 'ayanda.zulu@bestlessons.co.za'),
  @('Sipho', 'Mthembu', '12A', 'No', 'sipho.mthembu@bestlessons.co.za'),
  @('Lindiwe', 'Khoza', '12B', 'Yes', 'lindiwe.khoza@bestlessons.co.za'),
  @('Kagiso', 'Molefe', '12B', 'No', 'kagiso.molefe@bestlessons.co.za'),
  @('Thabo', 'Mokoena', '12C', 'Yes', 'thabo.mokoena@bestlessons.co.za'),
  @('Naledi', 'Dube', '12C', 'Yes', 'naledi.dube@bestlessons.co.za'),
  @('Pieter', 'van Wyk', '12A', 'Yes', 'pieter.vanwyk@bestlessons.co.za'),
  @('Zanele', 'Nkosi', '12B', 'No', 'zanele.nkosi@bestlessons.co.za')
)
$letter = @(
  'Matric Farewell 2026',
  'Dear [first name]',
  'You and your guest are invited to the Grade 12 matric farewell on Friday 13 November 2026 in the school hall, from 18:00 to 23:00.',
  'Your ticket for class [class] is paid. Please bring this letter to the door.',
  'Kind regards',
  'Ms P. Naidoo, Grade 12 teacher'
)
$files = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $files | Out-Null

$word = New-Object -ComObject Word.Application
$doc = $null
try {
  $word.DisplayAlerts = 0
  LocalUser
  # The CSV for pupils (plain ASCII text, a comma between fields)
  $csv = Join-Path $files 'Farewell guests.csv'
  ($guests | ForEach-Object { $_ -join ',' }) | Set-Content $csv -Encoding ASCII
  try { Copy-Item $csv 'G:\My Drive\CAT\Word\Farewell guests.csv' -Force; '  csv in the cloud' } catch { "  csv NOT in the cloud: $_" }
  # The Word-table source for the screens
  $tab = $word.Documents.Add()
  $t = $tab.Tables.Add($tab.Range(0, 0), $guests.Count, 5)
  for ($r = 0; $r -lt $guests.Count; $r++) { for ($c = 0; $c -lt 5; $c++) { $t.Cell($r + 1, $c + 1).Range.Text = $guests[$r][$c] } }
  SaveDoc12 $tab 'Farewell guests table.docx' $false
  $tab.Saved = $true; $tab.Close(0)
  $source = Join-Path $files 'Farewell guests table.docx'

  # The main document (the starter: not yet connected)
  $doc = NewDoc $letter
  $doc.PageSetup.PaperSize = 7
  (Para $doc 1).Style = -63
  SaveDoc12 $doc 'Farewell invitation.docx' $true
  $word.Visible = $true
  WordWindow

  # ---- 1. Select Recipients > Use an Existing List (simulation: Mailings tab, Select Recipients, Use an Existing List)
  $doc.MailMerge.MainDocumentType = 0                                 # wdFormLetters
  $doc.Range(0, 0).Select()
  Pic 's-1' $F
  TryPct 'mailingsTab' 's-1' { Box (Ctl @('Mailings') $T::TabItem) }
  Tab 'Mailings'
  Dump 'mailings'
  Pic 's-2' $F
  foreach ($k in @(@('startMerge', @('Start Mail Merge')), @('selectRecipients', @('Select Recipients')), @('editList', @('Edit Recipient List...', 'Edit Recipient List')), @('insertField', @('Insert Merge Field')),
                   @('rules', @('Rules')), @('preview', @('Preview Results')), @('finish', @('Finish & Merge')), @('highlight', @('Highlight Merge Fields')))) {
    TryPct $k[0] 's-2' { Box (Ctl $k[1]) }
  }
  $menu = MenuPic @('Select Recipients') $null 's-3' $F
  if ($menu -ne [IntPtr]::Zero) {
    TryPct 'existing' 's-3' { BoxIn (FindAny $menu @('Use an Existing List...', 'Use an Existing List')) $h }
    TryPct 'outlook' 's-3' { BoxIn (FindAny $menu @('Choose from Outlook Contacts...', 'Choose from Outlook Contacts')) $h }
    TryPct 'newList' 's-3' { BoxIn (FindAny $menu @('Type a New List...', 'Type a New List')) $h }
    try {
      $before = [Later]::Windows($script:wpid)
      [Later]::Invoke((FindAny $menu @('Use an Existing List...', 'Use an Existing List')))
      $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
      if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 2500; Pic 's-4' $null $dlg; DumpWin $dlg 'sourcebox'; CloseDialog $dlg; CloseAll }
    } catch { "  existing list: $_"; CloseAll }
  }
  EscMenu $menu

  # ---- 2. Connected; Edit Recipient List and Filter (simulation: Edit Recipient List, Filter, the Paid row, OK)
  $doc.MailMerge.OpenDataSource($source)
  "  source: $($doc.MailMerge.DataSource.Name)  records: $($doc.MailMerge.DataSource.RecordCount)"
  Start-Sleep -Milliseconds 1500
  Pic 'f-1' $F
  TryPct 'editList' 'f-1' { Box (Ctl @('Edit Recipient List...', 'Edit Recipient List')) }
  try {
    $dlg = OpenDialog (Ctl @('Edit Recipient List...', 'Edit Recipient List'))
    Start-Sleep -Milliseconds 1500
    Pic 'f-2' $null $dlg
    DumpWin $dlg 'recipients'
    $flt = $null
    try { $flt = FindIn $dlg @('Filter...', 'Filter') } catch { "  no Filter control: $_" }
    $before = [Later]::Windows($script:wpid)
    if ($flt) { [Later]::Invoke($flt) } else { [C12]::Alt($dlg, 0x46) }
    $fsb = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 30
    if ($fsb -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1500
      Pic 'f-3' $null $fsb
      DumpWin $fsb 'filterbox'
      [C12]::Chars($fsb, 'P'); Start-Sleep -Milliseconds 900          # Field: Paid
      [Shot]::PostKey($fsb, 0x09); Start-Sleep -Milliseconds 400        # Comparison: Equal to
      [Shot]::PostKey($fsb, 0x09); Start-Sleep -Milliseconds 400        # Compare to
      [C12]::Chars($fsb, 'Yes'); Start-Sleep -Milliseconds 900
      Pic 'f-4' $null $fsb
      # a second row: Or Class Equal to 12C (a picture for the OR rule)
      [Shot]::PostKey($fsb, 0x09); Start-Sleep -Milliseconds 400
      [C12]::Chars($fsb, 'O'); Start-Sleep -Milliseconds 600
      [Shot]::PostKey($fsb, 0x09); Start-Sleep -Milliseconds 400
      [C12]::Chars($fsb, 'C'); Start-Sleep -Milliseconds 600
      [Shot]::PostKey($fsb, 0x09); Start-Sleep -Milliseconds 400
      [Shot]::PostKey($fsb, 0x09); Start-Sleep -Milliseconds 400
      [C12]::Chars($fsb, '12C'); Start-Sleep -Milliseconds 900
      Pic 'f-5' $null $fsb
      CloseDialog $fsb
    }
    Start-Sleep -Milliseconds 800
    CloseDialog $dlg; CloseAll
  } catch { "  recipients box: $_"; CloseAll }
  # Leave out the four who have not paid
  $ds = $doc.MailMerge.DataSource
  for ($i = 1; $i -le $ds.RecordCount; $i++) { $ds.ActiveRecord = $i; if ($ds.DataFields.Item('Paid').Value -ne 'Yes') { $ds.Included = $false } }
  try {
    $dlg = OpenDialog (Ctl @('Edit Recipient List...', 'Edit Recipient List'))
    Start-Sleep -Milliseconds 1500; Pic 'f-6' $null $dlg; CloseDialog $dlg; CloseAll
  } catch { "  recipients box 2: $_"; CloseAll }

  # ---- 3. Insert Merge Field (simulation: replace [first name]: Insert Merge Field, FirstName)
  $r = Words12 $doc '[first name]'; $r.Select()
  Show $r
  Pic 'i-1' $F
  TryPct 'firstName' 'i-1' { TextBox $r }
  TryPct 'insertField' 'i-1' { Box (Ctl @('Insert Merge Field')) }
  $menu = MenuPic @('Insert Merge Field') $null 'i-2' $F
  $done = $false
  if ($menu -ne [IntPtr]::Zero) {
    TryPct 'fieldFirst' 'i-2' { BoxIn (FindAny $menu @('FirstName')) $h }
    try { [Later]::Invoke((FindAny $menu @('FirstName'))); Start-Sleep -Milliseconds 1500; $done = $true } catch { "  field item: $_"; EscMenu $menu }
  }
  if (-not $done -or ($doc.MailMerge.Fields.Count -lt 1)) { '  field by COM'; $r = Words12 $doc '[first name]'; [void]$doc.MailMerge.Fields.Add($r, 'FirstName') }
  $r = Words12 $doc '[class]'; [void]$doc.MailMerge.Fields.Add($r, 'Class')
  $word.ActiveWindow.View.ShowFieldCodes = $false
  $doc.Range(0, 0).Select()
  Pic 'i-3' $F

  # ---- 4. Preview Results (a figure), then Finish & Merge > Edit Individual Documents (simulation)
  try { Press (Ctl @('Preview Results')); Start-Sleep -Milliseconds 1500; Pic 'p-1' $F; Dump 'preview'; Press (Ctl @('Preview Results')); Start-Sleep -Milliseconds 1200 } catch { "  preview: $_" }
  Pic 'm-1' $F
  TryPct 'finish' 'm-1' { Box (Ctl @('Finish & Merge')) }
  $menu = MenuPic @('Finish & Merge') $null 'm-2' $F
  if ($menu -ne [IntPtr]::Zero) {
    TryPct 'editDocs' 'm-2' { BoxIn (FindAny $menu @('Edit Individual Documents...', 'Edit Individual Documents')) $h }
    TryPct 'email' 'm-2' { BoxIn (FindAny $menu @('Send Email Messages...', 'Send Email Messages')) $h }
    try {
      $before = [Later]::Windows($script:wpid)
      [Later]::Invoke((FindAny $menu @('Edit Individual Documents...', 'Edit Individual Documents')))
      $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
      if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; Pic 'm-3' $null $dlg; DumpWin $dlg 'mergebox'; CloseDialog $dlg; CloseAll }
    } catch { "  merge box: $_"; CloseAll }
  }
  EscMenu $menu
  # Send Email Messages (a figure: the Merge to E-mail box)
  $menu = @(OpenMenu (Ctl @('Finish & Merge')))[-1]
  try {
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke((FindAny $menu @('Send Email Messages...', 'Send Email Messages')))
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 30
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; Pic 'e-1' $null $dlg; DumpWin $dlg 'emailbox'; CloseDialog $dlg; CloseAll } else { '  no e-mail box' }
  } catch { "  e-mail box: $_"; CloseAll }
  EscMenu $menu

  # ---- 5. The merge itself: a new document of letters (the done-right copy)
  # NOTE (9 October 2026): the Included = False loop above did not take (RecordCount -1 for a Word-table source), so
  # all eight letters were merged; the three unpaid letters were then cut from the saved copy's document.xml on the host
  # (whole sections, the last letter's section mark moved) - tests/uploads/catword/Farewell letters done.docx.
  $doc.MailMerge.Destination = 0                                         # wdSendToNewDocument
  $doc.MailMerge.SuppressBlankLines = $true
  $doc.MailMerge.Execute($false)
  Start-Sleep -Milliseconds 2500
  $letters = $word.ActiveDocument
  "  merged: $($letters.Name)  sections: $($letters.Sections.Count)"
  $script:h = [IntPtr]$word.ActiveWindow.Hwnd; WordWindow
  $letters.Range(0, 0).Select()
  Pic 'm-4' $F
  foreach ($p in $letters.Paragraphs) { $x = $p.Range.Text.Trim(); if ($x -like 'Dear*' -or $x -like 'Your ticket*') { "  | $x" } }
  SaveDoc12 $letters 'Farewell letters done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  RestoreUser
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
