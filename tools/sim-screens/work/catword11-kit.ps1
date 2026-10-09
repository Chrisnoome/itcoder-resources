# Helpers for the catword Grade 11 screen scripts (catword-styles, -multilevel,
# -sections, -headers, -footnotes, -mailmerge, -labels, -importing, -templates;
# 9 October 2026). Dot-source it after office-kit.ps1 and work\catword-kit.ps1:
#     . (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')
#
# What it adds:
# - SaveDoc: a document saved WITHOUT Word's own save (Document.SaveAs2 hangs in
#   the CAT VM, and Backstage's Save As > Recent lost the CAT folder on 8 and 9
#   October): the document's WordOpenXML (flat OPC) is packed into a .docx here
#   with System.IO.Compression, written to C:\sims\files\<Name>\ (comes back to
#   the host) and, for a starter file, to G:\My Drive\CAT\Word\ as well.
# - RightClick: a right-click menu opened with WM_CONTEXTMENU at a place on the
#   window, and the new menu window returned.
# - Fresh: the picture guard started afresh (after Word's start-up or a save).
# - FindAny, DumpMenu, Chars, Retry, Show.

Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
Add-Type @'
using System; using System.Runtime.InteropServices;
public static class K11 {
  [DllImport ("user32.dll")] public static extern bool PostMessage (IntPtr h, uint m, IntPtr w, IntPtr l);
  [StructLayout (LayoutKind.Sequential)] public struct PT { public int X; public int Y; }
  [DllImport ("user32.dll")] public static extern bool ScreenToClient (IntPtr h, ref PT p);
  public static IntPtr Lp (int x, int y) { return new IntPtr (((y & 0xFFFF) << 16) | (x & 0xFFFF)); }
  public static void Chars (IntPtr h, string s) { foreach (char c in s) { PostMessage (h, 0x0102, new IntPtr (c), IntPtr.Zero); System.Threading.Thread.Sleep (40); } }
}
'@

function Fresh { $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false }

