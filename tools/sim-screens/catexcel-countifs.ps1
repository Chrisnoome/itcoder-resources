# Real Excel 365 screens for catexcel Grade 12, COUNTIFS, SUMIFS and
# rounding (AIPascalCourse/content/catexcel/countifs.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Phumlani Secondary's
# matric farewell tickets: COUNTIFS and SUMIFS with two conditions, the
# Function Arguments box for COUNTIFS, ROUNDUP for tables and buses,
# ROUNDDOWN to whole R100s, and (IEB) INT for the full tables. Also makes
# the pupils' starter file FarewellTickets.xlsx (and a done-right copy) in
# C:\sims\files\catexcel-countifs\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-countifs        (from the host)
$Name = 'catexcel-countifs'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

# Name, class, ticket, paid. Amount and guests come from the ticket: Single R350 / 1, Couple R600 / 2.
function TicketSheet ($ws, $title, $rows) {
  $ws.Range('A1').Formula = $title
  Fill12 $ws @(,@('Name', 'Class', 'Ticket', 'Paid', 'Amount (R)', 'Guests')) 3
  $r = 4
  foreach ($t in $rows) {
    Fill12 $ws @(,@($t[0], $t[1], $t[2], $t[3], $(if ($t[2] -eq 'Single') { 350 } else { 600 }), $(if ($t[2] -eq 'Single') { 1 } else { 2 }))) $r
    $r++
  }
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  $ws.Range('A3:F3').Font.Bold = $true
  try { $ws.Range('A3:F3').Interior.Color = 0xF2E6D9 } catch { }
  $ws.Columns.Item('A').ColumnWidth = 18
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 8 }
  $ws.Columns.Item('E').ColumnWidth = 11; $ws.Columns.Item('F').ColumnWidth = 8
  $ws.Columns.Item('G').ColumnWidth = 3
}

$ticketsA = @(
  @('Imran Pillay', '12A', 'Couple', 'Yes'), @('Zanele Khumalo', '12A', 'Single', 'Yes'), @('Gift Mahlangu', '12B', 'Single', 'No'),
  @('Chloe Adams', '12A', 'Couple', 'No'), @('Bongani Dlamini', '12C', 'Single', 'Yes'), @('Fatima Patel', '12B', 'Couple', 'Yes'),
  @('Mpho Sithole', '12C', 'Couple', 'No'), @('Tamsin Jacobs', '12A', 'Single', 'Yes'), @('Lindiwe Zulu', '12B', 'Single', 'Yes'),
  @('Owen Botha', '12C', 'Couple', 'Yes'), @('Kagiso Molefe', '12B', 'Couple', 'No'), @('Carmen Fourie', '12A', 'Single', 'No'),
  @('Sibusiso Khoza', '12C', 'Single', 'Yes'), @('Annelie van Wyk', '12B', 'Single', 'Yes'), @('Nandi Mthembu', '12A', 'Couple', 'Yes'),
  @('Graham Peters', '12C', 'Single', 'No'), @('Thulani Radebe', '12B', 'Couple', 'Yes'), @('Kavitha Govender', '12A', 'Single', 'Yes'),
  @('Andile Cele', '12C', 'Couple', 'Yes'), @('Ayesha Davids', '12B', 'Single', 'No'), @('Lungile Nkosi', '12A', 'Single', 'Yes'),
  @('Pieter Swart', '12C', 'Single', 'Yes'), @('Refilwe Maseko', '12B', 'Couple', 'Yes'), @('Yusuf Hendricks', '12C', 'Single', 'No'))

# The upload: 40 tickets, four classes.
$names = @('Busisiwe Ngcobo', 'Riaan Coetzee', 'Naledi Shabalala', 'Jason Naidoo', 'Palesa Mokoena', 'Ethan September', 'Sizwe Mabaso',
  'Megan Joubert', 'Tumelo Ramaphosa', 'Aisha Moosa', 'Johan Kruger', 'Nomvula Zwane', 'Liam Pretorius', 'Thandeka Mkhize', 'Kyle Abrahams',
  'Precious Baloyi', 'Ruan Steyn', 'Zinhle Hadebe', 'Daniel Ferreira', 'Lerato Mofokeng', 'Siyabonga Ntuli', 'Hannah Visser',
  'Kamogelo Tau', 'Ravi Moodley', 'Amahle Dube', 'Christo Louw', 'Boitumelo Sello', 'Nadia Isaacs', 'Lwazi Gumede', 'Jessica Kemp',
  'Tshepo Modise', 'Shireen Adams', 'Mandla Shezi', 'Elize du Toit', 'Karabo Phiri', 'Tariq Salie', 'Ntombi Zondi', 'Wian Nel',
  'Lesedi Motaung', 'Yolanda Williams')
