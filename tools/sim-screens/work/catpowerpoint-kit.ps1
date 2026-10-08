# Shared helpers for the Presentations course's screen scripts
# (catpowerpoint-<lessonId>.ps1 - cat-practical-writing.md, 8 October 2026).
# Dot-source it AFTER office-kit.ps1:
#     $Name = 'catpowerpoint-start'; . (Join-Path $PSScriptRoot 'office-kit.ps1')
#     . (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')
# It lives in work\ so that vm-shots.ps1 copies it into the VM with the script.
#
# Runs ONLY in the CAT VM (itcoder-cat), where nobody uses the mouse or the
# keyboard: unlike office-kit's rule, a few moments here need a real right-click
# or a menu open (a context menu, a drop-down gallery), which PrintWindow does
# not draw. Those moments bring PowerPoint to the front, use the real mouse or
# keys, and take the picture from the screen (Grab). Each one resets
# office-kit's input guard afterwards, so its own input never stops the run.

Add-Type -ReferencedAssemblies System.Drawing, ([System.Windows.Automation.AutomationElement].Assembly.Location), ([System.Windows.Automation.ControlType].Assembly.Location), ([Reflection.Assembly]::Load('WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35').Location) -TypeDefinition @'
using System; using System.Text; using System.Threading; using System.Drawing; using System.Drawing.Imaging;
using System.Runtime.InteropServices; using System.Windows.Automation;
public static class PP {
  [DllImport ("user32.dll")] static extern bool SetForegroundWindow (IntPtr h);
  [DllImport ("user32.dll")] static extern bool BringWindowToTop (IntPtr h);
  [DllImport ("user32.dll")] static extern bool SetCursorPos (int x, int y);
  [DllImport ("user32.dll")] static extern void mouse_event (uint f, int x, int y, uint d, UIntPtr e);
  [DllImport ("user32.dll")] static extern void keybd_event (byte vk, byte scan, uint f, UIntPtr e);
  [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr h, out RECT r);
  [DllImport ("user32.dll")] static extern bool SetWindowPos (IntPtr h, IntPtr after, int x, int y, int w, int hh, uint f);
  [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }

