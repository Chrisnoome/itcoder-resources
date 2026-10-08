# Real Excel 365 screens for catexcel lesson 7, Charts (AIPascalCourse/
# content/catexcel/charts.php - written to courses/cat-practical-writing.md,
# 8 October 2026). Botha's Bakery's sales by item for one week: a column
# chart made from the Insert tab, a title typed in, data labels from Add
# Chart Element, then Change Chart Type to a pie; a bar chart and (on a
# second sheet) a line chart for the figures. Drop-down galleries, menus and
# dialog boxes are windows of their own: SnapAll draws Excel's window and
# then each of Excel's other windows on top of it, where they are on the
# screen (PrintWindow on each - still only Excel's own drawing). Also makes
# the pupils' starter file TuckShop.xlsx (and a done-right copy) in
# C:\sims\files\catexcel-charts\ and G:\My Drive\CAT\Excel\. Read
# office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-charts        (from the host)
$Name = 'catexcel-charts'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class Comp
{
    [DllImport ("user32.dll")] static extern bool PrintWindow (IntPtr hWnd, IntPtr hdc, uint flags);
    [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr hWnd, out RECT rect);
    [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr hWnd);
    [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr hWnd, out uint pid);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr hWnd, System.Text.StringBuilder name, int size);
    delegate bool EnumProc (IntPtr hWnd, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc proc, IntPtr lParam);
    [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }

    /// Excel's other visible top-level windows, front first: "handle class x y w h" lines.
    public static List<IntPtr> Others (IntPtr main)
    {
        uint mainPid; GetWindowThreadProcessId (main, out mainPid);
        List<IntPtr> found = new List<IntPtr> ();
        EnumWindows (delegate (IntPtr h, IntPtr l) {
            uint pid; GetWindowThreadProcessId (h, out pid);
            if (pid == mainPid && h != main && IsWindowVisible (h)) { RECT r; GetWindowRect (h, out r); if (r.Right - r.Left > 4 && r.Bottom - r.Top > 4) { found.Add (h); } }
            return true; }, IntPtr.Zero);
        return found;
    }

    public static string Describe (IntPtr main)
    {
        System.Text.StringBuilder all = new System.Text.StringBuilder ();
        foreach (IntPtr h in Others (main))
        {
            RECT r; GetWindowRect (h, out r);
            System.Text.StringBuilder name = new System.Text.StringBuilder (256); GetClassName (h, name, 256);
            all.AppendLine (h + " " + name + " " + r.Left + "," + r.Top + " " + (r.Right - r.Left) + "x" + (r.Bottom - r.Top));
        }
        return all.ToString ();
    }

    [DllImport ("dwmapi.dll")] static extern int DwmGetWindowAttribute (IntPtr hWnd, int attribute, out RECT value, int size);
    [DllImport ("user32.dll")] static extern bool PostMessage (IntPtr hWnd, uint message, IntPtr wParam, IntPtr lParam);

    /// Closes a window as its X would (a dialog: the same as Cancel).
    public static void Close (IntPtr h) { PostMessage (h, 0x0010, IntPtr.Zero, IntPtr.Zero); }

    /// The window drawn by itself, cut to the part you see (a dialog's invisible border comes out black otherwise).
    static Bitmap Draw (IntPtr h, out RECT r, bool cut = true)
    {
        RECT whole; GetWindowRect (h, out whole);
        RECT seen;
        if (!cut || DwmGetWindowAttribute (h, 9, out seen, Marshal.SizeOf (typeof (RECT))) != 0) { seen = whole; }
        using (Bitmap b = new Bitmap (Math.Max (1, whole.Right - whole.Left), Math.Max (1, whole.Bottom - whole.Top), PixelFormat.Format32bppArgb))
        {
            using (Graphics g = Graphics.FromImage (b)) { IntPtr hdc = g.GetHdc (); PrintWindow (h, hdc, 2); g.ReleaseHdc (hdc); }
            r = seen;
            Rectangle part = new Rectangle (seen.Left - whole.Left, seen.Top - whole.Top, Math.Max (1, seen.Right - seen.Left), Math.Max (1, seen.Bottom - seen.Top));
            return b.Clone (part, PixelFormat.Format32bppArgb);
        }
    }

    /// The main window, then every other window of the program drawn over it (back to front).
    public static string Save (IntPtr main, string file)
    {
        RECT m;
        using (Bitmap page = Draw (main, out m, false))
        {
            using (Graphics g = Graphics.FromImage (page))
            {
                List<IntPtr> others = Others (main);
                others.Reverse ();
                foreach (IntPtr h in others)
                {
                    RECT r;
                    using (Bitmap one = Draw (h, out r)) { g.DrawImage (one, r.Left - m.Left, r.Top - m.Top); }
                }
            }
            page.Save (file, ImageFormat.Png);
            return page.Width + " x " + page.Height;
        }
    }
}
'@

