# Real Word 365 screens for catword lesson 9, Proofing and printing
# (content/catword/proofing.php - Chris, 8 October 2026: "do the cat
# practical courses"). Thabo's essay with mistakes in it: a right-click on a
# misspelt word, the Editor pane from the Review tab, the thesaurus, word
# count, a comment, Read Mode and the Print screen. Menus and dialog boxes are
# saved beside the main picture (SnapPop) and laid over it by
# catword-b-crop.py. The right-click menu is opened with a WM_CONTEXTMENU
# message to Word's document window - nothing clicks. Also makes the upload's
# starter file and a done-right copy.
# Run it in the CAT VM:  pwsh -File vm-shots.ps1 catword-proofing
# Then:                  python catword-b-crop.py catword-proofing
$Name = 'catword-proofing'
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

function Essay ($d, [string[]]$paras) {
  $d.Content.Text = ($paras -join "`r")
  OwnStyles $d
  $d.PageSetup.PaperSize = 7
  $d.Paragraphs.Item(1).Style = -63
}
function Para ($d, $text) { foreach ($p in $d.Paragraphs) { if ($p.Range.Text -like "*$text*") { return $p } }; throw "no paragraph with $text" }
function WordIn ($d, $text) { $r = $d.Content; $f = $r.Find; [void]$f.Execute($text, $true, (-not $text.Contains(' '))); if (-not $f.Found) { throw "no $text" }; return $r }