  /// PowerPoint in front (the VM only): Alt pressed and let go first, so Windows lets the window come forward.
  public static void Front (IntPtr h) {
    keybd_event (0x12, 0, 0, UIntPtr.Zero); keybd_event (0x12, 0, 2, UIntPtr.Zero);
    SetWindowPos (h, new IntPtr (0), 0, 0, 0, 0, 0x0001 | 0x0002);
    BringWindowToTop (h); SetForegroundWindow (h); Thread.Sleep (400);
  }
  /// A real click at a screen point: button "left", "right" or "double".
  public static void Click (int x, int y, string button) {
    SetCursorPos (x, y); Thread.Sleep (150);
    uint down = button == "right" ? 0x0008u : 0x0002u, up = button == "right" ? 0x0010u : 0x0004u;
    mouse_event (down, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (90); mouse_event (up, 0, 0, 0, UIntPtr.Zero);
    if (button == "double") { Thread.Sleep (80); mouse_event (down, 0, 0, 0, UIntPtr.Zero); mouse_event (up, 0, 0, 0, UIntPtr.Zero); }
    Thread.Sleep (300);
  }
  /// The mouse out of the way (no hover effects on the pictures).
  public static void Park (int x, int y) { SetCursorPos (x, y); Thread.Sleep (200); }
  /// A real key press, with Ctrl and/or Shift held if asked.
  public static void Key (byte vk, bool ctrl, bool shift) {
    if (ctrl) keybd_event (0x11, 0, 0, UIntPtr.Zero);
    if (shift) keybd_event (0x10, 0, 0, UIntPtr.Zero);
    keybd_event (vk, 0, 0, UIntPtr.Zero); keybd_event (vk, 0, 2, UIntPtr.Zero);
    if (shift) keybd_event (0x10, 0, 2, UIntPtr.Zero);
    if (ctrl) keybd_event (0x11, 0, 2, UIntPtr.Zero);
    Thread.Sleep (300);
  }
  /// The window's rectangle on the screen, taken from the screen itself - menus and drop-downs included.
  public static string Grab (IntPtr h, string file) {
    RECT r; GetWindowRect (h, out r);
    int w = r.Right - r.Left, hh = r.Bottom - r.Top;
    using (Bitmap b = new Bitmap (w, hh, PixelFormat.Format32bppArgb)) {
      using (Graphics g = Graphics.FromImage (b)) { g.CopyFromScreen (r.Left, r.Top, 0, 0, new Size (w, hh)); }
      b.Save (file, ImageFormat.Png);
    }
    return w + " x " + hh;
  }
  /// Invoke on a thread of its own (a control that opens a dialog would block the caller).
  public static void Later (AutomationElement e) {
    Thread t = new Thread (delegate () { try { object p; if (e.TryGetCurrentPattern (InvokePattern.Pattern, out p)) ((InvokePattern) p).Invoke (); } catch (Exception) { } });
    t.IsBackground = true; t.Start ();
  }
}
'@

# After our own real input: the guard must not count it as somebody's.
function Calm { $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false }

# A real click on a window-pixel box's centre (or a point in it).
function RealClick($box, [string]$button = 'left', [double]$fx = 0.5, [double]$fy = 0.5) {
  $win = [WinRect]::Of($h)
  [PP]::Front($h)
  [PP]::Click([int]($win[0] + $box[0] + $box[2] * $fx), [int]($win[1] + $box[1] + $box[3] * $fy), $button)
  Calm
}

# PowerPoint brought to the front only when it is not there already - a dialog of its own keeps the focus.
function FrontIfNeeded { if ([Shot]::FrontPid() -ne [Shot]::Pid($h)) { [PP]::Front($h) } }
function RealKey([byte]$vk, [switch]$Ctrl, [switch]$Shift) { FrontIfNeeded; [PP]::Key($vk, [bool]$Ctrl, [bool]$Shift); Calm }

# The picture from the screen, PowerPoint in front: for moments with a menu or drop-down open.
function Grab($n) {
  if ([Shot]::FrontPid() -ne [Shot]::Pid($h)) { [PP]::Front($h) }   # another program (Google Drive's pop-up) in front
  Start-Sleep -Milliseconds 700                                  # no Park here: moving the mouse closes Office's menus
  [void][PP]::Grab($h, (Join-Path $out "$Name-$n.png"))
  Calm
  "picture $n (screen)"
}

# Where a UI Automation element is, by name, anywhere on the screen - for menus outside the window.
function FindAnywhere([string[]]$names, $type = $null, [int]$tries = 16) {
  $desk = $AE::RootElement
  for ($try = 0; $try -lt $tries; $try++) {
    foreach ($name in $names) {
      $cond = New-Object $PropCond($AE::NameProperty, $name)
      if ($type) { $cond = New-Object System.Windows.Automation.AndCondition($cond, (New-Object $PropCond($AE::ControlTypeProperty, $type))) }
      $found = $null
      try { $found = $desk.FindFirst($Scope::Descendants, $cond) } catch { }
      if ($found -and -not $found.Current.IsOffscreen) { return $found }
    }
    Start-Sleep -Milliseconds 250
  }
  throw "No control called '$($names -join "' or '")' anywhere"
}

# Every named control on the whole desktop (a menu or gallery is a window of its own) - to find names.
function DumpAll($file) {
  $win = [WinRect]::Of($h)
  $all = @()
  try { $all = $AE::RootElement.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition) } catch { "  DumpAll $file`: $($_.Exception.Message)"; return }
  $lines = foreach ($e in $all) {
    try {
      $c = $e.Current
      if ($c.Name -and -not $c.IsOffscreen -and $c.ProcessId -eq [Shot]::Pid($h)) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" }
    } catch { }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}

# PowerPoint started with a new presentation in the default Office Theme, placed and sized.
function StartPowerPoint([int]$width = 1600, [int]$height = 900) {
  Get-Process POWERPNT -ErrorAction SilentlyContinue | Stop-Process -Force   # a PowerPoint left by a stopped run would block COM
  Start-Sleep -Milliseconds 800
  $script:pp = New-Object -ComObject PowerPoint.Application
  $pp.Visible = -1
  $script:pres = $pp.Presentations.Add(-1)
  $pp.WindowState = 1                                           # ppWindowNormal
  $script:h = [IntPtr]$pp.HWND
  [Shot]::Place($h, 30, 30, $width - 200, $height); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 30, 30, $width, $height)                    # sized twice: the ribbon lays itself out again
  Start-Sleep -Milliseconds 2000
  [PP]::Park(1900, 1060)                                        # the mouse off the window
  Calm
  $script:root = $AE::FromHandle($h)
}

