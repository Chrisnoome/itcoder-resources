# Shared helpers for the catword lesson 1-5 screen scripts (catword-start,
# -editing, -fonts, -paragraphs, -lists; 8 October 2026). Dot-source it after
# office-kit.ps1:   . (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
# It lives in work\ because vm-shots.ps1 copies work\ into the VM with the script.
#
# What it adds to office-kit: dialog boxes and menus (pressed on a thread of
# their own, since a button that opens a modal box does not return until it
# closes; pictured by their own window handle; closed with Escape posted to
# them), and pictures CROPPED HERE - never the title bar, which shows the
# Office account - with each target written in per cent of its cropped picture
# (out\<Name>.json, 'pct'), so nothing needs cat-crop.py.

Add-Type -ReferencedAssemblies ([System.Windows.Automation.AutomationElement].Assembly.Location), ([System.Windows.Automation.ControlType].Assembly.Location), ([Reflection.Assembly]::Load('WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35').Location) -TypeDefinition @'
using System; using System.Text; using System.Threading; using System.Collections.Generic; using System.Runtime.InteropServices; using System.Windows.Automation;
public static class Later {
  // A control pressed on a thread of its own: a button that opens a dialog box (modal) does not return until the box closes.
  public static void Invoke (AutomationElement e) {
    Thread t = new Thread (delegate () { try { object p; if (e.TryGetCurrentPattern (InvokePattern.Pattern, out p)) ((InvokePattern) p).Invoke (); else if (e.TryGetCurrentPattern (ExpandCollapsePattern.Pattern, out p)) ((ExpandCollapsePattern) p).Expand (); else if (e.TryGetCurrentPattern (TogglePattern.Pattern, out p)) ((TogglePattern) p).Toggle (); } catch (Exception) { } });
    t.IsBackground = true; t.Start ();
  }
  public static void Expand (AutomationElement e) {
    Thread t = new Thread (delegate () { try { object p; if (e.TryGetCurrentPattern (ExpandCollapsePattern.Pattern, out p)) ((ExpandCollapsePattern) p).Expand (); else if (e.TryGetCurrentPattern (InvokePattern.Pattern, out p)) ((InvokePattern) p).Invoke (); } catch (Exception) { } });
    t.IsBackground = true; t.Start ();
  }
  delegate bool EnumProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc p, IntPtr l);
  [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr h, out uint pid);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr h);
  // Every visible top-level window of a process: "handle<TAB>class<TAB>title".
  public static string[] Windows (uint pid) {
    List<string> all = new List<string> ();
    EnumWindows (delegate (IntPtr h, IntPtr l) { uint p; GetWindowThreadProcessId (h, out p);
      if (p == pid && IsWindowVisible (h)) { StringBuilder c = new StringBuilder (256), t = new StringBuilder (256); GetClassName (h, c, 256); GetWindowText (h, t, 256); all.Add (h.ToString () + "\t" + c + "\t" + t); }
      return true; }, IntPtr.Zero);
    return all.ToArray ();
  }
}
'@
# A trace that is written as the run goes (the .log only arrives at the end): C:\sims\<Name>.trace in the VM.
function Trace ($m) { Add-Content "C:\sims\$Name.trace" ((Get-Date -Format 'HH:mm:ss') + ' ' + $m) }
Remove-Item "C:\sims\$Name.trace" -ErrorAction SilentlyContinue
Trace 'kit loaded'
$raw = Join-Path $env:TEMP "$Name-raw"
New-Item -ItemType Directory -Force $raw | Out-Null
$script:crops = @{}
$script:pct   = [ordered]@{}
$script:wpid  = 0

