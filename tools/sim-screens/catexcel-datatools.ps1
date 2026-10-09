# Real Excel 365 screens for catexcel Grade 12, Data validation and data
# tools (AIPascalCourse/content/catexcel/datatools.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Phumlani Secondary's
# sports day entries: Data > Data Tools > Data Validation (a list from the
# Events sheet; a whole number from 8 to 12 for the grade), the drop-down
# arrow, Circle Invalid Data; and (IEB) Remove Duplicates, Text to Columns,
# Protect Sheet, Allow Edit Ranges and Record Macro. The window is 1860 wide
# so the Data tab's Data Tools group shows its names. The Data Validation box
# is an old-style dialog: keys and characters are posted to that one window
# (Allow: List, then the Source); if it takes none, the rule is set through
# COM and the box opened again to be pictured. Also makes the pupils'
# starter file SportsDay.xlsx (and a done-right copy) in
# C:\sims\files\catexcel-datatools\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-datatools -TimeoutSec 1200   (from the host)
$Name = 'catexcel-datatools'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Heads ($ws, $range) {
  $ws.Range($range).Font.Bold = $true
  try { $ws.Range($range).Interior.Color = 0xF2E6D9 } catch { }
}

$events = @('100 m', '200 m', '400 m', '800 m', '1500 m', 'Long jump', 'High jump', 'Shot put')

function SportsBook ($book, $entries, $pupils) {
  while ($book.Worksheets.Count -lt 3) { $null = $book.Worksheets.Add([Type]::Missing, $book.Worksheets.Item($book.Worksheets.Count)) }
  $we = $book.Worksheets.Item(1); $we.Name = 'Entries'
  $wv = $book.Worksheets.Item(2); $wv.Name = 'Events'
  $wp = $book.Worksheets.Item(3); $wp.Name = 'Pupils'
  $we.Range('A1').Formula = 'Phumlani Sports Day - entries'
  $we.Range('A1').Font.Bold = $true; $we.Range('A1').Font.Size = 14
  Fill12 $we @(,@('Name', 'Grade', 'Event')) 2
  Fill12 $we $entries 3
  Heads $we 'A2:C2'
  $we.Columns.Item('A').ColumnWidth = 20; $we.Columns.Item('B').ColumnWidth = 7; $we.Columns.Item('C').ColumnWidth = 12
  Fill12 $wv @(,@('Event')) 1
  for ($i = 0; $i -lt $events.Count; $i++) { $wv.Range("A$($i + 2)").Formula = $events[$i] }
  Heads $wv 'A1'
  $wv.Columns.Item('A').ColumnWidth = 12
  if ($pupils) {
    Fill12 $wp @(,@('Name', 'Grade')) 1
    Fill12 $wp $pupils 2
    Heads $wp 'A1:B1'
    $wp.Columns.Item('A').ColumnWidth = 20
  }
  return $we
}

$entriesA = @(
  @('Zanele Khumalo', 12, '100 m'), @('Imran Pillay', 11, '400 m'), @('Gift Mahlangu', 10, 'Shot put'), @('Chloe Adams', 12, 'High jump'),
  @('Bongani Dlamini', 13, '800 m'), @('Fatima Patel', 9, '100 m'), @('Mpho Sithole', 8, '1500 m'), @('Tamsin Jacobs', 10, 'Long jump'),
  @('Lindiwe Zulu', 7, '200 m'), @('Owen Botha', 12, 'Shot put'), @('Kagiso Molefe', 11, '100 m'), @('Carmen Fourie', 21, '400 m'))
# For Remove Duplicates and Text to Columns: a list typed from two class lists (some pupils twice), "Surname, First name".
$signups = @('Khumalo, Zanele', 'Pillay, Imran', 'Adams, Chloe', 'Khumalo, Zanele', 'Dlamini, Bongani', 'Patel, Fatima', 'Adams, Chloe', 'Sithole, Mpho', 'Zulu, Lindiwe', 'Pillay, Imran')

