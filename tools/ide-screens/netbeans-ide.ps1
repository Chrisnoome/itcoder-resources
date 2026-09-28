# NetBeans as pupils see it, for the "where would you click" picture activity
# in Java lesson 3 (28 September 2026; README.md, then crop.py). Run with
# Windows PowerShell 5.1 (powershell.exe - PowerShell 7 can't compile
# Shot.cs):
#     powershell -ExecutionPolicy Bypass -File netbeans-ide.ps1
#
# Starts a SEPARATE NetBeans: its own user and cache folders (--userdir,
# --cachedir) in $Work, with a copy of the small settings folder, so Chris's
# own NetBeans, its projects and its layout are never touched. It opens the
# Greeter project in netbeans-demo\ with Greeter.java in the editor, runs it
# (F6, posted to NetBeans' own window - no typing at the desktop), and each
# window of that NetBeans draws itself into a picture (PrintWindow,
# ..\access-screens\Shot.cs). Then that NetBeans, and only it, is closed.
#
# NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT RUNS (about two minutes - the
# first start indexes the JDK): NetBeans comes to the front, and a key would
# land in it. The run checks the last-input time before and after, and
# deletes the pictures if it moved.
param([string]$Work = 'D:\temp\nbshot', [int]$Settle = 30, [int]$RunWait = 25)
$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Add-Type -Path (Join-Path $dir '..\access-screens\Shot.cs') -ReferencedAssemblies System.Drawing
[Shot]::DpiAware()

$netbeans = 'C:\Program Files\Apache NetBeans\bin\netbeans64.exe'
$user     = Join-Path $Work 'user'
$cache    = Join-Path $Work 'cache'
$project  = Join-Path $Work 'demo\Greeter'
$out      = Join-Path $dir 'out'

# The throwaway user folder: a copy of the settings, with the Greeter project
# open and set as the main one, and Greeter.java open in the editor.
Remove-Item $Work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $user, $cache, $out, (Split-Path $project) | Out-Null
Copy-Item "$env:APPDATA\NetBeans\31\config" $user -Recurse
Copy-Item (Join-Path $dir 'netbeans-demo\Greeter') (Split-Path $project) -Recurse

$url = 'file:/' + ($project -replace '\\', '/') + '/'
$ui  = Join-Path $user 'config\Preferences\org\netbeans\modules'
New-Item -ItemType Directory -Force $ui | Out-Null
$uiFile = Join-Path $ui 'projectui.properties'
$old = if (Test-Path $uiFile) { (Get-Content $uiFile) | Where-Object { $_ -notmatch '^(openProjectsURLs|openProjectsDisplayNames|openProjectsIcons|mainProjectURL|recentProject)' } } else { @() }
Set-Content $uiFile -Encoding ASCII -Value ($old + @("openProjectsURLs.0=$url", 'openProjectsDisplayNames.0=Greeter', "mainProjectURL=$url"))

New-Item -ItemType Directory -Force (Join-Path $project 'nbproject\private') | Out-Null
Set-Content (Join-Path $project 'nbproject\private\private.xml') -Encoding UTF8 -Value @"
<?xml version="1.0" encoding="UTF-8"?>
<project-private xmlns="http://www.netbeans.org/ns/project-private/1">
    <open-files xmlns="http://www.netbeans.org/ns/projectui-open-files/2">
        <group>
            <file>${url}src/greeter/Greeter.java</file>
        </group>
    </open-files>
</project-private>
"@
Remove-Item (Join-Path $out 'nb-*') -ErrorAction SilentlyContinue

Start-Sleep -Seconds 10   # time to take your hands off
$started = [Shot]::LastInput()