# A new visible top-level window of Word's (a dialog box, a menu) that was not there in $before - or zero.
function NewWindow ($before, [string[]]$classes, [int]$tries = 40) {
  for ($i = 0; $i -lt $tries; $i++) {
    Start-Sleep -Milliseconds 250
    foreach ($line in [Later]::Windows($script:wpid)) {
      $parts = $line -split "`t"
      if ($before -notcontains $line -and ($classes.Count -eq 0 -or $classes -contains $parts[1])) { return [IntPtr][long]$parts[0] }
    }
  }
  return [IntPtr]::Zero
}

# A dialog box opened by a control, pressed on its own thread. Returns the box's handle.
function OpenDialog ($element) {
  Trace "dialog from $($element.Current.Name)"
  $before = [Later]::Windows($script:wpid)
  [Later]::Invoke($element)
  $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog')
  if ($dlg -eq [IntPtr]::Zero) { throw "No dialog box opened from '$($element.Current.Name)'" }
  Start-Sleep -Milliseconds 1200
  return $dlg
}
# A Word dialog box that has no button on the ribbon (Tabs: 179), shown by Word itself from another process
# (Dialogs.Item(n).Show() waits until the box closes, so it must not be this script that calls it).
function ShowWordDialog ([int]$id) {
  Trace "word dialog $id"
  $before = [Later]::Windows($script:wpid)
  $cmd = "[Runtime.InteropServices.Marshal]::GetActiveObject('Word.Application').Dialogs.Item($id).Show() | Out-Null"
  Start-Process powershell.exe -WindowStyle Hidden -ArgumentList '-NoProfile', '-Command', $cmd
  $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 60
  if ($dlg -eq [IntPtr]::Zero) { throw "Word dialog $id did not open" }
  Start-Sleep -Milliseconds 1200
  return $dlg
}
function CloseDialog ($dlg) { [Shot]::PostKey($dlg, 0x1B); Start-Sleep -Milliseconds 1200 }

# A menu or gallery opened by a control (its arrow), on its own thread. Returns the menu window's handle, or zero.
function OpenMenu ($element) {
  Trace "menu from $($element.Current.Name)"
  $before = [Later]::Windows($script:wpid)
  [Later]::Expand($element)
  $menu = NewWindow $before @() 20
  Start-Sleep -Milliseconds 900
  Write-Host ("  menu window: " + (([Later]::Windows($script:wpid) | Where-Object { $before -notcontains $_ }) -join ' | '))
  return $menu
}

# Every named control of a window (a dialog box or a menu) and where it is in that window's pixels.
function DumpWin ($win, $file) {
  $w = [WinRect]::Of($win)
  $lines = foreach ($e in $AE::FromHandle($win).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
    try { $c = $e.Current; if ($c.Name) { ($c.Name, $c.ControlType.ProgrammaticName, ('{0},{1},{2},{3}' -f [int]($c.BoundingRectangle.X - $w[0]), [int]($c.BoundingRectangle.Y - $w[1]), [int]$c.BoundingRectangle.Width, [int]$c.BoundingRectangle.Height)) -join "`t" } } catch { }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}

# Where a control is, in pixels of the window $win (the main window, or a dialog box).
function BoxIn ($element, $win) {
  $r = $element.Current.BoundingRectangle
  $w = [WinRect]::Of($win)
  return @([int]($r.X - $w[0]), [int]($r.Y - $w[1]), [int]$r.Width, [int]$r.Height)
}
# A control in a dialog box or menu whose name matches a pattern (dialog controls may say they are off the screen, and
# their names can carry an access key or a colon) - the first match, or an error that lists what is there.
function FindIn ($win, [string[]]$names, $type = $null) {
  for ($try = 0; $try -lt 12; $try++) {
    $all = $AE::FromHandle($win).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)
    foreach ($name in $names) {
      $want = '^&?' + [regex]::Escape($name).Replace('&', '&?') + ':?$'
      foreach ($e in $all) { try { $n = $e.Current.Name -replace '&', ''; if ($n -match $want -and (-not $type -or $e.Current.ControlType -eq $type)) { return $e } } catch { } }
    }
    Start-Sleep -Milliseconds 250
  }
  $list = foreach ($e in $all) { try { if ($e.Current.Name) { $e.Current.Name } } catch { } }
  throw "No control called '$($names -join "' or '")' in the box. It has: $(($list | Select-Object -First 60) -join ' | ')"
}

