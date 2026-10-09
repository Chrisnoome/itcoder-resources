# Helpers shared by writer C's catexcel Grade 11 screen scripts
# (catexcel-printoptions, -graphs, -importing - 9 October 2026, written to
# courses/cat-practical-writing.md). A copy of work\catexcel12-kit.ps1 with
# its class renamed (Comp11c), so the two can change apart. Dot-source it
# after office-kit.ps1 and work\catexcel-kit.ps1:
#     . (Join-Path $PSScriptRoot 'work\catexcel11c-kit.ps1')
# The Comp class and SnapAll come from catexcel-sorting.ps1 (Grade 10,
# lesson 9): menus, galleries and dialogs are windows of their own, so a
# picture "with others" draws each of the program's other visible windows
# over the main one where it sits on the screen. $h may be any program's main
# window (Word's too). Everything keeps office-kit.ps1's rules: nothing
# clicks or types at the desktop.

Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class Comp11c
{
    [DllImport ("user32.dll")] static extern bool PrintWindow (IntPtr hWnd, IntPtr hdc, uint flags);
    [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr hWnd, out RECT rect);
    [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr hWnd);
    [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr hWnd, out uint pid);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr hWnd, System.Text.StringBuilder name, int size);
    delegate bool EnumProc (IntPtr hWnd, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc proc, IntPtr lParam);
    [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }

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

    public static void Close (IntPtr h) { PostMessage (h, 0x0010, IntPtr.Zero, IntPtr.Zero); }

    [DllImport ("user32.dll")] static extern IntPtr GetShellWindow ();
    [DllImport ("user32.dll")] static extern bool SetForegroundWindow (IntPtr hWnd);
    [DllImport ("user32.dll")] static extern IntPtr GetForegroundWindow ();

    /// Hands the foreground back to the desktop (a pressed ribbon tab brings Excel to the front).
    public static bool Away (IntPtr main)
    {
        uint mainPid; GetWindowThreadProcessId (main, out mainPid);
        uint frontPid; GetWindowThreadProcessId (GetForegroundWindow (), out frontPid);
        if (frontPid != mainPid) { return true; }
        return SetForegroundWindow (GetShellWindow ());
    }

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

    [DllImport ("user32.dll", EntryPoint = "SendMessageW")] static extern IntPtr SendInt (IntPtr hWnd, uint message, IntPtr wParam, IntPtr lParam);
    [DllImport ("user32.dll", EntryPoint = "SendMessageW", CharSet = CharSet.Unicode)] static extern IntPtr SendStr (IntPtr hWnd, uint message, IntPtr wParam, string lParam);

    /// A message sent to one window (a Win32 combo box in a file dialog): CB_SHOWDROPDOWN, CB_SETCURSEL ...
    public static int Send (IntPtr h, uint message, int wParam, int lParam) { return (int) SendInt (h, message, new IntPtr (wParam), new IntPtr (lParam)); }

    /// The index of a combo box's item that starts with this text (CB_FINDSTRING), or -1.
    public static int FindItem (IntPtr combo, string text) { return (int) SendStr (combo, 0x014C, new IntPtr (-1), text); }

    delegate bool ChildProc (IntPtr hWnd, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool EnumChildWindows (IntPtr parent, ChildProc proc, IntPtr lParam);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr hWnd, System.Text.StringBuilder text, int size);

    /// The first visible child window of any class whose text (without the &) is this, or zero.
    public static IntPtr ChildByTextAny (IntPtr parent, string text)
    {
        IntPtr found = IntPtr.Zero;
        EnumChildWindows (parent, delegate (IntPtr h, IntPtr l) {
            System.Text.StringBuilder caption = new System.Text.StringBuilder (256);
            GetWindowText (h, caption, 256);
            if (caption.ToString ().Replace ("&", "") == text && IsWindowVisible (h)) { found = h; return false; }
            return true; }, IntPtr.Zero);
        return found;
    }

    [StructLayout (LayoutKind.Sequential)] public struct PT { public int X, Y; }
    [DllImport ("user32.dll")] static extern IntPtr ChildWindowFromPointEx (IntPtr parent, PT point, uint flags);
    [DllImport ("user32.dll")] static extern bool ScreenToClient (IntPtr hWnd, ref PT point);

    /// The deepest visible child window under a screen point (where a click there would land), or the window itself.
    public static IntPtr DeepestAt (IntPtr top, int x, int y)
    {
        IntPtr h = top;
        for (int i = 0; i < 30; i++)
        {
            PT p; p.X = x; p.Y = y; ScreenToClient (h, ref p);
            IntPtr c = ChildWindowFromPointEx (h, p, 1 | 4);   // CWP_SKIPINVISIBLE | CWP_SKIPTRANSPARENT
            if (c == IntPtr.Zero || c == h) { break; }
            h = c;
        }
        return h;
    }

    /// The program's other visible window of this class (a drop-down list box), or zero.
    public static IntPtr OtherByClass (IntPtr main, string className)
    {
        foreach (IntPtr h in Others (main))
        {
            System.Text.StringBuilder name = new System.Text.StringBuilder (256); GetClassName (h, name, 256);
            if (name.ToString () == className) { return h; }
        }
        return IntPtr.Zero;
    }

    /// A window's place on the screen: left, top, width, height.
    public static int[] Rect (IntPtr h) { RECT r; GetWindowRect (h, out r); return new int[] { r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top }; }
}
'@