# The upload: 30 entries; rows 9, 17 and 26 have impossible grades (the Pupils sheet has the right ones).
$pupilsB = @(
  @('Busisiwe Ngcobo', 12), @('Riaan Coetzee', 11), @('Naledi Shabalala', 10), @('Jason Naidoo', 9), @('Palesa Mokoena', 8),
  @('Ethan September', 12), @('Sizwe Mabaso', 11), @('Megan Joubert', 10), @('Aisha Moosa', 9), @('Johan Kruger', 8),
  @('Nomvula Zwane', 12), @('Liam Pretorius', 11), @('Thandeka Mkhize', 10), @('Kyle Abrahams', 9), @('Precious Baloyi', 8))
$entriesB = @()
$ev = 0
foreach ($i in 0..29) {
  $p = $pupilsB[$i % 15]
  $entriesB += ,@($p[0], $p[1], $events[($i * 3 + [int]($i / 4)) % 8])
}
$entriesB[6][1] = 1      # row 9: Sizwe Mabaso, really 11
$entriesB[14][1] = 18    # row 17: Precious Baloyi, really 8
$entriesB[23][1] = 0     # row 26: Aisha Moosa, really 9

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $se = SportsBook $sb $entriesB $pupilsB
  $ws4 = $sb.Worksheets.Add([Type]::Missing, $sb.Worksheets.Item($sb.Worksheets.Count)); $ws4.Name = 'Summary'
  Fill12 $ws4 @(@('Event', '100 m'), @('Entries', ''), @('Grade 12 entries', '')) 2
  $ws4.Range('A1').Formula = 'Entries for one event'; $ws4.Range('A1').Font.Bold = $true
  $ws4.Range('A2:A4').Font.Bold = $true; $ws4.Columns.Item('A').ColumnWidth = 17; $ws4.Columns.Item('B').ColumnWidth = 12
  $null = $se.Activate(); $null = $se.Range('A1').Select()
  SaveStarter $sb 'SportsDay.xlsx'
  $se.Range('B9').Formula = '11'; $se.Range('B17').Formula = '8'; $se.Range('B26').Formula = '9'
  $null = $se.Range('C3:C40').Validation.Add(3, 1, 1, '=Events!$A$2:$A$9')
  $null = $se.Range('B3:B40').Validation.Add(1, 1, 1, '8', '12')
  $null = $ws4.Range('B2').Validation.Add(3, 1, 1, '=Events!$A$2:$A$9')
  $ws4.Range('B3').Formula2 = '=COUNTIF(Entries!$C$3:$C$40,B2)'
  $ws4.Range('B4').Formula2 = '=COUNTIFS(Entries!$C$3:$C$40,B2,Entries!$B$3:$B$40,12)'
  $sb.SaveAs((Join-Path $filesDir 'SportsDay-done.xlsx'), 51)
  "  done: B3 $($ws4.Range('B3').Text), B4 $($ws4.Range('B4').Text); 100 m entries listed: $((3..32 | Where-Object { $se.Range("C$_").Text -eq '100 m' }).Count)"
  foreach ($r in 3..32) { "  entry $($r): $($se.Range("A$r").Text) $($se.Range("B$r").Text) $($se.Range("C$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $we = SportsBook $wb $entriesA $null
  $wv = $wb.Worksheets.Item('Events')
  $wl = $wb.Worksheets.Item('Pupils'); $wl.Name = 'Signups'
  Fill12 $wl @(,@('Name')) 1
  for ($i = 0; $i -lt $signups.Count; $i++) { $wl.Range("A$($i + 2)").Formula = $signups[$i] }
  Heads $wl 'A1:B1'
  $wl.Columns.Item('A').ColumnWidth = 18; $wl.Columns.Item('B').ColumnWidth = 12
  $null = $we.Activate()
  $null = $we.Range('E3').Select()
  ShowExcel 1860 820 10
  $root = $AE::FromHandle($h)
  MarkCells $we @('C3', 'C3:C14', 'B3:B14', 'E3', 'C2')
  foreach ($tab in 'Home', 'Data', 'Review', 'View') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }

  # 1. Data Validation: a list for the Event column.
  $null = $we.Range('C3:C14').Select()
  SnapAll 'v-0'                                                     # Home tab, C3:C14 selected
  Tab 'Data'
  Dump 'data'
  foreach ($nm in 'Data Validation', 'Remove Duplicates', 'Text to Columns', 'Consolidate', 'Flash Fill') { TryMark ('btn' + ($nm -replace ' ', '')) $root @($nm, "$nm...") }
  TryMark 'btnDV' $root @('Data Validation') $T::SplitButton
  SnapAll 'v-1'                                                     # the Data tab
  $typed = $false
  try {
    $dv = $null
    try { $dv = Find $root @('Data Validation...') -tries 4 } catch { $dv = Find $root @('Data Validation') -tries 6 }
    PressAsync $dv
    WaitOthers
    DumpOthers 'dvdlg'
    "dialog: $([Comp12]::Describe($h))"
    SnapAll 'v-2' -Others                                           # Settings: Allow Any value
    $dlg = [Comp12]::Others($h) | Select-Object -First 1
    if ($dlg) {
      $r = [Comp12]::Rect($dlg); $w0 = [WinRect]::Of($h)
      Mark 'dvDialog' @(($r[0] - $w0[0]), ($r[1] - $w0[1]), $r[2], $r[3])
      # Allow: the first box has the focus - an L picks List.
      [XlMsg]::Post($dlg, 0x0102, [int][char]'L', 0); Start-Sleep -Milliseconds 900
      SnapAll 'v-3' -Others                                         # Allow: List (the Source box appears)
      [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300    # Tab: Ignore blank
      [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300    # Tab: In-cell dropdown
      [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300    # Tab: Source
      foreach ($ch in '=Events!$A$2:$A$9'.ToCharArray()) { [XlMsg]::Post($dlg, 0x0102, [int]$ch, 0); Start-Sleep -Milliseconds 60 }
      Start-Sleep -Milliseconds 900
      SnapAll 'v-4' -Others                                         # the Source typed
      [Shot]::PostKey($dlg, 0x0D); Start-Sleep -Milliseconds 1500   # Enter: OK
      if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
    }
  } catch { "data validation dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $vt = -1; try { $vt = $we.Range('C3').Validation.Type } catch { }
  "validation type after the dialog: $vt"
  if ($vt -ne 3) {
    "  validation through COM, and the dialog drawn again"
    try { $we.Range('C3:C14').Validation.Delete() } catch { }
    $null = $we.Range('C3:C14').Validation.Add(3, 1, 1, '=Events!$A$2:$A$9')
    try {
      PressAsync (Find $root @('Data Validation...', 'Data Validation') -tries 6)
      WaitOthers
      SnapAll 'v-4b' -Others                                        # List, =Events!$A$2:$A$9
      CloseOthers
    } catch { "again: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  }
  $null = $we.Range('C5').Select()
  $c5 = CellAt $we 'C5'
  Mark 'arrowC5' @(($c5[0] + $c5[2] + 1), $c5[1], 18, $c5[3])
  SnapAll 'v-5'                                                     # C5 with its drop-down arrow

  # 2. Whole number 8 to 12 for the grade, an input message, then Circle Invalid Data.
  $null = $we.Range('B3:B14').Validation.Add(1, 1, 1, '8', '12')
  $we.Range('B3:B14').Validation.InputTitle = 'Grade'
  $we.Range('B3:B14').Validation.InputMessage = 'Type a grade from 8 to 12.'
  $we.Range('B3:B14').Validation.ErrorTitle = 'Not a grade'
  $we.Range('B3:B14').Validation.ErrorMessage = 'Phumlani has Grades 8 to 12 only.'
  $null = $we.Range('B4').Select()
  SnapAll 'k-1'                                                     # B4 selected: the input message
  try {
    PressAsync (Find $root @('Data Validation...', 'Data Validation') -tries 6)
    WaitOthers
    SnapAll 'k-2' -Others                                           # Whole number between 8 and 12
    CloseOthers
  } catch { "grade dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  # the Data Validation button's menu: Data Validation..., Circle Invalid Data, Clear Validation Circles
  try {
    $dvm = $null
    foreach ($ty in @($T::SplitButton, $T::MenuItem, $T::Button)) { try { $dvm = Find $root @('Data Validation') $ty -tries 3; if ($dvm) { break } } catch { } }
    if ($dvm) {
      Expand $dvm; WaitOthers
      DumpOthers 'dvmenu'
      MarkAny 'menuCircle' @('Circle Invalid Data')
      SnapAll 'k-0' -Others                                         # the menu open
      Collapse $dvm
      if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
    }
  } catch { "data validation menu: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $we.CircleInvalid()
  $null = $we.Range('E3').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'k-3'                                                     # red circles on 13, 7 and 21
  $we.ClearCircles()

  # 3. IEB: Remove Duplicates and Text to Columns on the Signups sheet.
  $null = $wl.Activate(); $null = $wl.Range('A2').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wl @('A2', 'A1:A11') 'su'
  SnapAll 'r-0'                                                     # ten sign-ups, two pupils twice
  try {
    PressAsync (Find $root @('Remove Duplicates', 'Remove Duplicates...') -tries 6)
    WaitOthers
    DumpOthers 'rddlg'
    MarkAny 'rdOK' @('OK') $T::Button
    SnapAll 'r-1' -Others                                           # the Remove Duplicates box
    try { Press (FindAny @('OK') $T::Button -tries 6) } catch { "rd ok: $_"; CloseOthers }
    Start-Sleep -Milliseconds 1500
    SnapAll 'r-2' -Others                                           # the message: duplicates removed
    if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "remove duplicates: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  if ($wl.Range('A11').Text -ne '') { "  remove duplicates through COM"; $null = $wl.Range('A1:A11').RemoveDuplicates(1, 1) }
  "after remove duplicates: $((2..11 | ForEach-Object { $wl.Range("A$_").Text }) -join '; ')"
  $null = $wl.Range('A2:A9').Select()
  SnapAll 'r-3'                                                     # eight left
  try {
    PressAsync (Find $root @('Text to Columns', 'Text to Columns...') -tries 6)
    WaitOthers
    DumpOthers 'ttcdlg'
    SnapAll 'r-4' -Others                                           # the wizard, step 1
    CloseOthers
  } catch { "text to columns: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $null = $wl.Range('A2:A9').TextToColumns($wl.Range('A2'), 1, 1, $true, $false, $false, $true, $true)
  $wl.Range('A1').Formula = 'Surname'; $wl.Range('B1').Formula = 'First name'
  $null = $wl.Range('D2').Select()
  SnapAll 'r-5'                                                     # surname and first name apart
  "after text to columns: $($wl.Range('A2').Text) | $($wl.Range('B2').Text)"

  # 4. IEB: Protect Sheet, Allow Edit Ranges (Review tab), Record Macro (View tab).
  $null = $we.Activate(); $null = $we.Range('E3').Select()
  Start-Sleep -Milliseconds 600
  Tab 'Review'
  Dump 'review'
  foreach ($nm in 'Protect Sheet', 'Protect Workbook', 'Allow Edit Ranges') { TryMark ('btn' + ($nm -replace ' ', '')) $root @($nm, "$nm...") }
  SnapAll 'p-1'                                                     # the Review tab
  try {
    PressAsync (Find $root @('Protect Sheet...', 'Protect Sheet') -tries 6)
    WaitOthers
    DumpOthers 'protdlg'
    SnapAll 'p-2' -Others                                           # Protect Sheet
    CloseOthers
  } catch { "protect sheet: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  try {
    PressAsync (Find $root @('Allow Edit Ranges...', 'Allow Edit Ranges') -tries 6)
    WaitOthers
    SnapAll 'p-3' -Others                                           # Allow Edit Ranges
    CloseOthers
  } catch { "allow edit ranges: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  Tab 'View'
  Dump 'view'
  TryMark 'btnMacros' $root @('Macros') $T::SplitButton
  SnapAll 'm-1'                                                     # the View tab, Macros at the right
  try {
    $macros = Find $root @('Macros') $T::SplitButton -tries 6
    Expand $macros; WaitOthers
    DumpOthers 'macromenu'
    SnapAll 'm-2' -Others                                           # View Macros, Record Macro, Use Relative References
    Collapse $macros
    if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "macros menu: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  try {
    $rec = $null
    try { $rec = Find $root @('Record Macro...') -tries 4 } catch { }
    if (-not $rec) { $macros = Find $root @('Macros') $T::SplitButton -tries 4; Expand $macros; Start-Sleep -Milliseconds 800; $rec = FindAny @('Record Macro...', 'Record Macro') -tries 6 }
    PressAsync $rec
    WaitOthers
    DumpOthers 'recdlg'
    SnapAll 'm-3' -Others                                           # Record Macro
    CloseOthers
  } catch { "record macro: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  Tab 'Home'

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
