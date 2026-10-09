# Real Excel 365 screens for catexcel lesson 8 (content/catexcel/printing.php),
# simLandscape (9 October 2026): the Orientation menu opened and Landscape
# chosen with real clicks in the CAT VM (the menu could not be opened through
# UI Automation in catexcel-printing.ps1). The same mark sheet as
# catexcel-printing.ps1 (its helpers and set-up, copied); nothing saved or
# printed. Pictures out\catexcel-landscape-land-3.png and -land-5.png.
#     pwsh -File vm-shots.ps1 catexcel-landscape
$Name = 'catexcel-landscape'
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

Add-Type @'
using System; using System.Runtime.InteropServices; using System.Threading;
public static class LsMouse {
  [DllImport ("user32.dll")] static extern bool SetCursorPos (int x, int y);
  [DllImport ("user32.dll")] static extern void mouse_event (uint f, int x, int y, uint d, UIntPtr e);
  [DllImport ("user32.dll")] static extern bool SetForegroundWindow (IntPtr h);
  public static void Front (IntPtr h) { SetForegroundWindow (h); Thread.Sleep (500); }
  public static void Click (int x, int y) { SetCursorPos (x, y); Thread.Sleep (250); mouse_event (2, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (90); mouse_event (4, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (300); }
  public static void Park () { SetCursorPos (1900, 1060); Thread.Sleep (200); }
}
'@
function Fill ($ws, $rows) {
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { if ([string]$rows[$r][$c] -ne '') { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } } }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
$word = $null
try {
  $xl.DisplayAlerts = $false

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
  # Landscape with real input: a real click on Page Layout's Orientation button opens its menu
  # (Invoke and Expand did not, 8 October 2026), the menu drawn over Excel's window, a real click on Landscape.
  Press (Find $root @('Page Layout') $T::TabItem)
  Start-Sleep -Milliseconds 900
  $orient = Find $root @('Orientation') -tries 8
  $ob = Box $orient; Mark 'orientation' $ob
  $w = [WinRect]::Of($h)
  [LsMouse]::Front($h)
  [LsMouse]::Click([int]($w[0] + $ob[0] + $ob[2] / 2), [int]($w[1] + $ob[1] + $ob[3] / 2))
  Start-Sleep -Milliseconds 1500
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  DumpOthers 'orientmenu'
  MarkAny 'landscape' @('Landscape')
  MarkAny 'portrait' @('Portrait')
  SnapAll 'land-3' -Others
  $land = $null; try { $land = FindAny @('Landscape') -tries 6 } catch { '  NO Landscape item' }
  if ($land) {
    $lb = Box $land
    [LsMouse]::Click([int]($w[0] + $lb[0] + $lb[2] / 2), [int]($w[1] + $lb[1] + $lb[3] / 2))
    [LsMouse]::Park()
    Start-Sleep -Milliseconds 1500
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    "  orientation now: $($ws.PageSetup.Orientation)"
    $ws.DisplayPageBreaks = $true
    Start-Sleep -Milliseconds 1200
    SnapAll 'land-5'
  }
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