function SnapAll($n, [switch]$Others) {
  Guard
  Start-Sleep -Milliseconds 1100
  if ($Others) { [void][Comp]::Save($h, (Join-Path $out "$Name-$n.png")) } else { [Shot]::Back($h); Start-Sleep -Milliseconds 300; [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png")) }
  Guard
  "picture $n" + $(if ($Others) { " (with $(@([Comp]::Others($h)).Count) other windows)" } else { '' })
}

# A control in any of Excel's windows (a drop-down's items live in a window of their own).
function FindAny([string[]]$names, $type = $null, [int]$tries = 16) {
  $procId = [Shot]::Pid($h)
  for ($try = 0; $try -lt $tries; $try++) {
    foreach ($nm in $names) {
      $cond = New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, $nm)), (New-Object $PropCond($AE::ProcessIdProperty, [int]$procId)))
      if ($type) { $cond = New-Object System.Windows.Automation.AndCondition($cond, (New-Object $PropCond($AE::ControlTypeProperty, $type))) }
      $found = $AE::RootElement.FindFirst($Scope::Descendants, $cond)
      if ($found -and -not $found.Current.IsOffscreen) { return $found }
    }
    Start-Sleep -Milliseconds 250
  }
  throw "No control called '$($names -join "' or '")'"
}

function Expand($element) {
  $pattern = $null
  if ($element.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$pattern)) { $pattern.Expand(); return }
  Press $element
}

function Collapse($element) {
  $pattern = $null
  try { if ($element.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$pattern)) { $pattern.Collapse() } } catch { }
}

