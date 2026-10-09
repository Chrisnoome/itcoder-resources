# Helpers for the catword Grade 12 screen scripts (catword-tracking, -pagination,
# -crossrefs, -mergesources, -linking, -macros; 9 October 2026). Dot-source it
# after office-kit.ps1 and work\catword-kit.ps1:
#     . (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')
# Adds: characters posted to a window (a dialog's focused box), a control found
# anywhere (the window, a menu, the desktop), a dump of a menu's items, the
# document's flat XML beside every saved file (in case Save As fails), and a
# COM call retried while Word is busy.

Add-Type @'
using System; using System.Runtime.InteropServices;
public static class C12 {
  [DllImport ("user32.dll")] public static extern bool PostMessage (IntPtr h, uint m, IntPtr w, IntPtr l);
  public static void Chars (IntPtr h, string s) { foreach (char c in s) { PostMessage (h, 0x0102, new IntPtr (c), IntPtr.Zero); System.Threading.Thread.Sleep (40); } }
  public static void Close (IntPtr h) { PostMessage (h, 0x0010, IntPtr.Zero, IntPtr.Zero); }
  // Alt+letter to a dialog box (an access key: a tab, a button, a tick box).
  public static void Alt (IntPtr h, int vk) { PostMessage (h, 0x0104, new IntPtr (vk), new IntPtr (0x20000001)); System.Threading.Thread.Sleep (60); PostMessage (h, 0x0105, new IntPtr (vk), new IntPtr (unchecked ((int) 0xE0000001))); }
}
'@