$word = New-Object -ComObject Word.Application
$doc = $null; $start = $null
try {
  $word.DisplayAlerts = 0
  "started"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null

  # ---- the lesson's document
  $doc = $word.Documents.Add()
  Essay $doc @(
    'My dream job',
    'When I finish school I want to become a software developer. I like solving problems, and I want to recieve a bursary to study at university.',
    'My sister Lerato says the the best developers never stop learning. She is right: the tools change every year.',
    'I will practise every day, keep my marks high and finish my projects on time. Nothing will stop me.')
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
  Start-Sleep -Milliseconds 4000                                    # time for the spelling check to underline
  $root = $AE::FromHandle($h)
  $wwg = [Shot]::Child($h, '_WwG')

  # 1. Right-click a misspelt word, choose the right spelling
  Tab 'Home'
  $bad = WordIn $doc 'recieve'
  Mark 'recieve' (TextBox $bad)
  Snap 'r-1'                                                        # right-click recieve
  $doc.Range($bad.Start + 2, $bad.Start + 2).Select()
  Start-Sleep -Milliseconds 600
  [void][CwWin]::PostMessage($wwg, 0x7B, $wwg, [IntPtr](-1))       # WM_CONTEXTMENU, as from the keyboard: at the cursor
  Start-Sleep -Milliseconds 2000
  $menu = $null; try { $menu = WaitPop } catch { '  NO CONTEXT MENU' }
  if ($menu) {
    DumpWin $menu 'contextmenu'
    MarkIn 'receive' $menu @('receive')
    SnapPop 'r-2'                                                   # the menu: click receive
    EscPops
  }
  $bad = WordIn $doc 'recieve'
  $bad.Text = 'receive'
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 1500
  Snap 'r-3'                                                        # done

  # 2. The Review tab's Spelling & Grammar: the Editor pane, the repeated word
  TryMark 'tabReview' $root @('Review') $T::TabItem
  Snap 'e-1'                                                        # Home tab: click Review
  Tab 'Review'
  TryMark 'spelling' $root @('Spelling & Grammar', 'Spelling and Grammar', 'Editor')
  TryMark 'thesaurus' $root @('Thesaurus...', 'Thesaurus')
  TryMark 'wordCount' $root @('Word Count...', 'Word Count')
  TryMark 'newComment' $root @('New Comment')
  Dump 'review'
  Snap 'e-2'                                                        # Review tab: click Spelling & Grammar
  PressLater (Find $root @('Spelling & Grammar', 'Spelling and Grammar', 'Editor'))
  Start-Sleep -Milliseconds 6000
  Dump 'editorpane'
  foreach ($w in Pops) { "  window $([CwWin]::Class($w))" }
  TryMark 'deleteRepeated' $root @('Delete Repeated Word', 'Delete repeated word', 'the')
  SnapPop 'e-3'                                                     # the Editor pane: click Delete Repeated Word
  $dup = WordIn $doc 'the the'
  $dup.Text = 'the'
  Start-Sleep -Milliseconds 2500
  SnapPop 'e-4'                                                     # done (the pane says so)
  try { $word.TaskPanes | Out-Null } catch { }
  EscPops
  try { $word.CommandBars.ExecuteMso('ReviewEditor') } catch { }   # a second press closes the pane, if it is a toggle
  Start-Sleep -Milliseconds 1500

  # 3. The thesaurus: double-click "like", Shift+F7
  $like = WordIn $doc 'like'
  Mark 'like' (TextBox $like)
  $doc.Range(0, 0).Select()
  Snap 't-1'                                                        # double-click like
  $like.Select()
  Start-Sleep -Milliseconds 800
  Snap 't-2'                                                        # selected: Shift+F7
  try { PressLater (Find $root @('Thesaurus...', 'Thesaurus')); Start-Sleep -Milliseconds 5000 } catch { "  no thesaurus: $_" }
  Dump 'thesauruspane'
  Snap 't-3'                                                        # done: the Thesaurus pane
  try { $word.CommandBars.ExecuteMso('Thesaurus') } catch { }
  Start-Sleep -Milliseconds 1000

  # Word Count (a figure)
  $doc.Range(0, 0).Select()
  PressLater (Find $root @('Word Count...', 'Word Count'))
  try { $dlg = WaitPop 'bosa_sdm_msword'; SnapPop 'c-1'; ClosePops } catch { "  no word count: $_"; ClosePops }

  # A comment (a figure)
  $c = $doc.Comments.Add((WordIn $doc 'software developer'), 'Which kind? Web, games or apps? - Ms Naidoo')
  try { $c.Author = 'Ms Naidoo'; $c.Initial = 'MN' } catch { }
  $doc.Range(0, 0).Select()
  Start-Sleep -Milliseconds 2000
  Snap 'c-2'
  $c.Delete()

  # Views: the View tab, then Read Mode (figures)
  Tab 'View'
  TryMark 'readMode' $root @('Read Mode')
  TryMark 'zoomBtn' $root @('Zoom...', 'Zoom')
  Dump 'view'
  Snap 'v-1'
  $word.ActiveWindow.View.Type = 7                                  # wdReadingView
  Start-Sleep -Milliseconds 2500
  Snap 'v-2'
  $word.ActiveWindow.View.Type = 3
  Start-Sleep -Milliseconds 1500

  # 4. Print: File tab, Print
  Tab 'Home'
  TryMark 'fileTab' $root @('File Tab')
  Snap 'p-1'                                                        # click File
  Press (Find $root @('File Tab'))
  Start-Sleep -Milliseconds 2500
  Dump 'backstage'
  TryMark 'print' $root @('Print') $T::ListItem
  TryMark 'exportItem' $root @('Export') $T::ListItem
  Snap 'p-2'                                                        # backstage: click Print
  try { Press (Find $root @('Print') $T::ListItem -tries 8) } catch { try { Press (Find $root @('Print') -tries 8) } catch { "  no Print: $_" } }
  Start-Sleep -Milliseconds 4000
  Dump 'printpane'
  TryMark 'printBtn' $root @('Print') $T::Button
  TryMark 'printer' $root @('Printer')
  Snap 'p-3'                                                        # done: the Print screen and its preview
  try { Press (Find $root @('Export') $T::ListItem -tries 8); Start-Sleep -Milliseconds 2500; Snap 'p-4' } catch { "  no Export: $_" }
  [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 1500
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
