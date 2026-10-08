# Helpers shared by the catexcel-*.ps1 screen scripts (the CAT Spreadsheets
# course, Grade 10 lessons 1-4 - 8 October 2026). Dot-source it after
# office-kit.ps1:
#     . (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
# It lives in work\ because vm-shots.ps1 copies work\ into the VM with the
# script. Everything here keeps office-kit.ps1's rules: nothing clicks or
# types at the desktop - messages go to one window by its handle, and the
# pictures come from PrintWindow.

Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class XlMsg
{
    [DllImport ("user32.dll")] static extern bool PostMessage (IntPtr hWnd, uint message, IntPtr wParam, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr hWnd, out RECT rect);
    [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }

    [DllImport ("user32.dll")] static extern bool ScreenToClient (IntPtr hWnd, ref POINT point);
    [StructLayout (LayoutKind.Sequential)] public struct POINT { public int X, Y; }

    /// A screen point as a window's client point, packed for a mouse message's lParam.
    public static int ToClient (IntPtr hWnd, int x, int y) { POINT p; p.X = x; p.Y = y; ScreenToClient (hWnd, ref p); return (p.Y << 16) | (p.X & 0xFFFF); }

    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern IntPtr SendMessage (IntPtr hWnd, uint message, IntPtr wParam, string lParam);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr hWnd, System.Text.StringBuilder text, int size);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr hWnd, System.Text.StringBuilder name, int size);
    [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr hWnd);
    delegate bool EnumProc (IntPtr hWnd, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool EnumChildWindows (IntPtr parent, EnumProc proc, IntPtr lParam);

    /// The first visible child window of this class whose text (without the &) is this, or zero.
    public static IntPtr ChildByText (IntPtr parent, string className, string text)
    {
        IntPtr found = IntPtr.Zero;
        EnumChildWindows (parent, delegate (IntPtr h, IntPtr l) {
            System.Text.StringBuilder name = new System.Text.StringBuilder (256), caption = new System.Text.StringBuilder (256);
            GetClassName (h, name, 256); GetWindowText (h, caption, 256);
            if (name.ToString () == className && caption.ToString ().Replace ("&", "") == text && IsWindowVisible (h)) { found = h; return false; }
            return true; }, IntPtr.Zero);
        return found;
    }

    /// The visible child window of this class whose rectangle holds this screen point, or zero.
    public static IntPtr ChildAt (IntPtr parent, string className, int x, int y)
    {
        IntPtr found = IntPtr.Zero;
        EnumChildWindows (parent, delegate (IntPtr h, IntPtr l) {
            System.Text.StringBuilder name = new System.Text.StringBuilder (256);
            GetClassName (h, name, 256);
            RECT r; GetWindowRect (h, out r);
            if (name.ToString () == className && IsWindowVisible (h) && x >= r.Left && x < r.Right && y >= r.Top && y < r.Bottom) { found = h; return false; }
            return true; }, IntPtr.Zero);
        return found;
    }

    /// A window's rectangle on the screen: left, top, width, height.
    public static int[] Rect (IntPtr hWnd) { RECT r; GetWindowRect (hWnd, out r); return new int[] { r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top }; }

    /// Sets a window's text (an edit box) - WM_SETTEXT, to that window only.
    public static void SetText (IntPtr hWnd, string text) { SendMessage (hWnd, 0x000C, IntPtr.Zero, text); }

    /// Clicks a button by its handle - BM_CLICK, posted to that button only.
    public static void Click (IntPtr hWnd) { PostMessage (hWnd, 0x00F5, IntPtr.Zero, IntPtr.Zero); }

    /// A message posted to one window by its handle.
    public static void Post (IntPtr hWnd, uint message, int wParam, int lParam) { PostMessage (hWnd, message, new IntPtr (wParam), new IntPtr (lParam)); }

    /// Pastes the picture of a popup (a menu, a dialog) onto the picture of the main window, where it sits on the screen.
    public static void Paste (string mainFile, IntPtr main, string popupFile, IntPtr popup, string outFile)
    {
        RECT a, b;
        GetWindowRect (main, out a);
        GetWindowRect (popup, out b);
        using (Bitmap back = new Bitmap (mainFile))
        using (Bitmap front = new Bitmap (popupFile))
        using (Bitmap result = new Bitmap (back.Width, back.Height, PixelFormat.Format32bppArgb))
        {
            using (Graphics g = Graphics.FromImage (result))
            {
                g.DrawImage (back, 0, 0, back.Width, back.Height);
                g.DrawImage (front, b.Left - a.Left, b.Top - a.Top, front.Width, front.Height);
            }
            result.Save (outFile, ImageFormat.Png);
        }
    }
}
'@

# Fills a sheet from rows of values, A1 first. Values go in as text (PowerShell 5.1's COM binder).
function FillRows($ws, $rows, [int]$firstRow = 1) {
  for ($r = 0; $r -lt $rows.Count; $r++) {
    for ($c = 0; $c -lt $rows[$r].Count; $c++) {
      $v = $rows[$r][$c]
      if ($null -ne $v -and "$v" -ne '') { $ws.Range(([string][char](65 + $c)) + ($r + $firstRow)).Formula = [string]$v }
    }
  }
}

# Where a cell is on the picture of the main window: [x, y, w, h] in window pixels.
function CellBox ($ws, $address) {
  $win  = [WinRect]::Of($h)
  $pane = $xl.ActiveWindow.ActivePane
  $cell = $ws.Range($address)
  $x1 = $pane.PointsToScreenPixelsX($cell.Left) - $win[0]
  $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
  $y1 = $pane.PointsToScreenPixelsY($cell.Top) - $win[1]
  $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
  return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
}

