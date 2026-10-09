# Real Excel 365 screens for catexcel Grade 12, Dates and times
# (AIPascalCourse/content/catexcel/dates.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Botha's Bakery's staff:
# a date as a number (General format), YEAR, MONTH and DAY, an age from
# YEAR(TODAY()), DAYS since starting, DATE for this year's birthday, NOW;
# the shift times - hours worked (out - in) * 24, HOUR and MINUTE, late with
# TIME(6,0,0); and (IEB) EDATE, WORKDAY, NETWORKDAYS, WEEKNUM and YEARFRAC.
# Also makes the pupils' starter file StaffTimes.xlsx (and a done-right copy)
# in C:\sims\files\catexcel-dates\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-dates        (from the host)
$Name = 'catexcel-dates'
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

# Staff: name, date of birth, start date. Shifts: date, name, in, out.
function StaffBook ($book, $staff, $shifts, [string]$reportDate) {
  while ($book.Worksheets.Count -lt 2) { $null = $book.Worksheets.Add([Type]::Missing, $book.Worksheets.Item($book.Worksheets.Count)) }
  $ws = $book.Worksheets.Item(1); $ws.Name = 'Staff'
  $wt = $book.Worksheets.Item(2); $wt.Name = 'Shifts'
  $ws.Range('A1').Formula = "Botha's Bakery - staff"
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  if ($reportDate) { $ws.Range('F1').Formula = 'Report date'; $ws.Range('G1').Formula = $reportDate; $ws.Range('F1').Font.Bold = $true; $ws.Range('G1').NumberFormat = 'yyyy/mm/dd' }
  Fill12 $ws @(,@('Name', 'Born', 'Started', 'Birth year', 'Age', 'Days worked', 'Birthday this year')) 3
  Fill12 $ws $staff 4
  $last = 3 + $staff.Count
  $ws.Range("B4:C$last").NumberFormat = 'yyyy/mm/dd'
  $ws.Range("G4:G$last").NumberFormat = 'yyyy/mm/dd'
  Heads $ws 'A3:G3'
  $ws.Columns.Item('A').ColumnWidth = 17
  foreach ($c in 'B', 'C') { $ws.Columns.Item($c).ColumnWidth = 11 }
  $ws.Columns.Item('D').ColumnWidth = 10; $ws.Columns.Item('E').ColumnWidth = 6; $ws.Columns.Item('F').ColumnWidth = 12; $ws.Columns.Item('G').ColumnWidth = 18
  Fill12 $wt @(,@('Date', 'Name', 'In', 'Out', 'Hours', 'Late?', 'Start hour')) 1
  Fill12 $wt $shifts 2
  $lastS = 1 + $shifts.Count
  $wt.Range("A2:A$lastS").NumberFormat = 'yyyy/mm/dd'
  $wt.Range("C2:D$lastS").NumberFormat = 'hh:mm'
  $wt.Range("E2:E$lastS").NumberFormat = '0.00'
  Heads $wt 'A1:G1'
  $wt.Columns.Item('A').ColumnWidth = 11; $wt.Columns.Item('B').ColumnWidth = 15
  foreach ($c in 'C', 'D', 'E', 'F') { $wt.Columns.Item($c).ColumnWidth = 8 }
  $wt.Columns.Item('G').ColumnWidth = 10
  return $ws
}

$staffA = @(
  @('Mr Botha', '1971/03/14', '1998/06/01'), @('Thandi Mokoena', '1985/11/02', '2012/02/15'), @('Pieter Venter', '1990/07/23', '2017/09/01'),
  @('Nomsa Khumalo', '1979/01/30', '2005/04/04'), @('Sipho Ndlovu', '2001/10/09', '2024/01/08'), @('Ayesha Davids', '1995/05/17', '2019/11/11'),
  @('Johan Kruger', '1966/12/25', '1999/03/01'), @('Lindiwe Zulu', '2003/08/05', '2025/07/14'))
$shiftsA = @(
  @('2026/10/05', 'Thandi Mokoena', '05:45', '14:00'), @('2026/10/05', 'Sipho Ndlovu', '06:10', '14:30'), @('2026/10/05', 'Pieter Venter', '06:00', '13:15'),
  @('2026/10/06', 'Thandi Mokoena', '05:50', '14:05'), @('2026/10/06', 'Ayesha Davids', '06:25', '15:00'), @('2026/10/06', 'Lindiwe Zulu', '07:00', '12:30'),
  @('2026/10/07', 'Nomsa Khumalo', '05:30', '13:30'), @('2026/10/07', 'Sipho Ndlovu', '06:00', '14:20'), @('2026/10/07', 'Johan Kruger', '06:05', '11:35'))

