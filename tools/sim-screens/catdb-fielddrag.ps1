# Real Access 365 screens for catdb Grade 11 lesson 6 (content/catdb/forms.php),
# simAddFields (9 October 2026): frmMembers in Design View without PaidUp, Add
# Existing Fields opens the Field List, and PaidUp is dragged with the real
# mouse from the Field List onto the Detail, under Monthly - Access adds its
# label and tick box. Pictures out\catdb-fielddrag-d-<n>.png, cropped by
# work/catdb-crop.py catdb-fielddrag and copied as catdb-forms-d-<n>.png.
# A throwaway copy of the starter; nothing kept. Content is never enabled.
#     pwsh -File vm-shots.ps1 catdb-fielddrag
# Window pixels: the drop place is where the tick box's top left lands (PaidUp's
# row in the full form, read off catdb-forms-f-4b); FromX 0 = the Field List's
# own PaidUp item, found by UI Automation.
param([int]$FromX = 0, [int]$FromY = 0, [int]$ToX = 440, [int]$ToY = 668)
$Name = 'catdb-fielddrag'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')
Add-Type @'
using System; using System.Runtime.InteropServices; using System.Threading;
public static class FdMouse {
  [DllImport ("user32.dll")] static extern bool SetCursorPos (int x, int y);
  [DllImport ("user32.dll")] static extern void mouse_event (uint f, int x, int y, uint d, UIntPtr e);
  [DllImport ("user32.dll")] static extern bool SetForegroundWindow (IntPtr h);
  public static void Front (IntPtr h) { SetForegroundWindow (h); Thread.Sleep (400); }
  public static void Drag (int x1, int y1, int x2, int y2) {
    SetCursorPos (x1, y1); Thread.Sleep (300);
    mouse_event (2, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (300);
    for (int i = 1; i <= 40; i++) { SetCursorPos (x1 + (x2 - x1) * i / 40, y1 + (y2 - y1) * i / 40); Thread.Sleep (40); }
    Thread.Sleep (600); mouse_event (4, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (1500);
  }
  public static void Park () { SetCursorPos (1900, 1060); Thread.Sleep (200); }
}
'@
function Scr($x, $y) { $w = [WinRect]::Of($h); return @([int]($w[0] + $x), [int]($w[1] + $y)) }

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'StokvelDrag.accdb'
$app = New-Object -ComObject Access.Application
try {
  Build-Stokvel $app $file
  # frmMembers without PaidUp, and a Detail tall enough for it (as in the full form).
  MakeForm $app 'tblMembers' 'frmMembers' 'Stokvel members' @('MemberID', 'FirstName', 'Surname', 'Cell', 'JoinDate', 'Monthly')
  $app.DoCmd.OpenForm('frmMembers', 1)
  Start-Sleep -Milliseconds 1200
  $app.Screen.ActiveForm.Section(0).Height = 3900
  $app.DoCmd.Close(2, 'frmMembers', 1)
  Start-Sleep -Milliseconds 800

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow(); Start-Sleep -Milliseconds 1000
  $app.DoCmd.OpenForm('frmMembers', 1)                      # acDesign
  Start-Sleep -Milliseconds 2000
  NoFieldList
  NoPropertySheet
  TryMark 'design Add Existing Fields' $root @('Add Existing Fields')
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  SnapDb 'd-0'
  Press (Find $root @('Add Existing Fields') $T::Button)
  Start-Sleep -Milliseconds 1500
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  Dump 'fieldlist'
  TryMark 'list PaidUp' $root @('PaidUp')
  SnapDb 'd-1'
  if ($FromX -le 0) { $b = Box (Find $root @('PaidUp')); $FromX = $b[0] + 22; $FromY = $b[1] + [int]($b[3] / 2) }
  "  drag from $FromX,$FromY to $ToX,$ToY (window pixels)"
  $a = Scr $FromX $FromY; $c = Scr $ToX $ToY
  [FdMouse]::Front($h)
  [FdMouse]::Drag($a[0], $a[1], $c[0], $c[1])
  [FdMouse]::Park()
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  SnapDb 'd-2'
  try { foreach ($ctl in $app.Screen.ActiveForm.Controls) { "  control: $($ctl.Name) [$($ctl.ControlType)] $($ctl.Left),$($ctl.Top)" } } catch { "  controls: $_" }
  SaveMarks
}
catch { "FAILED: $_"; $_.ScriptStackTrace; try { SaveMarks } catch { } }
finally {
  try { $app.DoCmd.Close(2, 'frmMembers', 2) } catch { }
  try { $app.CloseCurrentDatabase() } catch { }
  $app.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($app)
}
