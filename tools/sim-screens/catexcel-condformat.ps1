# Real Excel 365 screens for catexcel Grade 11, lesson 12: Conditional
# formatting (AIPascalCourse/content/catexcel/condformat.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Ms Naidoo's Grade 11A
# CAT marks at Phumlani Secondary: the sheet before and after; Home >
# Conditional Formatting > Highlight Cells Rules > Less Than (the menu, the
# submenu, the dialog); the pass mark in a cell ($B$2) and what changing it
# does; Text that Contains (ABS); Duplicate Values; Top/Bottom Rules (Top 3);
# Data Bars, Color Scales and Icon Sets (their galleries); a wrong green rule
# on top, Manage Rules, Delete Rule; Clear Rules. Also makes the pupils'
# starter file Term3Marks11B.xlsx (with a wrong rule in it) and a done-right
# copy in C:\sims\files\catexcel-condformat\ and G:\My Drive\CAT\Excel\.
# Menus and dialogs are windows of their own: SnapAll -Others draws them over
# Excel's window. Read office-kit.ps1's safety rules first.
# Crop: work/catexcel-condformat-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-condformat -TimeoutSec 1200   (from the host)
$Name = 'catexcel-condformat'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11a-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

$classA = @(
  @('Sipho Ndlovu', 62, 55, 70), @('Lindiwe Zulu', 48, 41, 52), @('Gift Mahlangu', 35, 'ABS', 44),
  @('Chloe Adams', 81, 77, 85), @('Imran Pillay', 90, 94, 88), @('Zanele Khumalo', 57, 49, 63),
  @('Owen Botha', 29, 38, 41), @('Fatima Patel', 74, 82, 79), @('Bongani Dlamini', 45, 52, 47),
  @('Ayanda Mokoena', 66, 71, 58), @('Tamsin Jacobs', 53, 46, 60), @('Lindiwe Zulu', 48, 41, 52),
  @('Kagiso Molefe', 39, 44, 35))
$classB = @(
  @('Ntokozo Mthembu', 58, 64, 70), @('Ruan Venter', 44, 39, 51), @('Precious Ngubane', 77, 81, 74),
  @('Kabelo Molefe', 36, 42, 'ABS'), @('Aisha Patel', 88, 91, 85), @('Musa Khoza', 52, 47, 55),
  @('Megan Fourie', 61, 66, 59), @('Sbu Ndlovu', 29, 35, 40), @('Palesa Sithole', 71, 69, 78),
  @('Kyle Jacobs', 49, 53, 46), @('Nomsa Cele', 64, 58, 62), @('Ruan Venter', 44, 39, 51),
  @('Tshepo Radebe', 40, 45, 38))