# A picture of Excel's window; -Others draws its other windows (a dialog, a menu, a gallery) over it.
function SnapAll($n, [switch]$Others) {
  if (-not $Others) { [Shot]::Back($h); $away = [Comp11c]::Away($h); Start-Sleep -Milliseconds 300; if (-not $away) { "  (Excel still in front before $n)" } }
  Guard
  Start-Sleep -Milliseconds 1100
  if ($Others) { [void][Comp11c]::Save($h, (Join-Path $out "$Name-$n.png")) } else { [Shot]::Back($h); Start-Sleep -Milliseconds 300; [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png")) }
  Guard
  "picture $n" + $(if ($Others) { " (with $(@([Comp11c]::Others($h)).Count) other windows)" } else { '' })
}

# Excel's other windows as UI Automation elements.
function OtherRoots { foreach ($w in [Comp11c]::Others($h)) { try { $AE::FromHandle($w) } catch { } } }

# A control of this Excel by name - in the main window or any of its other windows.
function FindAny([string[]]$names, $type = $null, [int]$tries = 16) {
  $procId = [Shot]::Pid($h)
  for ($try = 0; $try -lt $tries; $try++) {
    foreach ($nm in $names) {
      $cond = New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, $nm)), (New-Object $PropCond($AE::ProcessIdProperty, [int]$procId)))
      if ($type) { $cond = New-Object System.Windows.Automation.AndCondition($cond, (New-Object $PropCond($AE::ControlTypeProperty, $type))) }
      foreach ($top in @($AE::FromHandle($h)) + @(OtherRoots)) {
        $found = $top.FindFirst($Scope::Descendants, $cond)
        if ($found -and -not $found.Current.IsOffscreen) { return $found }
      }
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

# Every named control of Excel's other windows, and where it is on the main window's picture.
function DumpOthers($file) {
  $win = [WinRect]::Of($h)
  $lines = foreach ($top in (OtherRoots)) {
    "== $($top.Current.Name) ($($top.Current.ClassName))"
    foreach ($e in $top.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { $c = $e.Current; if ($c.Name -or $c.ControlType -eq $T::ComboBox -or $c.ControlType -eq $T::Edit) { ($c.Name, $c.ControlType.ProgrammaticName, $c.AutomationId, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
    }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
  [Comp11c]::Describe($h)
}

function MarkAny($key, [string[]]$names, $type = $null) {
  try { Mark $key (Box (FindAny $names $type -tries 6)) } catch { "  MISSING $key ($($names -join ' / '))" }
}

function WaitOthers([int]$want = 1, [int]$tries = 24) {
  for ($i = 0; $i -lt $tries -and @([Comp11c]::Others($h)).Count -lt $want; $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 1200
}

function CloseOthers {
  foreach ($w in [Comp11c]::Others($h)) { [Comp11c]::Close($w) }
  for ($i = 0; $i -lt 20 -and @([Comp11c]::Others($h)).Count -gt 0; $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 800
}

# Rows of values into a sheet: A1-style from $firstRow, column $firstCol (0 = A). Formulas go in as typed (Formula2).
function Fill12 ($ws, $rows, [int]$firstRow = 1, [int]$firstCol = 0) {
  for ($r = 0; $r -lt $rows.Count; $r++) {
    for ($c = 0; $c -lt $rows[$r].Count; $c++) {
      $v = [string]$rows[$r][$c]
      if ($v -eq '') { continue }
      $cell = $ws.Range(([string][char](65 + $firstCol + $c)) + ($r + $firstRow))
      if ($v.StartsWith('=')) { $cell.Formula2 = $v } else { $cell.Formula = $v }
    }
  }
}

# Where a cell (or range) is on the picture of the main window: [x, y, w, h] in window pixels.
function CellAt ($sheet, $address) {
  $win  = [WinRect]::Of($h)
  $pane = $xl.ActiveWindow.ActivePane
  $cell = $sheet.Range($address)
  $x1 = $pane.PointsToScreenPixelsX($cell.Left) - $win[0]
  $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
  $y1 = $pane.PointsToScreenPixelsY($cell.Top) - $win[1]
  $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
  return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
}

# Marks cells (their keys are the addresses) and, with -Handle, the fill handle at a cell's bottom right.
function MarkCells ($sheet, [string[]]$addresses, [string]$prefix = '') {
  foreach ($a in $addresses) { Mark ($prefix + ($a -replace '[:!]', '_')) (CellAt $sheet $a) }
}
function MarkHandle ($sheet, [string]$address, [string]$key = '') {
  $b = CellAt $sheet $address
  if ($key -eq '') { $key = 'fill' + $address }
  Mark $key @(($b[0] + $b[2] - 9), ($b[1] + $b[3] - 9), 18, 18)
}

# Opens Excel's window at a set size, 100% zoom, at the back of the stack.
function ShowExcel([int]$width = 1600, [int]$height = 800) {
  $xl.Visible = $true
  $xl.WindowState = -4143
  $script:h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, $width - 100, $height); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, $width, $height)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
}

# Presses a ribbon tab by name (and hands the foreground back).
function Tab([string]$name) {
  Press (Find $AE::FromHandle($h) @($name) $T::TabItem)
  Start-Sleep -Milliseconds 1000
  [void][Comp11c]::Away($h)
}

# Saves a workbook as a pupil's starter file: in C:\sims\files\<script>\ and in the cloud folder.
function SaveStarter($book, [string]$fileName) {
  $path = Join-Path $filesDir $fileName
  $book.SaveAs($path, 51)
  try { Copy-Item $path $cloudDir -Force } catch { "cloud copy failed: $_" }
  "saved $fileName"
}