# A column's heading (the letter above row 1 of what is on screen) and a row's heading (the number left of column A).
function ColHeadBox ($ws, $col) { $b = CellBox $ws "$($col)1"; $top = $xl.ActiveWindow.VisibleRange.Row; $t = CellBox $ws "$col$top"; return @($b[0], ($t[1] - 21), $b[2], 20) }
function RowHeadBox ($ws, $row) { $b = CellBox $ws "A$row"; return @(($b[0] - 34), $b[1], 32, $b[3]) }

# Where a control of another window (a dialog) is on that window's own picture.
function BoxIn($element, $handle) {
  $r   = $element.Current.BoundingRectangle
  $win = [WinRect]::Of($handle)
  return @([int]($r.X - $win[0]), [int]($r.Y - $win[1]), [int]$r.Width, [int]$r.Height)
}

# A top-level window of this Excel by its name (a dialog), or $null.
function TopWindow([string[]]$names, [int]$tries = 20) {
  $excelPid = [int][Shot]::Pid($h)
  for ($i = 0; $i -lt $tries; $i++) {
    foreach ($el in $AE::RootElement.FindAll($Scope::Children, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { if ($el.Current.ProcessId -eq $excelPid -and $names -contains $el.Current.Name) { return $el } } catch { }
    }
    # a dialog may be owned by the main window and listed under it
    foreach ($name in $names) {
      $found = $AE::FromHandle($h).FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, $name)))
      if ($found -and $found.Current.NativeWindowHandle -ne 0) { return $found }
    }
    Start-Sleep -Milliseconds 300
  }
  return $null
}

# Every named control of another window (a dialog) and where it is on its own picture.
function DumpOf($handle, $file) {
  $win = [WinRect]::Of($handle)
  $lines = foreach ($e in $AE::FromHandle($handle).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
    try {
      $c = $e.Current
      if ($c.Name -and -not $c.IsOffscreen) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" }
    } catch { }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}

# A picture of another window (a dialog) on its own.
function SnapOf($handle, $n) {
  Guard
  Start-Sleep -Milliseconds 900
  [void][Shot]::Save($handle, (Join-Path $out "$Name-$n.png"))
  Guard
  "picture $n (dialog)"
}

# A picture of the main window with a popup (a menu) pasted on where it is.
function SnapWithPopup($popupHandle, $n) {
  Guard
  Start-Sleep -Milliseconds 900
  $main  = Join-Path $env:TEMP "$Name-main.png"
  $popup = Join-Path $env:TEMP "$Name-popup.png"
  [void][Shot]::Save($h, $main)
  [void][Shot]::Save($popupHandle, $popup)
  [XlMsg]::Paste($main, $h, $popup, $popupHandle, (Join-Path $out "$Name-$n.png"))
  Guard
  "picture $n (with popup)"
}

# Sets a text box's value by UI Automation.
function SetText($element, [string]$text) {
  $pattern = $null
  if ($element.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$pattern)) { $pattern.SetValue($text); return }
  throw "'$($element.Current.Name)' takes no text"
}

# A picture of a dialog with anything personal blanked out: the signed-in
# account's OneDrive (it shows the owner's name and school) and the author.
function SnapPrivate($dialog, $handle, $n) {
  SnapOf $handle $n
  $file  = Join-Path $out "$Name-$n.png"
  $boxes = @()
  foreach ($e in $dialog.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
    try {
      $c = $e.Current
      if (-not $c.IsOffscreen -and ($c.Name -like 'Chris*' -or $c.Name -like '*Noome*' -or $c.Name -like '*De La Salle*' -or $c.Name -like 'OneDrive - *')) { $boxes += ,(BoxIn $e $handle); "  blanked '$($c.Name)'" }
    } catch { }
  }
  if ($boxes.Count -eq 0) { return }
  $bytes = [IO.File]::ReadAllBytes($file)
  $ms = New-Object IO.MemoryStream(,$bytes)
  $bmp = [Drawing.Bitmap]::FromStream($ms)
  $g = [Drawing.Graphics]::FromImage($bmp)
  foreach ($b in $boxes) {
    $colour = $bmp.GetPixel([Math]::Min($bmp.Width - 1, $b[0] + $b[2] + 3), [Math]::Max(0, $b[1] + 2))
    $brush = New-Object Drawing.SolidBrush($colour)
    $g.FillRectangle($brush, $b[0], $b[1], $b[2], $b[3])
    $brush.Dispose()
  }
  $g.Dispose()
  $bmp.Save($file, [Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose(); $ms.Dispose()
}

# Presses a control on another thread, for a button that opens a modal dialog
# or a gallery (the press would not come back until it closed).
$script:asyncPresses = @()
function PressAsync($element) {
  $ps = [powershell]::Create()
  $null = $ps.AddScript({ param($e)
    $p = $null
    if ($e.TryGetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern, [ref]$p)) { $p.Invoke() }
    elseif ($e.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand() }
  }).AddArgument($element)
  $script:asyncPresses += ,@($ps, $ps.BeginInvoke())
}

# A popup (a menu or gallery) of this Excel that is not the main window, or $null.
function PopupWindow([int]$tries = 15) {
  $excelPid = [int][Shot]::Pid($h)
  for ($i = 0; $i -lt $tries; $i++) {
    foreach ($el in $AE::RootElement.FindAll($Scope::Children, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { $c = $el.Current; if ($c.ProcessId -eq $excelPid -and $c.NativeWindowHandle -ne [int]$h -and $c.BoundingRectangle.Width -gt 50) { return $el } } catch { }
    }
    Start-Sleep -Milliseconds 300
  }
  return $null
}
