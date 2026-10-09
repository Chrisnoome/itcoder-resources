# Real Access 365 screens for catdb lesson 15 (content/catdb/mainform.php),
# simRelDrag (9 October 2026): the League's two tables added to the
# Relationships window, TeamID dragged with the real mouse from tblTeams onto
# TeamID in tblPlayers, the Edit Relationships box (Enforce Referential
# Integrity ticked), Create. Pictures out\catdb-reldrag-r-<n>.png, cropped by
# work/catdb-crop.py catdb-reldrag and copied as catdb-mainform-r-<n>.png.
# A throwaway copy of the starter; nothing kept. Content is never enabled.
#     pwsh -File vm-shots.ps1 catdb-reldrag
param([int]$FromX = 588, [int]$FromY = 315, [int]$ToX = 350, [int]$ToY = 381, [int]$TickX = 460, [int]$TickY = 382, [int]$CreateX = 790, [int]$CreateY = 258)
$Name = 'catdb-reldrag'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')
Add-Type @'
using System; using System.Runtime.InteropServices; using System.Threading;
public static class RdMouse {
  [DllImport ("user32.dll")] static extern bool SetCursorPos (int x, int y);
  [DllImport ("user32.dll")] static extern void mouse_event (uint f, int x, int y, uint d, UIntPtr e);
  [DllImport ("user32.dll")] static extern bool SetForegroundWindow (IntPtr h);
  public static void Front (IntPtr h) { SetForegroundWindow (h); Thread.Sleep (400); }
  public static void Click (int x, int y) { SetCursorPos (x, y); Thread.Sleep (250); mouse_event (2, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (90); mouse_event (4, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (600); }
  public static void Drag (int x1, int y1, int x2, int y2) {
    SetCursorPos (x1, y1); Thread.Sleep (300);
    mouse_event (2, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (300);
    for (int i = 1; i <= 30; i++) { SetCursorPos (x1 + (x2 - x1) * i / 30, y1 + (y2 - y1) * i / 30); Thread.Sleep (40); }
    Thread.Sleep (500); mouse_event (4, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (1500);
  }
  [DllImport ("user32.dll")] static extern void keybd_event (byte vk, byte sc, uint f, UIntPtr e);
  public static void Key (byte vk) { keybd_event (vk, 0, 0, UIntPtr.Zero); Thread.Sleep (60); keybd_event (vk, 0, 2, UIntPtr.Zero); Thread.Sleep (800); }
  public static void Park () { SetCursorPos (1900, 1060); Thread.Sleep (200); }
}
'@
# A place in window pixels -> the screen
function Scr($x, $y) { $w = [WinRect]::Of($h); return @([int]($w[0] + $x), [int]($w[1] + $y)) }

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'LeagueRel.accdb'
$app = New-Object -ComObject Access.Application
try {
  Build-League $app $file
  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow(); Start-Sleep -Milliseconds 1000
  Press (Find $root @('Database Tools') $T::TabItem); Start-Sleep -Milliseconds 900
  Press (Find $root @('Relationships') $T::Button); Start-Sleep -Milliseconds 2500
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  # The Add Tables pane: both tables selected, Add Selected Tables, the pane closed.
  $teams = Find $root @('tblTeams') $T::ListItem
  $players = Find $root @('tblPlayers') $T::ListItem
  $teams.GetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern).Select()
  $players.GetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern).AddToSelection()
  Start-Sleep -Milliseconds 500
  Press (Find $root @('Add Selected Tables') $T::Button); Start-Sleep -Milliseconds 2000
  try { Press (Find $root @('Close pane') $T::Button -tries 6); Start-Sleep -Milliseconds 1200 } catch { '  no Close pane' }
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  SnapDb 'r-1' -KeepPanes
  Dump 'rel'
  if ($FromX -gt 0) {
    $a = Scr $FromX $FromY; $b = Scr $ToX $ToY
    [RdMouse]::Front($h)
    [RdMouse]::Drag($a[0], $a[1], $b[0], $b[1])
    [RdMouse]::Park()
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    SnapDb 'r-2' -Others
    DumpOthers 'editrel'
    if ($TickX -gt 0) {
      $c = Scr $TickX $TickY; [RdMouse]::Click($c[0], $c[1]); [RdMouse]::Park()
      $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
      SnapDb 'r-3' -Others
      $c = Scr $CreateX $CreateY; [RdMouse]::Click($c[0], $c[1]); [RdMouse]::Park()
      $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
      SnapDb 'r-4' -KeepPanes
    } else { [RdMouse]::Key(0x1B) }                                     # Esc: the box closed, nothing made
  }
  try { foreach ($r in $app.CurrentDb().Relations) { "  relation: $($r.Table) - $($r.ForeignTable) attr $($r.Attributes)" } } catch { }
  SaveMarks
}
catch { "FAILED: $_"; $_.ScriptStackTrace; try { SaveMarks } catch { } }
finally {
  try { $app.DoCmd.Close(-1, '', 2) } catch { }
  try { $app.CloseCurrentDatabase() } catch { }
  $app.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($app)
}