# Save window $win (default: Word's) as out\<Name>-<n>.png, cropped to $box [x, y, w, h] in window pixels
# ($null: all of it). $popup: a menu window drawn on top at its own place, as the screen shows it.
function Pic ($n, $box, $win = $null, $popup = [IntPtr]::Zero) {
  if ($null -eq $win) { $win = $h }
  Trace "picture $n"
  Guard
  Start-Sleep -Milliseconds 900
  if ($win -eq $h -and $popup -eq [IntPtr]::Zero) { [Shot]::Back($h); Start-Sleep -Milliseconds 500 }
  $file = Join-Path $raw "$n.png"
  [void][Shot]::Save($win, $file)
  $bmp = New-Object System.Drawing.Bitmap $file
  $canvas = New-Object System.Drawing.Bitmap $bmp.Width, $bmp.Height
  $g = [System.Drawing.Graphics]::FromImage($canvas)
  $g.DrawImage($bmp, 0, 0, $bmp.Width, $bmp.Height)
  if ($popup -ne [IntPtr]::Zero) {
    $pfile = Join-Path $raw "$n-popup.png"
    [void][Shot]::Save($popup, $pfile)
    $pb = New-Object System.Drawing.Bitmap $pfile
    $a = [WinRect]::Of($win); $b = [WinRect]::Of($popup)
    $g.DrawImage($pb, $b[0] - $a[0], $b[1] - $a[1], $pb.Width, $pb.Height)
    $pb.Dispose()
  }
  $g.Dispose()
  if ($null -eq $box) { $box = @(0, 0, $bmp.Width, $bmp.Height) }
  $bmp.Dispose()
  $crop = $canvas.Clone((New-Object System.Drawing.Rectangle $box[0], $box[1], $box[2], $box[3]), [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
  $crop.Save((Join-Path $out "$Name-$n.png"), [System.Drawing.Imaging.ImageFormat]::Png)
  $crop.Dispose(); $canvas.Dispose()
  $script:crops[$n] = $box
  Guard
  "picture $n"
}

# A target in per cent of picture $n: $b is [x, y, w, h] in the same window's pixels as that picture.
function Pct ($key, $n, $b) {
  $c = $script:crops[$n]
  $v = @([math]::Round(($b[0] - $c[0]) / $c[2] * 100, 1), [math]::Round(($b[1] - $c[1]) / $c[3] * 100, 1), [math]::Round($b[2] / $c[2] * 100, 1), [math]::Round($b[3] / $c[3] * 100, 1))
  $script:pct["$key@$n"] = $v
  "  $key@$n = [$($v -join ', ')]"
}
function SavePct { (@{ crops = $script:crops; pct = $script:pct } | ConvertTo-Json -Depth 5) | Set-Content (Join-Path $out "$Name.json") -Encoding utf8; "places -> out\$Name.json" }

# Word's window at 1750 x 720 (narrower and the ribbon folds groups into menus), Print Layout at 100%, no rulers, no Navigation pane.
function WordWindow {
  Trace 'WordWindow'
  $script:h = [IntPtr]$word.ActiveWindow.Hwnd
  $word.WindowState = 0
  [Shot]::Place($script:h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($script:h, 40, 40, 1750, 720)
  $word.ActiveWindow.View.Type = 3
  $word.ActiveWindow.View.Zoom.Percentage = 100
  $word.ActiveWindow.DisplayRulers = $false
  $word.ActiveWindow.DocumentMap = $false
  Start-Sleep -Milliseconds 2000
  $script:root = $AE::FromHandle($script:h)
  $script:wpid = [Shot]::Pid($script:h)
}
function NewDoc ([string[]]$lines) {
  $d = $word.Documents.Add()
  if ($lines.Count -gt 0) { $d.Content.Text = ($lines -join "`r") }
  foreach ($style in $d.Styles) { try { if ($style.QuickStyle -and -not $style.BuiltIn) { $style.QuickStyle = $false } } catch { } }
  return $d
}
# Where a piece of text is (window pixels).
function TextBox ($range) {
  $l = 0; $t = 0; $w = 0; $ht = 0
  $word.ActiveWindow.GetPoint([ref]$l, [ref]$t, [ref]$w, [ref]$ht, $range)
  $win = [WinRect]::Of($h)
  return @(($l - $win[0]), ($t - $win[1]), $w, $ht)
}
function Para ($d, $n) { $d.Paragraphs.Item($n).Range }
function Words ($d, $n, $find) { $r = Para $d $n; $i = $r.Text.IndexOf($find); if ($i -lt 0) { throw "No '$find' in paragraph $n" }; return $d.Range($r.Start + $i, $r.Start + $i + $find.Length) }
function Tab ($name) { Press (Find $root @($name) $T::TabItem); Start-Sleep -Milliseconds 900 }
function Ctl ($names, $type = $null) { return Find $root $names $type }
# Every status bar part whose name starts like this (Word Count 29 words, Page Number Page 1 of 1).
function Status ($like) { foreach ($e in $root.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -like $like) { return $e } } catch { } } ; throw "No '$like'" }
# Save a document for pupils: C:\sims\files\<Name>\ (comes back to the host) and the cloud, G:\My Drive\CAT\Word\.
# Saving. Document.SaveAs2 hangs in the CAT VM (8 October 2026: it never returns, hidden or shown), so a
# document is saved the way a pupil does it - File > Save As > Recent > the CAT Word folder on Google
# Drive > the name > Save - and then copied to C:\sims\files\<Name>\, which vm-shots brings back.
function SaveCloud ($d, $file) {
  Trace "saving $file"
  $g = Join-Path 'G:\My Drive\CAT\Word' $file
  Remove-Item $g -ErrorAction SilentlyContinue
  Press (Find $root @('File Tab')); Start-Sleep -Milliseconds 2500
  Press (Find $root @('Save As') $T::ListItem); Start-Sleep -Milliseconds 2500
  Press (Find $root @('Recent') $T::TabItem); Start-Sleep -Milliseconds 2000
  $folder = $null
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) {
    try { if ($e.Current.Name -eq 'Word' -and (Box $e)[0] -gt 600 -and -not $e.Current.IsOffscreen) { $folder = $e; break } } catch { }
  }
  if (-not $folder) { throw 'No CAT Word folder in Save As > Recent' }
  Press $folder; Start-Sleep -Milliseconds 2500
  $box = Find $root @('Enter file name here') $T::Edit
  $vp = $null; [void]$box.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$vp)
  $vp.SetValue([IO.Path]::GetFileNameWithoutExtension($file))
  Start-Sleep -Milliseconds 800
  [Later]::Invoke((Find $root @('Save') $T::Button))
  for ($i = 0; $i -lt 80 -and -not (Test-Path $g); $i++) { Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 2500
  if (-not (Test-Path $g)) { throw "Saving $file did not work" }
  try { [void](Find $root @('File Tab') $null 4) } catch { [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 1500 }
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null
  Copy-Item $g (Join-Path "C:\sims\files\$Name" $file) -Force
  Trace "saved $file"
  "saved $file"
}
function SaveForPupils ($d, $file) { SaveCloud $d $file }           # the starter: stays in the cloud as well
function SaveModel ($d, $file) { SaveCloud $d $file }               # the done-right copy

$A = @(0, 56, 1290, 656)     # the usual crop: the ribbon, the page, the left of the status bar
$F = @(0, 56, 1750, 656)     # the whole window below the title bar

Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep 2