function Heading ($ws, $range) {
  try { $ws.Range($range).Style = 'Accent1' } catch { }
  $ws.Range($range).Font.Bold = $true
  $ws.Range($range).WrapText = $true
}
function MarksSheet ($ws, $title, $rows) {
  $ws.Range('A1').Formula = $title
  try { $ws.Range('A1').Style = 'Title' } catch { $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 16 }
  $ws.Range('A2').Formula = 'Pass mark'; $ws.Range('B2').Formula = '50'; $ws.Range('A2').Font.Bold = $true
  FillAt $ws @(,@('Name', 'Class test', 'Practical test', 'PAT', 'Average')) 3
  FillAt $ws $rows 4
  $ws.Range('E4:E16').Formula = '=AVERAGE(B4:D4)'
  $ws.Range('E4:E16').NumberFormat = '0.0'
  Heading $ws 'A3:E3'
  $ws.Range('B4:D16').HorizontalAlignment = -4152
  $ws.Columns.Item('A').ColumnWidth = 18
  foreach ($c in 'B', 'C', 'D', 'E') { $ws.Columns.Item($c).ColumnWidth = 11 }
  $ws.Rows.Item(3).RowHeight = 33
}
# The rules, through COM (for the done-right copy, and wherever the menus could not be driven).
function RuleLess ($r, $f)   { $c = $r.FormatConditions.Add(1, 6, $f); $c.Interior.Color = 0xCEC7FF; $c.Font.Color = 0x06009C; $c }   # xlCellValue, xlLess: light red fill, dark red text
function RuleGreen ($r)      { $c = $r.FormatConditions.Add(1, 5, '=0'); $c.Interior.Color = 0xCEEFC6; $c.Font.Color = 0x006100; $c }  # xlGreater 0: green
function RuleTop3 ($r)       { $c = $r.FormatConditions.AddTop10(); $c.TopBottom = 1; $c.Rank = 3; $c.Percent = $false; $c.Interior.Color = 0xCEEFC6; $c.Font.Color = 0x006100; $c }
function RuleDup ($r)        { $c = $r.FormatConditions.AddUniqueValues(); $c.DupeUnique = 1; $c.Interior.Color = 0xCEC7FF; $c.Font.Color = 0x06009C; $c }
function RuleAbs ($r)        { $c = $r.FormatConditions.Add(9, [Type]::Missing, [Type]::Missing, [Type]::Missing, 'ABS', 0); $c.Interior.Color = 0x9CEBFF; $c }  # xlTextString, contains

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $sf = $sb.Worksheets.Item(1); $sf.Name = '11B'
  MarksSheet $sf 'Phumlani Secondary - Grade 11B CAT, Term 3 (%)' $classB
  $null = RuleGreen $sf.Range('B4:D16')                             # the wrong rule the pupil deletes
  $null = $sf.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'Term3Marks11B.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'Term3Marks11B.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  $sf.Range('B4:D16').FormatConditions.Delete()
  $null = RuleLess $sf.Range('B4:D16') '=$B$2'
  $null = $sf.Range('E4:E16').FormatConditions.AddDatabar()
  $null = RuleTop3 $sf.Range('E4:E16')
  $null = RuleDup $sf.Range('A4:A16')
  "done rules: B $($sf.Range('B4:D16').FormatConditions.Count) E $($sf.Range('E4:E16').FormatConditions.Count) A $($sf.Range('A4:A16').FormatConditions.Count)"
  $sb.SaveAs((Join-Path $filesDir 'Term3Marks11B-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = '11A'
  MarksSheet $ws 'Phumlani Secondary - Grade 11A CAT, Term 3 (%)' $classA
  $null = $ws.Range('G4').Select()
  ShowExcel
  foreach ($a in 'A1', 'B2', 'A4:A16', 'B4:D16', 'E4:E16', 'C6', 'G4', 'B4', 'E8') { Mark ('cell' + ($a -replace ':', '_')) (CellBox $ws $a) }
  TryMark 'tabHome' $root @('Home') $T::TabItem
  TryMark 'cfBtn'   $root @('Conditional Formatting')
  TryMark 'formatTable' $root @('Format as Table')
  Dump 'home'
  SnapAll 'w-1'                                                     # the plain sheet

  # The FIRST opening of the Conditional Formatting menu moves the input clock (two runs, 9 October 2026,
  # both at this point and nowhere else - Office, not a person), and the guard then deleted every picture.
  # So the menu is opened and closed once here, before any picture of this part, and the clock read again.
  try {
    $warm = Find $root @('Conditional Formatting') -tries 6
    Expand $warm; Start-Sleep -Milliseconds 1500; Collapse $warm; Start-Sleep -Milliseconds 800
    if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "warm-up: $_" }
  [void][CompA]::Away($h); Start-Sleep -Milliseconds 500
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false

  # 1. Highlight Cells Rules > Less Than... on B4:D16.
  $null = $ws.Range('B4:D16').Select()
  SnapAll 'l-1'                                                     # B4:D16 selected, Home tab
  $cf = $null
  try { $cf = Find $root @('Conditional Formatting') -tries 6 } catch { "  MISSING Conditional Formatting" }
  $lessDone = $false
  if ($cf) {
    try {
      Expand $cf; Start-Sleep -Milliseconds 1500
      DumpOthers 'cfmenu'
      foreach ($nm in 'Highlight Cells Rules', 'Top/Bottom Rules', 'Data Bars', 'Color Scales', 'Icon Sets', 'New Rule...', 'Clear Rules', 'Manage Rules...') { MarkAny ('cf' + ($nm -replace '[ ./]', '')) @($nm) }
      SnapAll 'l-2' -Others                                         # the Conditional Formatting menu
      $hcr = FindAny @('Highlight Cells Rules') -tries 6
      Expand $hcr; Start-Sleep -Milliseconds 1500
      DumpOthers 'hcrmenu'
      foreach ($nm in 'Greater Than...', 'Less Than...', 'Between...', 'Equal To...', 'Text that Contains...', 'A Date Occurring...', 'Duplicate Values...', 'More Rules...') { MarkAny ('hc' + ($nm -replace '[ .]', '')) @($nm) }
      SnapAll 'l-3' -Others                                         # the Highlight Cells Rules submenu
      PressAsync (FindAny @('Less Than...') -tries 6)
      WaitOthers
      DumpOthers 'lessdlg'
      MarkAny 'lessOK' @('OK')
      SnapAll 'l-4' -Others                                         # the Less Than dialog
      try {
        $dlgEdit = FindAny @('Format cells that are LESS THAN:') $T::Edit -tries 3
      } catch {
        $dlgEdit = $null
        foreach ($top in (OtherRoots)) { $e = $top.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Edit))); if ($e) { $dlgEdit = $e; break } }
      }
      if ($dlgEdit) {
        Mark 'lessEdit' (Box $dlgEdit)
        SetText $dlgEdit '50'
        Start-Sleep -Milliseconds 900
        SnapAll 'l-4b' -Others                                      # 50 in the box
        Press (FindAny @('OK') $T::Button -tries 4)
        Start-Sleep -Milliseconds 1500
        $lessDone = ($ws.Range('B4:D16').FormatConditions.Count -gt 0)
      } else { "  no edit box in the dialog" }
    } catch { "less than: $_" }
    if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  }
  if (-not $lessDone) { $ws.Range('B4:D16').FormatConditions.Delete(); $null = RuleLess $ws.Range('B4:D16') '=50'; "  (Less Than 50 by COM)" }
  "rule: $($ws.Range('B4:D16').FormatConditions.Item(1).Formula1)"
  $null = $ws.Range('G4').Select()
  SnapAll 'l-5'                                                     # the marks under 50 in red

  # 2. The pass mark in a cell: =$B$2; then the pass mark changed to 40.
  $ws.Range('B4:D16').FormatConditions.Delete()
  $null = RuleLess $ws.Range('B4:D16') '=$B$2'
  $null = $ws.Range('B2').Select()
  SnapAll 'k-1'                                                     # Cell Value < $B$2, B2 50
  $ws.Range('B2').Formula = '40'
  SnapAll 'k-2'                                                     # B2 40: fewer red cells
  $ws.Range('B2').Formula = '50'

  # 3. Text that Contains ABS, and Duplicate Values on the names.
  $null = RuleAbs $ws.Range('B4:D16')
  $null = $ws.Range('A4:A16').Select()
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    Expand (FindAny @('Highlight Cells Rules') -tries 6); Start-Sleep -Milliseconds 1200
    PressAsync (FindAny @('Duplicate Values...') -tries 6)
    WaitOthers
    DumpOthers 'dupdlg'
    SnapAll 'du-0' -Others                                          # the Duplicate Values dialog
    Press (FindAny @('OK') $T::Button -tries 4); Start-Sleep -Milliseconds 1200
  } catch { "duplicates: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  if ($ws.Range('A4:A16').FormatConditions.Count -eq 0) { $null = RuleDup $ws.Range('A4:A16'); "  (duplicates by COM)" }
  $null = $ws.Range('G4').Select()
  SnapAll 'du-1'                                                    # Lindiwe Zulu twice, both red; ABS yellow

  # 4. Top/Bottom Rules: the top 3 averages.
  $null = $ws.Range('E4:E16').Select()
  $topDone = $false
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    $tb = FindAny @('Top/Bottom Rules') -tries 6
    Expand $tb; Start-Sleep -Milliseconds 1500
    DumpOthers 'tbmenu'
    foreach ($nm in 'Top 10 Items...', 'Top 10%...', 'Bottom 10 Items...', 'Bottom 10%...', 'Above Average...', 'Below Average...') { MarkAny ('tb' + ($nm -replace '[ .%]', '')) @($nm) }
    SnapAll 'tb-1' -Others                                          # the Top/Bottom Rules submenu
    PressAsync (FindAny @('Top 10 Items...') -tries 6)
    WaitOthers
    DumpOthers 'topdlg'
    SnapAll 'tb-2' -Others                                          # the Top 10 Items dialog
    $spin = $null
    foreach ($top in (OtherRoots)) { $e = $top.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Edit))); if ($e) { $spin = $e; break } }
    if ($spin) { Mark 'topEdit' (Box $spin); SetText $spin '3'; Start-Sleep -Milliseconds 800; SnapAll 'tb-3' -Others; Press (FindAny @('OK') $T::Button -tries 4); Start-Sleep -Milliseconds 1200; $topDone = $true }
  } catch { "top 3: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  if ($ws.Range('E4:E16').FormatConditions.Count -eq 0) { $null = RuleTop3 $ws.Range('E4:E16'); "  (top 3 by COM)" }
  else { try { $tc = $ws.Range('E4:E16').FormatConditions.Item(1); $tc.Rank = 3; $tc.Interior.Color = 0xCEEFC6; $tc.Font.Color = 0x006100 } catch { "top colour: $_" } }
  $null = $ws.Range('G4').Select()
  SnapAll 'tb-4'                                                    # the three best averages
  $ws.Range('E4:E16').FormatConditions.Delete()

  # 5. Data Bars, Color Scales, Icon Sets on the averages.
  $null = $ws.Range('E4:E16').Select()
  SnapAll 'd-1'                                                     # E4:E16 selected
  $barsDone = $false
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    SnapAll 'd-2' -Others                                           # the menu again
    $db = FindAny @('Data Bars') -tries 6
    Expand $db; Start-Sleep -Milliseconds 1500
    DumpOthers 'dbgallery'
    foreach ($nm in 'Blue Data Bar', 'Green Data Bar', 'Red Data Bar', 'Orange Data Bar', 'Light Blue Data Bar', 'Purple Data Bar') { MarkAny ('db' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'd-3' -Others                                           # the Data Bars gallery
    Press (FindAny @('Blue Data Bar') -tries 4); Start-Sleep -Milliseconds 1500
    $barsDone = ($ws.Range('E4:E16').FormatConditions.Count -gt 0)
  } catch { "data bars: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  if (-not $barsDone) { $null = $ws.Range('E4:E16').FormatConditions.AddDatabar(); "  (data bars by COM)" }
  $null = $ws.Range('G4').Select()
  SnapAll 'd-4'                                                     # bars in the averages
  $ws.Range('E4:E16').FormatConditions.Delete()
  $null = $ws.Range('E4:E16').Select()
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    Expand (FindAny @('Color Scales') -tries 6); Start-Sleep -Milliseconds 1500
    DumpOthers 'csgallery'
    SnapAll 'cs-1' -Others                                          # the Color Scales gallery
    Collapse $cf
  } catch { "color scales: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  $null = $ws.Range('E4:E16').FormatConditions.AddColorScale(3)
  $null = $ws.Range('G4').Select()
  SnapAll 'cs-2'                                                    # green-yellow-red
  $ws.Range('E4:E16').FormatConditions.Delete()
  $null = $ws.Range('E4:E16').FormatConditions.AddColorScale(2)
  SnapAll 'cs-3'                                                    # a two-colour scale
  $ws.Range('E4:E16').FormatConditions.Delete()
  $null = $ws.Range('E4:E16').Select()
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    Expand (FindAny @('Icon Sets') -tries 6); Start-Sleep -Milliseconds 1500
    DumpOthers 'icgallery'
    SnapAll 'ic-1' -Others                                          # the Icon Sets gallery
    Collapse $cf
  } catch { "icon sets: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  $ic = $ws.Range('E4:E16').FormatConditions.AddIconSetCondition()
  try { $ic.IconSet = $wb.IconSets.Item(4) } catch { "icon set: $_" }       # xl3TrafficLights1
  $null = $ws.Range('G4').Select()
  SnapAll 'ic-2'                                                    # traffic lights
  $ws.Range('E4:E16').FormatConditions.Delete()

  # 6. The wrong rule on top: Manage Rules, Delete Rule.
  $ws.Range('B4:D16').FormatConditions.Delete()
  $null = RuleLess $ws.Range('B4:D16') '=$B$2'
  $null = RuleGreen $ws.Range('B4:D16')
  try { $ws.Range('B4:D16').FormatConditions.Item(2).SetFirstPriority() } catch { "priority: $_" }
  $null = $ws.Range('G4').Select()
  SnapAll 'm-0'                                                     # everything green
  $null = $ws.Range('B4:D16').Select()
  SnapAll 'm-1'                                                     # B4:D16 selected
  $mgrDone = $false
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    SnapAll 'm-2' -Others                                           # the menu: Manage Rules at the bottom
    PressAsync (FindAny @('Manage Rules...') -tries 6)
    WaitOthers
    FitDialogs
    DumpOthers 'rulesmgr'
    foreach ($nm in 'New Rule...', 'Edit Rule...', 'Delete Rule', 'Duplicate Rule', 'OK', 'Cancel', 'Apply') { MarkAny ('rm' + ($nm -replace '[ .]', '')) @($nm) }
    SnapAll 'm-3' -Others                                           # the Rules Manager: green on top
    Press (FindAny @('Delete Rule') -tries 4); Start-Sleep -Milliseconds 1200
    SnapAll 'm-4' -Others                                           # one rule left
    Press (FindAny @('OK') $T::Button -tries 4); Start-Sleep -Milliseconds 1500
    $mgrDone = ($ws.Range('B4:D16').FormatConditions.Count -eq 1)
  } catch { "manage rules: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  "rules left on B4:D16: $($ws.Range('B4:D16').FormatConditions.Count)"
  if (-not $mgrDone) {
    while ($ws.Range('B4:D16').FormatConditions.Count -gt 0) { $ws.Range('B4:D16').FormatConditions.Item(1).Delete() }
    $null = RuleLess $ws.Range('B4:D16') '=$B$2'
    "  (the green rule deleted by COM)"
    try {
      $null = $ws.Range('B4:D16').Select()
      Expand $cf; Start-Sleep -Milliseconds 1200
      PressAsync (FindAny @('Manage Rules...') -tries 6)
      WaitOthers
      FitDialogs
      SnapAll 'm-4b' -Others                                        # the Rules Manager, reopened: one rule
      CloseOthers
    } catch { "manager again: $_"; if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers } }
  }
  $null = $ws.Range('G4').Select()
  SnapAll 'm-5'                                                     # red again

  # 7. Everything together, then Clear Rules.
  $null = RuleAbs $ws.Range('B4:D16')
  $null = $ws.Range('E4:E16').FormatConditions.AddDatabar()
  $null = $ws.Range('G4').Select()
  SnapAll 'w-2'                                                     # the finished sheet
  $null = $ws.Range('B4:D16').Select()
  try {
    Expand $cf; Start-Sleep -Milliseconds 1200
    Expand (FindAny @('Clear Rules') -tries 6); Start-Sleep -Milliseconds 1500
    DumpOthers 'clearmenu'
    MarkAny 'clSel' @('Clear Rules from Selected Cells')
    MarkAny 'clSheet' @('Clear Rules from Entire Sheet')
    SnapAll 'cl-1' -Others                                          # Clear Rules
    Collapse $cf
  } catch { "clear rules: $_" }
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
  try { if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers } } catch { }
}
finally {
  try { SaveMarks } catch { }
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
