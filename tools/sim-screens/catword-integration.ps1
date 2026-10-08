# Real Word 365 (and Excel 365) screens for catword lesson 10, Hyperlinks,
# help and fixing problems (content/catword/integration.php - Chris, 8
# October 2026: "do the cat practical courses"). Ms Naidoo's class notice: a
# hyperlink through Insert > Link; Mr Botha's sales copied from Excel and
# pasted into Word; a hidden ribbon and the formatting marks (fixing
# problems); the Help pane. Menus and dialog boxes are saved beside the main
# picture (SnapPop) and laid over it by catword-b-crop.py. Also makes the
# upload's starter files (a Word report and an Excel sheet) and a done-right
# copy.
# Run it in the CAT VM:  pwsh -File vm-shots.ps1 catword-integration
# Then:                  python catword-b-crop.py catword-integration
$Name = 'catword-integration'
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

function Para ($d, $text) { foreach ($p in $d.Paragraphs) { if ($p.Range.Text -like "*$text*") { return $p } }; throw "no paragraph with $text" }
function WordIn ($d, $text) { $r = $d.Content; $f = $r.Find; [void]$f.Execute($text, $true, $false); if (-not $f.Found) { throw "no $text" }; return $r }
$rows = @(@('Item', 'Price (R)', 'Number sold'), @('White bread', '18', '42'), @('Brown bread', '17', '35'), @('Cupcakes', '12', '60'), @('Koeksisters', '8', '48'), @('Rusks', '25', '30'))
function SalesSheet ($wb) {
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Saturday'
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt 3; $c++) { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } }
  $ws.Range('A7').Formula = 'Total'
  $ws.Range('C7').Formula = '=SUM(C2:C6)'
  $ws.Range('A1:C1').Font.Bold = $true
  $ws.Range('A7:C7').Font.Bold = $true
  $ws.Range('B2:B6').NumberFormat = '0.00'
  $ws.Columns.Item('A').ColumnWidth = 14; $ws.Columns.Item('B').ColumnWidth = 11; $ws.Columns.Item('C').ColumnWidth = 13
  return $ws
}

$word = New-Object -ComObject Word.Application
$xl = $null; $doc = $null; $start = $null; $wb = $null
try {
  $word.DisplayAlerts = 0
  "started"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null
  $xl = New-Object -ComObject Excel.Application
  $xl.DisplayAlerts = $false
  $xl.Visible = $true

  # ---- the lesson's document: Ms Naidoo's notice
  $doc = $word.Documents.Add()
  OwnStyles $doc
  $doc.PageSetup.PaperSize = 7
  $doc.Content.Text = (@('Grade 10 CAT - homework', 'Do the Word lessons on the BestLessons website before Friday.', 'Bring your project on a flash drive or save it in your Google Drive.', '', '', '', 'Saturday sales at Botha''s Bakery:', '') -join "`r")
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
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  # 1. A hyperlink: select the words, Insert > Link, type the address
  Tab 'Home'
  $words = WordIn $doc 'BestLessons website'
  $words.Select()
  Start-Sleep -Milliseconds 800
  Mark 'linkWords' (TextBox $words)
  TryMark 'tabInsert' $root @('Insert') $T::TabItem
  Snap 'k-1'                                                        # words selected: click Insert
  Tab 'Insert'
  $link = $null
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Link')))) { if ($e.Current.ControlType -eq $T::Button) { $link = $e } }
  if ($link) { Mark 'link' (Box $link) } else { '  MISSING link' }
  Snap 'k-2'                                                        # Insert tab: click Link
  PressLater $link
  $dlg = WaitPop 'bosa_sdm_msword'
  DumpWin $dlg 'linkdlg'
  SnapPop 'k-3'                                                     # Insert Hyperlink: type the address
  ClosePops
  $words = WordIn $doc 'BestLessons website'
  [void]$doc.Hyperlinks.Add($words, 'https://bestlessons.co.za/')
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 1000
  Snap 'k-4'                                                        # done: blue and underlined

  # 2. Copy from Excel, paste into Word
  $wb2 = $xl.Workbooks.Add()
  $ws2 = SalesSheet $wb2
  $xl.Visible = $true
  $xh = [IntPtr]$xl.Hwnd
  $wordH = $h
  $h = $xh
  [Shot]::Place($h, 40, 40, 1600, 860); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 860)
  $null = $ws2.Range('A1:C7').Select()
  Start-Sleep -Milliseconds 1500
  try { Mark 'xlA1' (Box (FindIn $h @('A1'))) } catch { '  MISSING xlA1' }
  Dump 'excel'
  Snap 'x-1'                                                        # Excel, A1:C7 selected: Ctrl+C
  $ws2.Range('A1:C7').Copy()
  Start-Sleep -Milliseconds 800
  Snap 'x-2'                                                        # copied (the status bar says so)
  $h = $wordH
  $target = (Para $doc 'Saturday sales at').Range.Next(4, 1)
  $target.Select(); $word.Selection.Collapse(1)
  Tab 'Home'
  Mark 'pasteLine' (TextBox $target)
  TryMark 'pasteBtn' $root @('Paste')
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 800
  Snap 'x-3'                                                        # Word: click the empty line under "Saturday sales"
  $target.Select(); $word.Selection.Collapse(1)
  Start-Sleep -Milliseconds 600
  Snap 'x-4'                                                        # cursor there: Ctrl+V
  $word.Selection.Paste()
  Start-Sleep -Milliseconds 1500
  foreach ($w in Pops) { "  window $([CwWin]::Class($w))" }
  SnapPop 'x-5'                                                     # done: the table, with the Paste Options button
  $wb2.Saved = $true; $wb2.Close($false); $wb2 = $null

  # 3. Fixing problems: the ribbon has gone; what are the gaps?
  $doc.Range(0, 0).Select()
  $word.ActiveWindow.ToggleRibbon()
  Start-Sleep -Milliseconds 1500
  Mark 'homeTabFolded' (Box (Find $root @('Home') $T::TabItem))
  Snap 'f-1'                                                        # the ribbon folded away: double-click Home
  $word.ActiveWindow.ToggleRibbon()
  Start-Sleep -Milliseconds 1500
  Tab 'Home'
  TryMark 'showHide' $root @('Show/Hide', 'Show/Hide ¶')
  Snap 'f-2'                                                        # back: click Show/Hide
  $word.ActiveWindow.View.ShowAll = $true
  Start-Sleep -Milliseconds 1000
  Snap 'f-3'                                                        # done: the empty paragraphs show
  $word.ActiveWindow.View.ShowAll = $false

  # 4. Help: the Help tab, then Help
  TryMark 'tabHelp' $root @('Help') $T::TabItem
  Snap 'h-1'                                                        # click the Help tab
  Tab 'Help'
  $helpBtn = $null
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Help')))) { if ($e.Current.ControlType -eq $T::Button) { $helpBtn = $e } }
  if ($helpBtn) { Mark 'helpBtn' (Box $helpBtn) } else { '  MISSING helpBtn' }
  Dump 'helptab'
  Snap 'h-2'                                                        # Help tab: click Help
  if ($helpBtn) { PressLater $helpBtn; Start-Sleep -Milliseconds 8000 }
  Dump 'helppane'
  Snap 'h-3'                                                        # done: the Help pane
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
  if ($xl) { try { foreach ($b in @($xl.Workbooks)) { $b.Saved = $true }; $xl.Quit() } catch { }; [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl) }
}
