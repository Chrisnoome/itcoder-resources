# Shared helpers for the catdb (Databases - Access) screen scripts and starter
# files (AIPascalCourse/content/catdb/ - written to courses/cat-practical-writing.md,
# 9 October 2026). Dot-source it AFTER office-kit.ps1:
#     $Name = 'catdb-whatfor'; . (Join-Path $PSScriptRoot 'office-kit.ps1'); . (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
# Every database is built in real Access 365 through COM (DAO and Access SQL DDL) -
# never a file from elsewhere, so nothing needs Enable Content.
# Learnt (the pilot, cat-access.ps1): Access's design grids and datasheets are not
# visible to UI Automation - places on them are read off the pictures.

Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
public static class DbComp
{
    [DllImport ("user32.dll")] static extern bool PrintWindow (IntPtr hWnd, IntPtr hdc, uint flags);
    [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr hWnd, out RECT rect);
    [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr hWnd);
    [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr hWnd, out uint pid);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr hWnd, System.Text.StringBuilder name, int size);
    delegate bool EnumProc (IntPtr hWnd, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc proc, IntPtr lParam);
    [DllImport ("dwmapi.dll")] static extern int DwmGetWindowAttribute (IntPtr hWnd, int attribute, out RECT value, int size);
    [DllImport ("user32.dll")] static extern bool PostMessage (IntPtr hWnd, uint message, IntPtr wParam, IntPtr lParam);
    [DllImport ("user32.dll")] static extern IntPtr GetShellWindow ();
    [DllImport ("user32.dll")] static extern bool SetForegroundWindow (IntPtr hWnd);
    [DllImport ("user32.dll")] static extern IntPtr GetForegroundWindow ();
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

    public static bool Away (IntPtr main)
    {
        uint mainPid; GetWindowThreadProcessId (main, out mainPid);
        uint frontPid; GetWindowThreadProcessId (GetForegroundWindow (), out frontPid);
        if (frontPid != mainPid) { return true; }
        return SetForegroundWindow (GetShellWindow ());
    }

    public static void Close (IntPtr h) { PostMessage (h, 0x0010, IntPtr.Zero, IntPtr.Zero); }

    [StructLayout (LayoutKind.Sequential)] public struct GUITHREADINFO { public int cbSize, flags; public IntPtr hwndActive, hwndFocus, hwndCapture, hwndMenuOwner, hwndMoveSize, hwndCaret; public RECT rcCaret; }
    [DllImport ("user32.dll")] static extern bool GetGUIThreadInfo (uint thread, ref GUITHREADINFO info);

    /// The window that has the keyboard focus in the program's own thread (a combo box inside
    /// Access's grid, say) - so characters can be posted to exactly that window.
    public static IntPtr Focused (IntPtr main)
    {
        uint pid; uint thread = GetWindowThreadProcessId (main, out pid);
        GUITHREADINFO info = new GUITHREADINFO (); info.cbSize = Marshal.SizeOf (typeof (GUITHREADINFO));
        return GetGUIThreadInfo (thread, ref info) ? info.hwndFocus : IntPtr.Zero;
    }

    /// Characters posted to ONE window by its handle (WM_CHAR) - typing into Access's grid without the keyboard.
    public static void PostChars (IntPtr h, string text) { foreach (char c in text) { PostMessage (h, 0x0102, new IntPtr (c), IntPtr.Zero); } }

    /// Alt+Down posted to one window (opens a combo box's list) - a message to that window only.
    public static void AltDown (IntPtr h)
    {
        PostMessage (h, 0x0104, new IntPtr (0x12), new IntPtr (0x20380001));
        PostMessage (h, 0x0104, new IntPtr (0x28), new IntPtr (0x21500001));
        PostMessage (h, 0x0105, new IntPtr (0x28), new IntPtr (unchecked ((int) 0xE1500001)));
        PostMessage (h, 0x0101, new IntPtr (0x12), new IntPtr (unchecked ((int) 0xC0380001)));
    }

    static Bitmap Draw (IntPtr h, out RECT r, bool cut)
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

    /// The main window with every other window of the program (a dialog, a list) drawn over it.
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
                    using (Bitmap one = Draw (h, out r, true)) { g.DrawImage (one, r.Left - m.Left, r.Top - m.Top); }
                }
            }
            page.Save (file, ImageFormat.Png);
            return page.Width + " x " + page.Height;
        }
    }
}
'@

