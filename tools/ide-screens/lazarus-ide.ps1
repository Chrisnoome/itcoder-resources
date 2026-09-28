# The Lazarus IDE as pupils see it, for the "where would you click" picture
# activity in Pascal lesson 26 (28 September 2026; README.md, then crop.py).
# Run with Windows PowerShell 5.1 (powershell.exe - PowerShell 7 can't compile
# Shot.cs):
#     powershell -ExecutionPolicy Bypass -File lazarus-ide.ps1
#
# Starts a SEPARATE Lazarus: its own settings folder (--pcp), a copy of the
# small settings files only, so Chris's own Lazarus, its layout and its last
# project are never touched; it opens the Greeter demo in demo\ with its form
# in the designer. Each window of that Lazarus draws itself into
# a picture (PrintWindow, ..\access-screens\Shot.cs) - nothing else on the
# screen can get in. Then that Lazarus, and only it, is closed.
#
# NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT RUNS (about 40 seconds):
# Lazarus comes to the front, and a key would land in it. The run checks the
# last-input time before and after, and deletes the pictures if it moved.
param([string]$Work = 'D:\temp\lazshot', [int]$Wait = 8)
$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Add-Type -Path (Join-Path $dir '..\access-screens\Shot.cs') -ReferencedAssemblies System.Drawing
[Shot]::DpiAware()

# The throwaway settings and the demo project.
$cfg  = Join-Path $Work 'cfg'
$demo = Join-Path $Work 'demo'
$out  = Join-Path $dir 'out'
Remove-Item $Work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $cfg, $demo, $out | Out-Null
Get-ChildItem "$env:LOCALAPPDATA\lazarus" -File | Where-Object { $_.Extension -in '.xml', '.cfg' } | Copy-Item -Destination $cfg
# The package manager's own settings too (656 KB, not its 569 MB of packages).
New-Item -ItemType Directory -Force (Join-Path $cfg 'onlinepackagemanager') | Out-Null
Copy-Item "$env:LOCALAPPDATA\lazarus\onlinepackagemanager\config" (Join-Path $cfg 'onlinepackagemanager') -Recurse
# Opening the last project at start is what raises the access violation (Chris,
# 28 September 2026: "the access violation happens when previous project opens
# automatically") - off in this copy, and no last project.
$envFile = Join-Path $cfg 'environmentoptions.xml'
$envXml  = [IO.File]::ReadAllText($envFile) -replace '<AutoSave [^>]*/>', '<AutoSave OpenLastProjectAtStart="False" LastSavedProjectFile=""/>'
[IO.File]::WriteAllText($envFile, $envXml)
# The demo: a small "Greeter" form, named the course's way; its session opens uMain with the form designer.
Copy-Item (Join-Path $dir 'demo\*') $demo -Recurse
Remove-Item (Join-Path $out 'ide-*') -ErrorAction SilentlyContinue

Start-Sleep -Seconds 10   # time to take your hands off
$started = [Shot]::LastInput()

# Every visible top-level window of THIS Lazarus, with where it is on the screen.
Add-Type @"
using System; using System.Collections.Generic; using System.Runtime.InteropServices; using System.Text;
public static class Tops {
  delegate bool EnumProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc p, IntPtr l);
  [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr h);
  [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr h, out uint pid);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll")] public static extern bool GetWindowRect (IntPtr h, out RECT r);
  [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
  public static List<IntPtr> Of (uint pid) {
    var list = new List<IntPtr> ();
    EnumWindows (delegate (IntPtr h, IntPtr l) { uint p; GetWindowThreadProcessId (h, out p); if (p == pid && IsWindowVisible (h)) { list.Add (h); } return true; }, IntPtr.Zero);
    return list;
  }
  public static string Title (IntPtr h) { var s = new StringBuilder (256); GetWindowText (h, s, 256); return s.ToString (); }

  // An error box of this Lazarus ("Access violation ... Press OK to ignore"):
  // its OK button is clicked by a message to that button - no typing, no mouse.
  delegate bool ChildProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumChildWindows (IntPtr parent, ChildProc p, IntPtr l);
  [DllImport ("user32.dll")] static extern IntPtr SendMessage (IntPtr h, uint msg, IntPtr w, IntPtr l);
  // The box draws its message itself, so it is known by being a small window of
  // this Lazarus with an OK button (this throwaway IDE has nothing to lose).
  public static bool ClickOkIfError (IntPtr dialog) {
    RECT r; GetWindowRect (dialog, out r);
    if (r.Right - r.Left > 700 || r.Bottom - r.Top > 400) { return false; }
    IntPtr ok = IntPtr.Zero;
    EnumChildWindows (dialog, delegate (IntPtr h, IntPtr l) {
      var s = new StringBuilder (256); GetWindowText (h, s, 256);
      if (s.ToString ().Replace ("&", "") == "OK") { ok = h; }
      return true; }, IntPtr.Zero);
    if (ok == IntPtr.Zero) { return false; }
    SendMessage (ok, 0x00F5, IntPtr.Zero, IntPtr.Zero);   // BM_CLICK
    return true;
  }

  // The editor's Code | Form | Anchors tabs: the one tab control with three
  // tabs; asking it to move to tab 1 shows the form designer (TCM_SETCURFOCUS,
  // which tells the IDE as a click would). No keys, no mouse.
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr h, StringBuilder s, int n);
  public static int ShowFormTab (IntPtr main) {
    int switched = 0;
    EnumChildWindows (main, delegate (IntPtr h, IntPtr l) {
      var c = new StringBuilder (64); GetClassName (h, c, 64);
      if (c.ToString () == "SysTabControl32" && SendMessage (h, 0x1304, IntPtr.Zero, IntPtr.Zero).ToInt32 () == 3) {   // TCM_GETITEMCOUNT
        SendMessage (h, 0x1330, new IntPtr (1), IntPtr.Zero);   // TCM_SETCURFOCUS
        switched++;
      }
      return true; }, IntPtr.Zero);
    return switched;
  }
}
"@

