# Real PowerPoint 365 screens for Presentations lesson 1 (content/catpowerpoint/
# start.php), simMove (9 October 2026): Thabo's "Thank you" slide (4) dragged
# with the real mouse in the Slides pane to after slide 5 - a drag step.
# Pictures out\catpowerpoint-move-mv-<n>.png (window pixels; the lesson's
# copies are cropped to (9, 58, 1791, 871) as catpowerpoint-start-mv-<n>.png),
# the thumbnails' places in out\catpowerpoint-move.json. Nothing saved.
#     pwsh -File vm-shots.ps1 catpowerpoint-move
$Name = 'catpowerpoint-move'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')
Add-Type @'
using System; using System.Runtime.InteropServices; using System.Threading;
public static class MvDrag {
  [DllImport ("user32.dll")] static extern bool SetCursorPos (int x, int y);
  [DllImport ("user32.dll")] static extern void mouse_event (uint f, int x, int y, uint d, UIntPtr e);
  public static void Drag (int x1, int y1, int x2, int y2) {
    SetCursorPos (x1, y1); Thread.Sleep (300);
    mouse_event (0x0002, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (300);
    for (int i = 1; i <= 30; i++) { SetCursorPos (x1 + (x2 - x1) * i / 30, y1 + (y2 - y1) * i / 30); Thread.Sleep (40); }
    Thread.Sleep (500);
    mouse_event (0x0004, 0, 0, 0, UIntPtr.Zero); Thread.Sleep (500);
  }
}
'@

try {
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11
  $why  = "Videos play in HD`rApps update on mobile data`rWhatsApp downloads every photo"
  $five = "Use Wi-Fi when you can`rTurn off auto-play`rSet apps to update on Wi-Fi only`rStop WhatsApp downloading media`rCheck which apps use the most"
  $check = "Settings > Network > Data usage`rSee which apps use the most`rSet a warning before the bundle runs out"
  $null = AddSlide 'Title Slide' @('Make your data last', 'Thabo, Grade 10')
  $null = AddSlide 'Title and Content' @('Why data runs out', $why)
  $null = AddSlide 'Title and Content' @('Five ways to save data', $five)
  $null = AddSlide 'Title Slide' @('Thank you', 'Questions?')
  $null = AddSlide 'Title and Content' @('Check your data use', $check)
  while ($pres.Slides.Count -gt 5) { $pres.Slides.Item(1).Delete() }   # a blank first slide, if the new presentation had one
  GoTo 4
  Start-Sleep -Milliseconds 1500
  # The thumbnails are not in UI Automation: their places are read off mv-1 (window pixels, 1800 x 880):
  # slide 4 at (53, 538, 128, 73), slide 5 at (53, 635, 126, 72).
  Snap 'mv-1'
  $win = [WinRect]::Of($h)
  [PP]::Front($h); Start-Sleep -Milliseconds 500
  [MvDrag]::Drag([int]($win[0] + 116), [int]($win[1] + 574), [int]($win[0] + 116), [int]($win[1] + 716))
  [PP]::Park(1900, 1060)
  Calm
  Start-Sleep -Milliseconds 1200
  $order = @(foreach ($s in $pres.Slides) { $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text }) -join ' | '
  "  order now: $order"
  Snap 'mv-2'
  SaveMarks
}
catch { "FAILED: $_"; $_.ScriptStackTrace; try { SaveMarks } catch { } }
finally { ClosePowerPoint }
