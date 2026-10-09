# Real Excel 365 screens for catexcel Grade 12, Text functions
# (AIPascalCourse/content/catexcel/text.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Phumlani Secondary's
# matric yearbook list: joining names with & (and CONCATENATE), LEFT for an
# initial, MID for the grade inside a pupil number, RIGHT and VALUE for its
# number, FIND for the @ in an e-mail address, LEFT with FIND for the
# username, RIGHT with LEN and FIND for the domain, and (IEB) SUBSTITUTE for
# a cell number without spaces. Also makes the pupils' starter file
# Yearbook.xlsx (and a done-right copy) in C:\sims\files\catexcel-text\ and
# G:\My Drive\CAT\Excel\. Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-text        (from the host)
$Name = 'catexcel-text'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Heads ($ws, $cols) {
  $last = [string][char](64 + $cols)
  $ws.Range("A1:$($last)1").Font.Bold = $true
  try { $ws.Range("A1:$($last)1").Interior.Color = 0xF2E6D9 } catch { }
}

function YearbookBook ($book, $people) {
  while ($book.Worksheets.Count -lt 2) { $null = $book.Worksheets.Add([Type]::Missing, $book.Worksheets.Item($book.Worksheets.Count)) }
  $wn = $book.Worksheets.Item(1); $wn.Name = 'Names'
  $wc = $book.Worksheets.Item(2); $wc.Name = 'Contacts'
  Fill12 $wn @(,@('Surname', 'First name', 'Pupil no.', 'Full name', 'Short name', 'Grade', 'Number')) 1
  Fill12 $wc @(,@('Full name', 'E-mail', 'Cell', 'Username', 'Domain', 'Cell (no spaces)')) 1
  $r = 2
  foreach ($p in $people) {
    $wn.Range("A$r").Formula = $p[0]; $wn.Range("B$r").Formula = $p[1]
    $wn.Range("C$r").NumberFormat = '@'; $wn.Range("C$r").Formula = $p[2]
    $wc.Range("A$r").Formula = "$($p[1]) $($p[0])"; $wc.Range("B$r").Formula = $p[3]
    $wc.Range("C$r").NumberFormat = '@'; $wc.Range("C$r").Formula = $p[4]
    $r++
  }
  Heads $wn 7; Heads $wc 6
  $wn.Columns.Item('A').ColumnWidth = 12; $wn.Columns.Item('B').ColumnWidth = 11; $wn.Columns.Item('C').ColumnWidth = 11
  $wn.Columns.Item('D').ColumnWidth = 19; $wn.Columns.Item('E').ColumnWidth = 14; $wn.Columns.Item('F').ColumnWidth = 7; $wn.Columns.Item('G').ColumnWidth = 8
  $wc.Columns.Item('A').ColumnWidth = 17; $wc.Columns.Item('B').ColumnWidth = 30; $wc.Columns.Item('C').ColumnWidth = 13
  $wc.Columns.Item('D').ColumnWidth = 16; $wc.Columns.Item('E').ColumnWidth = 16; $wc.Columns.Item('F').ColumnWidth = 15
  return $wn
}

$peopleA = @(
  @('Khumalo', 'Zanele', 'PS12-0417', 'zanele.khumalo@mymail.co.za', '082 555 0143'),
  @('Pillay', 'Imran', 'PS12-0388', 'imranp@webpost.co.za', '073 555 2210'),
  @('Mahlangu', 'Gift', 'PS12-1052', 'gift.mahlangu@mymail.co.za', '061 555 8790'),
  @('Adams', 'Chloe', 'PS12-0076', 'chloe.adams@capemail.co.za', '084 555 3301'),
  @('Dlamini', 'Bongani', 'PS12-0923', 'bdlamini@webpost.co.za', '071 555 4456'),
  @('Patel', 'Fatima', 'PS12-0154', 'fatima.patel@mymail.co.za', '083 555 7788'),
  @('Sithole', 'Mpho', 'PS12-1101', 'mpho.s@webpost.co.za', '076 555 1029'),
  @('Jacobs', 'Tamsin', 'PS12-0640', 'tamsinj@capemail.co.za', '082 555 6612'),
  @('Zulu', 'Lindiwe', 'PS12-0815', 'lindiwe.zulu@mymail.co.za', '060 555 3345'),
  @('Botha', 'Owen', 'PS12-0299', 'owen.botha@webpost.co.za', '079 555 9001'),
  @('Molefe', 'Kagiso', 'PS12-0731', 'kmolefe@mymail.co.za', '081 555 2468'),
  @('Fourie', 'Carmen', 'PS12-0502', 'carmen.fourie@capemail.co.za', '072 555 1357'))