# Every named control in Excel's other windows (the open drop-down or dialog), to find names.
function DumpOthers($file) {
  $win = [WinRect]::Of($h)
  $procId = [Shot]::Pid($h)
  $cond = New-Object $PropCond($AE::ProcessIdProperty, [int]$procId)
  $lines = foreach ($top in $AE::RootElement.FindAll($Scope::Children, $cond)) {
    if ([IntPtr]$top.Current.NativeWindowHandle -eq $h) { continue }
    "== $($top.Current.Name) ($($top.Current.ClassName))"
    foreach ($e in $top.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { $c = $e.Current; if ($c.Name) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
    }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
  [Comp]::Describe($h)
}

function MarkAny($key, [string[]]$names, $type = $null) {
  try { Mark $key (Box (FindAny $names $type -tries 6)) } catch { "  MISSING $key ($($names -join ' / '))" }
}

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Fill ($ws, $rows) {
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1)
  $ss.Name = 'Tuck shop'
  Fill $ss @(@('Item', 'Sold'), @('Pies', 64), @('Chips', 118), @('Juice', 85), @('Muffins', 37), @('Sweets', 96))
  $ss.Columns.Item('A').ColumnWidth = 12
  $ss.Rows.Item(1).Font.Bold = $true
  $null = $ss.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'TuckShop.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'TuckShop.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  $c1 = $ss.Shapes.AddChart2(201, 51, 200, 10, 360, 220).Chart      # clustered column
  $c1.SetSourceData($ss.Range('A1:B6'))
  $c1.HasTitle = $true; $c1.ChartTitle.Text = 'Tuck shop sales this week'
  $c1.SeriesCollection(1).HasDataLabels = $true
  $c2 = $ss.Shapes.AddChart2(251, 5, 200, 240, 360, 220).Chart      # pie
  $c2.SetSourceData($ss.Range('A1:B6'))
  $c2.HasTitle = $true; $c2.ChartTitle.Text = 'Share of tuck shop sales'
  $sb.SaveAs((Join-Path $filesDir 'TuckShop-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Items'
  $wd = $wb.Worksheets.Item(2); $wd.Name = 'Days'
  Fill $ws @(@('Item', 'Sold'), @('Bread', 420), @('Pies', 260), @('Vetkoek', 180), @('Koeksisters', 150), @('Muffins', 90))
  $ws.Columns.Item('A').ColumnWidth = 13
  $ws.Rows.Item(1).Font.Bold = $true
  Fill $wd @(@('Day', 'Loaves'), @('Mon', 96), @('Tue', 88), @('Wed', 104), @('Thu', 96), @('Fri', 131), @('Sat', 142))
  $wd.Rows.Item(1).Font.Bold = $true
  $null = $ws.Activate()
  $null = $ws.Range('B3').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1500, 800); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1600, 800)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  $win  = [WinRect]::Of($h)
  function CellBox ($sheet, $address) {
    $pane = $xl.ActiveWindow.ActivePane
    $cell = $sheet.Range($address)
    $x1 = $pane.PointsToScreenPixelsX($cell.Left) - $win[0]
    $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
    $y1 = $pane.PointsToScreenPixelsY($cell.Top) - $win[1]
    $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
    return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
  }
  Mark 'A1' (CellBox $ws 'A1'); Mark 'B6' (CellBox $ws 'B6'); Mark 'B3' (CellBox $ws 'B3')
  TryMark 'tabInsert' $root @('Insert') $T::TabItem
  Dump 'home'

  # 1. A column chart: click in the data, Ctrl+A, Insert tab, the column gallery, Clustered Column.
  SnapAll 'col-1'                                                   # B3 active
  $null = $ws.Range('A1:B6').Select(); SnapAll 'col-2'              # Ctrl+A: A1:B6 selected
  Press (Find $root @('Insert') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'insert'
  SnapAll 'col-3'                                                   # the Insert tab
  $gallery = $null
  try { $gallery = Find $root @('Insert Column or Bar Chart') -tries 8; Mark 'columnGallery' (Box $gallery) } catch { "  MISSING columnGallery" }
  try { Mark 'recommended' (Box (Find $root @('Recommended Charts') -tries 4)) } catch { "  MISSING recommended" }
  if ($gallery) {
    try {
      Expand $gallery
      Start-Sleep -Milliseconds 1500
      DumpOthers 'columnmenu'
      MarkAny 'clusteredColumn' @('Clustered Column')
      MarkAny 'clusteredBar' @('Clustered Bar')
      SnapAll 'col-4' -Others                                               # the gallery open
      Collapse $gallery
      Start-Sleep -Milliseconds 600
    } catch { "gallery: $_" }
  }
  $shape = $ws.Shapes.AddChart2(201, 51, 140, 10, 340, 215)
  $chart = $shape.Chart
  $chart.SetSourceData($ws.Range('A1:B6'))
  $null = $ws.ChartObjects(1).Activate()                          # selected as a click would: the chart tabs appear
  Start-Sleep -Milliseconds 1200
  function ChartTab {
    for ($i = 0; $i -lt 4; $i++) {
      try { Press (Find $root @('Chart Design') $T::TabItem -tries 12); Start-Sleep -Milliseconds 1200; return } catch { Start-Sleep -Milliseconds 1500; $null = $ws.ChartObjects(1).Activate() }
    }
    'no Chart Design tab'
  }
  ChartTab
  Dump 'chartdesign'
  SnapAll 'col-5'                                                   # the chart, selected; the Chart Design tab
  "chart title now: $($chart.ChartTitle.Text)"

  # 2. A title of its own, then data labels from Add Chart Element.
  $null = $chart.ChartTitle.Select()
  Start-Sleep -Milliseconds 800
  try { Mark 'chartTitle' (Box (Find $root @('Chart Title') -tries 6)) } catch { "  MISSING chartTitle element" }
  $ct = $chart.ChartTitle
  "chart title at $($ct.Left),$($ct.Top) pts; chart at $($shape.Left),$($shape.Top)"
  $pane = $xl.ActiveWindow.ActivePane
  $tx1 = $pane.PointsToScreenPixelsX($shape.Left + $ct.Left) - $win[0]
  $ty1 = $pane.PointsToScreenPixelsY($shape.Top + $ct.Top) - $win[1]
  $tx2 = $pane.PointsToScreenPixelsX($shape.Left + $ct.Left + $ct.Width) - $win[0]
  $ty2 = $pane.PointsToScreenPixelsY($shape.Top + $ct.Top + $ct.Height) - $win[1]
  Mark 'titleBox' @($tx1, $ty1, ($tx2 - $tx1), ($ty2 - $ty1))
  $sx1 = $pane.PointsToScreenPixelsX($shape.Left) - $win[0]; $sy1 = $pane.PointsToScreenPixelsY($shape.Top) - $win[1]
  $sx2 = $pane.PointsToScreenPixelsX($shape.Left + $shape.Width) - $win[0]; $sy2 = $pane.PointsToScreenPixelsY($shape.Top + $shape.Height) - $win[1]
  Mark 'chartBox' @($sx1, $sy1, ($sx2 - $sx1), ($sy2 - $sy1))
  SnapAll 'title-1'                                                 # the title selected
  $chart.ChartTitle.Text = 'Botha''s Bakery: items sold this week'
  Start-Sleep -Milliseconds 800
  $null = $ws.ChartObjects(1).Activate()
  $null = $chart.ChartArea.Select()
  ChartTab
  SnapAll 'title-2'                                                 # the new title; the chart selected
  $add = $null
  try { $add = Find $root @('Add Chart Element') -tries 8; Mark 'addElement' (Box $add) } catch { "  MISSING addElement" }
  if ($add) {
    try {
      Expand $add
      Start-Sleep -Milliseconds 1500
      DumpOthers 'addmenu'
      MarkAny 'dataLabelsItem' @('Data Labels')
      SnapAll 'title-3' -Others                                             # the Add Chart Element menu
      $dl = FindAny @('Data Labels') -tries 6
      Expand $dl
      Start-Sleep -Milliseconds 1500
      DumpOthers 'labelsmenu'
      MarkAny 'outsideEnd' @('Outside End')
      SnapAll 'title-4' -Others                                             # the Data Labels menu beside it
      Collapse $dl; Collapse $add
      Start-Sleep -Milliseconds 600
    } catch { "add chart element: $_" }
  }
  $chart.SeriesCollection(1).HasDataLabels = $true
  $chart.SeriesCollection(1).DataLabels().Position = 2              # xlLabelPositionOutsideEnd
  Start-Sleep -Milliseconds 800
  SnapAll 'title-5'                                                 # numbers on the bars

  # 3. A pie chart of the same data, from the Insert tab (the column chart deleted first: click it, Delete).
  # (Change Chart Type sits at the far right of the Chart Design tab - too far for the pictures' crop.)
  $shape.Visible = 0
  $null = $ws.Range('A1:B6').Select()
  Start-Sleep -Milliseconds 600
  Press (Find $root @('Insert') $T::TabItem)
  Start-Sleep -Milliseconds 900
  SnapAll 'pie-1'                                                   # the data selected, the Insert tab
  $pieGallery = $null
  try { $pieGallery = Find $root @('Insert Pie or Doughnut Chart') -tries 8; Mark 'pieGallery' (Box $pieGallery) } catch { "  MISSING pieGallery" }
  if ($pieGallery) {
    try {
      Expand $pieGallery
      Start-Sleep -Milliseconds 1500
      DumpOthers 'piemenu'
      MarkAny 'pieItem' @('Pie')
      SnapAll 'pie-2' -Others                                       # the pie gallery open
      Collapse $pieGallery
      Start-Sleep -Milliseconds 600
    } catch { "pie gallery: $_" }
  }
  $pieShape = $ws.Shapes.AddChart2(251, 5, 140, 10, 340, 215)
  $pie = $pieShape.Chart
  $pie.SetSourceData($ws.Range('A1:B6'))
  $pie.HasTitle = $true; $pie.ChartTitle.Text = 'Share of this week''s sales'
  $pie.HasLegend = $true
  $null = $ws.ChartObjects($ws.ChartObjects().Count).Activate()
  Start-Sleep -Milliseconds 1000
  SnapAll 'pie-3'                                                   # a pie with a legend
  "pie: type $($pie.ChartType), legend $($pie.HasLegend)"
  $pie.SeriesCollection(1).HasDataLabels = $true
  $pie.SeriesCollection(1).DataLabels().ShowPercentage = $true
  $pie.SeriesCollection(1).DataLabels().ShowValue = $false
  $null = $ws.Range('L2').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'pie-4'                                                   # percentages on the slices
  $pieShape.Delete()
  $shape.Visible = -1

  # 4. The same data as bars, and the parts of a chart named (figures).
  $chart.ChartType = 57                                             # clustered bar
  $chart.HasLegend = $false
  $chart.SeriesCollection(1).HasDataLabels = $true
  Start-Sleep -Milliseconds 800
  SnapAll 'bar-1'
  $chart.ChartType = 51
  $chart.HasLegend = $true
  $chart.Legend.Position = -4107                                    # bottom
  $chart.Axes(1).HasTitle = $true; $chart.Axes(1).AxisTitle.Text = 'Item'
  $chart.Axes(2).HasTitle = $true; $chart.Axes(2).AxisTitle.Text = 'Number sold'
  $chart.Axes(2).HasMajorGridlines = $true
  $null = $ws.Range('L2').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'parts-1'

  # 5. A line chart of the days (CAPS).
  $null = $wd.Activate()
  $null = $wd.Range('A1:B7').Select()
  $line = $wd.Shapes.AddChart2(227, 4, 130, 10, 420, 250).Chart     # line
  $line.SetSourceData($wd.Range('A1:B7'))
  $line.HasTitle = $true; $line.ChartTitle.Text = 'Loaves sold each day'
  $null = $wd.Range('L2').Select()
  Start-Sleep -Milliseconds 1000
  SnapAll 'line-1'

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { } }
  $xl.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
