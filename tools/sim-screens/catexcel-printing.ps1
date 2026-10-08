# Real Excel 365 (and Word 365) screens for catexcel lesson 8, Printing,
# sharing and solving problems (AIPascalCourse/content/catexcel/printing.php -
# written to courses/cat-practical-writing.md, 8 October 2026). Ms Naidoo's
# Grade 10A mark sheet, too wide and too long for one portrait page:
# Orientation > Landscape, Print Titles (the Page Setup dialog), Page Break
# Preview, a header, File > Print; then Mr Botha's order sheet with four
# mistakes, Show Formulas, and the price list pasted into Word. Menus and
# dialogs are windows of their own: SnapAll draws them over Excel's window
# (as catexcel-charts.ps1). Also makes the pupils' starter file Orders.xlsx
# (and a done-right copy) in C:\sims\files\catexcel-printing\ and
# G:\My Drive\CAT\Excel\. Nothing is printed. Read office-kit.ps1's safety
# rules first.
#     pwsh -File vm-shots.ps1 catexcel-printing        (from the host)
$Name = 'catexcel-printing'
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

# A box's value set through UI Automation (a dialog's text box).
function SetValue($element, [string]$text) {
  $pattern = $null
  if ($element.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$pattern)) { $pattern.SetValue($text); return }
  throw "'$($element.Current.Name)' takes no value"
}

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Fill ($ws, $rows) {
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { if ([string]$rows[$r][$c] -ne '') { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } } }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
$word = $null
try {
  $xl.DisplayAlerts = $false

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1)
  $ss.Name = 'Order'
  Fill $ss @(
    @('Item', 'Price', 'Quantity', 'Amount'),
    @('Sandwiches', 25, 40, '=B2*C2'),
    @('Pies', 22, 30, '=B3*C3'),
    @('Muffins', 12, 50, 600),
    @('Juice', 15, "'45", '=B5*C5'),
    @('Koeksisters', 5, 60, 'B6*C6'),
    @('Total', '', '=SUM(C2:C6)', '=SUM(D4:D6)'))
  $ss.Columns.Item('A').ColumnWidth = 13
  foreach ($col in 'B', 'C', 'D') { $ss.Columns.Item($col).ColumnWidth = 11 }
  $ss.Rows.Item(1).Font.Bold = $true; $ss.Rows.Item(7).Font.Bold = $true
  $null = $ss.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'Orders.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'Orders.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  "starter: C7 $($ss.Range('C7').Text), D6 $($ss.Range('D6').Text), D7 $($ss.Range('D7').Text)"
  $ss.Range('D4').Formula = '=B4*C4'
  $ss.Range('C5').Formula = '45'
  $ss.Range('D6').Formula = '=B6*C6'
  $ss.Range('D7').Formula = '=SUM(D2:D6)'
  $sb.SaveAs((Join-Path $filesDir 'Orders-done.xlsx'), 51)
  "done: C7 $($ss.Range('C7').Text), D7 $($ss.Range('D7').Text)"
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Marks'
  $wo = $wb.Worksheets.Item(2); $wo.Name = 'Orders'
  $first = @('Ayanda','Bongani','Chloe','Dineo','Ethan','Fatima','Gift','Hlengiwe','Imran','Jabu','Karabo','Lindiwe','Mpho','Nadia','Owen','Palesa','Quinton','Refilwe','Sipho','Tamsin','Unathi','Vusi','Wandile','Xolani','Yusuf','Zanele','Amahle','Bheki','Carmen','Duduzile','Eric','Fikile','Grace','Hendrik','Itumeleng','Johan','Kamogelo','Lebo','Musa','Nomvula')
  $last  = @('Mokoena','Dlamini','van Wyk','Nkosi','Smith','Patel','Mahlangu','Khumalo','Moosa','Ndlovu','Molefe','Zulu','Sithole','Adams','Botha','Mabaso','Pillay','Masilo','Ngcobo','Jacobs','Mthembu','Radebe','Cele','Mkhize','Hassan','Shabalala','Naidoo','Mbatha','Fourie','Mazibuko','Nel','Zungu','Petersen','Venter','Maseko','Pretorius','Tau','Phiri','Gumede','Ntuli')
  Fill $ws @(,@('Name', 'Surname', 'Test 1', 'Test 2', 'Task 1', 'Task 2', 'Practical', 'June exam', 'Term mark', 'Percent'))
  $rand = New-Object System.Random 10
  for ($i = 0; $i -lt 40; $i++) {
    $r = $i + 2
    $ws.Range("A$r").Formula = $first[$i]; $ws.Range("B$r").Formula = $last[$i]
    foreach ($col in 'C', 'D', 'E', 'F', 'G') { $ws.Range("$col$r").Formula = [string]$rand.Next(18, 49) }
    $ws.Range("H$r").Formula = [string]$rand.Next(70, 148)
    $ws.Range("I$r").Formula = "=SUM(C${r}:H${r})"
    $ws.Range("J$r").Formula = "=I$r/400"
  }
  $ws.Range('J2:J41').NumberFormat = '0%'
  $ws.Columns.Item('A').ColumnWidth = 12; $ws.Columns.Item('B').ColumnWidth = 12
  foreach ($col in 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J') { $ws.Columns.Item($col).ColumnWidth = 11 }
  $ws.Rows.Item(1).Font.Bold = $true

  Fill $wo @(
    @('Item', 'Price', 'Quantity', 'Amount'),
    @('Bread rolls', 18, 10, '=B2*C2'),
    @('Pies', 22, 24, '=B3*C3'),
    @('Vetkoek', 6, 40, 240),
    @('Koeksisters', 5, "'36", '=B5*C5'),
    @('Muffins', 12, 15, 'B6*C6'),
    @('Total', '', '=SUM(C2:C6)', '=SUM(D4:D6)'))
  $wo.Columns.Item('A').ColumnWidth = 13
  foreach ($col in 'B', 'C', 'D') { $wo.Columns.Item($col).ColumnWidth = 11 }
  $wo.Rows.Item(1).Font.Bold = $true; $wo.Rows.Item(7).Font.Bold = $true
  $null = $ws.Activate()
  $null = $ws.Range('A1').Select()

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
  TryMark 'tabPageLayout' $root @('Page Layout') $T::TabItem
  TryMark 'tabView'       $root @('View') $T::TabItem
  TryMark 'tabInsert'     $root @('Insert') $T::TabItem
  TryMark 'tabFormulas'   $root @('Formulas') $T::TabItem
  Dump 'home'

  # 1. Landscape: Page Layout tab > Orientation > Landscape.
  SnapAll 'land-1'                                                  # the marks, Home tab
  Press (Find $root @('Page Layout') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'pagelayout'
  SnapAll 'land-2'                                                  # the Page Layout tab
  $orient = $null
  try { $orient = Find $root @('Orientation') -tries 8; Mark 'orientation' (Box $orient) } catch { "  MISSING orientation" }
  foreach ($nm in 'Print Titles', 'Print Area', 'Margins', 'Size', 'Breaks', 'Background') { TryMark ($nm -replace ' ', '') $root @($nm) }
  if ($orient) {
    try {
      Press $orient                                                  # a menu button: Invoke opens its menu
      Start-Sleep -Milliseconds 2000
      "after Invoke: $([Comp]::Describe($h))"
      $found = $null; try { $found = FindAny @('Landscape') -tries 4 } catch { }
      if (-not $found) { Expand $orient; Start-Sleep -Milliseconds 2000; "after Expand: $([Comp]::Describe($h))" }
      Start-Sleep -Milliseconds 1500
      DumpOthers 'orientmenu'
      MarkAny 'landscape' @('Landscape')
      SnapAll 'land-3' -Others                                              # Portrait and Landscape
      Collapse $orient
      Start-Sleep -Milliseconds 600
    } catch { "orientation: $_" }
  }
  $ws.PageSetup.Orientation = 2                                     # xlLandscape
  $ws.DisplayPageBreaks = $true
  Start-Sleep -Milliseconds 1200
  SnapAll 'land-4'                                                  # landscape: the dashed page breaks

  # 2. Print Titles: row 1 on every page. The Page Setup dialog's boxes are not in UI Automation:
  # it is drawn empty, closed (as its X would), the rows set through COM, and drawn again with $1:$1 in.
  function DialogOpen ($button) {
    Press $button
    for ($i = 0; $i -lt 20 -and @([Comp]::Others($h)).Count -eq 0; $i++) { Start-Sleep -Milliseconds 250 }
    Start-Sleep -Milliseconds 1500
  }
  function DialogClose {
    foreach ($w in [Comp]::Others($h)) { [Comp]::Close($w) }
    for ($i = 0; $i -lt 20 -and @([Comp]::Others($h)).Count -gt 0; $i++) { Start-Sleep -Milliseconds 250 }
    Start-Sleep -Milliseconds 800
  }
  $pt = $null
  try { $pt = Find $root @('Print Titles') -tries 8 } catch { "  MISSING Print Titles" }
  if ($pt) {
    try {
      DialogOpen $pt
      [Comp]::Describe($h)
      SnapAll 'titles-1' -Others                                    # the Page Setup dialog, Sheet tab, box empty
      DialogClose
      $ws.PageSetup.PrintTitleRows = '$1:$1'
      DialogOpen $pt
      SnapAll 'titles-2' -Others                                    # the same, $1:$1 in the box
      DialogClose
    } catch { "print titles: $_" }
  }
  try { $ws.PageSetup.PrintTitleRows = '$1:$1' } catch { "print titles (COM): $_" }
  "print titles now: $($ws.PageSetup.PrintTitleRows)"

  # 3. Page Break Preview, then a header in Page Layout view (figures and a short task).
  Press (Find $root @('View') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'view'
  TryMark 'pageBreakPreview' $root @('Page Break Preview')
  TryMark 'pageLayoutView'   $root @('Page Layout') $T::Button
  SnapAll 'view-1'                                                  # the View tab
  $xl.ActiveWindow.View = 2                                         # xlPageBreakPreview
  $xl.ActiveWindow.Zoom = 60
  Start-Sleep -Milliseconds 1500
  SnapAll 'view-2'                                                  # Page 1, Page 2
  $xl.ActiveWindow.View = 1
  $xl.ActiveWindow.Zoom = 100
  Press (Find $root @('Insert') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'insert'
  TryMark 'textGroup' $root @('Text')
  SnapAll 'head-1'                                                  # the Insert tab
  try {
    $textBtn = Find $root @('Text') -tries 6
    Press $textBtn; Start-Sleep -Milliseconds 2000
    if (@([Comp]::Others($h)).Count -eq 0) { Expand $textBtn; Start-Sleep -Milliseconds 2000 }
    DumpOthers 'textmenu'
    MarkAny 'headerFooter' @('Header & Footer', 'Header and Footer')
    SnapAll 'head-1b' -Others                                       # the Text menu: Header & Footer
    Collapse $textBtn; Start-Sleep -Milliseconds 600
  } catch { "text menu: $_" }
  $ws.PageSetup.CenterHeader = 'Grade 10A - Term 2 marks'
  $ws.PageSetup.CenterFooter = 'Page &P of &N'
  $xl.ActiveWindow.View = 3                                         # xlPageLayoutView
  Start-Sleep -Milliseconds 1500
  $xl.ActiveWindow.ScrollRow = 1
  SnapAll 'head-2'                                                  # Page Layout view: the header
  $xl.ActiveWindow.View = 1
  Start-Sleep -Milliseconds 800

  # 4. File > Print (Backstage) - looked at, never printed.
  try {
    $fileTab = Find $root @('File Tab', 'File') -tries 8
    Mark 'fileTab' (Box $fileTab)
    Press $fileTab
    Start-Sleep -Milliseconds 2500
    Dump 'backstage'
    SnapAll 'print-1'                                               # Backstage
    $printItem = Find $root @('Print') $T::ListItem -tries 8
    Mark 'printItem' (Box $printItem)
    Press $printItem
    Start-Sleep -Milliseconds 3000
    Dump 'printpage'
    TryMark 'copies'      $root @('Copies', 'Copies:')
    TryMark 'printButton' $root @('Print') $T::Button
    SnapAll 'print-2'                                               # the Print page and its preview
    try { SetValue (Find $root @('Copies', 'Copies:') -tries 4) '2'; Start-Sleep -Milliseconds 800; SnapAll 'print-3' } catch { "copies: $_" }
    try { Press (Find $root @('Back') -tries 6) } catch { [Shot]::PostKey($h, 0x1B) }
    Start-Sleep -Milliseconds 1500
  } catch { "backstage: $_" }

  # 5. Mr Botha's order sheet: four mistakes, then Show Formulas.
  $null = $wo.Activate()
  $null = $wo.Range('F1').Select()
  Press (Find $root @('Formulas') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'formulas'
  TryMark 'showFormulas' $root @('Show Formulas')
  foreach ($a in 'C5', 'D4', 'D6', 'D7') { Mark ('orders' + $a) (CellBox $wo $a) }
  SnapAll 'fix-1'                                                   # the order sheet, Formulas tab
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  foreach ($a in 'C5', 'D4', 'D6', 'D7') { Mark ('ordersF' + $a) (CellBox $wo $a) }
  SnapAll 'fix-2'                                                   # Show Formulas on
  $xl.ActiveWindow.DisplayFormulas = $false
  Start-Sleep -Milliseconds 600

  # 6. The price list into Word: copy in Excel, paste in Word - it arrives as a table.
  try {
    $word = New-Object -ComObject Word.Application
    $word.DisplayAlerts = 0
    $doc = $word.Documents.Add()
    $doc.Content.Text = "Dear Ms Naidoo`rHere is the order for the Grade 10 market day, as we agreed:`r"
    $null = $wo.Range('A1:D7').Copy()
    Start-Sleep -Milliseconds 800
    $end = $doc.Content; $end.Collapse(0)
    $end.Paste()
    try { $xl.CutCopyMode = 1 } catch { }   # any value ends copy mode (xlCopy = 1)
    $word.Visible = $true
    $word.WindowState = 0
    $hw = [IntPtr]$word.ActiveWindow.Hwnd
    [Shot]::Place($hw, 40, 40, 1600, 760); Start-Sleep -Milliseconds 1500
    [Shot]::Place($hw, 40, 40, 1750, 760)
    $word.ActiveWindow.View.Type = 3
    $word.ActiveWindow.View.Zoom.Percentage = 100
    $word.ActiveWindow.DisplayRulers = $false
    try { $word.ActiveWindow.DocumentMap = $false } catch { }
    $doc.Range(0, 0).Select()
    Start-Sleep -Milliseconds 2500
    "word tables: $($doc.Tables.Count)"
    Guard
    [void][Shot]::Save($hw, (Join-Path $out "$Name-word-1.png"))
    Guard
    'picture word-1'
    $doc.Close(0)
  } catch { "word: $_" }

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
}
finally {
  if ($word) { try { $word.Quit(0) } catch { }; [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word) }
  $xlPid = if ($h -ne [IntPtr]::Zero) { [Shot]::Pid($h) } else { 0 }
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_ - stopping Excel $xlPid" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }   # a dialog left open would keep it running
}
