# Real Word 365 screens for catword lesson 6, Page layout (content/catword/
# pagelayout.php - Chris, 8 October 2026: "do the cat practical courses").
# Two documents: Mr Botha's sign for the shop window (orientation, margins)
# and Phumlani Secondary's newsletter (columns, header, watermark, page
# colour, page border, line numbers). Ribbon menus and dialog boxes are
# their own windows: SnapPop saves each one beside the main picture
# (<n>~1.png ... and its place in out\<name>.json); catword-b-crop.py lays
# them over the main picture the way the screen shows them. Also makes the
# upload's starter file and a done-right copy.
# Run it in the CAT VM:  pwsh -File vm-shots.ps1 catword-pagelayout
# Then:                  python catword-b-crop.py catword-pagelayout
$Name = 'catword-pagelayout'
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
  for ($i = 0; $i -lt 40; $i++) { foreach ($w in Pops) { if (-not $class -or [CwWin]::Class($w) -eq $class) { return $w } }; Start-Sleep -Milliseconds 250 }
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

$news = @(
  'Phumlani News',
  'Term 3, 2026 - the newsletter of Phumlani Secondary, Soweto',
  'Our new library',
  'The new library opens on Monday. It has forty computers, a printer and more than two thousand books. Ms Naidoo says the computers are for homework and projects during break and after school, and the librarian will help anyone who gets stuck.',
  'Market day',
  'The Grade 10 market day raised R4 350 for the matric farewell. Thank you to every stall holder and every parent who came. The cupcakes sold out by eleven o''clock, and the boerewors rolls soon after.',
  'Sport',
  'The netball team beat Orlando High 24 to 19 on Saturday, and the soccer team plays in the district semi-final next week. Come and support them at the Dobsonville stadium.',
  'Dates to remember',
  'Reports go home on Friday 25 September. Schools close on 2 October and open again on 13 October.',
  ''
)
function Newsletter ($d) {
  $d.Content.Text = ($news -join "`r")
  $d.Content.ParagraphFormat.Alignment = 0
  $d.Content.Font.Reset()
  OwnStyles $d
  $d.PageSetup.PaperSize = 7                                        # A4
  $d.Paragraphs.Item(1).Style = -63                                 # wdStyleTitle
  foreach ($i in 3, 5, 7, 9) { $d.Paragraphs.Item($i).Style = -2 }  # Heading 1
}

