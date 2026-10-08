# Real PowerPoint 365 screens for Presentations lesson 3, "Tables, charts and
# pictures" (AIPascalCourse/content/catpowerpoint/objects.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Mr Botha's bakery
# slides; out\catpowerpoint-objects.json says where things are (window
# pixels). Runs in the CAT VM only (dialogs and galleries use the real mouse
# and keys - work\catpowerpoint-kit.ps1):
#     pwsh -File vm-shots.ps1 catpowerpoint-objects
# Then: python cat-crop.py catpowerpoint-objects
# It also makes the starter Bakery.pptx and a done-right copy
# Bakery-done.pptx in C:\sims\files\<name>\, and the starter in
# G:\My Drive\CAT\PowerPoint\.
$Name = 'catpowerpoint-objects'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')

$files = "C:\sims\files\$Name"
$cloud = 'G:\My Drive\CAT\PowerPoint'
New-Item -ItemType Directory -Force $files | Out-Null

function ShapeBox($shape) {
  $w = $pp.ActiveWindow
  $x1 = $w.PointsToScreenPixelsX($shape.Left); $x2 = $w.PointsToScreenPixelsX($shape.Left + $shape.Width)
  $y1 = $w.PointsToScreenPixelsY($shape.Top);  $y2 = $w.PointsToScreenPixelsY($shape.Top + $shape.Height)
  $win = [WinRect]::Of($h)
  return @(($x1 - $win[0]), ($y1 - $win[1]), ($x2 - $x1), ($y2 - $y1))
}
# Click a dialog control (anywhere on the screen) by name, and mark it.
function DialogClick([string]$key, [string[]]$names, $type = $null) {
  $e = FindAnywhere $names $type -tries 12
  Mark $key (Box $e)
  RealClick (Box $e)
}
# Select all in the focused box and type a value.
function DialogType([string]$text) { RealKey 0x41 -Ctrl; RealType $text }

$prices = @(@('Item', 'Price'), @('Bread', 'R18'), @('Milk tart', 'R25'), @('Koeksisters (6)', 'R30'))