# The Property Sheet pane (Access remembers it open between sessions, even across runs):
# closed with its own ribbon button when it is showing and not wanted.
function NoPropertySheet {
  try {
    $root = $AE::FromHandle($h)
    $cond = New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Property Sheet')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Pane)))
    $pane = $root.FindFirst($Scope::Descendants, $cond)
    if ($pane -and -not $pane.Current.IsOffscreen) {
      $btn = $root.FindFirst($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Property Sheet')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))))
      if ($btn) { Press $btn; Start-Sleep -Milliseconds 700; $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false; '  Property Sheet closed' }
    }
  } catch { "  property sheet: $_" }
}

# A picture of Access with its dialogs drawn over it (-Others), or the window alone.
# The Property Sheet and Field List are closed first unless -KeepPanes.
function SnapDb($n, [switch]$Others, [switch]$KeepPanes) {
  if (-not $KeepPanes -and -not $Others) { NoPropertySheet }
  if (-not $Others) { [Shot]::Back($h); [void][DbComp]::Away($h); Start-Sleep -Milliseconds 300 }
  Guard
  Start-Sleep -Milliseconds 1100
  if ($Others) { [void][DbComp]::Save($h, (Join-Path $out "$Name-$n.png")) } else { [Shot]::Back($h); Start-Sleep -Milliseconds 300; [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png")) }
  Guard
  "picture $n" + $(if ($Others) { " (with $(@([DbComp]::Others($h)).Count) other windows)" } else { '' })
}

function DumpOthers($file) {
  $win = [WinRect]::Of($h)
  $lines = foreach ($w in [DbComp]::Others($h)) {
    try { $top = $AE::FromHandle($w) } catch { continue }
    "== $($top.Current.Name) ($($top.Current.ClassName))"
    foreach ($e in $top.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { $c = $e.Current; if ($c.Name) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
    }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
  [DbComp]::Describe($h)
}

# ---------------------------------------------------------------- DAO helpers

# A field property, made if it is not there yet (Caption, Format, DecimalPlaces, InputMask, DisplayControl ...).
# $type: 10 text, 3 integer, 2 byte, 1 yes/no.
function SetProp($obj, [string]$prop, [int]$type, $value) {
  try { $obj.Properties.Item($prop).Value = $value }
  catch { $obj.Properties.Append($obj.CreateProperty($prop, $type, $value)) }
}

# Yes/No fields made by DDL show 0/-1: give them a tick box, as Access's own Design View does.
function TickBox($db, [string]$table, [string]$field) {
  SetProp $db.TableDefs.Item($table).Fields.Item($field) 'DisplayControl' 3 106
}

function FieldFormat($db, [string]$table, [string]$field, [string]$format) {
  SetProp $db.TableDefs.Item($table).Fields.Item($field) 'Format' 10 $format
}

function Sq([string]$s) { "'" + $s.Replace("'", "''") + "'" }

# Rows into a table: $cols 'A, B, C'; each row an array of values already written as Access SQL literals.
function Rows($db, [string]$table, [string]$cols, $rows) {
  foreach ($r in $rows) { $db.Execute("INSERT INTO $table ($cols) VALUES (" + ($r -join ', ') + ")") }
}

# An auto form or report of a table (Create > Form / Create > Report), saved under a name. 539 / 540: acCmdNewObjectAutoForm / AutoReport.
function AutoObject($app, [string]$table, [string]$name, [string]$kind) {
  $app.DoCmd.SelectObject(0, $table, $true)
  Start-Sleep -Milliseconds 500
  if ($kind -eq 'form') { $app.DoCmd.RunCommand(539) } else { $app.DoCmd.RunCommand(540) }
  Start-Sleep -Milliseconds 1500
  $type = $(if ($kind -eq 'form') { 2 } else { 3 })
  $current = $(if ($kind -eq 'form') { $app.Screen.ActiveForm.Name } else { $app.Screen.ActiveReport.Name })
  $app.DoCmd.Save($type, $name)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Close($type, $name, 1)
  Start-Sleep -Milliseconds 500
  "  made $kind $name (was $current)"
}

# Every saved query's rows as Access returns them - to compare with the marker's re-run on the server.
function QueryAnswers($db) {
  $all = [ordered]@{}
  foreach ($q in $db.QueryDefs) {
    if ($q.Name.StartsWith('~')) { continue }
    $one = [ordered]@{ sql = $q.SQL; columns = @(); rows = @() }
    try {
      $rs = $q.OpenRecordset()
      $one.columns = @(for ($i = 0; $i -lt $rs.Fields.Count; $i++) { $rs.Fields.Item($i).Name })
      $rows = New-Object System.Collections.ArrayList
      while (-not $rs.EOF) {
        $row = @(for ($i = 0; $i -lt $rs.Fields.Count; $i++) { $v = $rs.Fields.Item($i).Value; if ($v -is [datetime]) { $v.ToString('yyyy-MM-dd HH:mm:ss') } elseif ($v -is [DBNull]) { $null } else { $v } })
        [void]$rows.Add($row)
        $rs.MoveNext()
      }
      $rs.Close()
      $one.rows = $rows
    } catch { $one.error = "$_" }
    $all[$q.Name] = $one
  }
  $all
}

# Out to the pupils: C:\sims\files\<script>\ (comes back to the host) and Google Drive's CAT\Access folder.
function Publish([string]$file) {
  $dest = "C:\sims\files\$Name"
  New-Item -ItemType Directory -Force $dest | Out-Null
  Copy-Item $file $dest -Force
  $cloud = 'G:\My Drive\CAT\Access'
  try { New-Item -ItemType Directory -Force $cloud -ErrorAction Stop | Out-Null; Copy-Item $file $cloud -Force; "  $([IO.Path]::GetFileName($file)) -> files and Google Drive" }
  catch { "  $([IO.Path]::GetFileName($file)) -> files (Google Drive: $_)" }
}

# A new database, made smaller by Compact and Repair (the pupils download it).
function Compact($app, [string]$file) {
  $tmp = $file + '.tmp.accdb'
  Remove-Item $tmp -ErrorAction SilentlyContinue
  [void]$app.CompactRepair($file, $tmp, $false)
  Move-Item $tmp $file -Force
}

# Close the current database and wait until Access has let go of the file (up to 20 s).
function CloseDb($app, [string]$file) {
  [GC]::Collect(); [GC]::WaitForPendingFinalizers(); [GC]::Collect()   # DAO objects still held keep the file open
  try { $app.CloseCurrentDatabase() } catch { }
  for ($i = 0; $i -lt 80; $i++) {
    try { $s = [IO.File]::Open($file, 'Open', 'ReadWrite', 'None'); $s.Close(); return } catch { [GC]::Collect(); Start-Sleep -Milliseconds 250 }
  }
  "  (still locked: $file)"
}

# A tabular report built control by control (Create > Report Design): a title in the Report
# Header, column headings in the Page Header, one row of text boxes in the Detail. Twips: 567 a cm.
# $cols: @(@('Field', widthTwips), ...). Saved under $name.
function MakeReport($app, [string]$source, [string]$name, [string]$title, $cols, [switch]$Landscape) {
  $r = $app.CreateReport()
  $r.RecordSource = $source
  $tmp = $r.Name
  $app.DoCmd.RunCommand(37)                                # acCmdReportHdrFtr: a Report Header and Footer
  $t = $app.CreateReportControl($tmp, 100, 1, '', '', 100, 100, 9000, 600)
  $t.Caption = $title; $t.FontSize = 18; $t.FontBold = $true
  $x = 100
  foreach ($c in $cols) {
    $l = $app.CreateReportControl($tmp, 100, 3, '', '', $x, 60, $c[1] - 60, 330)
    $l.Caption = $c[0]; $l.FontBold = $true
    $b = $app.CreateReportControl($tmp, 109, 0, '', $c[0], $x, 40, $c[1] - 60, 330)
    $x += $c[1]
  }
  $r.Section(0).Height = 420
  $r.Section(3).Height = 450
  if ($Landscape) { $r.Printer.Orientation = 2 }
  $app.DoCmd.Close(3, $tmp, 1)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Rename($name, 3, $tmp)
  "  made report $name"
}

# A columnar form built control by control (Create > Form Design): a title in the Form Header,
# a label and a text box for each field. $fields: @('Field', ...).
function MakeForm($app, [string]$source, [string]$name, [string]$title, $fields) {
  # The Yes/No fields (a tick box each), read before the form is made - and every DAO object
  # let go: one still held while a second form was made crashed Access (9 October 2026).
  $yn = @{}
  try { $d = $app.CurrentDb(); foreach ($fd in $d.TableDefs.Item($source).Fields) { if ($fd.Type -eq 1) { $yn[$fd.Name] = $true } } } catch { }
  $d = $null; $fd = $null; [GC]::Collect(); [GC]::WaitForPendingFinalizers()
  $f = $app.CreateForm()
  $f.RecordSource = $source
  $tmp = $f.Name
  $app.DoCmd.RunCommand(36)                                # acCmdFormHdrFtr: a Form Header and Footer
  $t = $app.CreateControl($tmp, 100, 1, '', '', 300, 150, 6000, 600)
  $t.Caption = $title; $t.FontSize = 18; $t.FontBold = $true
  $y = 300
  foreach ($fld in $fields) {
    $l = $app.CreateControl($tmp, 100, 0, '', '', 300, $y, 1800, 330)
    $l.Caption = $fld
    if ($yn.ContainsKey($fld)) { $b = $app.CreateControl($tmp, 106, 0, '', $fld, 2200, $y + 60, 260, 240) }   # acCheckBox for a Yes/No field
    else        { $b = $app.CreateControl($tmp, 109, 0, '', $fld, 2200, $y, 4200, 330) }
    try { $b.Name = $fld; $l.Name = $fld + '_Label' } catch { }   # as the Form Wizard names them (the Tab Order box lists these)
    $y += 480
  }
  $f.Section(1).Height = 900
  $f.Section(0).Height = $y + 100                         # the Detail ends under the last field
  $f.Section(2).Height = 500                              # a Form Footer that shows in Design View
  $app.DoCmd.Close(2, $tmp, 1)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Rename($name, 2, $tmp)
  "  made form $name"
}

# Type into Access's design grid (or a datasheet): characters, then optional keys (0x09 Tab, 0x0D Enter, 0x28 Down).
function GridType([string]$text, [int[]]$keys = @()) {
  $grid = [Shot]::Child($h, 'OGrid')
  if ($grid -eq [IntPtr]::Zero) { throw 'no OGrid window' }
  [DbComp]::PostChars($grid, $text)
  Start-Sleep -Milliseconds 400
  foreach ($k in $keys) { [Shot]::PostKey($grid, $k); Start-Sleep -Milliseconds 350 }
}
# Type into whatever has the focus inside Access (a Data Type combo box, a cell being edited).
function FocusType([string]$text, [int[]]$keys = @()) {
  $f = [DbComp]::Focused($h)
  if ($f -eq [IntPtr]::Zero) { $f = [Shot]::Child($h, 'OGrid') }
  [DbComp]::PostChars($f, $text)
  Start-Sleep -Milliseconds 400
  foreach ($k in $keys) { [Shot]::PostKey($f, $k); Start-Sleep -Milliseconds 350 }
  "  typed into $f"
}
function GridKeys([int[]]$keys) {
  $grid = [Shot]::Child($h, 'OGrid')
  foreach ($k in $keys) { [Shot]::PostKey($grid, $k); Start-Sleep -Milliseconds 350 }
}

# The Field List pane (Access remembers it open between sessions): close it only if it is there -
# RunCommand 42 (acCmdFieldList) toggles it.
function NoFieldList {
  $root = $AE::FromHandle($h)
  $cond = New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Field List')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Pane)))
  $pane = $root.FindFirst($Scope::Descendants, $cond)
  if ($pane -and -not $pane.Current.IsOffscreen) { try { $app.DoCmd.RunCommand(42); Start-Sleep -Milliseconds 700; '  Field List closed' } catch { "  Field List: $_" } }
}

# The Group, Sort, and Total pane of a report stays open from one run to the next: close it.
function NoGroupPane {
  $root = $AE::FromHandle($h)
  $pane = $root.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Group, Sort, and Total')))
  if ($pane -and -not $pane.Current.IsOffscreen) { try { $app.DoCmd.RunCommand(205); Start-Sleep -Milliseconds 700; '  Group, Sort, and Total closed' } catch { "  group pane: $_" } }
}

# Open a ribbon menu (New Data Source, Selection ...) by its own Expand pattern. Expanding can
# count as input and bring Access in front: the run made it, so the guard's mark moves on.
function ExpandMenu($element) {
  $p = $null
  if ($element.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand() } else { Press $element }
  Start-Sleep -Milliseconds 1200
  $script:lastInput = [Shot]::LastInput()
  $script:wasFront  = $false
  return $p
}

# A report as the Report Wizard and Report button make it: a title and =Date() in the Report
# Header, column headings in the Page Header, the fields in the Detail, ="Page " & [Page] &
# " of " & [Pages] in the Page Footer, and a count and (optionally) a sum in the Report Footer.
function MakeReportFull($app, [string]$source, [string]$name, [string]$title, $cols, [string]$sumField = '', [string]$countLabel = 'Pupils:') {
  $r = $app.CreateReport()
  $r.RecordSource = $source
  $tmp = $r.Name
  $app.DoCmd.RunCommand(37)                                # Report Header and Footer
  $t = $app.CreateReportControl($tmp, 100, 1, '', '', 100, 100, 5500, 600); $t.Caption = $title; $t.FontSize = 18; $t.FontBold = $true
  $d = $app.CreateReportControl($tmp, 109, 1, '', '', 5800, 150, 3400, 330); $d.ControlSource = '=Date()'; $d.Format = 'Long Date'; $d.TextAlign = 3
  $x = 100
  foreach ($c in $cols) {
    $l = $app.CreateReportControl($tmp, 100, 3, '', '', $x, 60, $c[1] - 60, 330); $l.Caption = $c[0]; $l.FontBold = $true
    $b = $app.CreateReportControl($tmp, 109, 0, '', $c[0], $x, 40, $c[1] - 60, 330)
    $x += $c[1]
  }
  $p = $app.CreateReportControl($tmp, 109, 4, '', '', 6000, 60, 3200, 330); $p.ControlSource = '="Page " & [Page] & " of " & [Pages]'; $p.TextAlign = 3
  $cl = $app.CreateReportControl($tmp, 100, 2, '', '', 100, 100, 1500, 330); $cl.Caption = $countLabel; $cl.FontBold = $true
  $cn = $app.CreateReportControl($tmp, 109, 2, '', '', 1700, 100, 1000, 330); $cn.ControlSource = '=Count(*)'
  if ($sumField) {
    $sl = $app.CreateReportControl($tmp, 100, 2, '', '', 4500, 100, 1500, 330); $sl.Caption = 'Total:'; $sl.FontBold = $true
    $sm = $app.CreateReportControl($tmp, 109, 2, '', '', 6300, 100, 1500, 330); $sm.ControlSource = "=Sum([$sumField])"; $sm.Format = 'Currency'
  }
  $r.Section(0).Height = 420; $r.Section(3).Height = 450; $r.Section(4).Height = 450; $r.Section(2).Height = 600
  $app.DoCmd.Close(3, $tmp, 1)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Rename($name, 3, $tmp)
  "  made report $name"
}

# A grouped report, as the Report Wizard makes it with a grouping level: the group field in
# its Group Header, the other fields in the Detail, and in the Group Footer a label and
# =Count(*) and =Sum([sumField]); the same totals for everything in the Report Footer.
# Sections: 5 = the first group's header, 6 = its footer.
function MakeGroupedReport($app, [string]$source, [string]$name, [string]$title, [string]$groupField, $cols, [string]$sumField) {
  $r = $app.CreateReport()
  $r.RecordSource = $source
  $tmp = $r.Name
  $app.DoCmd.RunCommand(37)
  $t = $app.CreateReportControl($tmp, 100, 1, '', '', 100, 100, 6500, 600); $t.Caption = $title; $t.FontSize = 18; $t.FontBold = $true
  $null = $app.CreateGroupLevel($tmp, $groupField, $true, $true)
  $gl = $app.CreateReportControl($tmp, 100, 3, '', '', 100, 60, 1800, 330); $gl.Caption = $groupField; $gl.FontBold = $true
  $g = $app.CreateReportControl($tmp, 109, 5, '', $groupField, 100, 60, 2400, 380); $g.FontBold = $true; $g.FontSize = 12
  $x = 2700
  foreach ($c in $cols) {
    $l = $app.CreateReportControl($tmp, 100, 3, '', '', $x, 60, $c[1] - 60, 330); $l.Caption = $c[0]; $l.FontBold = $true
    $b = $app.CreateReportControl($tmp, 109, 0, '', $c[0], $x, 40, $c[1] - 60, 330)
    $x += $c[1]
  }
  $fl = $app.CreateReportControl($tmp, 100, 6, '', '', 2700, 80, 1600, 330); $fl.Caption = 'Sales:'; $fl.FontItalic = $true
  $fc = $app.CreateReportControl($tmp, 109, 6, '', '', 4300, 80, 900, 330); $fc.ControlSource = '=Count(*)'
  $sl = $app.CreateReportControl($tmp, 100, 6, '', '', 5400, 80, 1700, 330); $sl.Caption = 'Branch total:'; $sl.FontItalic = $true
  $sm = $app.CreateReportControl($tmp, 109, 6, '', '', 7200, 80, 1500, 330); $sm.ControlSource = "=Sum([$sumField])"; $sm.Format = 'Currency'; $sm.FontBold = $true
  $tl = $app.CreateReportControl($tmp, 100, 2, '', '', 5400, 100, 1700, 330); $tl.Caption = 'Grand total:'; $tl.FontBold = $true
  $ts = $app.CreateReportControl($tmp, 109, 2, '', '', 7200, 100, 1500, 330); $ts.ControlSource = "=Sum([$sumField])"; $ts.Format = 'Currency'; $ts.FontBold = $true
  $p = $app.CreateReportControl($tmp, 109, 4, '', '', 6000, 60, 3200, 330); $p.ControlSource = '="Page " & [Page] & " of " & [Pages]'; $p.TextAlign = 3
  $r.Section(0).Height = 420; $r.Section(3).Height = 450; $r.Section(5).Height = 480; $r.Section(6).Height = 520; $r.Section(2).Height = 600
  $app.DoCmd.Close(3, $tmp, 1)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Rename($name, 3, $tmp)
  "  made grouped report $name"
}

# A subform on a saved form: the form $sub inside $main, linked on $link (as the Form
# Wizard does with two related tables). 112 = acSubform.
function AddSubform($app, [string]$main, [string]$sub, [string]$link) {
  $app.DoCmd.OpenForm($main, 1)
  Start-Sleep -Milliseconds 800
  $s = $app.CreateControl($main, 112, 0, '', '', 300, 2300, 9000, 2800)
  $s.SourceObject = 'Form.' + $sub
  $s.LinkMasterFields = $link
  $s.LinkChildFields = $link
  $app.DoCmd.Close(2, $main, 1)
  $s = $null; [GC]::Collect(); [GC]::WaitForPendingFinalizers()
  "  subform $sub on $main"
}

# A main form (a menu): a title and one button for each form it opens - the kind a Command
# Button Wizard makes with Form Operations > Open Form. 104 = acCommandButton.
function MakeMenuForm($app, [string]$name, [string]$title, $buttons) {
  $f = $app.CreateForm()
  $tmp = $f.Name
  $app.DoCmd.RunCommand(36)
  $t = $app.CreateControl($tmp, 100, 1, '', '', 300, 150, 7000, 700); $t.Caption = $title; $t.FontSize = 20; $t.FontBold = $true
  $y = 400
  foreach ($b in $buttons) {
    $c = $app.CreateControl($tmp, 104, 0, '', '', 1500, $y, 4000, 600)
    $c.Caption = $b[0]                                    # (the picture only: no macro behind it)
    $y += 800
  }
  $f.Section(1).Height = 1000
  $f.RecordSelectors = $false; $f.NavigationButtons = $false
  $app.DoCmd.Close(2, $tmp, 1)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Rename($name, 2, $tmp)
  "  made menu form $name"
}