# A layout of the slide master by its name ('Title Slide', 'Title and Content', 'Two Content' ...).
function Layout([string]$name) {
  foreach ($l in $pres.SlideMaster.CustomLayouts) { if ($l.Name -eq $name) { return $l } }
  throw "No layout called $name"
}

# A new slide at the end, in a layout, its placeholders filled in order (title first; "`r" between bullet lines).
function AddSlide([string]$layout, [string[]]$texts) {
  $slide = $pres.Slides.AddSlide($pres.Slides.Count + 1, (Layout $layout))
  for ($i = 0; $i -lt $texts.Count -and $i -lt $slide.Shapes.Placeholders.Count; $i++) {
    if ($texts[$i] -ne $null) { $slide.Shapes.Placeholders.Item($i + 1).TextFrame.TextRange.Text = $texts[$i] }
  }
  return $slide
}

# Go to a slide in Normal view (the thumbnail selected, the slide shown).
function GoTo([int]$n) { $pp.ActiveWindow.ViewType = 9; $pp.ActiveWindow.View.GotoSlide($n); Start-Sleep -Milliseconds 500 }

function ClosePowerPoint {
  try { foreach ($p in @($pp.Presentations)) { $p.Saved = -1; $p.Close() } } catch { }
  try { $pp.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($pp)
}

# Real typing into whatever has the focus in PowerPoint (a dialog's box, say) - the VM only.
Add-Type -AssemblyName System.Windows.Forms
function RealType([string]$text) {
  FrontIfNeeded
  [System.Windows.Forms.SendKeys]::SendWait(($text -replace '([+^%~(){}\[\]])', '{$1}'))
  Start-Sleep -Milliseconds 400
  Calm
}

# The top window of a dialog PowerPoint opened (Replace, Insert Outline ...), by its title - zero if none.
Add-Type -TypeDefinition @'
using System; using System.Text; using System.Runtime.InteropServices;
public static class PPWin {
  delegate bool EnumProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc p, IntPtr l);
  [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr h, out uint pid);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr h);
  public static IntPtr Find (uint pid, string title) {
    IntPtr found = IntPtr.Zero;
    EnumWindows (delegate (IntPtr h, IntPtr l) { uint p; GetWindowThreadProcessId (h, out p);
      if (p == pid && IsWindowVisible (h)) { StringBuilder t = new StringBuilder (256); GetWindowText (h, t, 256); if (t.ToString () == title) { found = h; return false; } }
      return true; }, IntPtr.Zero);
    return found;
  }
}
'@

# Opens a ribbon drop-down (a gallery, a split button's list, a combo box) through UI Automation - a real click
# on the ribbon right after COM work sometimes only shows the tooltip. Falls back to the real click.
function OpenMenu($element) {
  $p = $null
  if ($element.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand() } else { RealClick (Box $element) }
  Start-Sleep -Milliseconds 1200
}
# Presses a ribbon button that opens a dialog box, on a thread of its own (the dialog would block the call).
function OpenDialog($element) { [PP]::Later($element); Start-Sleep -Milliseconds 2000 }