$staffB = @(
  @('Gift Mahlangu', '1988/02/29', '2010/05/03'), @('Carmen Fourie', '1993/09/30', '2016/01/18'), @('Bongani Dlamini', '1975/04/12', '2001/10/01'),
  @('Fatima Patel', '1999/12/31', '2022/03/07'), @('Owen Smith', '2004/06/15', '2026/02/02'), @('Refilwe Maseko', '1982/10/30', '2008/08/18'),
  @('Kagiso Molefe', '1997/01/01', '2020/06/22'), @('Annelie van Wyk', '1969/07/04', '1995/11/13'), @('Tumelo Sello', '2002/03/21', '2023/09/04'),
  @('Kavitha Govender', '1986/11/08', '2013/04/29'))
$shiftsB = @(
  @('2026/10/19', 'Gift Mahlangu', '05:55', '14:10'), @('2026/10/19', 'Owen Smith', '06:20', '14:50'), @('2026/10/19', 'Fatima Patel', '06:00', '12:00'),
  @('2026/10/20', 'Carmen Fourie', '05:40', '13:55'), @('2026/10/20', 'Tumelo Sello', '06:01', '14:31'), @('2026/10/20', 'Kagiso Molefe', '06:45', '15:15'),
  @('2026/10/21', 'Bongani Dlamini', '05:30', '14:45'), @('2026/10/21', 'Owen Smith', '06:00', '13:30'), @('2026/10/21', 'Refilwe Maseko', '07:15', '12:45'),
  @('2026/10/22', 'Gift Mahlangu', '06:10', '14:40'))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = StaffBook $sb $staffB $shiftsB '2026/10/30'
  $st = $sb.Worksheets.Item('Shifts')
  $null = $ss.Activate(); $null = $ss.Range('A1').Select()
  SaveStarter $sb 'StaffTimes.xlsx'
  for ($r = 4; $r -le 13; $r++) {
    $ss.Range("D$r").Formula2 = "=YEAR(B$r)"
    $ss.Range("E$r").Formula2 = "=YEAR(`$G`$1)-YEAR(B$r)"
    $ss.Range("F$r").Formula2 = "=DAYS(`$G`$1,C$r)"
    $ss.Range("G$r").Formula2 = "=DATE(YEAR(`$G`$1),MONTH(B$r),DAY(B$r))"
  }
  for ($r = 2; $r -le 11; $r++) {
    $st.Range("E$r").Formula2 = "=(D$r-C$r)*24"
    $st.Range("F$r").Formula2 = "=IF(C$r>TIME(6,0,0),""Late"",""On time"")"
    $st.Range("G$r").Formula2 = "=HOUR(C$r)"
  }
  $sb.SaveAs((Join-Path $filesDir 'StaffTimes-done.xlsx'), 51)
  foreach ($r in 4..13) { "  done staff $($r): $($ss.Range("A$r").Text) $($ss.Range("D$r").Text) $($ss.Range("E$r").Text) $($ss.Range("F$r").Text) $($ss.Range("G$r").Text) (value $($ss.Range("G$r").Value2))" }
  foreach ($r in 2..11) { "  done shift $($r): $($st.Range("B$r").Text) $($st.Range("E$r").Text) $($st.Range("F$r").Text) $($st.Range("G$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = StaffBook $wb $staffA $shiftsA ''
  $wt = $wb.Worksheets.Item('Shifts')
  $null = $ws.Activate()
  $null = $ws.Range('I4').Select()
  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $ws @('B4', 'D4', 'E4', 'F4', 'G4', 'I4', 'B4:C11')
  TryMark 'formulaBar' $root @('Formula Bar')
  Dump 'home'

  # 1. A date is a number: B4:C11 shown as General, then back.
  SnapAll 'd-0'                                                     # dates as dates, I4 active
  $ws.Range('B4:C11').NumberFormat = 'General'
  $null = $ws.Range('B4').Select(); SnapAll 'd-1'                   # the same dates as numbers
  "Mr Botha born: $($ws.Range('B4').Text)"
  $ws.Range('B4:C11').NumberFormat = 'yyyy/mm/dd'

  # 2. YEAR in D4; the age in E4; DAYS in F4; DATE in G4.
  $null = $ws.Range('D4').Select(); SnapAll 'd-2'                   # D4 clicked
  $ws.Range('D4').Formula2 = '=YEAR(B4)'
  $null = $ws.Range('E4').Select(); SnapAll 'd-3'                   # 1971; E4 clicked
  $ws.Range('E4').Formula2 = '=YEAR(TODAY())-YEAR(B4)'
  $null = $ws.Range('F4').Select(); SnapAll 'd-4'                   # the age; F4 clicked
  $ws.Range('F4').Formula2 = '=DAYS(TODAY(),C4)'
  $null = $ws.Range('G4').Select(); SnapAll 'd-5'                   # days worked; G4 clicked
  $ws.Range('G4').Formula2 = '=DATE(YEAR(TODAY()),MONTH(B4),DAY(B4))'
  $null = $ws.Range('D4:G4').AutoFill($ws.Range('D4:G11'), 0)
  $null = $ws.Range('G4').Select(); SnapAll 'd-6'                   # every row
  foreach ($r in 4..11) { "  staff $($r): $($ws.Range("D$r").Text) $($ws.Range("E$r").Text) $($ws.Range("F$r").Text) $($ws.Range("G$r").Text)" }
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  SnapAll 'd-7'                                                     # the formulas
  $xl.ActiveWindow.DisplayFormulas = $false

  # 3. Times: the shifts.
  $null = $wt.Activate()
  $null = $wt.Range('I2').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wt @('C2', 'E2', 'F2', 'G2', 'I2') 's'
  SnapAll 't-0'                                                     # the shifts
  $null = $wt.Range('E2').Select(); SnapAll 't-1'                   # E2 clicked
  $wt.Range('E2').Formula2 = '=(D2-C2)*24'
  $null = $wt.Range('F2').Select(); SnapAll 't-2'                   # 8.25; F2 clicked
  $wt.Range('F2').Formula2 = '=IF(C2>TIME(6,0,0),"Late","On time")'
  $null = $wt.Range('G2').Select(); SnapAll 't-3'                   # On time; G2 clicked
  $wt.Range('G2').Formula2 = '=HOUR(C2)'
  $null = $wt.Range('E2:G2').AutoFill($wt.Range('E2:G10'), 0)
  $null = $wt.Range('G2').Select(); SnapAll 't-4'                   # every shift
  foreach ($r in 2..10) { "  shift $($r): $($wt.Range("E$r").Text) $($wt.Range("F$r").Text) $($wt.Range("G$r").Text)" }
  # a time as a number
  $wt.Range('C2:D10').NumberFormat = 'General'
  SnapAll 't-5'                                                     # times as parts of a day
  $wt.Range('C2:D10').NumberFormat = 'hh:mm'
  # hours without *24
  $wt.Range('E2').Formula2 = '=D2-C2'; $wt.Range('E2').NumberFormat = 'General'
  $null = $wt.Range('E2').Select(); SnapAll 't-6'                   # 0.34375 - a part of a day
  $wt.Range('E2').Formula2 = '=(D2-C2)*24'; $wt.Range('E2').NumberFormat = '0.00'

  # 4. IEB: EDATE, WORKDAY, NETWORKDAYS, WEEKNUM, YEARFRAC on the Staff sheet.
  $null = $ws.Activate()
  Fill12 $ws @(,@('Trial ends', 'Age (YEARFRAC)')) 3 7
  Heads $ws 'H3:I3'
  $ws.Columns.Item('H').ColumnWidth = 12; $ws.Columns.Item('I').ColumnWidth = 15
  $ws.Range('H4:H11').NumberFormat = 'yyyy/mm/dd'
  $null = $ws.Range('H4').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $ws @('H4', 'I4')
  SnapAll 'e-1'                                                     # H4 clicked
  $ws.Range('H4').Formula2 = '=EDATE(C4,3)'
  $ws.Range('I4').Formula2 = '=INT(YEARFRAC(B4,TODAY()))'
  $null = $ws.Range('H4:I4').AutoFill($ws.Range('H4:I11'), 0)
  $null = $ws.Range('I4').Select(); SnapAll 'e-2'                   # trial end dates and ages
  foreach ($r in 4..11) { "  ieb $($r): $($ws.Range("H$r").Text) $($ws.Range("I$r").Text)" }
  # An order sheet for WORKDAY, NETWORKDAYS, WEEKNUM
  $wo = $wb.Worksheets.Add([Type]::Missing, $wt); $wo.Name = 'Orders'
  Fill12 $wo @(,@('Order', 'Ordered', 'Working days', 'Ready', 'Week', 'Working days to 30 Oct')) 1
  Fill12 $wo @(@('Wedding cake', '2026/10/09', 5), @('Matric farewell', '2026/10/14', 3), @('Year-end function', '2026/10/23', 10)) 2
  $wo.Range('B2:B4').NumberFormat = 'yyyy/mm/dd'; $wo.Range('D2:D4').NumberFormat = 'yyyy/mm/dd'
  Heads $wo 'A1:F1'
  $wo.Columns.Item('A').ColumnWidth = 17; $wo.Columns.Item('B').ColumnWidth = 11; $wo.Columns.Item('C').ColumnWidth = 13
  $wo.Columns.Item('D').ColumnWidth = 11; $wo.Columns.Item('E').ColumnWidth = 7; $wo.Columns.Item('F').ColumnWidth = 22
  for ($r = 2; $r -le 4; $r++) {
    $wo.Range("D$r").Formula2 = "=WORKDAY(B$r,C$r)"
    $wo.Range("E$r").Formula2 = "=WEEKNUM(B$r)"
    $wo.Range("F$r").Formula2 = "=NETWORKDAYS(B$r,DATE(2026,10,30))"
  }
  $null = $wo.Range('D2').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'w-1'                                                     # WORKDAY, WEEKNUM, NETWORKDAYS
  foreach ($r in 2..4) { "  order $($r): ready $($wo.Range("D$r").Text) week $($wo.Range("E$r").Text) working days $($wo.Range("F$r").Text)" }

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
