# Done-right copies of four catexcel uploads whose checks grew on 9 October 2026
# (the reader now reads validation messages, axis titles and page setup), made
# by real Excel 365 in the CAT VM from work\cxin-*.xlsx (the old done copies and
# the MarkBook11 starter): SportsDay-done (the grade rule's input message and a
# Stop alert), BakerySales-done (the Report sheet's line chart: both axis
# titles), Orders-done (Landscape, Narrow margins), MarkBook11-done (new: the
# printoptions task done). Saved by Excel in C:\sims\files\<name>\.
#     pwsh -File vm-shots.ps1 catexcel-done-fixes
$Name = 'catexcel-done-fixes'
$dir = "C:\sims\files\$Name"
$work = Join-Path $PSScriptRoot 'work'
New-Item -ItemType Directory -Force $dir | Out-Null
$job = Start-Job -ArgumentList $dir, $work {
  param($dir, $work)
  $ErrorActionPreference = 'Stop'
  $xl = New-Object -ComObject Excel.Application
  $xl.DisplayAlerts = $false
  function Open ($n) { $xl.Workbooks.Open((Join-Path $work "cxin-$n.xlsx")) }
  function Save ($wb, $n) { $wb.SaveAs((Join-Path $dir "$n.xlsx"), 51); $wb.Close($false); "  saved $n.xlsx" }
  try {
    "--- SportsDay-done"
    $wb = Open 'SportsDay-done'
    $v = $wb.Worksheets.Item('Entries').Range('B3:B40').Validation
    $t = $v.Type; $op = $v.Operator; $f1 = $v.Formula1; $f2 = $v.Formula2
    "  rule was: type $t, operator $op, $f1 - $f2, alert $($v.AlertStyle)"
    $v.Delete()
    $v.Add($t, 1, $op, $f1, $f2)                                  # AlertStyle 1: Stop
    $v.InputTitle = 'Grade'; $v.InputMessage = 'Type a grade from 8 to 12.'; $v.ShowInput = $true
    $v.ErrorTitle = 'Not a grade'; $v.ErrorMessage = 'The grade must be a whole number from 8 to 12.'; $v.ShowError = $true
    Save $wb 'SportsDay-done'

    "--- BakerySales-done"
    $wb = Open 'BakerySales-done'
    $ws = $wb.Worksheets.Item('Report')
    foreach ($co in $ws.ChartObjects()) {
      $c = $co.Chart
      if ($c.ChartType -in 4, 65) {                                   # xlLine, xlLineMarkers
        $c.Axes(1).HasTitle = $true; $c.Axes(1).AxisTitle.Text = 'Month'
        $c.Axes(2).HasTitle = $true; $c.Axes(2).AxisTitle.Text = 'Items sold'
        "  axis titles on $($co.Name)"
      }
    }
    Save $wb 'BakerySales-done'

    "--- Orders-done"
    $wb = Open 'Orders-done'
    $ps = $wb.Worksheets.Item('Order').PageSetup
    $ps.Orientation = 2
    $ps.LeftMargin = $xl.CentimetersToPoints(0.64); $ps.RightMargin = $xl.CentimetersToPoints(0.64)
    $ps.TopMargin = $xl.CentimetersToPoints(1.91); $ps.BottomMargin = $xl.CentimetersToPoints(1.91)
    $ps.HeaderMargin = $xl.CentimetersToPoints(0.76); $ps.FooterMargin = $xl.CentimetersToPoints(0.76)
    Save $wb 'Orders-done'

    "--- MarkBook11-done"
    $wb = Open 'MarkBook11'
    $a = $wb.Worksheets.Item('11A')
    $a.PageSetup.Zoom = $false; $a.PageSetup.FitToPagesWide = 1; $a.PageSetup.FitToPagesTall = $false
    $a.PageSetup.PrintTitleRows = '$2:$2'
    [void]$a.HPageBreaks.Add($a.Range('A39'))
    $wb.Worksheets.Item('11B').PageSetup.PrintArea = '$A$1:$M$42'
    foreach ($s in '11A', '11B', '11C') { $wb.Worksheets.Item($s).PageSetup.PrintGridlines = $true }
    Save $wb 'MarkBook11-done'
    'done'
  } finally {
    foreach ($b in @($xl.Workbooks)) { try { $b.Close($false) } catch { } }
    $xl.Quit()
  }
}
if (Wait-Job $job -Timeout 400) { Receive-Job $job } else { Stop-Job $job; Receive-Job $job; Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force; 'FAILED: Excel hung' }
Remove-Job $job -Force
Get-ChildItem $dir | ForEach-Object { "  $($_.Name) $($_.Length)" }