# A Word outline (each line @(text, style): -2 Heading 1, -3 Heading 2) saved as a .docx, made in real Word
# in a job of its own: Word in the VM sometimes hangs on start (8 October 2026), and a hung Word must not
# stop the screens. Gives up after $timeoutSec and stops that Word.
function WordOutline([string]$path, $lines, [int]$timeoutSec = 120) {
  $packed = ($lines | ForEach-Object { "$([int]$_[1])`t$($_[0])" }) -join "`n"   # one "style<TAB>text" line each (5.1's JSON mangles nested arrays)
  $job = Start-Job -ArgumentList $path, $packed {
    param($p, $packed)
    $ls = $packed -split "`n" | ForEach-Object { , ($_ -split "`t", 2) }
    $word = New-Object -ComObject Word.Application
    try {
      $word.DisplayAlerts = 0
      $doc = $word.Documents.Add()
      $doc.Content.Text = (($ls | ForEach-Object { $_[1] }) -join "`r")
      for ($i = 0; $i -lt $ls.Count; $i++) { $doc.Paragraphs.Item($i + 1).Style = $(if ($ls[$i][0] -eq '-2') { 'Heading 1' } else { 'Heading 2' }) }
      $doc.SaveAs2($p, 16)
      $doc.Close()
      "saved $p"
    } finally { $word.Quit() }
  }
  if (Wait-Job $job -Timeout $timeoutSec) { try { Receive-Job $job -ErrorAction Stop } catch { "  WORD FAILED - $path`: $($_.Exception.Message)" } } else {
    Stop-Job $job; Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
    "  WORD HUNG - $path not made"
  }
  Remove-Job $job -Force
}

# The Designer pane opens by itself after a paste or a new picture (8 October 2026): closed before every picture.
function CloseDesigner {
  try {
    $pane = $root.FindFirst($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Designer')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Custom)))))
    if ($pane) {
      $close = $pane.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Close')))
      if ($close) { Press $close; Start-Sleep -Milliseconds 800 }
    }
  } catch { }
}
${function:SnapBase} = ${function:Snap}
function Snap($n) { CloseDesigner; SnapBase $n }

# Google Drive's own window pops up now and then in the VM (8 October 2026) and covers PowerPoint on a screen
# picture: minimised before each one.
Add-Type -TypeDefinition @'
using System; using System.Text; using System.Runtime.InteropServices;
public static class PPHide {
  delegate bool EnumProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc p, IntPtr l);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr h);
  [DllImport ("user32.dll")] static extern bool ShowWindow (IntPtr h, int c);
  public static int Minimise (string part) {
    int n = 0;
    EnumWindows (delegate (IntPtr h, IntPtr l) { if (IsWindowVisible (h)) { StringBuilder t = new StringBuilder (256); GetWindowText (h, t, 256);
      if (t.ToString ().IndexOf (part, StringComparison.OrdinalIgnoreCase) >= 0) { ShowWindow (h, 6); n++; } } return true; }, IntPtr.Zero);
    return n;
  }
}
'@
${function:GrabBase} = ${function:Grab}
function Grab($n) { [void][PPHide]::Minimise('Google Drive'); GrabBase $n }

# A real click on a ribbon drop-down: a click on the title bar first, so that the window is truly active - a
# first click on the ribbon otherwise only shows the button's tooltip (VM tests, 8 October 2026).
function RibbonClick($box) {
  $win = [WinRect]::Of($h)
  [PP]::Front($h); [PP]::Click($win[0] + 1250, $win[1] + 30, 'left'); Calm
  Start-Sleep -Milliseconds 400
  RealClick $box
}
