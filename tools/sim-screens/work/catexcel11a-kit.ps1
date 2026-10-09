# Helpers shared by writer A's catexcel Grade 11 screen scripts
# (catexcel-absolute, catexcel-rounding, catexcel-condformat - 9 October 2026,
# written to courses/cat-practical-writing.md). Dot-source it after
# office-kit.ps1 and work\catexcel-kit.ps1:
#     . (Join-Path $PSScriptRoot 'work\catexcel11a-kit.ps1')
# The CompA class and SnapAll are catexcel-sorting.ps1's (Grade 10, lesson 9):
# menus, galleries and dialogs are windows of their own, so a picture "with
# others" draws each of Excel's other visible windows over the main one where
# it sits on the screen. New here: Chars posts typed characters (WM_CHAR) to
# ONE window by its handle - Excel's grid - so a formula can be pictured
# while it is being typed (edit mode). While Excel is in edit mode its COM
# calls are refused, so nothing here touches COM between Chars and the Enter
# (or Escape) that ends it. Everything keeps office-kit.ps1's rules: nothing
# clicks or types at the desktop.

Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class CompA
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

    [DllImport ("user32.dll")] static extern bool SetWindowPos (IntPtr hWnd, IntPtr after, int x, int y, int w, int h, uint flags);

    /// Moves a window (a dialog Excel put half off its own window) without sizing, activating or restacking it.
    public static void MoveTo (IntPtr h, int x, int y) { SetWindowPos (h, IntPtr.Zero, x, y, 0, 0, 0x0001 | 0x0004 | 0x0010); }

    public static int[] RectOf (IntPtr h) { RECT r; GetWindowRect (h, out r); return new int[] { r.Left, r.Top, r.Right, r.Bottom }; }

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

    /// Characters posted to ONE window by its handle (WM_CHAR) - typing into Excel's grid without the desktop.
    public static void Chars (IntPtr h, string s)
    {
        foreach (char c in s) { PostMessage (h, 0x0102, new IntPtr (c), new IntPtr (1)); System.Threading.Thread.Sleep (60); }
    }

    /// A key (down and up) posted to ONE window: Enter 0x0D, Escape 0x1B, F4 0x73.
    public static void Key (IntPtr h, int vk)
    {
        PostMessage (h, 0x0100, new IntPtr (vk), new IntPtr (1));
        PostMessage (h, 0x0101, new IntPtr (vk), new IntPtr (unchecked ((int) 0xC0000001)));
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
}
'@

