# Real Word 365 screens for catword lesson 7, Tables (content/catword/
# tables.php - Chris, 8 October 2026: "do the cat practical courses"). Mr
# Botha's Saturday sales as a table: insert it from the grid, add a row with
# Tab, merge the title row, total a column with a formula; the Table Design
# and Layout tabs for figures. Menus and dialog boxes are saved beside the
# main picture (SnapPop) and laid over it by catword-b-crop.py. Also makes
# the upload's starter file and a done-right copy.
# Run it in the CAT VM:  pwsh -File vm-shots.ps1 catword-tables
# Then:                  python catword-b-crop.py catword-tables
$Name = 'catword-tables'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

# ---------------------------------------------------------------- helpers (the same in every catword-b script)
Add-Type @'
using System; using System.Collections.Generic; using System.Runtime.InteropServices; using System.Text;
public static class CwWin {
  public delegate bool EnumProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc p, IntPtr l);
  [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr h, out uint pid);
  [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr h);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr h, out RECT r);
  [DllImport ("user32.dll")] public static extern bool PostMessage (IntPtr h, uint m, IntPtr w, IntPtr l);
  public struct RECT { public int L, T, R, B; }
  public static string Class (IntPtr h) { StringBuilder s = new StringBuilder (256); GetClassName (h, s, 256); return s.ToString (); }
  public static IntPtr[] Tops (uint pid) {
    List<IntPtr> list = new List<IntPtr> ();
    EnumWindows (delegate (IntPtr h, IntPtr l) { uint p; GetWindowThreadProcessId (h, out p); RECT r;
      if (p == pid && IsWindowVisible (h) && GetWindowRect (h, out r) && r.R - r.L > 20 && r.B - r.T > 20) list.Add (h); return true; }, IntPtr.Zero);
    return list.ToArray ();
  }
}
'@
$script:later = @()
# Press a control from another thread: a button that opens a dialog box does not return until the dialog closes.
function PressLater ($element) {
  $ps = [PowerShell]::Create()
  [void]$ps.AddScript({ param($e)
    $p = $null
    if ($e.Current.ControlType -eq [System.Windows.Automation.ControlType]::MenuItem -and $e.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand(); return 'expand' }
    if ($e.TryGetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern, [ref]$p)) { $p.Invoke(); return 'invoke' }
    if ($e.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand(); return 'expand' }
    if ($e.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern, [ref]$p)) { $p.Select(); return 'select' }
    'none' }).AddArgument($element)
  $script:later += ,@($ps, $ps.BeginInvoke())
}
function Pops { @([CwWin]::Tops([Shot]::Pid($h)) | Where-Object { $_ -ne $h -and [CwWin]::Class($_) -ne 'OpusApp' }) }
# The main window and every menu or dialog of Word's that is open, each saved as it draws itself.
function SnapPop ($n) {
  Guard
  Start-Sleep -Milliseconds 1200
  $win = [WinRect]::Of($h)
  $k = 0
  foreach ($w in Pops) {
    $k++
    [void][Shot]::Save($w, (Join-Path $out "$Name-$n~$k.png"))
    $r = [WinRect]::Of($w)
    $script:marks["$n~$k"] = @(($r[0] - $win[0]), ($r[1] - $win[1]), ($r[2] - $r[0]), ($r[3] - $r[1]))
    "  over $n~$k $([CwWin]::Class($w)) $($script:marks["$n~$k"] -join ',')"
  }
  [void][Shot]::Save($h, (Join-Path $out "$Name-$n.png"))
  Guard
  "picture $n (+$k)"
}
function WaitPop ([string]$class) {
  for ($i = 0; $i -lt 60; $i++) { foreach ($w in Pops) { if (-not $class -or [CwWin]::Class($w) -eq $class) { return $w } }; Start-Sleep -Milliseconds 250 }
  throw "No $class window opened"
}
function ClosePops { foreach ($w in Pops) { [void][CwWin]::PostMessage($w, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) }; Start-Sleep -Milliseconds 900 }   # WM_CLOSE = Cancel
function EscPops { foreach ($w in Pops) { [Shot]::PostKey($w, 0x1B) }; [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 800 }
# A named control in any of Word's own windows (a menu, a dialog), marked in main-window pixels.
# A control in a menu or dialog: Office menus show in UI Automation under the window, the desktop or the menu itself.
function FindIn ($hwnd, [string[]]$names) {
  foreach ($r in @($AE::FromHandle($hwnd), $root, $AE::RootElement)) { try { return (Find $r $names -tries 3) } catch { } }
  throw "No control called '$($names -join "' or '")'"
}
function MarkIn ($key, $hwnd, [string[]]$names) { try { Mark $key (Box (FindIn $hwnd $names)) } catch { "  MISSING $key ($($names -join ' / '))" } }
function DumpWin ($hwnd, $file) {
  $win = [WinRect]::Of($h)
  $lines = foreach ($e in $AE::FromHandle($hwnd).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
    try { $c = $e.Current; if ($c.Name) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $win[0]), [int]($c.BoundingRectangle.Y - $win[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}
function Tab ($name) { Press (Find $root @($name) $T::TabItem); Start-Sleep -Milliseconds 1000 }
function TextBox ($range) {
  $l = 0; $t = 0; $w = 0; $ht = 0
  $word.ActiveWindow.GetPoint([ref]$l, [ref]$t, [ref]$w, [ref]$ht, $range)
  $win = [WinRect]::Of($h)
  return @(($l - $win[0]), ($t - $win[1]), $w, $ht)
}
function SaveBoth ($d, $file) {
  $d.SaveAs2((Join-Path "C:\sims\files\$Name" $file), 16)
  try { New-Item -ItemType Directory -Force 'G:\My Drive\CAT\Word' | Out-Null; Copy-Item (Join-Path "C:\sims\files\$Name" $file) 'G:\My Drive\CAT\Word\' -Force; "  cloud: $file" } catch { "  NO CLOUD COPY: $_" }
}
function OwnStyles ($d) { foreach ($style in $d.Styles) { try { if ($style.QuickStyle -and -not $style.BuiltIn) { $style.QuickStyle = $false } } catch { } } }
# ----------------------------------------------------------------------------------------------------------

$items = @(@('White bread', '18.00', '42'), @('Brown bread', '17.00', '35'), @('Cupcakes', '12.00', '60'), @('Koeksisters', '8.00', '48'))
function Fill ($t, $row, $values) { for ($c = 0; $c -lt $values.Count; $c++) { $t.Cell($row, $c + 1).Range.Text = $values[$c] } }

$word = New-Object -ComObject Word.Application
$doc = $null; $start = $null
try {
  $word.DisplayAlerts = 0
  "started"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null

  # ---- the lesson's document
  $doc = $word.Documents.Add()
  OwnStyles $doc
  $doc.PageSetup.PaperSize = 7
  $doc.Content.Text = "Saturday sales`rBotha's Bakery, Centurion - what we sold on Saturday.`r"
  $doc.Paragraphs.Item(1).Style = -2
  $word.Visible = $true
  $word.WindowState = 0
  $h = [IntPtr]$word.ActiveWindow.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 860); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 860)
  $word.ActiveWindow.View.Type = 3
  $word.ActiveWindow.View.Zoom.Percentage = 100
  $word.ActiveWindow.DisplayRulers = $false
  $word.ActiveWindow.DocumentMap = $false
  $doc.Paragraphs.Item(3).Range.Select()
  $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  # 1. Insert a 3 x 6 table from the grid
  Tab 'Insert'
  TryMark 'table' $root @('Table')
  Mark 'emptyLine' (TextBox ($doc.Paragraphs.Item(3).Range))
  Snap 'i-1'                                                        # Insert tab: click Table
  PressLater (Find $root @('Table'))
  $menu = WaitPop
  DumpWin $menu 'tablemenu'
  MarkIn 'insertTableDlg' $menu @('Insert Table...')
  SnapPop 'i-2'                                                     # the grid: click the square 3 across, 6 down
  PressLater (FindIn $menu @('Insert Table...'))
  Start-Sleep -Milliseconds 1500
  $dlg = WaitPop 'bosa_sdm_msword'
  SnapPop 'x-1'                                                     # the Insert Table dialog box (a figure)
  ClosePops
  $t = $doc.Tables.Add($doc.Paragraphs.Item(3).Range, 6, 3)
  $t.Style = 'Table Grid'
  $t.Cell(1, 1).Range.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 800
  try { Tab 'Table Design' } catch { '  no Table Design tab' }
  Dump 'tabledesign'
  Snap 'i-3'                                                        # done: an empty table, the cursor in the first cell

  # 2. Typed in; a new row with Tab in the last cell
  Fill $t 1 @('Item', 'Price (R)', 'Number sold')
  for ($i = 0; $i -lt 4; $i++) { Fill $t ($i + 2) $items[$i] }
  Fill $t 6 @('Rusks', '25.00', '30')
  $doc.Paragraphs.Item(1).Range.Select(); $word.Selection.Collapse(1)
  Tab 'Home'
  Start-Sleep -Milliseconds 600
  Mark 'lastCell' (TextBox ($t.Cell(6, 3).Range))
  Mark 'cellA1' (TextBox ($t.Cell(1, 1).Range))
  Mark 'cellC1' (TextBox ($t.Cell(1, 3).Range))
  Snap 'r-1'                                                        # click in the last cell
  $e = $t.Cell(6, 3).Range.End - 1
  $doc.Range($e, $e).Select()
  Start-Sleep -Milliseconds 600
  Snap 'r-2'                                                        # cursor after 30: press Tab
  [void]$t.Rows.Add()
  $t.Cell(7, 1).Range.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 800
  Snap 'r-3'                                                        # done: a new row
  Fill $t 7 @('Total', '', '')

  # 3. A title row, merged
  [void]$t.Rows.Add($t.Rows.Item(1))
  Fill $t 1 @("Botha's Bakery - Saturday sales", '', '')
  $doc.Paragraphs.Item(1).Range.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 800
  Mark 'row1' (TextBox ($t.Rows.Item(1).Range))
  Mark 'row1a' (TextBox ($t.Cell(1, 1).Range))
  Mark 'row2a' (TextBox ($t.Cell(2, 1).Range))
  Snap 'm-1'                                                        # Home tab: click left of row 1
  $t.Rows.Item(1).Select()
  Start-Sleep -Milliseconds 800
  $layouts = @(Find $root @('Table Layout', 'Layout') $T::TabItem)
  TryMark 'tableLayoutTab' $root @('Table Layout') $T::TabItem
  TryMark 'tableDesignTab' $root @('Table Design') $T::TabItem
  Snap 'm-2'                                                        # row 1 selected: click the table's Layout tab
  Press (Find $root @('Table Layout') $T::TabItem)
  Start-Sleep -Milliseconds 1000
  TryMark 'merge' $root @('Merge Cells')
  TryMark 'formula' $root @('Formula...', 'Formula')
  TryMark 'insertAbove' $root @('Insert Above')
  TryMark 'insertBelow' $root @('Insert Below')
  TryMark 'sort' $root @('Sort...', 'Sort')
  TryMark 'convert' $root @('Convert to Text...', 'Convert to Text')
  TryMark 'autofit' $root @('AutoFit')
  Dump 'tablelayout'
  Snap 'm-3'                                                        # Layout tab: click Merge Cells
  $t.Rows.Item(1).Cells.Merge()
  Start-Sleep -Milliseconds 800
  Snap 'm-4'                                                        # done: one wide cell

  # 4. The total with a formula
  $t.Cell(1, 1).Range.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 600
  Mark 'totalCell' (TextBox ($t.Cell(8, 3).Range))
  Mark 'totalLabel' (TextBox ($t.Cell(8, 1).Range))
  Snap 's-1'                                                        # click the total cell
  $t.Cell(8, 3).Range.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 600
  Snap 's-2'                                                        # cursor in it: click Formula
  PressLater (Find $root @('Formula...', 'Formula'))
  $dlg = WaitPop 'bosa_sdm_msword'
  DumpWin $dlg 'formuladlg'
  SnapPop 's-3'                                                     # =SUM(ABOVE): click OK
  ClosePops
  $t.Cell(8, 3).Formula('=SUM(ABOVE)')
  Start-Sleep -Milliseconds 800
  Snap 's-4'                                                        # done: 215

  # Figures: a table style; the Sort dialog box
  try { Tab 'Table Design' } catch { }
  $t.Style = 'Grid Table 4 - Accent 1'
  $doc.Paragraphs.Item(1).Range.Select(); $word.Selection.Collapse(1)
  $t.Cell(2, 1).Range.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 1000
  Snap 'd-1'
  Press (Find $root @('Table Layout') $T::TabItem)
  Start-Sleep -Milliseconds 800
  $doc.Range($t.Rows.Item(2).Range.Start, $t.Rows.Item(7).Range.End).Select()
  PressLater (Find $root @('Sort...', 'Sort'))
  try { $dlg = WaitPop 'bosa_sdm_msword'; SnapPop 'o-1'; ClosePops } catch { "  no sort dialog: $_" }
  $doc.Saved = $true

  # The starter file and its done-right copy: catword-b-files.ps1.
  foreach ($l in $script:later) { try { [void]$l[0].EndInvoke($l[1]) } catch { } }
  SaveMarks
}
catch {
  "FAILED: $_"
  try { SaveMarks } catch { }
  try { ClosePops } catch { }
  throw
}
finally {
  try { ClosePops } catch { }
  foreach ($d in $doc, $start) { if ($d) { try { $d.Saved = $true; $d.Close(0) } catch { } } }
  $word.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
