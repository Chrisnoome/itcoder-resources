# Real Excel 365 screens for catexcel Grade 12, Nested IF, AND and OR
# (AIPascalCourse/content/catexcel/nestedif.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Ms Naidoo's Grade 12A
# prelim marks at Phumlani Secondary: a nested IF for the result, IF with
# AND for the trip, IF with OR for a letter home, Show Formulas, two broken
# formulas (no quotes; the wrong order), and (IEB) CHOOSE on an exam
# timetable. Also makes the pupils' starter file Prelims12B.xlsx (and a
# done-right copy) in C:\sims\files\catexcel-nestedif\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-nestedif        (from the host)
$Name = 'catexcel-nestedif'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function MarkSheet ($ws, $title, $rows) {
  $ws.Range('A1').Formula = $title
  Fill12 $ws @(,@('Name', 'PAT (%)', 'Exam (%)', 'Final (%)', 'Result', 'Trip', 'Letter')) 2
  Fill12 $ws $rows 3
  $last = 2 + $rows.Count
  for ($r = 3; $r -le $last; $r++) { $ws.Range("D$r").Formula2 = "=AVERAGE(B$($r):C$($r))" }
  $ws.Range("D3:D$last").NumberFormat = '0.0'
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  $ws.Range('A2:G2').Font.Bold = $true
  try { $ws.Range('A2:G2').Interior.Color = 0xF2E6D9 } catch { }
  $ws.Columns.Item('A').ColumnWidth = 18
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 10 }
  $ws.Columns.Item('E').ColumnWidth = 12
  foreach ($c in 'F', 'G') { $ws.Columns.Item($c).ColumnWidth = 9 }
}

# Ms Naidoo's 12A (the lesson): 12 pupils.
$pupilsA = @(
  @('Zanele Khumalo', 72, 68), @('Imran Pillay', 88, 84), @('Gift Mahlangu', 45, 38), @('Chloe Adams', 81, 79),
  @('Bongani Dlamini', 64, 55), @('Fatima Patel', 92, 95), @('Mpho Sithole', 38, 51), @('Tamsin Jacobs', 70, 70),
  @('Lindiwe Zulu', 58, 49), @('Owen Botha', 77, 85), @('Kagiso Molefe', 51, 47), @('Carmen Fourie', 66, 73))