function SnapAll($n, [switch]$Others) {
  if (-not $Others) { [Shot]::Back($h); $away = [CompA]::Away($h); Start-Sleep -Milliseconds 300; if (-not $away) { "  (Excel still in front before $n)" } }
  Guard
  Start-Sleep -Milliseconds 1100
  if ($Others) { [void][CompA]::Save($h, (Join-Path $out "$Name-$n.png")) } else { [Shot]::Back($h); Start-Sleep -Milliseconds 300; [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png")) }
  Guard
  "picture $n" + $(if ($Others) { " (with $(@([CompA]::Others($h)).Count) other windows)" } else { '' })
}

function OtherRoots {
  foreach ($w in [CompA]::Others($h)) { try { $AE::FromHandle($w) } catch { } }
}

function FindAny([string[]]$names, $type = $null, [int]$tries = 16) {
  $procId = [Shot]::Pid($h)
  for ($try = 0; $try -lt $tries; $try++) {
    foreach ($nm in $names) {
      $cond = New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, $nm)), (New-Object $PropCond($AE::ProcessIdProperty, [int]$procId)))
      if ($type) { $cond = New-Object System.Windows.Automation.AndCondition($cond, (New-Object $PropCond($AE::ControlTypeProperty, $type))) }
      foreach ($top in (OtherRoots)) {
        $found = $top.FindFirst($Scope::Descendants, $cond)
        if ($found -and -not $found.Current.IsOffscreen) { return $found }
      }
      $found = $AE::FromHandle($h).FindFirst($Scope::Descendants, $cond)
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

function DumpOthers($file) {
  $win = [WinRect]::Of($h)
  $lines = foreach ($top in (OtherRoots)) {
    "== $($top.Current.Name) ($($top.Current.ClassName))"
    foreach ($e in $top.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { $c = $e.Current; if ($c.Name -or $c.ControlType -eq $T::ComboBox -or $c.ControlType -eq $T::Edit) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
    }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
  [CompA]::Describe($h)
}

function MarkAny($key, [string[]]$names, $type = $null) {
  try { Mark $key (Box (FindAny $names $type -tries 6)) } catch { "  MISSING $key ($($names -join ' / '))" }
}

function WaitOthers([int]$want = 1, [int]$tries = 24) {
  for ($i = 0; $i -lt $tries -and @([CompA]::Others($h)).Count -lt $want; $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 1200
}

# Moves any of Excel's other windows that stick out past its left or right edge back inside it (centred across).
function FitDialogs {
  $m = [WinRect]::Of($h)
  foreach ($w in [CompA]::Others($h)) {
    $r = [CompA]::RectOf($w)
    $wd = $r[2] - $r[0]
    if ($r[0] -lt ($m[0] + 8) -or $r[2] -gt ($m[2] - 8)) {
      $x = $m[0] + [Math]::Max(8, [int](($m[2] - $m[0] - $wd) / 2))
      [CompA]::MoveTo($w, $x, $r[1]); "  moved a window from $($r[0]) to $x"
      Start-Sleep -Milliseconds 600
    }
  }
}

function CloseOthers {
  foreach ($w in [CompA]::Others($h)) { [CompA]::Close($w) }
  for ($i = 0; $i -lt 20 -and @([CompA]::Others($h)).Count -gt 0; $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 800
}

# Fills a sheet from rows of values; first column A (or the letter given), first row given. Values go in as text.
function FillAt ($ws, $rows, [int]$firstRow = 1, [string]$firstCol = 'A') {
  $c0 = [int][char]$firstCol
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { if ([string]$rows[$r][$c] -ne '') { $ws.Range(([string][char]($c0 + $c)) + ($r + $firstRow)).Formula = [string]$rows[$r][$c] } } }
}

# The fill handle of a cell (or the bottom-right cell of a range): a small box at its bottom-right corner, window pixels.
function FillHandleBox ($ws, $address) {
  $b = CellBox $ws $address
  return @(($b[0] + $b[2] - 8), ($b[1] + $b[3] - 8), 16, 16)
}

# Types into Excel's grid as a pupil would (posted characters), pictures it, then ends with Enter or Escape.
# No COM in between: Excel refuses COM calls in edit mode.
function TypeAndSnap ($text, $snapName, [switch]$Escape, [switch]$NoEnd) {
  # The first posted character only switches Excel into edit mode and is lost (9 October 2026), so F2
  # (edit the active cell, emptied first: typing over a cell replaces it anyway) goes first, then every character.
  try { $null = $xl.ActiveCell.ClearContents() } catch { }
  [CompA]::Key($grid, 0x71)
  Start-Sleep -Milliseconds 500
  [CompA]::Chars($grid, $text)
  Start-Sleep -Milliseconds 900
  if ($snapName) { SnapAll $snapName }
  if ($NoEnd) { return }
  if ($Escape) { [CompA]::Key($grid, 0x1B) } else { [CompA]::Key($grid, 0x0D) }
  Start-Sleep -Milliseconds 1200
}

# Sets up the visible Excel window as the other catexcel scripts do: 1600 x 800, zoom 100, at the back.
function ShowExcel {
  $xl.Visible = $true
  $xl.WindowState = -4143
  $script:h = [IntPtr]$xl.Hwnd
  [Shot]::Place($script:h, 40, 40, 1500, 800); Start-Sleep -Milliseconds 1500
  [Shot]::Place($script:h, 40, 40, 1600, 800)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $script:root = $AE::FromHandle($script:h)
  $script:grid = [Shot]::Child($script:h, 'EXCEL7')
}