# A flat OPC string (Document.WordOpenXML) -> a .docx file at $path.
function FlatToDocx ([string]$flat, [string]$path) {
  $xml = New-Object System.Xml.XmlDocument
  $xml.PreserveWhitespace = $true
  $xml.LoadXml($flat)
  $ns = New-Object System.Xml.XmlNamespaceManager $xml.NameTable
  $ns.AddNamespace('pkg', 'http://schemas.microsoft.com/office/2006/xmlPackage')
  if (Test-Path $path) { Remove-Item $path -Force }
  $fs = [IO.File]::Open($path, 'Create')
  $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
  $types = New-Object System.Text.StringBuilder
  [void]$types.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">')
  foreach ($part in $xml.SelectNodes('//pkg:part', $ns)) {
    $name = $part.GetAttribute('name', 'http://schemas.microsoft.com/office/2006/xmlPackage').TrimStart('/')
    $ct   = $part.GetAttribute('contentType', 'http://schemas.microsoft.com/office/2006/xmlPackage')
    [void]$types.Append(('<Override PartName="/{0}" ContentType="{1}"/>' -f $name, $ct))
    $entry = $zip.CreateEntry($name)
    $s = $entry.Open()
    $data = $part.SelectSingleNode('pkg:xmlData', $ns)
    if ($data) {
      $inner = $data.FirstChild
      while ($inner -and $inner.NodeType -ne [System.Xml.XmlNodeType]::Element) { $inner = $inner.NextSibling }
      $bytes = [Text.Encoding]::UTF8.GetBytes('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "`r`n" + $inner.OuterXml)
    } else {
      $bytes = [Convert]::FromBase64String(($part.SelectSingleNode('pkg:binaryData', $ns).InnerText -replace '\s', ''))
    }
    $s.Write($bytes, 0, $bytes.Length); $s.Dispose()
  }
  [void]$types.Append('</Types>')
  $entry = $zip.CreateEntry('[Content_Types].xml')
  $s = $entry.Open(); $b = [Text.Encoding]::UTF8.GetBytes($types.ToString()); $s.Write($b, 0, $b.Length); $s.Dispose()
  $zip.Dispose(); $fs.Dispose()
}

# A document saved as $file (e.g. 'Price list.docx'): C:\sims\files\<Name>\ always; G:\My Drive\CAT\Word\ when $cloud.
function SaveDoc ($d, [string]$file, [bool]$cloud = $true) {
  Trace "packing $file"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null
  $local = Join-Path "C:\sims\files\$Name" $file
  FlatToDocx $d.WordOpenXML $local
  if ($cloud) {
    try { Copy-Item $local (Join-Path 'G:\My Drive\CAT\Word' $file) -Force; "  saved $file (and in the cloud)" } catch { "  saved $file - NOT in the cloud: $_" }
  } else { "  saved $file" }
}

# A control anywhere: a menu window, Word's window, or the desktop (Office menus show up under any of them).
function FindAny ($hwnd, [string[]]$names, $type = $null) {
  $roots = @($root, $AE::RootElement)
  if ($hwnd -and $hwnd -ne [IntPtr]::Zero) { $roots = @($AE::FromHandle($hwnd)) + $roots }
  foreach ($r in $roots) { try { return (Find $r $names $type 3) } catch { } }
  throw "No control called '$($names -join "' or '")'"
}
# Every named item of a menu window, and the list / menu items and buttons on the desktop, into out\<Name>-<file>.txt.
function DumpMenu ($menu, $file) {
  $lines = @()
  if ($menu -and $menu -ne [IntPtr]::Zero) { $lines += foreach ($e in $AE::FromHandle($menu).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { $c = $e.Current; if ($c.Name) { "menu`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } } }
  foreach ($type in $T::ListItem, $T::MenuItem, $T::Button, $T::CheckBox) {
    $lines += foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $type)))) { try { $c = $e.Current; if ($c.Name -and -not $c.IsOffscreen) { "desk`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}
# A right-click menu at [x, y] in Word's window pixels (WM_CONTEXTMENU). Returns the menu window, or zero.
function RightClick ($x, $y) {
  $before = [Later]::Windows($script:wpid)
  $win = [WinRect]::Of($h)
  $lp = [IntPtr]((((([int]$win[1] + [int]$y) -band 0xFFFF)) -shl 16) -bor ((([int]$win[0] + [int]$x) -band 0xFFFF)))
  [void][K11]::PostMessage($h, 0x007B, $h, $lp)
  $m = NewWindow $before @() 20
  Start-Sleep -Milliseconds 900
  return $m
}
# A right-click on a ribbon control (a gallery tile): the mouse messages go to the window that draws it
# (the ribbon's own child window), at the control's centre. Returns the menu window, or zero.
function RightClickEl ($element) {
  $walker = [System.Windows.Automation.TreeWalker]::RawViewWalker
  $e = $element; $hw = 0
  while ($e -and $hw -eq 0) { try { $hw = $e.Current.NativeWindowHandle } catch { }; if ($hw -eq 0) { $e = $walker.GetParent($e) } }
  if ($hw -eq 0) { $hw = [int64]$h }
  $target = [IntPtr][int64]$hw
  $r = $element.Current.BoundingRectangle
  $pt = New-Object K11+PT; $pt.X = [int]($r.X + $r.Width / 2); $pt.Y = [int]($r.Y + $r.Height / 2)
  $sx = $pt.X; $sy = $pt.Y
  [void][K11]::ScreenToClient($target, [ref]$pt)
  $before = [Later]::Windows($script:wpid)
  [void][K11]::PostMessage($target, 0x0204, [IntPtr]2, [K11]::Lp($pt.X, $pt.Y))     # WM_RBUTTONDOWN
  Start-Sleep -Milliseconds 120
  [void][K11]::PostMessage($target, 0x0205, [IntPtr]0, [K11]::Lp($pt.X, $pt.Y))     # WM_RBUTTONUP
  $m = NewWindow $before @() 12
  if ($m -eq [IntPtr]::Zero) {
    [void][K11]::PostMessage($target, 0x007B, $target, [K11]::Lp($sx, $sy))         # WM_CONTEXTMENU
    $m = NewWindow $before @() 12
  }
  Start-Sleep -Milliseconds 900
  return $m
}
function Chars ($hwnd, [string]$s) { [K11]::Chars($hwnd, $s) }
function Retry ([scriptblock]$sb) { for ($i = 0; $i -lt 30; $i++) { try { return (& $sb) } catch { if ($i -eq 29) { throw }; Start-Sleep -Milliseconds 500 } } }
function Show ($range) { $word.ActiveWindow.ScrollIntoView($range, $true); Start-Sleep -Milliseconds 700 }
# A closed menu or box: Escape to it, then to Word.
function Esc ($w) { if ($w -and $w -ne [IntPtr]::Zero) { [Shot]::PostKey($w, 0x1B); Start-Sleep -Milliseconds 600 }; [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 800 }
# The first ribbon list item (a gallery tile) whose name matches, or $null.
function Tile ($pattern) { $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -match $pattern -and -not $_.Current.IsOffscreen } | Select-Object -First 1 }

# Pictures without the VM's Add-ins (and Claude) ribbon groups: P is Pic, then each such group's box on
# the ribbon is painted over with the ribbon's own colour. Only for pictures of Word's own window.
function AddinBoxes {
  $boxes = @()
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Group)))) {
    try { if ($e.Current.Name -match '^(Add-ins|Claude)' -and -not $e.Current.IsOffscreen) { $boxes += ,(Box $e) } } catch { }
  }
  return ,$boxes
}
function P ($n, $box, $win = $null, $popup = [IntPtr]::Zero) {
  $boxes = @()
  if ($null -eq $win -or $win -eq $h) { $boxes = AddinBoxes }
  Fresh                                   # the guard watches the picture itself (Word's start-up and posted clicks move the input clock)
  Pic $n $box $win $popup | Out-Null
  if ($boxes.Count -gt 0) {
    $c = $script:crops[$n]
    $file = Join-Path $out "$Name-$n.png"
    $bmp = [System.Drawing.Bitmap]::FromFile($file)
    $copy = New-Object System.Drawing.Bitmap $bmp
    $bmp.Dispose()
    $g = [System.Drawing.Graphics]::FromImage($copy)
    foreach ($b in $boxes) {
      $x = $b[0] - $c[0]; $y = $b[1] - $c[1]
      if ($x -ge $c[2] -or $y -ge $c[3] -or $x + $b[2] -le 0) { continue }
      $sx = [math]::Max(0, [math]::Min($copy.Width - 1, $x - 4)); $sy = [math]::Max(0, [math]::Min($copy.Height - 1, $y + 4))
      $brush = New-Object System.Drawing.SolidBrush ($copy.GetPixel($sx, $sy))
      $g.FillRectangle($brush, $x - 2, $y, $b[2] + 4, $b[3])
      $brush.Dispose()
    }
    $g.Dispose()
    $copy.Save($file, [System.Drawing.Imaging.ImageFormat]::Png); $copy.Dispose()
  }
  "picture $n"
}

# The document's own right-click menu at the insertion point (WM_CONTEXTMENU to Word's _WwG window, as
# from the keyboard's menu key - the menu opens where the cursor is). Returns the menu window, or zero.
function DocMenu {
  $wwg = [Shot]::Child($h, '_WwG')
  $before = [Later]::Windows($script:wpid)
  [void][K11]::PostMessage($wwg, 0x007B, $wwg, [IntPtr](-1))
  $m = NewWindow $before @() 20
  Start-Sleep -Milliseconds 900
  return $m
}

# A ribbon control clicked with posted mouse messages (for buttons whose menu UI Automation does not open).
# Returns a new window (a menu), or zero.
function ClickEl ($element) {
  $walker = [System.Windows.Automation.TreeWalker]::RawViewWalker
  $e = $element; $hw = 0
  while ($e -and $hw -eq 0) { try { $hw = $e.Current.NativeWindowHandle } catch { }; if ($hw -eq 0) { $e = $walker.GetParent($e) } }
  if ($hw -eq 0) { $hw = [int64]$h }
  $target = [IntPtr][int64]$hw
  $r = $element.Current.BoundingRectangle
  $pt = New-Object K11+PT; $pt.X = [int]($r.X + $r.Width / 2); $pt.Y = [int]($r.Y + $r.Height / 2)
  [void][K11]::ScreenToClient($target, [ref]$pt)
  $before = [Later]::Windows($script:wpid)
  [void][K11]::PostMessage($target, 0x0201, [IntPtr]1, [K11]::Lp($pt.X, $pt.Y)); Start-Sleep -Milliseconds 100
  [void][K11]::PostMessage($target, 0x0202, [IntPtr]0, [K11]::Lp($pt.X, $pt.Y))
  $m = NewWindow $before @() 16
  Start-Sleep -Milliseconds 900
  return $m
}
# A menu opened by UI Automation, or else by a posted click.
function Menu ($element) { $m = OpenMenu $element; if ($m -eq [IntPtr]::Zero) { $m = ClickEl $element }; return $m }
# A Word COM call made from another process (it may open a box and wait): fire and forget.
function ComLater ([string]$code) {
  $cmd = "`$w = [Runtime.InteropServices.Marshal]::GetActiveObject('Word.Application'); `$d = `$w.ActiveDocument; $code"
  Start-Process powershell.exe -WindowStyle Hidden -ArgumentList '-NoProfile', '-Command', $cmd
}
# Picture places in a window other than Word's (a dialog box): $element's box in per cent of picture $n, taken of $win.
function PctIn ($key, $n, $element, $win) {
  $pb = [WinRect]::Of($win); $r = $element.Current.BoundingRectangle; $c = $script:crops[$n]
  $v = @([math]::Round(($r.X - $pb[0] - $c[0]) / $c[2] * 100, 1), [math]::Round(($r.Y - $pb[1] - $c[1]) / $c[3] * 100, 1), [math]::Round($r.Width / $c[2] * 100, 1), [math]::Round($r.Height / $c[3] * 100, 1))
  $script:pct["$key@$n"] = $v
  "  $key@$n = [$($v -join ', ')]"
}
# Use an Existing List... from Select Recipients, through the Select Data Source and Select Table boxes.
# $pics: picture names for the menu, the file box and the table box (or $null for none). True when joined.
function UseList ($path, $pics = @($null, $null, $null)) {
  $sr = Ctl @('Select Recipients') $T::MenuItem
  $menu = Menu $sr
  if ($pics[0]) { P $pics[0] $A $h $menu; try { Pct 'existing' $pics[0] (BoxIn (FindAny $menu @('Use an Existing List...', 'Use an Existing List')) $h) } catch { } }
  $use = FindAny $menu @('Use an Existing List...', 'Use an Existing List')
  $before = [Later]::Windows($script:wpid)
  [Later]::Invoke($use)
  $dlg = NewWindow $before @('#32770', 'bosa_sdm_msword', 'NUIDialog') 60
  if ($dlg -eq [IntPtr]::Zero) { '  NO file box'; Esc $menu; return $false }
  Start-Sleep -Milliseconds 2500
  $fn = $null
  foreach ($e in $AE::FromHandle($dlg).FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Edit)))) { try { if ($e.Current.Name -match '^File name') { $fn = $e; break } } catch { } }
  Trace "uselist: file box $dlg"
  if (-not $fn) { Trace 'uselist: NO File name box'; '  NO File name box'; [Shot]::PostKey($dlg, 0x1B); return $false }
  $vp = $null; [void]$fn.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$vp)
  $open = $null
  foreach ($e in $AE::FromHandle($dlg).FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))) { try { if ($e.Current.Name -match '^&?Open$') { $open = $e; break } } catch { } }
  $vp.SetValue((Split-Path $path)); Start-Sleep -Milliseconds 500
  Trace "uselist: open button $([bool]$open)"
  if ($open) { [Later]::Invoke($open) } else { [Shot]::PostKey($dlg, 0x0D) }
  Start-Sleep -Milliseconds 2500
  Trace "uselist: box still there $([bool]([Later]::Windows($script:wpid) | Where-Object { $_ -like "$dlg`t*" }))"
  if ($pics[1]) {
    P $pics[1] $null $dlg
    PaintOut $pics[1] @(,@(14, 232, 178, 36))
    foreach ($e in $AE::FromHandle($dlg).FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) { try { if ($e.Current.Name -eq [IO.Path]::GetFileNameWithoutExtension($path) -or $e.Current.Name -eq (Split-Path $path -Leaf)) { PctIn 'file' $pics[1] $e $dlg; break } } catch { } }
  }
  $vp.SetValue($path); Start-Sleep -Milliseconds 500
  $before = [Later]::Windows($script:wpid)
  if ($open) { [Later]::Invoke($open) } else { [Shot]::PostKey($dlg, 0x0D) }
  Start-Sleep -Milliseconds 3000
  $tbl = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
  if ($tbl -ne [IntPtr]::Zero) {
    Start-Sleep -Milliseconds 1500
    if ($pics[2]) { DumpWin $tbl ($pics[2] + 'win'); P $pics[2] $null $tbl }
    $ok = $null
    foreach ($e in $AE::FromHandle($tbl).FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))) { try { if ($e.Current.Name -eq 'OK') { $ok = $e; break } } catch { } }
    if ($ok) { [Later]::Invoke($ok) } else { [Shot]::PostKey($tbl, 0x0D) }
    Start-Sleep -Milliseconds 3000
  } else { '  NO Select Table box' }
  return $true
}

# A click at [x, y] in a window's own picture pixels (a dialog box's controls are drawn by the box itself, so
# the box takes the mouse messages). For dialog boxes whose controls UI Automation cannot see.
function ClickAt ($hwnd, [int]$x, [int]$y) {
  $win = [WinRect]::Of($hwnd)
  $pt = New-Object K11+PT; $pt.X = [int]($win[0] + $x); $pt.Y = [int]($win[1] + $y)
  [void][K11]::ScreenToClient($hwnd, [ref]$pt)
  [void][K11]::PostMessage($hwnd, 0x0201, [IntPtr]1, [K11]::Lp($pt.X, $pt.Y)); Start-Sleep -Milliseconds 100
  [void][K11]::PostMessage($hwnd, 0x0202, [IntPtr]0, [K11]::Lp($pt.X, $pt.Y))
  Start-Sleep -Milliseconds 900
}

# A click at [px, py] in picture $n of window $hwnd (a dialog box pictured whole): the picture is drawn at the
# box's own scale, the screen may be scaled (a DPI-unaware box), so the place is worked out from both.
function ClickPic ($hwnd, $n, [int]$px, [int]$py) {
  $win = [WinRect]::Of($hwnd)
  $c = $script:crops[$n]
  $ratio = $win[2] / [double]$c[2]
  $sx = [int]($win[0] + $px * $ratio); $sy = [int]($win[1] + $py * $ratio)
  $pt = New-Object K11+PT; $pt.X = $sx; $pt.Y = $sy
  [void][K11]::ScreenToClient($hwnd, [ref]$pt)
  $cx = [int]($pt.X / $ratio); $cy = [int]($pt.Y / $ratio)
  "  click in $n at $px,$py - screen $sx,$sy - client $cx,$cy (ratio $ratio)"
  [void][K11]::PostMessage($hwnd, 0x0201, [IntPtr]1, [K11]::Lp($cx, $cy)); Start-Sleep -Milliseconds 100
  [void][K11]::PostMessage($hwnd, 0x0202, [IntPtr]0, [K11]::Lp($cx, $cy))
  Start-Sleep -Milliseconds 1200
}

# Paint over boxes [x, y, w, h] of out\<Name>-<n>.png (an account name in a file box) with the colour just left of each box.
function PaintOut ($n, $boxes) {
  $file = Join-Path $out "$Name-$n.png"
  if (-not (Test-Path $file)) { return }
  $bmp = [System.Drawing.Bitmap]::FromFile($file); $copy = New-Object System.Drawing.Bitmap $bmp; $bmp.Dispose()
  $g = [System.Drawing.Graphics]::FromImage($copy)
  foreach ($b in $boxes) {
    $sx = [math]::Max(0, $b[0] - 3); $sy = [math]::Min($copy.Height - 1, $b[1] + 2)
    $br = New-Object System.Drawing.SolidBrush ($copy.GetPixel($sx, $sy)); $g.FillRectangle($br, $b[0], $b[1], $b[2], $b[3]); $br.Dispose()
  }
  $g.Dispose(); $copy.Save($file, [System.Drawing.Imaging.ImageFormat]::Png); $copy.Dispose()
}