$word = New-Object -ComObject Word.Application
$sign = $null; $doc = $null; $start = $null
try {
  $word.DisplayAlerts = 0
  "started"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null

  # ---- 1. Mr Botha's sign: landscape, then a smaller top margin
  $sign = $word.Documents.Add()
  $sign.Content.Text = (@("Botha's Bakery", 'Closed on Monday', 'We open again on Tuesday at 07:00. Thank you!') -join "`r")
  OwnStyles $sign
  $sign.PageSetup.PaperSize = 7
  $sign.Content.ParagraphFormat.Alignment = 1
  $sign.Paragraphs.Item(1).Range.Font.Size = 48; $sign.Paragraphs.Item(1).Range.Font.Bold = $true
  $sign.Paragraphs.Item(2).Range.Font.Size = 72; $sign.Paragraphs.Item(2).Range.Font.Bold = $true; $sign.Paragraphs.Item(2).Range.Font.Color = 192   # dark red
  $sign.Paragraphs.Item(3).Range.Font.Size = 28

  $word.Visible = $true
  $word.WindowState = 0
  $h = [IntPtr]$word.ActiveWindow.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 860); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 860)
  $word.ActiveWindow.View.Type = 3
  $word.ActiveWindow.View.Zoom.Percentage = 50
  $word.ActiveWindow.DisplayRulers = $false
  $word.ActiveWindow.DocumentMap = $false
  $sign.Range(0, 0).Select()
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  Tab 'Home'
  TryMark 'tabLayout' $root @('Layout') $T::TabItem
  Snap 'o-1'                                                        # Home tab: click Layout
  Tab 'Layout'
  TryMark 'orientation' $root @('Orientation')
  TryMark 'margins' $root @('Margins')
  TryMark 'size' $root @('Size')
  TryMark 'columns' $root @('Columns')
  TryMark 'breaks' $root @('Breaks')
  TryMark 'hyphenation' $root @('Hyphenation')
  TryMark 'lineNumbers' $root @('Line Numbers')
  TryMark 'pageSetup' $root @('Page Setup...')
  Dump 'layout'
  Snap 'o-2'                                                        # Layout tab: click Orientation
  PressLater (Find $root @('Orientation'))
  $menu = WaitPop
  MarkIn 'landscape' $menu @('Landscape')
  MarkIn 'portrait' $menu @('Portrait')
  SnapPop 'o-3'                                                     # the menu: click Landscape
  EscPops
  $sign.PageSetup.Orientation = 1                                   # wdOrientLandscape
  Start-Sleep -Milliseconds 1200
  Snap 'o-4'                                                        # done: landscape

  # Margins: the Page Setup dialog box, Top 1.5 cm
  PressLater (Find $root @('Page Setup...') $T::Button)
  $dlg = WaitPop 'bosa_sdm_msword'
  DumpWin $dlg 'pagesetupdlg'
  SnapPop 'm-1'                                                     # the dialog: Top is selected
  ClosePops
  $sign.PageSetup.TopMargin = $word.CentimetersToPoints(1.5)
  Start-Sleep -Milliseconds 1200
  Snap 'm-2'                                                        # done: the text moved up
  PressLater (Find $root @('Page Setup...') $T::Button)
  $dlg = WaitPop 'bosa_sdm_msword'
  SnapPop 'm-3'                                                     # the dialog again: Top 1.5 cm (for the figure)
  ClosePops

  # Size: the menu, for a figure
  try { PressLater (Find $root @('Size')); $menu = WaitPop; MarkIn 'sizeA4' $menu @('A4'); SnapPop 's-1' } catch { "  no size menu: $_" }
  EscPops
  $sign.Saved = $true
  # The same document and window go on as the newsletter: a new window is not active, and its ribbon menus do not open.
  $doc = $sign; $sign = $null
  $doc.Content.Delete() | Out-Null
  $doc.PageSetup.Orientation = 0
  $doc.PageSetup.TopMargin = $word.CentimetersToPoints(2.54)
  Newsletter $doc
  $doc.Content.Font.Reset()
  $word.ActiveWindow.View.Zoom.Percentage = 70
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 2000
  $root = $AE::FromHandle($h)
  Tab 'Layout'
  $last = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range.Start   # the empty last paragraph stays out, so the columns end before it
  $body = $doc.Range($doc.Paragraphs.Item(3).Range.Start, $last)
  $body.Select()
  Start-Sleep -Milliseconds 800
  Mark 'body' (TextBox ($doc.Range($doc.Paragraphs.Item(3).Range.Start, $doc.Paragraphs.Item(4).Range.End)))
  Snap 'c-1'                                                        # body selected, Layout tab: click Columns
  PressLater (Find $root @('Columns'))
  $menu = WaitPop
  MarkIn 'moreColumns' $menu @('More Columns...')
  MarkIn 'colTwo' $menu @('Two')
  SnapPop 'c-2'                                                     # the menu: click More Columns...
  PressLater (FindIn $menu @('More Columns...'))
  Start-Sleep -Milliseconds 1500
  $dlg = WaitPop 'bosa_sdm_msword'
  DumpWin $dlg 'columnsdlg'
  SnapPop 'c-3'                                                     # Columns dialog, One: click Two
  ClosePops
  $s3 = $doc.Paragraphs.Item(3).Range.Start
  $e = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range.Start
  $doc.Range($e, $e).InsertBreak(3)                                 # what the dialog does for selected text: continuous section breaks after it
  $doc.Range($s3, $s3).InsertBreak(3)                               # and before it - so the two columns are balanced
  $doc.Sections.Item(2).PageSetup.TextColumns.SetCount(2)
  Start-Sleep -Milliseconds 800
  $doc.Sections.Item(2).Range.Select()
  PressLater (Find $root @('Columns'))
  $menu = WaitPop
  PressLater (FindIn $menu @('More Columns...'))
  Start-Sleep -Milliseconds 1500
  $dlg = WaitPop 'bosa_sdm_msword'
  SnapPop 'c-4'                                                     # Two chosen: tick Line between
  ClosePops
  $doc.Sections.Item(2).PageSetup.TextColumns.LineBetween = -1
  $doc.Sections.Item(2).Range.Select()
  PressLater (Find $root @('Columns'))
  $menu = WaitPop
  PressLater (FindIn $menu @('More Columns...'))
  Start-Sleep -Milliseconds 1500
  $dlg = WaitPop 'bosa_sdm_msword'
  SnapPop 'c-5'                                                     # Two and Line between: click OK
  ClosePops
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 800
  Snap 'c-6'                                                        # done: two columns with a line

  # Hyphenation menu (a figure), then on
  try { PressLater (Find $root @('Hyphenation')); $menu = WaitPop; MarkIn 'hyphAuto' $menu @('Automatic'); SnapPop 'y-1' } catch { "  no hyphenation menu: $_" }
  EscPops
  $doc.AutoHyphenation = $true
  Start-Sleep -Milliseconds 800
  Snap 'y-2'

  # The header: double-click the top margin, type, close
  Tab 'Insert'
  $doc.Range(0, 0).Select()
  $word.ActiveWindow.ScrollIntoView($doc.Range(0, 0), $true)
  Start-Sleep -Milliseconds 800
  try { Mark 'page' (Box (Find $root @('Page 1') $T::Custom -tries 6)) } catch { '  MISSING page' }
  Mark 'firstLine' (TextBox ($doc.Paragraphs.Item(1).Range))
  TryMark 'header' $root @('Header')
  TryMark 'footer' $root @('Footer')
  TryMark 'pageNumber' $root @('Page Number')
  Dump 'insert'
  Snap 'h-1'                                                        # Insert tab, top of the page: double-click the top margin
  $word.ActiveWindow.ActivePane.View.SeekView = 9                   # wdSeekCurrentPageHeader
  Start-Sleep -Milliseconds 1500
  Mark 'headerLine' (TextBox ($word.Selection.Range))
  TryMark 'closeHF' $root @('Close Header and Footer')
  Dump 'hftab'
  Snap 'h-2'                                                        # in the header: type
  $word.Selection.TypeText('Phumlani News - Term 3')
  Start-Sleep -Milliseconds 800
  Snap 'h-3'                                                        # typed: click Close Header and Footer
  $word.ActiveWindow.ActivePane.View.SeekView = 0
  Start-Sleep -Milliseconds 1200
  Snap 'h-4'                                                        # done

  # Page numbers menu (a figure)
  try { PressLater (Find $root @('Page Number')); $menu = WaitPop; SnapPop 'n-1' } catch { "  no page number menu: $_" }
  EscPops

  # The page background: Design tab, Watermark gallery; then watermark, page colour, page border
  Tab 'Design'
  TryMark 'watermark' $root @('Watermark')
  TryMark 'pageColor' $root @('Page Color')
  TryMark 'pageBorders' $root @('Page Borders...', 'Page Borders')
  Dump 'design'
  Snap 'w-1'
  $menu = $null
  try { PressLater (Find $root @('Watermark')); $menu = WaitPop; SnapPop 'w-2' } catch { "  no watermark gallery: $_" }
  $draft = $null
  if ($menu) {
    $all = @($AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))))
    foreach ($it in $all) { try { if ($it.Current.Name -match 'draft|confid') { "  item: $($it.Current.Name)" } } catch { } }
    $draft = $all | Where-Object { try { $_.Current.Name -match '^draft ?1' } catch { $false } } | Select-Object -First 1
    if (-not $draft) { $draft = $all | Where-Object { try { $_.Current.Name -match 'draft' } catch { $false } } | Select-Object -First 1 }
    if (-not $draft) { '  MISSING DRAFT 1' }
  }
  if ($draft) { PressLater $draft; Start-Sleep -Milliseconds 2500 } else { EscPops }
  try { PressLater (Find $root @('Page Color')); $menu = WaitPop; SnapPop 'w-3' } catch { "  no page colour menu: $_" }
  EscPops
  $doc.Background.Fill.Visible = -1
  $doc.Background.Fill.ForeColor.RGB = 0xD9F2FF                     # a pale yellow (BGR)
  $doc.Background.Fill.Solid()
  $word.ActiveWindow.View.DisplayBackgrounds = $true
  foreach ($sec in $doc.Sections) { foreach ($b in 1..4) { $sec.Borders.Item(-$b).LineStyle = 1; $sec.Borders.Item(-$b).Color = 0x7F3F00 } }
  $word.ActiveWindow.View.Zoom.Percentage = 50
  Start-Sleep -Milliseconds 1500
  Snap 'w-4'                                                        # the finished newsletter

  # Line numbers (IEB): a figure
  $word.ActiveWindow.View.Zoom.Percentage = 100
  foreach ($sec in $doc.Sections) { $sec.PageSetup.LineNumbering.Active = -1 }
  $doc.Range(0, 0).Select()
  $word.ActiveWindow.ScrollIntoView($doc.Range(0, 0), $true)
  Start-Sleep -Milliseconds 1200
  Snap 'l-1'
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
  foreach ($d in $doc, $sign, $start) { if ($d) { try { $d.Saved = $true; $d.Close(0) } catch { } } }
  $word.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