try {
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11
  $null = AddSlide 'Title Slide' @('Botha''s Bakery', 'Fresh every morning in Centurion')
  $s2 = AddSlide 'Title and Content' @('This week''s prices')
  $s3 = AddSlide 'Title and Content' @('Loaves sold this week')
  $s4 = AddSlide 'Title Only' @('New: rusks!')
  $s5 = AddSlide 'Title Only' @('From flour to your table')
  $s2 = $pres.Slides.Item(2); $s3 = $pres.Slides.Item(3); $s4 = $pres.Slides.Item(4); $s5 = $pres.Slides.Item(5)
  $pp.ActiveWindow.Selection.Unselect()

  # 1. A table from the placeholder's icon: 2 columns, 4 rows.
  GoTo 2
  $pp.ActiveWindow.Selection.Unselect()
  Mark 'contentPh' (ShapeBox $s2.Shapes.Placeholders.Item(2))
  DumpAll 'slide2'
  # The placeholder's six icons are not in UI Automation: their places are read off the picture (window pixels).
  $iconTable = @(970, 565, 41, 41); $iconChart = @(1025, 565, 41, 41)
  Mark 'iconTable' $iconTable; Mark 'iconChart' $iconChart
  Snap 'tb-1'
  RealClick $iconTable
  Start-Sleep -Milliseconds 1500
  DumpAll 'tabledialog'
  try { Mark 'cols' (Box (FindAnywhere @('Number of columns:', 'Number of columns') $T::Edit -tries 6)) } catch { '  MISSING cols' }
  try { Mark 'rows' (Box (FindAnywhere @('Number of rows:', 'Number of rows') $T::Edit -tries 4)) } catch { '  MISSING rows' }
  try { Mark 'tableOK' (Box (FindAnywhere @('OK') $T::Button -tries 4)) } catch { '  MISSING tableOK' }
  Grab 'tb-2'                                                    # the Insert Table box: 5 columns, 2 rows
  if ($script:marks.Contains('cols')) {
    DialogType '2'
    Grab 'tb-3'
    RealKey 0x09; DialogType '4'
    Grab 'tb-4'
    RealKey 0x1B                                                 # cancel; the table is made through COM
  } else { '  NO Insert Table box - nothing typed' }
  Start-Sleep -Milliseconds 800
  $ph2 = $s2.Shapes.Placeholders.Item(2)
  $null = $s2.Shapes.AddTable(4, 2, $ph2.Left, $ph2.Top, $ph2.Width, 200); $tblShape = @($s2.Shapes | Where-Object { $_.HasTable })[0]
  GoTo 2
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'tb-5'                                                    # the empty table
  for ($r = 1; $r -le 4; $r++) { for ($c = 1; $c -le 2; $c++) { $tblShape.Table.Cell($r, $c).Shape.TextFrame.TextRange.Text = $prices[$r - 1][$c - 1] } }
  Snap 'tb-6'                                                    # filled in

  # 2. A chart from the placeholder's icon: Insert Chart, Pie, OK.
  GoTo 3
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'ch-1'
  RealClick $iconChart
  Start-Sleep -Milliseconds 2500
  DumpAll 'chartdialog'
  try { Mark 'pie' (Box (FindAnywhere @('Pie') $T::ListItem -tries 6)) } catch { '  MISSING pie' }
  try { Mark 'columnCat' (Box (FindAnywhere @('Column') $T::ListItem -tries 4)) } catch { '  MISSING columnCat' }
  Grab 'ch-2'                                                    # the Insert Chart box, Column chosen
  try { RealClick (Box (FindAnywhere @('Pie') $T::ListItem -tries 4)); Start-Sleep -Milliseconds 1200 } catch { }
  try { Mark 'chartOK' (Box (FindAnywhere @('OK') $T::Button -tries 4)) } catch { '  MISSING chartOK' }
  Grab 'ch-3'                                                    # Pie chosen
  RealKey 0x1B
  Start-Sleep -Milliseconds 800
  if ([PPWin]::Find([Shot]::Pid($h), 'Insert Chart') -ne [IntPtr]::Zero) { RealKey 0x1B }
  Start-Sleep -Milliseconds 800
  # The chart itself through COM, with Mr Botha's numbers (no data window on the picture).
  $ph = $s3.Shapes.Placeholders.Item(2)
  $ch = $s3.Shapes.AddChart2(-1, 5, $ph.Left, $ph.Top, $ph.Width, $ph.Height); $ch = @($s3.Shapes | Where-Object { $_.HasChart })[0]   # xlPie
  $wb = $ch.Chart.ChartData.Workbook
  $ws = $wb.Worksheets.Item(1)
  $data = @(@('', 'Loaves'), @('White', '120'), @('Brown', '85'), @('Whole wheat', '40'), @('Rye', '15'))
  for ($r = 0; $r -lt $data.Count; $r++) { for ($c = 0; $c -lt 2; $c++) { $ws.Cells.Item($r + 1, $c + 1).Formula = [string]$data[$r][$c] } }
  $ws.ListObjects.Item(1).Resize($ws.Range('A1:B5'))
  $ch.Chart.ChartTitle.Text = 'Loaves sold this week'
  $wb.Close()
  GoTo 3
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'ch-4'                                                    # the pie chart

  # 3. A shape: Insert > Shapes > a star.
  GoTo 4
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'sh-1'
  Press (Find $root @('Insert') $T::TabItem); Start-Sleep -Milliseconds 1200
  Dump 'insert'
  foreach ($n in 'Pictures', 'Shapes', 'SmartArt', 'Chart', 'Table', 'Icons', 'Video', 'Audio', 'Text Box', 'Header & Footer', 'Slide Number', 'Link', 'Action') { TryMark "ins $n" $root @($n) }
  Snap 'sh-2'                                                    # the Insert tab
  try { OpenMenu (Find $root @('Shapes') -tries 4) } catch { }
  DumpAll 'shapes'
  try { Mark 'star' (Box (FindAnywhere @('Star: 5 Points') -tries 6)) } catch { '  MISSING star' }
  Grab 'sh-3'                                                    # the Shapes gallery
  RealKey 0x1B
  Start-Sleep -Milliseconds 800
  $star = $s4.Shapes.AddShape(92, 520, 170, 220, 210)            # msoShape5pointStar
  $star.TextFrame.TextRange.Text = 'New!'
  $star.TextFrame.TextRange.Font.Size = 32
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'sh-4'                                                    # the star, with New! in it

  # The Pictures menu, for a figure.
  try { OpenMenu (Find $root @('Pictures') -tries 4); DumpAll 'pictures'; Grab 'pic-1'; RealKey 0x1B } catch { '  no Pictures menu' }
  Start-Sleep -Milliseconds 800

  # 4. SmartArt: Insert > SmartArt > Process > Basic Process > OK.
  GoTo 5
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'sa-1'                                                    # Insert tab, slide 5
  try { OpenDialog (Find $root @('SmartArt...', 'SmartArt') -tries 4); Start-Sleep -Milliseconds 800 } catch { }
  DumpAll 'smartart'
  try { Mark 'process' (Box (FindAnywhere @('Process') $T::ListItem -tries 8)) } catch { '  MISSING process' }
  Grab 'sa-2'                                                    # the dialog, All chosen
  try { RealClick (Box (FindAnywhere @('Process') $T::ListItem -tries 4)); Start-Sleep -Milliseconds 1500 } catch { }
  DumpAll 'smartart2'
  try { Mark 'basicProcess' (Box (FindAnywhere @('Basic Process') -tries 6)) } catch { '  MISSING basicProcess' }
  Grab 'sa-3'                                                    # Process chosen
  try { RealClick (Box (FindAnywhere @('Basic Process') -tries 4)); Start-Sleep -Milliseconds 1000 } catch { }
  try { Mark 'smartOK' (Box (FindAnywhere @('OK') $T::Button -tries 4)) } catch { '  MISSING smartOK' }
  Grab 'sa-4'                                                    # Basic Process chosen
  RealKey 0x1B
  Start-Sleep -Milliseconds 800
  $layoutSA = $null
  foreach ($l in $pp.SmartArtLayouts) { if ($l.Name -eq 'Basic Process') { $layoutSA = $l; break } }
  if ($layoutSA) {
    $sa = $s5.Shapes.AddSmartArt($layoutSA, 80, 160, 800, 300)
    $words = @('Mix the dough', 'Bake at 05:00', 'Sell it warm')
    for ($i = 1; $i -le 3; $i++) { $sa.SmartArt.AllNodes.Item($i).TextFrame2.TextRange.Text = $words[$i - 1] }
  }
  GoTo 5
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'sa-5'
  Press (Find $root @('Home') $T::TabItem)

  SaveMarks

  # ---- The starter and a done-right copy.
  $st = $pp.Presentations.Add(-1)
  $lay = { param($n) $st.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq $n } | Select-Object -First 1 }
  $s = $st.Slides.AddSlide(1, (& $lay 'Title Slide'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Botha''s Bakery'
  $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = 'Fresh every morning in Centurion'
  $s = $st.Slides.AddSlide(2, (& $lay 'Title and Content'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'This week''s prices'
  $s = $st.Slides.AddSlide(3, (& $lay 'Title and Content'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Loaves sold this week'
  $st.SaveAs((Join-Path $files 'Bakery.pptx'), 24)
  $s2b = $st.Slides.Item(2)
  $p2 = $s2b.Shapes.Placeholders.Item(2)
  $t = $s2b.Shapes.AddTable(4, 2, $p2.Left, $p2.Top, $p2.Width, 200); $t = @($s2b.Shapes | Where-Object { $_.HasTable })[0]
  for ($r = 1; $r -le 4; $r++) { for ($c = 1; $c -le 2; $c++) { $t.Table.Cell($r, $c).Shape.TextFrame.TextRange.Text = $prices[$r - 1][$c - 1] } }
  $s3b = $st.Slides.Item(3)
  $p3 = $s3b.Shapes.Placeholders.Item(2)
  $c3 = $s3b.Shapes.AddChart2(-1, 5, $p3.Left, $p3.Top, $p3.Width, $p3.Height); $c3 = @($s3b.Shapes | Where-Object { $_.HasChart })[0]
  $wb = $c3.Chart.ChartData.Workbook; $ws = $wb.Worksheets.Item(1)
  for ($r = 0; $r -lt $data.Count; $r++) { for ($c = 0; $c -lt 2; $c++) { $ws.Cells.Item($r + 1, $c + 1).Formula = [string]$data[$r][$c] } }
  $ws.ListObjects.Item(1).Resize($ws.Range('A1:B5')); $wb.Close()
  $st.SaveAs((Join-Path $files 'Bakery-done.pptx'), 24)
  $st.Close()
  if (Test-Path 'G:\My Drive') { New-Item -ItemType Directory -Force $cloud | Out-Null; Copy-Item (Join-Path $files 'Bakery.pptx') $cloud -Force; "starter -> $cloud" }
}
catch { "FAILED: $_"; throw }
finally { ClosePowerPoint }