$lazarus = Start-Process -FilePath 'C:\lazarus\lazarus.exe' -ArgumentList "--pcp=`"$cfg`"", "`"$(Join-Path $demo 'greeter.lpi')`"" -PassThru
try {
  # Wait for the IDE itself (its title names the project), not the splash - a
  # first start with new settings scans the sources, which takes a while.
  $until = (Get-Date).AddSeconds(90)
  do {
    Start-Sleep -Seconds 2
    $ready = [Tops]::Of([uint32]$lazarus.Id) | Where-Object { [Tops]::Title($_) -match 'Greeter|Lazarus IDE' }
  } until ($ready -or (Get-Date) -gt $until)
  if (-not $ready) { throw 'Lazarus did not open its IDE window within 90 seconds.' }

  # Close any access-violation box ("just close it" - Chris), then let the
  # editor, inspector and designer fill in.
  for ($try = 0; $try -lt $Wait; $try++) {
    foreach ($h in [Tops]::Of([uint32]$lazarus.Id)) { if ([Tops]::ClickOkIfError($h)) { "closed an error box" } }
    Start-Sleep -Seconds 1
  }

  # The form designer rather than the code (the editor's Form tab).
  foreach ($h in [Tops]::Of([uint32]$lazarus.Id)) {
    if ([Tops]::Title($h) -match 'Lazarus IDE') { "form tab: " + [Tops]::ShowFormTab($h) }
  }
  Start-Sleep -Seconds 3
  foreach ($h in [Tops]::Of([uint32]$lazarus.Id)) { if ([Tops]::ClickOkIfError($h)) { "closed an error box" } }

  if ([Shot]::LastInput() -ne $started) { throw 'The keyboard or mouse was used during the run - nothing was kept. Run it again with hands off.' }

  $windows = @()
  $n = 0
  foreach ($h in [Tops]::Of([uint32]$lazarus.Id)) {
    $r = New-Object Tops+RECT
    [void][Tops]::GetWindowRect($h, [ref]$r)
    if (($r.Right - $r.Left) -lt 80 -or ($r.Bottom - $r.Top) -lt 40) { continue }
    $n++
    $file = Join-Path $out ("ide-window-$n.png")
    [void][Shot]::Save($h, $file)
    $windows += [pscustomobject]@{ file = (Split-Path $file -Leaf); title = [Tops]::Title($h); left = $r.Left; top = $r.Top; right = $r.Right; bottom = $r.Bottom }
  }

  if ([Shot]::LastInput() -ne $started) {
    Remove-Item (Join-Path $out 'ide-*') -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used during the run - the pictures were deleted. Run it again with hands off.'
  }

  $windows | ConvertTo-Json | Set-Content (Join-Path $out 'ide-windows.json') -Encoding UTF8
  "$n window(s) captured:"
  $windows | ForEach-Object { "  $($_.file)  $($_.title)  $($_.right - $_.left) x $($_.bottom - $_.top) at $($_.left),$($_.top)" }
}
finally {
  # Close only the Lazarus this run started (never saving anything).
  if (-not $lazarus.HasExited) { Stop-Process -Id $lazarus.Id -Force }
}