# 12B (the upload): 20 pupils, with the edges in it - 80, 79.5, 50, 49.5; 70 and 70; 69; 39; 40 and 40.
$pupilsB = @(
  @('Sibusiso Khoza', 82, 78), @('Annelie van Wyk', 85, 74), @('Nandi Mthembu', 55, 45), @('Graham Peters', 60, 39),
  @('Thulani Radebe', 70, 70), @('Kavitha Govender', 85, 69), @('Kagiso Molefe', 39, 62), @('Joanne Smith', 40, 40),
  @('Andile Cele', 91, 88), @('Ayesha Davids', 73, 66), @('Lungile Nkosi', 48, 57), @('Pieter Swart', 67, 71),
  @('Refilwe Maseko', 94, 97), @('Yusuf Hendricks', 35, 44), @('Busisiwe Ngcobo', 76, 72), @('Riaan Coetzee', 52, 50),
  @('Naledi Shabalala', 69, 75), @('Jason Naidoo', 58, 61), @('Palesa Mokoena', 79, 81), @('Ethan September', 43, 37))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  try { "decimal separator: '$($xl.DecimalSeparator)', use system: $($xl.UseSystemSeparators)" } catch { "separators: $_" }

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Prelims'
  MarkSheet $ss 'Phumlani Secondary - Grade 12B CAT prelims' $pupilsB
  $null = $ss.Range('A1').Select()
  SaveStarter $sb 'Prelims12B.xlsx'
  for ($r = 3; $r -le 22; $r++) {
    $ss.Range("E$r").Formula2 = "=IF(D$r>=80,""Distinction"",IF(D$r>=50,""Pass"",""Support""))"
    $ss.Range("F$r").Formula2 = "=IF(AND(B$r>=70,C$r>=70),""Yes"",""No"")"
    $ss.Range("G$r").Formula2 = "=IF(OR(B$r<40,C$r<40),""Letter"",""OK"")"
  }
  $sb.SaveAs((Join-Path $filesDir 'Prelims12B-done.xlsx'), 51)
  foreach ($r in 3..22) { "  12B row $($r): $($ss.Range("A$r").Text) final $($ss.Range("D$r").Text) $($ss.Range("E$r").Text) $($ss.Range("F$r").Text) $($ss.Range("G$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Prelims'
  $wt = $wb.Worksheets.Item(2); $wt.Name = 'Timetable'
  MarkSheet $ws 'Phumlani Secondary - Grade 12A CAT prelims' $pupilsA

  # The exam timetable (IEB: CHOOSE): a session code 1, 2 or 3 for each paper.
  $wt.Range('A1').Formula = 'Prelim timetable - Grade 12'
  Fill12 $wt @(
    @('Paper', 'Date', 'Session code', 'Session'),
    @('CAT Paper 1', '2026/08/17', 1), @('Mathematics P1', '2026/08/18', 1), @('English HL P2', '2026/08/18', 3),
    @('Life Sciences P1', '2026/08/19', 2), @('CAT Paper 2', '2026/08/20', 1), @('History P1', '2026/08/21', 2),
    @('Accounting', '2026/08/24', 3), @('Geography P1', '2026/08/25', 2)) 2
  $wt.Range('B3:B10').NumberFormat = 'yyyy/mm/dd'
  $wt.Range('A1').Font.Bold = $true; $wt.Range('A1').Font.Size = 14
  $wt.Range('A2:D2').Font.Bold = $true
  try { $wt.Range('A2:D2').Interior.Color = 0xF2E6D9 } catch { }
  $wt.Columns.Item('A').ColumnWidth = 18; $wt.Columns.Item('B').ColumnWidth = 12; $wt.Columns.Item('C').ColumnWidth = 13; $wt.Columns.Item('D').ColumnWidth = 12
  Fill12 $wt @(@('Code', 'Session'), @(1, 'Morning'), @(2, 'Midday'), @(3, 'Afternoon')) 2 6
  $wt.Range('F2:G2').Font.Bold = $true

  $null = $ws.Activate()
  $null = $ws.Range('I3').Select()
  ShowExcel 1600 760
  $root = $AE::FromHandle($h)
  MarkCells $ws @('E3', 'F3', 'G3', 'D3', 'E3:E14', 'I3')
  MarkHandle $ws 'E3'
  TryMark 'nameBox' $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  foreach ($tab in 'Home', 'Formulas') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }
  Dump 'home'

  # 1. The nested IF in E3: click, type, click again, fill down.
  SnapAll 'n-0'                                                     # I3 active
  $null = $ws.Range('E3').Select(); SnapAll 'n-1'                   # E3 clicked
  $ws.Range('E3').Formula2 = '=IF(D3>=80,"Distinction",IF(D3>=50,"Pass","Support"))'
  $null = $ws.Range('E4').Select(); SnapAll 'n-2'                   # Pass; E4 active
  $null = $ws.Range('E3').Select(); SnapAll 'n-3'                   # E3 again: its fill handle
  $null = $ws.Range('E3').AutoFill($ws.Range('E3:E14'), 0)
  $null = $ws.Range('E3:E14').Select(); SnapAll 'n-4'               # every result
  "results: $((3..14 | ForEach-Object { $ws.Range("E$_").Text }) -join ', ')"

  # 2. AND in F3.
  $null = $ws.Range('F3').Select(); SnapAll 'a-1'                   # F3 clicked
  $ws.Range('F3').Formula2 = '=IF(AND(B3>=70,C3>=70),"Yes","No")'
  $null = $ws.Range('F4').Select(); SnapAll 'a-2'                   # No; F4 active
  $null = $ws.Range('F3').AutoFill($ws.Range('F3:F14'), 0)

  # 3. OR in G3, then Show Formulas.
  $null = $ws.Range('G3').Select(); SnapAll 'o-1'                   # G3 clicked (F filled)
  $ws.Range('G3').Formula2 = '=IF(OR(B3<40,C3<40),"Letter","OK")'
  $null = $ws.Range('G3').AutoFill($ws.Range('G3:G14'), 0)
  $null = $ws.Range('G3').Select(); SnapAll 'o-2'                   # every column filled, G3 active
  "trip: $((3..14 | ForEach-Object { $ws.Range("F$_").Text }) -join ', ')"
  "letter: $((3..14 | ForEach-Object { $ws.Range("G$_").Text }) -join ', ')"
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  SnapAll 'o-3'                                                     # the formulas
  $xl.ActiveWindow.DisplayFormulas = $false
  Start-Sleep -Milliseconds 800

  # 4. Two broken formulas, for the "spot the mistake" figures.
  $ws.Range('E3').Formula2 = '=IF(D3>=80,Distinction,IF(D3>=50,"Pass","Support"))'
  $null = $ws.Range('E3').Select()
  SnapAll 'e-1'                                                     # #NAME? - no quotes round Distinction
  $ws.Range('E3').Formula2 = '=IF(D3>=50,"Pass",IF(D3>=80,"Distinction","Support"))'
  $null = $ws.Range('E3').AutoFill($ws.Range('E3:E14'), 0)
  $null = $ws.Range('E4').Select()
  SnapAll 'e-2'                                                     # the wrong order: Imran's 86 says Pass
  $ws.Range('E3').Formula2 = '=IF(D3>=80,"Distinction",IF(D3>=50,"Pass","Support"))'
  $null = $ws.Range('E3').AutoFill($ws.Range('E3:E14'), 0)

  # 5. The Formulas tab: the Logical list (a menu - drawn with the others).
  $null = $ws.Range('E3').Select()
  try {
    Tab 'Formulas'
    Dump 'formulas'
    TryMark 'btnLogical' $root @('Logical') $T::MenuItem
    TryMark 'btnShowFormulas' $root @('Show Formulas')
    SnapAll 'f-1'
    $logical = Find $root @('Logical') $T::MenuItem -tries 6
    Expand $logical; WaitOthers
    DumpOthers 'logical'
    MarkAny 'itemIF' @('IF')
    MarkAny 'itemAND' @('AND')
    SnapAll 'f-2' -Others                                           # the Logical list open
    Collapse $logical
    if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
    Tab 'Home'
  } catch { "formulas tab: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }

  # 6. IEB: CHOOSE on the timetable.
  $null = $wt.Activate()
  $null = $wt.Range('F8').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wt @('D3', 'C3', 'D3:D10') 'tt'
  MarkHandle $wt 'D3' 'ttfillD3'
  SnapAll 'c-1'                                                     # the timetable, F8 active
  $null = $wt.Range('D3').Select(); SnapAll 'c-2'                   # D3 clicked
  $wt.Range('D3').Formula2 = '=CHOOSE(C3,"Morning","Midday","Afternoon")'
  $null = $wt.Range('D3').AutoFill($wt.Range('D3:D10'), 0)
  $null = $wt.Range('D3:D10').Select(); SnapAll 'c-3'               # every session
  "sessions: $((3..10 | ForEach-Object { $wt.Range("D$_").Text }) -join ', ')"

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
