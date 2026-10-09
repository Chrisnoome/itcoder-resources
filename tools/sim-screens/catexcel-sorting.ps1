# Real Excel 365 screens for catexcel lesson 9, Sorting, filtering and
# finishing touches (AIPascalCourse/content/catexcel/sorting.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Phumlani Secondary's
# Grade 10 fun run: Sort A to Z, the Sort dialog box (its Sort by list open,
# one level, then two), Filter and the filtered list, the Thesaurus, Translate
# and a comment on the Review tab, the Illustrations menu, the Shapes gallery,
# Icons and a picture on the Insert tab, and the Themes gallery on the Page
# Layout tab. Menus and dialogs are windows of their own: SnapAll -Others
# draws them over Excel's window (as catexcel-printing.ps1). Also makes the
# pupils' starter file TeachersRace.xlsx (and a done-right copy, sorted by
# real Excel) in C:\sims\files\catexcel-sorting\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel at the end.
# Learnt (8 October 2026): pressing a ribbon tab leaves Excel in front, and
# the input guard then stopped the run - SnapAll hands the foreground back
# first (not while a drop-down is open: that closes it). The Sort Warning
# never showed (a whole-column Sort A to Z sorted the column alone); the
# filter drop-down would not open from a posted click or Alt+Down (once Excel
# hung); task panes close by "Close pane" - "Close" is Excel's own.
# Crop: work/catexcel-sorting-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-sorting -TimeoutSec 1200   (from the host)
$Name = 'catexcel-sorting'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

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

    public static IntPtr OtherByClass (IntPtr main, string className)
    {
        foreach (IntPtr h in Others (main))
        {
            System.Text.StringBuilder name = new System.Text.StringBuilder (256); GetClassName (h, name, 256);
            if (name.ToString () == className) { return h; }
        }
        return IntPtr.Zero;
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

    /// Hands the foreground back to the desktop (a pressed ribbon tab brings Excel to the front), so the
    /// input guard does not see Excel in front. No click, no key: one call.
    public static bool Away (IntPtr main)
    {
        uint mainPid; GetWindowThreadProcessId (main, out mainPid);
        uint frontPid; GetWindowThreadProcessId (GetForegroundWindow (), out frontPid);
        if (frontPid != mainPid) { return true; }
        return SetForegroundWindow (GetShellWindow ());
    }

    /// Alt+Down posted to one window (opens a cell's filter drop-down) - a message to that window only.
    public static void AltDown (IntPtr h)
    {
        PostMessage (h, 0x0104, new IntPtr (0x12), new IntPtr (0x20380001));   // WM_SYSKEYDOWN Alt
        PostMessage (h, 0x0104, new IntPtr (0x28), new IntPtr (0x21500001));   // WM_SYSKEYDOWN Down, Alt held
        PostMessage (h, 0x0105, new IntPtr (0x28), new IntPtr (unchecked ((int) 0xE1500001)));
        PostMessage (h, 0x0101, new IntPtr (0x12), new IntPtr (unchecked ((int) 0xC0380001)));
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
  # pressing a ribbon tab can bring Excel forward: back first, then the input check - but not while a
  # drop-down is open (losing the foreground closes it)
  if (-not $Others) { [Shot]::Back($h); $away = [Comp]::Away($h); Start-Sleep -Milliseconds 300; if (-not $away) { "  (Excel still in front before $n)" } }
  Guard
  Start-Sleep -Milliseconds 1100
  if ($Others) { [void][Comp]::Save($h, (Join-Path $out "$Name-$n.png")) } else { [Shot]::Back($h); Start-Sleep -Milliseconds 300; [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png")) }
  Guard
  "picture $n" + $(if ($Others) { " (with $(@([Comp]::Others($h)).Count) other windows)" } else { '' })
}

# Excel's other windows (a dialog, a drop-down) as UI Automation elements, from their handles
# (a NUIDialog is not listed under the desktop by process).
function OtherRoots {
  foreach ($w in [Comp]::Others($h)) { try { $AE::FromHandle($w) } catch { } }
}

function FindAny([string[]]$names, $type = $null, [int]$tries = 16) {
  $procId = [Shot]::Pid($h)
  for ($try = 0; $try -lt $tries; $try++) {
    foreach ($nm in $names) {
      $cond = New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, $nm)), (New-Object $PropCond($AE::ProcessIdProperty, [int]$procId)))
      if ($type) { $cond = New-Object System.Windows.Automation.AndCondition($cond, (New-Object $PropCond($AE::ControlTypeProperty, $type))) }
      $found = $AE::RootElement.FindFirst($Scope::Descendants, $cond)
      if ($found -and -not $found.Current.IsOffscreen) { return $found }
      foreach ($top in (OtherRoots)) {
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

function DumpOthers($file) {
  $win = [WinRect]::Of($h)
  $procId = [Shot]::Pid($h)
  $cond = New-Object $PropCond($AE::ProcessIdProperty, [int]$procId)
  $lines = foreach ($top in (OtherRoots)) {
    "== $($top.Current.Name) ($($top.Current.ClassName))"
    foreach ($e in $top.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { $c = $e.Current; if ($c.Name -or $c.ControlType -eq $T::ComboBox) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
    }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
  [Comp]::Describe($h)
}

# Closes a task pane (Thesaurus, Translator) by ITS Close button - never the window's own Close (that quits Excel).
function ClosePane {
  $win = [WinRect]::Of($h)
  foreach ($b in @($AE::FromHandle($h).FindAll($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Close pane')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))))) {
    if ($true) { "  closing the pane"; Press $b; Start-Sleep -Milliseconds 1000; return }
  }
  "  no pane Close button"
}

function MarkAny($key, [string[]]$names, $type = $null) {
  try { Mark $key (Box (FindAny $names $type -tries 6)) } catch { "  MISSING $key ($($names -join ' / '))" }
}

function WaitOthers([int]$want = 1, [int]$tries = 24) {
  for ($i = 0; $i -lt $tries -and @([Comp]::Others($h)).Count -lt $want; $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 1200
}

function CloseOthers {
  foreach ($w in [Comp]::Others($h)) { [Comp]::Close($w) }
  for ($i = 0; $i -lt 20 -and @([Comp]::Others($h)).Count -gt 0; $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 800
}

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Fill ($ws, $rows, [int]$firstRow = 1) {
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { if ([string]$rows[$r][$c] -ne '') { $ws.Range(([string][char](65 + $c)) + ($r + $firstRow)).Formula = [string]$rows[$r][$c] } } }
}

function SortBy ($ws, $range, $keys) {
  $s = $ws.Sort
  $s.SortFields.Clear()
  foreach ($k in $keys) { $null = $s.SortFields.Add($ws.Range($k[0]), 0, $k[1]) }   # xlSortOnValues; 1 ascending, 2 descending
  $s.SetRange($ws.Range($range))
  $s.Header = 1                                                                      # xlYes
  $s.Apply()
}

$runners = @(
  @('Ndlovu',   'Sipho',   '10B', 24.5, 150),
  @('Adams',    'Chloe',   '10A', 31.2, 220),
  @('Khumalo',  'Zanele',  '10C', 22.8, 80),
  @('Pillay',   'Imran',   '10A', 27.0, 300),
  @('Mahlangu', 'Gift',    '10B', 19.6, 120),
  @('Botha',    'Owen',    '10C', 35.4, 450),
  @('Dlamini',  'Bongani', '10A', 21.3, 60),
  @('Venter',   'Hendrik', '10B', 29.9, 200),
  @('Mokoena',  'Ayanda',  '10C', 18.4, 100),
  @('Patel',    'Fatima',  '10A', 26.1, 250),
  @('Sithole',  'Mpho',    '10B', 33.0, 90),
  @('Jacobs',   'Tamsin',  '10C', 23.7, 180),
  @('Zulu',     'Lindiwe', '10B', 25.2, 130),
  @('Fourie',   'Carmen',  '10A', 30.6, 160))

$teachers = @(
  @('Naidoo',        'Priya',    'CAT',               27.4, 350),
  @('Khoza',         'Sibusiso', 'Mathematics',       22.9, 200),
  @('van der Merwe', 'Annelie',  'Afrikaans',         31.8, 150),
  @('Mthembu',       'Nandi',    'Life Sciences',     25.6, 400),
  @('Peters',        'Graham',   'History',           34.2, 120),
  @('Radebe',        'Thulani',  'Physical Education', 19.7, 500),
  @('Govender',      'Kavitha',  'English',           29.3, 260),
  @('Molefe',        'Kagiso',   'Geography',         24.1, 180),
  @('Smith',         'Joanne',   'Accounting',        38.5, 300),
  @('Cele',          'Andile',   'Physical Sciences', 21.5, 220))

function ListSheet ($ws, $title, $heads, $rows) {
  $ws.Range('A1').Formula = $title
  Fill $ws @(,$heads) 3
  Fill $ws $rows 4
  $last = 3 + $rows.Count
  try { $ws.Range('A1').Style = 'Title' } catch { $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 16 }
  try { $ws.Range('A3:E3').Style = 'Accent1' } catch { }
  $ws.Range('A3:E3').Font.Bold = $true
  $ws.Range("D4:D$last").NumberFormat = '0.0'
  $ws.Columns.Item('A').ColumnWidth = 15; $ws.Columns.Item('B').ColumnWidth = 12; $ws.Columns.Item('C').ColumnWidth = 18
  $ws.Columns.Item('D').ColumnWidth = 11; $ws.Columns.Item('E').ColumnWidth = 11
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  while ($sb.Worksheets.Count -lt 2) { $null = $sb.Worksheets.Add([Type]::Missing, $sb.Worksheets.Item($sb.Worksheets.Count)) }
  $st = $sb.Worksheets.Item(1); $st.Name = 'Times'
  $sn = $sb.Worksheets.Item(2); $sn.Name = 'Names'
  $heads = @('Surname', 'First name', 'Subject', 'Time (min)', 'Raised (R)')
  ListSheet $st 'Phumlani Fun Run 2026 - the teachers'' race' $heads $teachers
  ListSheet $sn 'Phumlani Fun Run 2026 - the teachers'' race' $heads $teachers
  $null = $st.Activate(); $null = $st.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'TeachersRace.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'TeachersRace.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  SortBy $st 'A3:E13' @(,@('D4:D13', 1))
  SortBy $sn 'A3:E13' @(,@('A4:A13', 1))
  "done Times: $($st.Range('A4').Text) $($st.Range('D4').Text) ... $($st.Range('A13').Text) $($st.Range('D13').Text)"
  "done Names: $($sn.Range('A4').Text) $($sn.Range('B4').Text) ... $($sn.Range('A13').Text) $($sn.Range('B13').Text)"
  $sb.SaveAs((Join-Path $filesDir 'TeachersRace-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Results'
  $pupilHeads = @('Surname', 'First name', 'Class', 'Time (min)', 'Money')
  ListSheet $ws 'Phumlani Fun Run 2026 - Grade 10' $pupilHeads $runners
  function Restore {
    try { if ($ws.AutoFilterMode) { $ws.AutoFilterMode = $false } } catch { }
    $ws.Sort.SortFields.Clear()
    $ws.Range('A1:E17').Clear()
    ListSheet $ws 'Phumlani Fun Run 2026 - Grade 10' $pupilHeads $runners
  }
  $null = $ws.Range('G5').Select()

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
  foreach ($a in 'A1', 'A3', 'C3', 'D3', 'E3', 'A4:A17', 'C4:C17', 'D4:D17', 'A4:E17', 'A7', 'D6', 'D12', 'E3', 'G5') { Mark ('cell' + ($a -replace ':', '_')) (CellBox $ws $a) }
  foreach ($tab in 'Home', 'Insert', 'Page Layout', 'Data', 'Review') { TryMark ('tab' + ($tab -replace ' ', '')) $root @($tab) $T::TabItem }

  # 1. Sort A to Z: one cell in the column, Data tab > Sort A to Z.
  SnapAll 's-1'                                                     # Home tab, G5 (outside the list)
  Press (Find $root @('Data') $T::TabItem)
  Start-Sleep -Milliseconds 1000
  Dump 'data'
  foreach ($nm in 'Sort A to Z', 'Sort Z to A', 'Filter', 'Clear', 'Reapply') { TryMark ('btn' + ($nm -replace ' ', '')) $root @($nm) }; TryMark 'btnSort' $root @('Sort...', 'Sort', 'Custom Sort...')
  SnapAll 's-2'                                                     # Data tab, G5
  $null = $ws.Range('A7').Select()
  SnapAll 's-3'                                                     # A7 (Pillay) selected
  try { Press (Find $root @('Sort A to Z') -tries 8); Start-Sleep -Milliseconds 1500 } catch { "sort a-z button: $_"; SortBy $ws 'A3:E17' @(,@('A4:A17', 1)) }
  "after Sort A to Z: A4 $($ws.Range('A4').Text), A17 $($ws.Range('A17').Text), B4 $($ws.Range('B4').Text)"
  SnapAll 's-4'                                                     # sorted by surname

  Restore

  # 3. The Sort dialog box: Sort by Time (min), Smallest to Largest.
  $null = $ws.Range('D6').Select()
  SnapAll 'd-1'                                                     # Data tab, D6
  try {
    PressAsync (Find $root @('Sort...', 'Sort', 'Custom Sort...') -tries 8)
    WaitOthers
    DumpOthers 'sortdlg'
    $dlg = @(OtherRoots) | Select-Object -First 1
    $combos = @()
    if ($dlg) {
      $i = 0
      foreach ($cb in $dlg.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ComboBox)))) { $combos += ,$cb; Mark ("combo$i") (Box $cb); $i++ }
      foreach ($nm in 'OK', 'Cancel', 'Add Level', 'Delete Level', 'Copy Level', 'Options...', 'My data has headers') { MarkAny ('dlg' + ($nm -replace '[ .]', '')) @($nm) }
    }
    SnapAll 'd-2' -Others                                           # the dialog: Sort by empty
    if ($combos.Count -gt 0) {
      Expand $combos[0]
      Start-Sleep -Milliseconds 1500
      DumpOthers 'sortbylist'
      MarkAny 'itemTime' @('Time (min)')
      MarkAny 'itemSurname' @('Surname')
      SnapAll 'd-3' -Others                                         # the Sort by list open
      $picked = $false
      $lb = [Comp]::OtherByClass($h, 'REListBox20W')
      if ($lb -ne [IntPtr]::Zero) {
        $r = [XlMsg]::Rect($lb); Mark 'sortList' @(($r[0] - [WinRect]::Of($h)[0]), ($r[1] - [WinRect]::Of($h)[1]), $r[2], $r[3])
        foreach ($k in 1..4) { [Shot]::PostKey($lb, 0x28); Start-Sleep -Milliseconds 150 }   # Down to the fourth heading, Time (min)
        Start-Sleep -Milliseconds 600
        SnapAll 'd-3b' -Others
        [Shot]::PostKey($lb, 0x0D); $picked = $true                                            # Enter chooses it
      }
      Start-Sleep -Milliseconds 800
      if (@([Comp]::Others($h)).Count -gt 1) { Collapse $combos[0] }
      Start-Sleep -Milliseconds 1200
      "picked: $picked"
      SnapAll 'd-4' -Others                                         # Sort by Time (min)
      try { Press (FindAny @('OK') $T::Button -tries 6) } catch { "ok: $_"; CloseOthers }
      Start-Sleep -Milliseconds 1500
    } else { CloseOthers }
  } catch { "sort dialog: $_"; CloseOthers }
  if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers }
  "after the dialog: A4 $($ws.Range('A4').Text) D4 $($ws.Range('D4').Text)"
  if ($ws.Range('A4').Text -ne 'Mokoena') {
    # the dialog's list could not be driven: the sort through COM, the list put back, the dialog drawn again showing it
    SortBy $ws 'A3:E17' @(,@('D4:D17', 1))
    Fill $ws $runners 4
    $null = $ws.Range('D6').Select()
    try {
      PressAsync (Find $root @('Sort...', 'Sort', 'Custom Sort...') -tries 8)
      WaitOthers
      SnapAll 'd-4b' -Others                                        # Sort by Time (min), from the sheet's sort
      CloseOthers
    } catch { "sort dialog again: $_"; CloseOthers }
    SortBy $ws 'A3:E17' @(,@('D4:D17', 1))
  }
  $null = $ws.Range('D6').Select()
  SnapAll 'd-5'                                                     # sorted by time
  # two levels: Class, then Surname
  SortBy $ws 'A3:E17' @(@('C4:C17', 1), @('A4:A17', 1))
  $null = $ws.Range('C6').Select()
  try {
    PressAsync (Find $root @('Sort...', 'Sort', 'Custom Sort...') -tries 8)
    WaitOthers
    DumpOthers 'sortdlg2'
    SnapAll 'd-6' -Others                                           # two levels
    CloseOthers
  } catch { "two levels: $_"; CloseOthers }
  SnapAll 'd-7'                                                     # by class, then surname

  # 4. Filter: Data tab > Filter, the Class arrow, only 10B.
  Restore
  $null = $ws.Range('C6').Select()
  SnapAll 'f-1'                                                     # Data tab, C6
  try { Press (Find $root @('Filter') -tries 8); Start-Sleep -Milliseconds 1500 } catch { "filter button: $_"; $null = $ws.Range('A3:E17').AutoFilter() }
  "filter on: $($ws.AutoFilterMode)"
  $c3 = CellBox $ws 'C3'
  Mark 'arrowC3' @(($c3[0] + $c3[2] - 20), ($c3[1] + 1), 19, ($c3[3] - 2))
  $d3 = CellBox $ws 'D3'
  Mark 'arrowD3' @(($d3[0] + $d3[2] - 20), ($d3[1] + 1), 19, ($d3[3] - 2))
  SnapAll 'f-2'                                                     # arrows on the headings
  # The filter drop-down is not drawn here: a click or Alt+Down posted to the grid either did nothing or
  # left Excel waiting (8 October 2026). The lesson shows the drop-down in words; the filter is set through COM.
  if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers }
  if (-not $ws.FilterMode) { $null = $ws.Range('A3:E17').AutoFilter(3, '10B') }
  $null = $ws.Range('C6').Select()
  Start-Sleep -Milliseconds 800
  foreach ($r in 4..17) { if (-not $ws.Rows.Item($r).Hidden) { Mark ('shownRow' + $r) (CellBox $ws "A$r") } }
  SnapAll 'f-6'                                                     # only 10B
  Restore

  # 5. Review: Thesaurus on E3 (Money), Translate, a comment on D12.
  $null = $ws.Range('E3').Select()
  SnapAll 't-1'                                                     # Home tab, E3
  Press (Find $root @('Review') $T::TabItem)
  Start-Sleep -Milliseconds 1000
  Dump 'review'
  foreach ($nm in 'Spelling...', 'Thesaurus...', 'Translate', 'New Comment', 'Show Comments', 'Delete', 'Notes') { TryMark ('btn' + ($nm -replace ' ', '')) $root @($nm) }
  SnapAll 't-2'                                                     # Review tab, E3
  try {
    Press (Find $root @('Thesaurus...', 'Thesaurus') -tries 8)
    Start-Sleep -Milliseconds 4000
    SnapAll 't-3'                                                   # the Thesaurus pane
    SnapAll 't-3o' -Others
    ClosePane
    Start-Sleep -Milliseconds 1200
  } catch { "thesaurus: $_" }
  $null = $ws.Range('A1').Select()
  try {
    PressAsync (Find $root @('Translate') -tries 8)
    Start-Sleep -Milliseconds 6000
    Dump 'translator'
    SnapAll 'tr-1' -Others                                          # the Translator pane
    try {
      $to = Find $root @('To', 'To English', 'Target language') -tries 4
      Expand $to; Start-Sleep -Milliseconds 1500
      SnapAll 'tr-2' -Others
      Press (FindAny @('Afrikaans') -tries 6); Start-Sleep -Milliseconds 4000
      SnapAll 'tr-3' -Others                                        # into Afrikaans
    } catch { "translate to: $_" }
    if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers }
    ClosePane
    Start-Sleep -Milliseconds 1200
  } catch { "translate: $_" }
  # 5b. Comments: Review tab, D12.
  SaveMarks
  Press (Find $root @('Review') $T::TabItem)
  Start-Sleep -Milliseconds 1000
  foreach ($btn in @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Comments have changed'))))) {
    foreach ($b in @($btn.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))) { "  callout button: $($b.Current.Name)" }
    try { Press (@($btn.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))[-1]); Start-Sleep -Milliseconds 800 } catch { "callout: $_" }
  }
  $null = $ws.Range('D12').Select()
  SnapAll 'c-1'                                                     # Review tab, D12
  try {
    PressAsync (Find $root @('New Comment') -tries 8)
    Start-Sleep -Milliseconds 3500
    DumpOthers 'commentothers'
    SnapAll 'c-2' -Others                                           # the comment box
    $box = $null
    foreach ($nm in 'Start a conversation', 'Start a conversation. Use @mention to tag someone.', 'Comment', 'Reply') { try { $box = FindAny @($nm) -tries 2; break } catch { } }
    if ($box) {
      Mark 'commentBox' (Box $box)
      try { SetText $box 'Check this time - a new record?'; Start-Sleep -Milliseconds 800; SnapAll 'c-3' -Others } catch { "comment text: $_" }
      MarkAny 'postBtn' @('Post comment (Ctrl + Enter)', 'Post comment', 'Post')
      try { Press (FindAny @('Post comment (Ctrl + Enter)', 'Post comment', 'Post') -tries 4); Start-Sleep -Milliseconds 2000 } catch { "post: $_" }
    }
  } catch { "new comment: $_" }
  if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers }
  "comments now: $($ws.CommentsThreaded.Count)"
  if ($ws.CommentsThreaded.Count -eq 0) { try { $null = $ws.Range('D12').AddCommentThreaded('Check this time - a new record?') } catch { "threaded comment: $_" } }
  $null = $ws.Range('G5').Select()
  Start-Sleep -Milliseconds 1000
  SnapAll 'c-4'                                                     # the purple mark on D12
  try { Press (Find $root @('Show Comments') -tries 6); Start-Sleep -Milliseconds 2500; SnapAll 'c-5'; SnapAll 'c-5o' -Others; Press (Find $root @('Show Comments') -tries 4); Start-Sleep -Milliseconds 1000 } catch { "show comments: $_" }



  # 6. Insert tab: Shapes gallery, Icons, a shape and a picture on the sheet.
  Press (Find $root @('Insert') $T::TabItem)
  Start-Sleep -Milliseconds 1000
  Dump 'insert'
  foreach ($nm in 'Illustrations', 'Pictures', 'Shapes', 'Icons', '3D Models', 'SmartArt', 'Screenshot') { TryMark ('ins' + ($nm -replace ' ', '')) $root @($nm) $T::MenuItem }
  SnapAll 'p-1'                                                     # the Insert tab
  $shapesBtn = $null
  try { $shapesBtn = Find $root @('Shapes') -tries 4 } catch { }
  if (-not $shapesBtn) {
    try {
      $ill = Find $root @('Illustrations') $T::MenuItem -tries 6
      Expand $ill; Start-Sleep -Milliseconds 1500
      DumpOthers 'illmenu'
      MarkAny 'menuShapes' @('Shapes'); MarkAny 'menuIcons' @('Icons'); MarkAny 'menuPictures' @('Pictures')
      SnapAll 'p-1b' -Others                                        # the Illustrations menu
      $shapesBtn = FindAny @('Shapes') -tries 6
    } catch { "illustrations: $_" }
  }
  if ($shapesBtn) {
    try {
      Expand $shapesBtn; Start-Sleep -Milliseconds 1800
      DumpOthers 'shapes'
      MarkAny 'shapeCallout' @('Speech Bubble: Rectangle with Corners Rounded', 'Speech Bubble: Rectangle')
      MarkAny 'shapeRounded' @('Rectangle: Rounded Corners')
      MarkAny 'shapeArrow'   @('Arrow: Right')
      SnapAll 'p-2' -Others                                         # the Shapes gallery
      Collapse $shapesBtn; Start-Sleep -Milliseconds 600
      if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers }
    } catch { "shapes gallery: $_" }
  }
  try {
    try { $ill2 = Find $root @('Illustrations') $T::MenuItem -tries 4; Expand $ill2; Start-Sleep -Milliseconds 1500 } catch { }
    PressAsync (FindAny @('Icons') -tries 6)
    WaitOthers 1 30
    Start-Sleep -Milliseconds 4000
    DumpOthers 'icons'
    SnapAll 'p-3' -Others                                           # the Icons window
    CloseOthers
  } catch { "icons: $_"; if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers } }
  $g5 = $ws.Range('G4')
  $shape = $ws.Shapes.AddShape(106, $g5.Left + 10, $g5.Top, 170, 60)          # msoShapeRoundedRectangularCallout
  $shape.TextFrame2.TextRange.Text = 'Fastest runner: Ayanda Mokoena, 18.4 min!'
  try { $shape.Adjustments.Item(1) = -0.75; $shape.Adjustments.Item(2) = 1.6 } catch { }
  $null = $shape.Select()
  Start-Sleep -Milliseconds 1200
  try { Press (Find $root @('Shape Format') $T::TabItem -tries 8); Start-Sleep -Milliseconds 1000 } catch { "shape format tab: $_" }
  $sx = CellBox $ws 'G4'
  SnapAll 'p-4'                                                     # the shape, selected; the Shape Format tab
  # a picture: a medal drawn here, saved as a PNG and inserted from this device
  $png = Join-Path $env:TEMP 'catexcel-medal.png'
  $bmp = New-Object Drawing.Bitmap 160, 200
  $g = [Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.Clear([Drawing.Color]::White)
  $g.FillPolygon((New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(0, 112, 192))), [Drawing.Point[]]@((New-Object Drawing.Point 40, 0), (New-Object Drawing.Point 75, 0), (New-Object Drawing.Point 95, 90), (New-Object Drawing.Point 60, 90)))
  $g.FillPolygon((New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(192, 0, 0))), [Drawing.Point[]]@((New-Object Drawing.Point 85, 0), (New-Object Drawing.Point 120, 0), (New-Object Drawing.Point 100, 90), (New-Object Drawing.Point 65, 90)))
  $g.FillEllipse((New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(230, 180, 30))), 20, 70, 120, 120)
  $g.DrawEllipse((New-Object Drawing.Pen ([Drawing.Color]::FromArgb(160, 110, 0)), 6), 26, 76, 108, 108)
  $font = New-Object Drawing.Font 'Segoe UI', 44, ([Drawing.FontStyle]::Bold)
  $fmt = New-Object Drawing.StringFormat; $fmt.Alignment = 'Center'; $fmt.LineAlignment = 'Center'
  $g.DrawString('1', $font, [Drawing.Brushes]::White, (New-Object Drawing.RectangleF 20, 70, 120, 120), $fmt)
  $g.Dispose(); $bmp.Save($png, [Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
  $j = $ws.Range('J4')
  $pic = $ws.Shapes.AddPicture($png, 0, -1, $j.Left + 10, $j.Top, 64, 80)
  $null = $ws.Range('G14').Select()
  Start-Sleep -Milliseconds 1000
  SnapAll 'p-5'                                                     # the shape and the picture on the sheet

  # 7. Page Layout tab: the Themes gallery, then a theme applied (the list, the shape and the picture change with it).
  $null = $ws.Range('G14').Select()
  Press (Find $root @('Page Layout') $T::TabItem)
  Start-Sleep -Milliseconds 1000
  Dump 'pagelayout'
  foreach ($nm in 'Themes', 'Colors', 'Fonts', 'Effects') { TryMark ('th' + $nm) $root @($nm) }
  SnapAll 'th-1'                                                    # the Page Layout tab
  $themesBtn = $null
  try { $themesBtn = Find $root @('Themes') $T::MenuItem -tries 6 } catch { "  MISSING Themes" }
  if ($themesBtn) {
    try {
      Expand $themesBtn; Start-Sleep -Milliseconds 2500
      DumpOthers 'themes'
      foreach ($nm in 'Office Theme', 'Facet', 'Ion', 'Ion Boardroom', 'Organic', 'Retrospect', 'Slice', 'Wisp', 'Integral', 'Basis', 'Berlin', 'Celestial') { MarkAny ('theme' + ($nm -replace ' ', '')) @($nm) }
      SnapAll 'th-2' -Others                                        # the Themes gallery
      Collapse $themesBtn; Start-Sleep -Milliseconds 600
      if (@([Comp]::Others($h)).Count -gt 0) { CloseOthers }
    } catch { "themes gallery: $_" }
  }
  $themeDir = Get-ChildItem 'C:\Program Files\Microsoft Office\root\Document Themes 16', 'C:\Program Files (x86)\Microsoft Office\root\Document Themes 16' -Filter '*.thmx' -ErrorAction SilentlyContinue
  "themes on disk: $(($themeDir | ForEach-Object { $_.BaseName }) -join ', ')"
  $pick = $themeDir | Where-Object { $_.BaseName -eq 'Ion' } | Select-Object -First 1
  if (-not $pick) { $pick = $themeDir | Where-Object { $_.BaseName -in 'Facet', 'Slice', 'Retrospect' } | Select-Object -First 1 }
  if ($pick) { $wb.ApplyTheme($pick.FullName); "applied $($pick.BaseName)" }
  Start-Sleep -Milliseconds 1500
  SnapAll 'th-3'                                                    # the new theme

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }   # only this run's Excel (a dialog left open would keep it running)
}