$classes = @('12A', '12B', '12C', '12D')
$ticketsB = @()
for ($i = 0; $i -lt 40; $i++) {
  $cls = $classes[($i * 3 + [int]($i / 5)) % 4]
  $kind = $(if (($i % 3) -eq 1) { 'Couple' } else { 'Single' })
  $paid = $(if (($i % 4) -eq 2 -or ($i % 7) -eq 5) { 'No' } else { 'Yes' })
  $ticketsB += ,@($names[$i], $cls, $kind, $paid)
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Tickets'
  TicketSheet $ss 'Phumlani Secondary - matric farewell tickets' $ticketsB
  Fill12 $ss @(
    @('12C tickets paid', ''), @('Paid by 12A (R)', ''), @('Couple tickets not paid', ''), @('Guests', '=SUM(F4:F43)'),
    @('Tables of 10', ''), @('Minibuses of 22', ''), @('Total paid (R)', '=SUMIF(D4:D43,"Yes",E4:E43)'), @('Paid, in whole R100s', '')) 3 8
  $ss.Columns.Item('I').ColumnWidth = 22; $ss.Columns.Item('J').ColumnWidth = 10
  $ss.Range('I3:I10').Font.Bold = $true
  $null = $ss.Range('A1').Select()
  SaveStarter $sb 'FarewellTickets.xlsx'
  $ss.Range('J3').Formula2 = '=COUNTIFS(B4:B43,"12C",D4:D43,"Yes")'
  $ss.Range('J4').Formula2 = '=SUMIFS(E4:E43,B4:B43,"12A",D4:D43,"Yes")'
  $ss.Range('J5').Formula2 = '=COUNTIFS(C4:C43,"Couple",D4:D43,"No")'
  $ss.Range('J7').Formula2 = '=ROUNDUP(J6/10,0)'
  $ss.Range('J8').Formula2 = '=ROUNDUP(J6/22,0)'
  $ss.Range('J10').Formula2 = '=ROUNDDOWN(J9,-2)'
  $sb.SaveAs((Join-Path $filesDir 'FarewellTickets-done.xlsx'), 51)
  foreach ($r in 3..10) { "  done J$($r): $($ss.Range("I$r").Text) = $($ss.Range("J$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Tickets'
  TicketSheet $ws 'Phumlani Secondary - matric farewell tickets' $ticketsA
  Fill12 $ws @(
    @('12A tickets paid', ''), @('12B money paid (R)', ''), @('Couple tickets not paid', ''), @('Guests', '=SUM(F4:F27)'),
    @('Tables of 10', ''), @('Taxis of 15', ''), @('Total paid (R)', '=SUMIF(D4:D27,"Yes",E4:E27)'), @('Paid, in whole R100s', ''),
    @('Full tables (IEB)', '')) 3 7
  $ws.Columns.Item('H').ColumnWidth = 22; $ws.Columns.Item('I').ColumnWidth = 10
  $ws.Range('H3:H11').Font.Bold = $true
  $null = $ws.Range('K3').Select()

  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $ws @('I3', 'I4', 'I5', 'I7', 'I8', 'I10', 'I11', 'K3', 'B4:B27', 'D4:D27', 'E4:E27')
  TryMark 'nameBox' $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  Dump 'home'

  # 1. COUNTIFS and SUMIFS: I3, then I4 and I5 (Enter moves down).
  SnapAll 'c-0'                                                     # K3 active
  $null = $ws.Range('I3').Select(); SnapAll 'c-1'                   # I3 clicked
  $ws.Range('I3').Formula2 = '=COUNTIFS(B4:B27,"12A",D4:D27,"Yes")'
  $null = $ws.Range('I4').Select(); SnapAll 'c-2'                   # 4; I4 active
  $ws.Range('I4').Formula2 = '=SUMIFS(E4:E27,B4:B27,"12B",D4:D27,"Yes")'
  $null = $ws.Range('I5').Select(); SnapAll 'c-3'                   # I5 active
  $ws.Range('I5').Formula2 = '=COUNTIFS(C4:C27,"Couple",D4:D27,"No")'
  $null = $ws.Range('I6').Select(); SnapAll 'c-4'                   # I6 active
  "I3 $($ws.Range('I3').Text), I4 $($ws.Range('I4').Text), I5 $($ws.Range('I5').Text), guests $($ws.Range('I6').Text), paid $($ws.Range('I9').Text)"

  # 2. The Function Arguments box for COUNTIFS (Insert Function with a COUNTIFS cell selected).
  $null = $ws.Range('I3').Select()
  try {
    Tab 'Formulas'
    TryMark 'insertFunction' $root @('Insert Function...')
    TryMark 'btnMath' $root @('Math & Trig') $T::MenuItem
    SnapAll 'c-5'                                                   # the Formulas tab, I3 selected
    PressAsync (Find $root @('Insert Function...') -tries 8)
    WaitOthers
    DumpOthers 'fnargs'
    SnapAll 'c-6' -Others                                           # Function Arguments, COUNTIFS
    CloseOthers
    $math = Find $root @('Math & Trig') $T::MenuItem -tries 6
    Expand $math; WaitOthers
    DumpOthers 'math'
    MarkAny 'itemRoundup' @('ROUNDUP')
    SnapAll 'c-7' -Others                                           # the Math & Trig list
    Collapse $math
    if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
    Tab 'Home'
  } catch { "function arguments: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }

  # 3. ROUNDUP for the tables and the buses; ROUNDDOWN to whole R100s.
  $null = $ws.Range('I7').Select(); SnapAll 'r-1'                   # I7 clicked
  $ws.Range('I7').Formula2 = '=ROUNDUP(I6/10,0)'
  $null = $ws.Range('I8').Select(); SnapAll 'r-2'                   # I8 active
  $ws.Range('I8').Formula2 = '=ROUNDUP(I6/15,0)'
  $null = $ws.Range('I9').Select(); SnapAll 'r-3'                   # I9 active
  $null = $ws.Range('I10').Select(); SnapAll 'r-4'                  # I10 clicked
  $ws.Range('I10').Formula2 = '=ROUNDDOWN(I9,-2)'
  $null = $ws.Range('I11').Select(); SnapAll 'r-5'                  # I11 active
  "tables $($ws.Range('I7').Text), buses $($ws.Range('I8').Text), whole R100s $($ws.Range('I10').Text)"

  # 4. IEB: INT for the full tables.
  $ws.Range('I11').Formula2 = '=INT(I6/10)'
  $null = $ws.Range('I12').Select(); SnapAll 'i-1'                  # full tables
  "full tables $($ws.Range('I11').Text)"
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  $null = $ws.Range('I3').Select()
  SnapAll 'i-2'                                                     # every formula
  $xl.ActiveWindow.DisplayFormulas = $false

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