$peopleB = @(
  @('Ngcobo', 'Busisiwe', 'PS12-1204', 'busi.ngcobo@mymail.co.za', '082 555 0101'),
  @('Coetzee', 'Riaan', 'PS12-0333', 'riaanc@webpost.co.za', '083 555 0202'),
  @('Shabalala', 'Naledi', 'PS12-0790', 'naledi.shabalala@mymail.co.za', '071 555 0303'),
  @('Naidoo', 'Jason', 'PS12-0048', 'jnaidoo@capemail.co.za', '084 555 0404'),
  @('Mokoena', 'Palesa', 'PS12-0561', 'palesa.m@webpost.co.za', '072 555 0505'),
  @('September', 'Ethan', 'PS12-1119', 'ethan.september@mymail.co.za', '073 555 0606'),
  @('Mabaso', 'Sizwe', 'PS12-0275', 'sizwe.mabaso@webpost.co.za', '076 555 0707'),
  @('Joubert', 'Megan', 'PS12-0866', 'meganj@capemail.co.za', '061 555 0808'),
  @('Moosa', 'Aisha', 'PS12-0412', 'aisha.moosa@mymail.co.za', '079 555 0909'),
  @('Kruger', 'Johan', 'PS12-0958', 'johan.kruger@webpost.co.za', '082 555 1010'),
  @('Zwane', 'Nomvula', 'PS12-0137', 'nzwane@mymail.co.za', '083 555 1111'),
  @('Pretorius', 'Liam', 'PS12-0620', 'liam.p@capemail.co.za', '071 555 1212'),
  @('Mkhize', 'Thandeka', 'PS12-1033', 'thandeka.mkhize@webpost.co.za', '084 555 1313'),
  @('Abrahams', 'Kyle', 'PS12-0209', 'kyle.abrahams@mymail.co.za', '072 555 1414'),
  @('Baloyi', 'Precious', 'PS12-0744', 'pbaloyi@webpost.co.za', '073 555 1515'),
  @('Steyn', 'Ruan', 'PS12-0381', 'ruan.steyn@capemail.co.za', '076 555 1616'),
  @('Hadebe', 'Zinhle', 'PS12-0899', 'zinhle.h@mymail.co.za', '061 555 1717'),
  @('Ferreira', 'Daniel', 'PS12-0016', 'daniel.ferreira@webpost.co.za', '079 555 1818'),
  @('Mofokeng', 'Lerato', 'PS12-0577', 'lerato.mofokeng@mymail.co.za', '082 555 1919'),
  @('Ntuli', 'Siyabonga', 'PS12-1186', 'siya.ntuli@capemail.co.za', '083 555 2020'))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $sn = YearbookBook $sb $peopleB
  $sn.Range('F22').Formula = 'Total'
  $sn.Range('G22').Formula2 = '=SUM(G2:G21)'
  $sn.Range('F22').Font.Bold = $true
  $null = $sn.Activate(); $null = $sn.Range('A1').Select()
  SaveStarter $sb 'Yearbook.xlsx'
  $sc = $sb.Worksheets.Item('Contacts')
  for ($r = 2; $r -le 21; $r++) {
    $sn.Range("D$r").Formula2 = "=B$r&"" ""&A$r"
    $sn.Range("E$r").Formula2 = "=LEFT(B$r,1)&"". ""&A$r"
    $sn.Range("F$r").Formula2 = "=VALUE(MID(C$r,3,2))"
    $sn.Range("G$r").Formula2 = "=VALUE(RIGHT(C$r,4))"
    $sc.Range("D$r").Formula2 = "=LEFT(B$r,FIND(""@"",B$r)-1)"
    $sc.Range("E$r").Formula2 = "=RIGHT(B$r,LEN(B$r)-FIND(""@"",B$r))"
    $sc.Range("F$r").Formula2 = "=SUBSTITUTE(C$r,"" "","""")"
  }
  $sb.SaveAs((Join-Path $filesDir 'Yearbook-done.xlsx'), 51)
  foreach ($r in 2, 3, 11, 21) { "  done row $($r): $($sn.Range("D$r").Text) | $($sn.Range("E$r").Text) | $($sn.Range("F$r").Text) | $($sn.Range("G$r").Text) | $($sc.Range("D$r").Text) | $($sc.Range("E$r").Text) | $($sc.Range("F$r").Text)" }
  "  done total G22: $($sn.Range('G22').Text)"
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $wn = YearbookBook $wb $peopleA
  $wc = $wb.Worksheets.Item('Contacts')
  $null = $wn.Activate()
  $null = $wn.Range('I2').Select()
  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $wn @('D2', 'E2', 'F2', 'G2', 'I2', 'C2')
  MarkHandle $wn 'D2'
  TryMark 'formulaBar' $root @('Formula Bar')
  Dump 'home'

  # 1. Joining: D2 =B2&" "&A2, then fill down.
  SnapAll 'j-0'                                                     # I2 active
  $null = $wn.Range('D2').Select(); SnapAll 'j-1'                   # D2 clicked
  $wn.Range('D2').Formula2 = '=B2&" "&A2'
  $null = $wn.Range('D3').Select(); SnapAll 'j-2'                   # Zanele Khumalo; D3 active
  $null = $wn.Range('D2').Select(); SnapAll 'j-3'                   # D2 again: the fill handle
  $null = $wn.Range('D2').AutoFill($wn.Range('D2:D13'), 0)
  $null = $wn.Range('D2:D13').Select(); SnapAll 'j-4'               # every full name

  # 2. LEFT: E2 =LEFT(B2,1)&". "&A2.
  $null = $wn.Range('E2').Select(); SnapAll 'l-1'                   # E2 clicked
  $wn.Range('E2').Formula2 = '=LEFT(B2,1)&". "&A2'
  $null = $wn.Range('E2').AutoFill($wn.Range('E2:E13'), 0)
  # 3. MID: F2 =MID(C2,3,2) - text "12", sitting on the left.
  $null = $wn.Range('F2').Select(); SnapAll 'l-2'                   # F2 clicked, E filled
  $wn.Range('F2').Formula2 = '=MID(C2,3,2)'
  $null = $wn.Range('F2').AutoFill($wn.Range('F2:F13'), 0)
  $null = $wn.Range('G2').Select(); SnapAll 'l-3'                   # the grades as text (left), G2 active
  # 4. RIGHT on its own, then VALUE round it.
  $wn.Range('G2').Formula2 = '=RIGHT(C2,4)'
  $null = $wn.Range('G2').AutoFill($wn.Range('G2:G13'), 0)
  $wn.Range('F15').Formula = 'Total'; $wn.Range('G15').Formula2 = '=SUM(G2:G13)'; $wn.Range('F15').Font.Bold = $true
  $null = $wn.Range('G15').Select(); SnapAll 'l-4'                  # 0417 on the left; the total is 0
  "RIGHT total: $($wn.Range('G15').Text)"
  $null = $wn.Range('G2').Select(); SnapAll 'l-5'                   # G2 clicked again
  $wn.Range('G2').Formula2 = '=VALUE(RIGHT(C2,4))'
  $null = $wn.Range('G2').AutoFill($wn.Range('G2:G13'), 0)
  $wn.Range('F2').Formula2 = '=VALUE(MID(C2,3,2))'
  $null = $wn.Range('F2').AutoFill($wn.Range('F2:F13'), 0)
  $null = $wn.Range('G15').Select(); SnapAll 'l-6'                  # numbers on the right; the total adds up
  "VALUE total: $($wn.Range('G15').Text)"
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  $null = $wn.Range('D2').Select()
  SnapAll 'l-7'                                                     # the Names formulas
  $xl.ActiveWindow.DisplayFormulas = $false

  # 5. Contacts: FIND the @, the username, the domain.
  $null = $wc.Activate()
  $null = $wc.Range('H2').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wc @('B2', 'D2', 'E2', 'F2', 'H2') 'c'
  SnapAll 'f-0'                                                     # the Contacts sheet
  $null = $wc.Range('D2').Select(); SnapAll 'f-1'                   # D2 clicked
  $wc.Range('D2').Formula2 = '=FIND("@",B2)'
  $null = $wc.Range('D3').Select(); SnapAll 'f-2'                   # 15; D3 active
  "find: $($wc.Range('D2').Text)"
  $null = $wc.Range('D2').Select(); SnapAll 'f-3'                   # D2 again, to change it
  $wc.Range('D2').Formula2 = '=LEFT(B2,FIND("@",B2)-1)'
  $null = $wc.Range('E2').Select(); SnapAll 'f-4'                   # zanele.khumalo; E2 active
  $wc.Range('E2').Formula2 = '=RIGHT(B2,LEN(B2)-FIND("@",B2))'
  $null = $wc.Range('D2:E2').AutoFill($wc.Range('D2:E13'), 0)
  $null = $wc.Range('F2').Select(); SnapAll 'f-5'                   # usernames and domains; F2 active
  "user: $($wc.Range('D2').Text), domain: $($wc.Range('E2').Text), len: $($wc.Range('B2').Text.Length)"

  # 6. IEB: SUBSTITUTE.
  $wc.Range('F2').Formula2 = '=SUBSTITUTE(C2," ","")'
  $null = $wc.Range('F2').AutoFill($wc.Range('F2:F13'), 0)
  $null = $wc.Range('F2').Select(); SnapAll 's-1'                   # cell numbers with no spaces

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