function FindAny ($hwnd, [string[]]$names, $type = $null) {
  $roots = @($root, $AE::RootElement)
  if ($hwnd -and $hwnd -ne [IntPtr]::Zero) { $roots = @($AE::FromHandle($hwnd)) + $roots }
  foreach ($r in $roots) { try { return (Find $r $names $type 3) } catch { } }
  throw "No control called '$($names -join "' or '")'"
}
function DumpMenu ($menu, $file) {
  $lines = @()
  if ($menu -and $menu -ne [IntPtr]::Zero) { $lines += foreach ($e in $AE::FromHandle($menu).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { $c = $e.Current; if ($c.Name) { "menu`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } } }
  foreach ($type in $T::ListItem, $T::MenuItem, $T::Button, $T::CheckBox, $T::RadioButton) {
    $lines += foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $type)))) { try { $c = $e.Current; if ($c.Name -and -not $c.IsOffscreen) { "desk`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}
function Flat ($d, $file) { }   # (not needed: SaveDoc12 packs the flat XML itself, scrubbed of the account name)
function Retry ([scriptblock]$sb) { for ($i = 0; $i -lt 30; $i++) { try { return (& $sb) } catch { if ($i -eq 29) { throw }; Start-Sleep -Milliseconds 500 } } }
function Show ($range) { $word.ActiveWindow.ScrollIntoView($range, $true); Start-Sleep -Milliseconds 700 }
# The paragraph that starts like this.
function ParaLike ($d, $like) { foreach ($p in $d.Paragraphs) { if ($p.Range.Text -like "$like*") { return $p.Range } }; throw "No paragraph like '$like'" }
# A piece of text in the document (the first), as a range.
function Words12 ($d, $text) { $r = $d.Content; $f = $r.Find; $f.ClearFormatting(); [void]$f.Execute($text, $true); if (-not $f.Found) { throw "No '$text'" }; return $r }
# Safe Pct: says MISSING instead of stopping the run.
function TryPct ($key, $n, [scriptblock]$box) { try { Pct $key $n (& $box) } catch { "  MISSING $key@$n : $_" } }
# Open a menu from a ribbon control; picture it as $n (when given); give back the menu handle (or zero).
function MenuPic ($names, $type, $n, $crop) {
  try {
    $menu = @(OpenMenu (Ctl $names $type))[-1]
    DumpMenu $menu "$n-menu"
    if ($n) { Pic $n $crop $h $menu | Out-Host }
    return $menu
  } catch { "  menu $($names -join '/'): $_" | Out-Host; return [IntPtr]::Zero }
}
function EscMenu ($menu) { try { if ($menu -ne [IntPtr]::Zero) { [Shot]::PostKey($menu, 0x1B) }; [Shot]::PostKey($h, 0x1B) } catch { }; Start-Sleep -Milliseconds 900 }
# Close every dialog box of Word's that is still open (Cancel).
function CloseAll { foreach ($line in [Later]::Windows($script:wpid)) { $p = $line -split "`t"; if ($p[1] -in 'bosa_sdm_msword', '#32770', 'NUIDialog') { [C12]::Close([IntPtr][long]$p[0]) } }; Start-Sleep -Milliseconds 900 }

# Saving without Word's own Save As (copied from work\catword11-kit.ps1, 9 October 2026: SaveAs2 hangs in the VM and
# Backstage's Recent list lost the CAT folder): the flat OPC packed into a .docx.
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
# A flat OPC string (Document.WordOpenXML) -> a .docx file at $path.
function FlatToDocx12 ([string]$flat, [string]$path) {
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
function SaveDoc12 ($d, [string]$file, [bool]$cloud = $true) {
  Trace "packing $file"
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null
  $local = Join-Path "C:\sims\files\$Name" $file
  $flat = $d.WordOpenXML -replace '(<dc:creator>)[^<]*', '$1BestLessons' -replace '(<cp:lastModifiedBy>)[^<]*', '$1BestLessons'
  if ($flat -match 'Noome|chris\.noome|@gmail') { "  ACCOUNT NAME LEFT IN $file - not saved"; return }
  FlatToDocx12 $flat $local
  if ($cloud) {
    try { Copy-Item $local (Join-Path 'G:\My Drive\CAT\Word' $file) -Force; "  saved $file (and in the cloud)" } catch { "  saved $file - NOT in the cloud: $_" }
  } else { "  saved $file" }
}

# A right-click menu at [x, y] in Word's window pixels (WM_CONTEXTMENU). Returns the menu window, or zero.
function RightClick12 ($x, $y) {
  $before = [Later]::Windows($script:wpid)
  $win = [WinRect]::Of($h)
  $lp = [IntPtr]((((([int]$win[1] + [int]$y) -band 0xFFFF)) -shl 16) -bor ((([int]$win[0] + [int]$x) -band 0xFFFF)))
  [void][C12]::PostMessage($h, 0x007B, $h, $lp)
  $m = NewWindow $before @() 20
  Start-Sleep -Milliseconds 900
  return $m
}

# Word's window 1910 px wide (the Review tab folds its Tracking, Changes and Protect groups into menus at 1750).
$W = @(0, 56, 1910, 656)
function Wide { [Shot]::Place($script:h, 5, 40, 1910, 720); Start-Sleep -Milliseconds 1800; $script:root = $AE::FromHandle($script:h); Fresh12 }
# Word's own user name in tracked changes and comments, not the signed-in Office account's.
function LocalUser { try { $script:oldLocal = $word.Options.UseLocalUserInfo; $word.Options.UseLocalUserInfo = $true } catch { "  UseLocalUserInfo: $_" } }
function RestoreUser { try { $word.Options.UseLocalUserInfo = $script:oldLocal } catch { } }

# The picture guard started afresh (Word's start-up and window moves count as input in the VM).
function Fresh12 { $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false }
# work\catword-kit.ps1's WordWindow, then the guard afresh.
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
  [Shot]::Back($script:h); Start-Sleep -Milliseconds 600
  Fresh12
}
# A ribbon tab, then Word sent to the back again (selecting a tab through UI Automation can bring Word to the front,
# and any input on the VM while it is in front stops the run - 9 October 2026, three runs lost at the first Tab).
function Tab ($name) { Press (Find $root @($name) $T::TabItem); Start-Sleep -Milliseconds 900; [Shot]::Back($h); Start-Sleep -Milliseconds 400 }

# Pictures (as work\catword11-kit.ps1's P, 9 October 2026): the guard started afresh for each picture - in this VM
# Word's start-up, ribbon presses and posted keys move the input clock - and the VM's Add-ins / Claude ribbon groups
# painted over with the ribbon's own colour.
function PicBase ($n, $box, $win = $null, $popup = [IntPtr]::Zero) {
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
function AddinBoxes12 {
  $boxes = @()
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Group)))) {
    try { if ($e.Current.Name -match '^(Add-ins|Claude)' -and -not $e.Current.IsOffscreen) { $boxes += ,(Box $e) } } catch { }
  }
  return ,$boxes
}
function Pic ($n, $box, $win = $null, $popup = [IntPtr]::Zero) {
  $boxes = @()
  if ($null -eq $win -or $win -eq $h) { $boxes = AddinBoxes12 }
  Fresh12
  PicBase $n $box $win $popup | Out-Null
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