# Every visible top-level window of one process, and its title.
Add-Type @"
using System; using System.Collections.Generic; using System.Runtime.InteropServices; using System.Text;
public static class NbTops {
  delegate bool EnumProc (IntPtr h, IntPtr l);
  [DllImport ("user32.dll")] static extern bool EnumWindows (EnumProc p, IntPtr l);
  [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr h);
  [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr h, out uint pid);
  [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetWindowText (IntPtr h, StringBuilder s, int n);
  [DllImport ("user32.dll")] public static extern bool GetWindowRect (IntPtr h, out RECT r);
  [DllImport ("user32.dll")] public static extern bool SetForegroundWindow (IntPtr h);
  [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
  public static List<IntPtr> Of (uint pid) {
    var list = new List<IntPtr> ();
    EnumWindows (delegate (IntPtr h, IntPtr l) { uint p; GetWindowThreadProcessId (h, out p); if (p == pid && IsWindowVisible (h)) { list.Add (h); } return true; }, IntPtr.Zero);
    return list;
  }
  public static string Title (IntPtr h) { var s = new StringBuilder (256); GetWindowText (h, s, 256); return s.ToString (); }
}
"@

# NetBeans' own Java process: the one started with this user folder.
function NetBeansJava {
  Get-CimInstance Win32_Process -Filter "Name = 'java.exe' OR Name = 'javaw.exe' OR Name = 'netbeans64.exe'" |
    Where-Object { $_.CommandLine -and $_.CommandLine -like "*$Work*" }
}

$launcher = Start-Process -FilePath $netbeans -ArgumentList '--userdir', "`"$user`"", '--cachedir', "`"$cache`"", '--nosplash' -PassThru
try {
  # Wait for the main window: its title names the project.
  $until = (Get-Date).AddSeconds(240)
  $main = $null
  do {
    Start-Sleep -Seconds 3
    foreach ($p in @(NetBeansJava)) {
      foreach ($h in [NbTops]::Of([uint32]$p.ProcessId)) { if ([NbTops]::Title($h) -match 'NetBeans') { $main = $h; $javaPid = $p.ProcessId } }
    }
  } until ($main -or (Get-Date) -gt $until)
  if (-not $main) { throw 'NetBeans did not open its window within 4 minutes.' }
  "main window: " + [NbTops]::Title($main)

  # A fixed size (physical pixels), so the picture is the same every time.
  [Shot]::Place($main, 0, 0, 1800, 1150)
  [void][NbTops]::SetForegroundWindow($main)
  Start-Sleep -Seconds $Settle          # the project opens, the JDK is indexed

  # Run the project: F6, to NetBeans' own window.
  [void][NbTops]::SetForegroundWindow($main)
  [Shot]::PostKey($main, 0x75)
  Start-Sleep -Seconds $RunWait

  if ([Shot]::LastInput() -ne $started) { throw 'The keyboard or mouse was used during the run - nothing was kept. Run it again with hands off.' }

  $windows = @()
  $n = 0
  foreach ($h in [NbTops]::Of([uint32]$javaPid)) {
    $r = New-Object NbTops+RECT
    [void][NbTops]::GetWindowRect($h, [ref]$r)
    if (($r.Right - $r.Left) -lt 80 -or ($r.Bottom - $r.Top) -lt 40) { continue }
    $n++
    $file = Join-Path $out ("nb-window-$n.png")
    [void][Shot]::Save($h, $file)
    $windows += [pscustomobject]@{ file = (Split-Path $file -Leaf); title = [NbTops]::Title($h); left = $r.Left; top = $r.Top; right = $r.Right; bottom = $r.Bottom }
  }

  if ([Shot]::LastInput() -ne $started) {
    Remove-Item (Join-Path $out 'nb-*') -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used during the run - the pictures were deleted. Run it again with hands off.'
  }

  $windows | ConvertTo-Json | Set-Content (Join-Path $out 'nb-windows.json') -Encoding UTF8
  "$n window(s) captured:"
  $windows | ForEach-Object { "  $($_.file)  $($_.title)  $($_.right - $_.left) x $($_.bottom - $_.top) at $($_.left),$($_.top)" }
}
finally {
  # Close only the NetBeans this run started (never saving anything).
  foreach ($p in @(NetBeansJava)) { Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue }
  if (-not $launcher.HasExited) { Stop-Process -Id $launcher.Id -Force -ErrorAction SilentlyContinue }
}
