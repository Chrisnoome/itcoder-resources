# Real Word 365 screens for catword lesson 8, Pictures, shapes and WordArt
# (content/catword/illustrations.php - Chris, 8 October 2026: "do the cat
# practical courses"). Thabo's project on e-waste: a picture from the
# computer (work\catword-ewaste.jpg - the course's own ComfyUI picture,
# public/assets/match/theory10/e-waste-g1.webp), text wrapped round it,
# WordArt, a SmartArt process; the Shapes, Text Box, Screenshot and chart
# windows for figures. Menus and dialog boxes are saved beside the main
# picture (SnapPop) and laid over it by catword-b-crop.py.
# Run it in the CAT VM:  pwsh -File vm-shots.ps1 catword-illustrations
# Then:                  python catword-b-crop.py catword-illustrations
$Name = 'catword-illustrations'
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

$pictures = [Environment]::GetFolderPath('MyPictures')
Copy-Item (Join-Path $PSScriptRoot 'work\catword-ewaste.jpg') (Join-Path $pictures 'e-waste.jpg') -Force

$word = New-Object -ComObject Word.Application
$doc = $null
try {
  $word.DisplayAlerts = 0
  "started"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null
  $doc = $word.Documents.Add()
  OwnStyles $doc
  $doc.PageSetup.PaperSize = 7
  $doc.Content.Text = (@(
    'E-waste in Soweto',
    'Every year South Africans throw away thousands of tonnes of old phones, computers and chargers. Most of it ends up on rubbish dumps, where the metals and plastics leak into the soil and the water.',
    'An old phone is not rubbish. Its battery, its circuit board and its screen can all be taken apart and used again. The gold, copper and silver inside it are worth money.',
    'In this project I look at where the e-waste in my area goes, and at three things every family can do about it.',
    '') -join "`r")
  $doc.Paragraphs.Item(1).Style = -63
  $word.Visible = $true
  $word.WindowState = 0
  $h = [IntPtr]$word.ActiveWindow.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 860); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 860)
  $word.ActiveWindow.View.Type = 3
  $word.ActiveWindow.View.Zoom.Percentage = 100
  $word.ActiveWindow.DisplayRulers = $false
  $word.ActiveWindow.DocumentMap = $false
  $s2 = $doc.Paragraphs.Item(2).Range.Start
  $doc.Range($s2, $s2).Select()
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  # 1. A picture from the computer
  Tab 'Insert'
  TryMark 'pictures' $root @('Pictures')
  TryMark 'shapes' $root @('Shapes')
  TryMark 'icons' $root @('Icons')
  TryMark 'smartart' $root @('SmartArt...', 'SmartArt')
  TryMark 'chart' $root @('Chart...', 'Chart')
  TryMark 'screenshot' $root @('Screenshot')
  TryMark 'textbox' $root @('Text Box')
  TryMark 'wordart' $root @('WordArt')
  Dump 'insert'
  Snap 'p-1'                                                        # Insert tab: click Pictures
  PressLater (Find $root @('Pictures'))
  $menu = WaitPop
  DumpWin $menu 'picturesmenu'
  MarkIn 'thisDevice' $menu @('This Device...', 'This Device')
  SnapPop 'p-2'                                                     # the menu: click This Device...
  PressLater (FindIn $menu @('This Device...', 'This Device'))
  Start-Sleep -Milliseconds 2500
  $dlg = WaitPop '#32770'
  Start-Sleep -Milliseconds 2000
  DumpWin $dlg 'insertpicturedlg'
  MarkIn 'ewasteFile' $dlg @('e-waste', 'e-waste.jpg')
  MarkIn 'insertBtn' $dlg @('Insert')
  SnapPop 'p-3'                                                     # Insert Picture: double-click e-waste
  ClosePops
  $pic = $doc.InlineShapes.AddPicture((Join-Path $pictures 'e-waste.jpg'), $false, $true, $doc.Range($s2, $s2))
  $pic.LockAspectRatio = -1
  $pic.Width = $word.CentimetersToPoints(5)
  Start-Sleep -Milliseconds 800
  $pic.Select()
  Start-Sleep -Milliseconds 1200
  Mark 'picture' (TextBox ($pic.Range))
  Snap 'p-4'                                                        # done: the picture, in line with the text

  # 2. Wrap text round it: Picture Format tab, Wrap Text, Square
  Tab 'Home'
  $pic.Select()
  Start-Sleep -Milliseconds 800
  TryMark 'pictureFormatTab' $root @('Picture Format') $T::TabItem
  Snap 'w-1'                                                        # Home tab, picture selected: click Picture Format
  Tab 'Picture Format'
  TryMark 'wrapText' $root @('Wrap Text')
  TryMark 'position' $root @('Position')
  TryMark 'bringForward' $root @('Bring Forward')
  TryMark 'sendBackward' $root @('Send Backward')
  TryMark 'align' $root @('Align')
  TryMark 'group' $root @('Group')
  TryMark 'rotate' $root @('Rotate')
  TryMark 'selectionPane' $root @('Selection Pane...', 'Selection Pane')
  Dump 'pictureformat'
  Snap 'w-2'                                                        # click Wrap Text
  PressLater (Find $root @('Wrap Text'))
  $menu = WaitPop
  DumpWin $menu 'wrapmenu'
  MarkIn 'square' $menu @('Square')
  MarkIn 'inLine' $menu @('In Line with Text')
  MarkIn 'tight' $menu @('Tight')
  MarkIn 'behind' $menu @('Behind Text')
  SnapPop 'w-3'                                                     # the menu: click Square
  EscPops
  $shape = $pic.ConvertToShape()
  $shape.WrapFormat.Type = 0                                        # wdWrapSquare
  $shape.RelativeHorizontalPosition = 0                             # the margin
  $shape.Left = -999996                                             # wdShapeRight
  $shape.Select()
  Start-Sleep -Milliseconds 1200
  Snap 'w-4'                                                        # done: the text wraps round it

  # 3. WordArt
  $e = $doc.Paragraphs.Item(5).Range.Start
  $doc.Range($e, $e).Select()
  Tab 'Insert'
  Snap 'a-1'                                                        # Insert tab: click WordArt
  PressLater (Find $root @('WordArt'))
  $menu = WaitPop
  DumpWin $menu 'wordartmenu'
  SnapPop 'a-2'                                                     # the gallery: click the first style
  $items = $AE::FromHandle($menu).FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))
  if ($items.Count -eq 0) { $items = @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -like 'Fill*' }) }
  if ($items.Count -eq 0) { $items = @($AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -like 'Fill*' }) }
  $k = 0; foreach ($it in $items) { $k++; if ($k -le 3) { Mark "wordart$k" (Box $it) } }
  if ($items.Count -gt 0) { PressLater $items[0]; Start-Sleep -Milliseconds 2500 } else { EscPops }
  Start-Sleep -Milliseconds 1000
  Mark 'wordartText' (TextBox ($word.Selection.Range))
  Snap 'a-3'                                                        # "Your text here", selected: type
  try { $word.Selection.TypeText('Say no to e-waste') } catch { "  no typing: $_" }
  Start-Sleep -Milliseconds 1000
  Snap 'a-4'                                                        # done

  # 4. SmartArt: a process
  $doc.Range($doc.Content.End - 1, $doc.Content.End - 1).Select()
  Tab 'Insert'
  Snap 'm-1'                                                        # Insert tab: click SmartArt
  PressLater (Find $root @('SmartArt...', 'SmartArt'))
  Start-Sleep -Milliseconds 2500
  $dlg = WaitPop
  Start-Sleep -Milliseconds 1500
  DumpWin $dlg 'smartartdlg'
  $de = $AE::FromHandle($dlg)
  MarkIn 'process' $dlg @('Process')
  MarkIn 'okSmart' $dlg @('OK')
  SnapPop 'm-2'                                                     # the dialog box: click Process
  try { Press (Find $de @('Process') -tries 6); Start-Sleep -Milliseconds 1500 } catch { "  no Process: $_" }
  DumpWin $dlg 'smartartdlg2'
  MarkIn 'basicProcess' $dlg @('Basic Process')
  SnapPop 'm-3'                                                     # Process: click Basic Process
  try { Press (Find $de @('Basic Process') -tries 6); Start-Sleep -Milliseconds 1200 } catch { "  no Basic Process: $_" }
  SnapPop 'm-4'                                                     # chosen: click OK
  try { PressLater (Find $de @('OK') $T::Button -tries 6); Start-Sleep -Milliseconds 3000 } catch { ClosePops }
  try {
    $art = $doc.Shapes | Where-Object { $_.HasSmartArt } | Select-Object -First 1
    if (-not $art) { foreach ($ils in $doc.InlineShapes) { if ($ils.HasSmartArt) { $art = $ils } } }
    $words = 'Collect', 'Sort', 'Recycle'
    for ($i = 1; $i -le 3; $i++) { $art.SmartArt.AllNodes.Item($i).TextFrame2.TextRange.Text = $words[$i - 1] }
  } catch { "  no SmartArt text: $_" }
  $doc.Range($doc.Content.End - 1, $doc.Content.End - 1).Select()
  Start-Sleep -Milliseconds 1500
  Snap 'm-5'                                                        # done

  # Figures: the Shapes gallery, Text Box gallery, Screenshot menu, Icons, Insert Chart
  $doc.Range($doc.Content.End - 1, $doc.Content.End - 1).Select()
  Tab 'Insert'
  foreach ($pair in @(@('Shapes', 'f-1'), @('Text Box', 'f-2'), @('Screenshot', 'f-3'))) {
    try { PressLater (Find $root @($pair[0])); $menu = WaitPop; SnapPop $pair[1]; EscPops } catch { "  no $($pair[0]) menu: $_"; EscPops }
  }
  try { PressLater (Find $root @('Chart...', 'Chart')); Start-Sleep -Milliseconds 2500; $dlg = WaitPop; Start-Sleep -Milliseconds 1500; SnapPop 'f-4'; ClosePops } catch { "  no chart dialog: $_"; ClosePops }
  try { PressLater (Find $root @('Icons')); Start-Sleep -Milliseconds 4000; $dlg = WaitPop; Start-Sleep -Milliseconds 3000; SnapPop 'f-5'; ClosePops } catch { "  no icons: $_"; ClosePops }
  $doc.Saved = $true

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
  if ($doc) { try { $doc.Saved = $true; $doc.Close(0) } catch { } }
  $word.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
