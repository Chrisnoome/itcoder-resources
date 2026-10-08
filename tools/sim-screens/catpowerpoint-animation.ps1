# Real PowerPoint 365 screens for Presentations lesson 4, "Transitions and
# animation" (AIPascalCourse/content/catpowerpoint/animation.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Mr Botha's bakery
# slides; out\catpowerpoint-animation.json says where things are (window
# pixels). Runs in the CAT VM only (the Start list uses the real mouse -
# work\catpowerpoint-kit.ps1):
#     pwsh -File vm-shots.ps1 catpowerpoint-animation
# Then: python cat-crop.py catpowerpoint-animation
# It also makes the starter BakeryShow.pptx and a done-right copy
# BakeryShow-done.pptx in C:\sims\files\<name>\, and the starter in
# G:\My Drive\CAT\PowerPoint\.
$Name = 'catpowerpoint-animation'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')

$files = "C:\sims\files\$Name"
$cloud = 'G:\My Drive\CAT\PowerPoint'
New-Item -ItemType Directory -Force $files | Out-Null

function ShapeBox($shape) {
  $w = $pp.ActiveWindow
  $x1 = $w.PointsToScreenPixelsX($shape.Left); $x2 = $w.PointsToScreenPixelsX($shape.Left + $shape.Width)
  $y1 = $w.PointsToScreenPixelsY($shape.Top);  $y2 = $w.PointsToScreenPixelsY($shape.Top + $shape.Height)
  $win = [WinRect]::Of($h)
  return @(($x1 - $win[0]), ($y1 - $win[1]), ($x2 - $x1), ($y2 - $y1))
}

# Mr Botha's four slides, in a presentation of their own.
function BuildBakery($p) {
  $lay = { param($n) $p.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq $n } | Select-Object -First 1 }
  $s = $p.Slides.AddSlide(1, (& $lay 'Title Slide'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Botha''s Bakery'
  $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = 'Fresh every morning in Centurion'
  $s = $p.Slides.AddSlide(2, (& $lay 'Title and Content'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'This week''s prices'
  $ph = $s.Shapes.Placeholders.Item(2)
  $t = $s.Shapes.AddTable(4, 2, $ph.Left, $ph.Top, $ph.Width, 200); $t = @($s.Shapes | Where-Object { $_.HasTable })[0]
  $prices = @(@('Item', 'Price'), @('Bread', 'R18'), @('Milk tart', 'R25'), @('Koeksisters (6)', 'R30'))
  for ($r = 1; $r -le 4; $r++) { for ($c = 1; $c -le 2; $c++) { $t.Table.Cell($r, $c).Shape.TextFrame.TextRange.Text = $prices[$r - 1][$c - 1] } }
  $s = $p.Slides.AddSlide(3, (& $lay 'Title Only'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'New: rusks!'
  $star = $s.Shapes.AddShape(92, 520, 170, 220, 210)             # msoShape5pointStar
  $star.TextFrame.TextRange.Text = 'New!'
  $star.TextFrame.TextRange.Font.Size = 32
  $s = $p.Slides.AddSlide(4, (& $lay 'Title and Content'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Open every day'
  $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = "Monday to Friday: 06:00 to 18:00`rSaturday: 06:00 to 14:00`rSunday: 07:00 to 12:00"
  return $star
}

try {
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11
  $star = BuildBakery $pres
  GoTo 1
  $pp.ActiveWindow.Selection.Unselect()
  TryMark 'tabTransitions' $root @('Transitions') $T::TabItem
  TryMark 'tabAnimations'  $root @('Animations') $T::TabItem

  # 1. A transition: Transitions tab, Fade, Apply To All.
  Snap 'tr-1'
  Press (Find $root @('Transitions') $T::TabItem); Start-Sleep -Milliseconds 1500
  Dump 'transitions'
  foreach ($n in 'None', 'Morph', 'Fade', 'Push', 'Wipe', 'Split', 'Reveal', 'Cut', 'Random Bars', 'Shape', 'Uncover', 'Cover', 'Flash') { TryMark "tr $n" $root @($n) $T::ListItem }
  foreach ($n in 'Apply To All', 'Duration', 'On Mouse Click', 'After', 'Preview', 'Effect Options', 'Sound') { TryMark "trb $n" $root @($n) }
  Snap 'tr-2'
  Press (Find $root @('Fade') $T::ListItem); Start-Sleep -Milliseconds 3000
  Snap 'tr-3'                                                    # Fade on slide 1: the star by its thumbnail
  Press (Find $root @('Apply To All') -tries 6); Start-Sleep -Milliseconds 2500
  Snap 'tr-4'                                                    # every slide has it

  # 2. Animate the star: click it, Animations tab, Fly In.
  Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 800
  GoTo 3
  $pp.ActiveWindow.Selection.Unselect()
  Mark 'star' (ShapeBox $star)
  Snap 'an-1'
  $star.Select(); Start-Sleep -Milliseconds 800
  Snap 'an-2'                                                    # the star selected
  Press (Find $root @('Animations') $T::TabItem); Start-Sleep -Milliseconds 1500
  Dump 'animations'
  foreach ($n in 'None', 'Appear', 'Fade', 'Fly In', 'Float In', 'Split', 'Wipe', 'Shape', 'Wheel', 'Random Bars', 'Grow & Turn', 'Zoom', 'Swivel', 'Bounce') { TryMark "an $n" $root @($n) $T::ListItem }
  foreach ($n in 'Animation Pane', 'Add Animation', 'Start', 'Duration', 'Delay', 'Preview', 'Effect Options', 'Move Earlier', 'Move Later') { TryMark "anb $n" $root @($n) }
  Snap 'an-3'
  Press (Find $root @('Fly In') $T::ListItem); Start-Sleep -Milliseconds 3000
  Snap 'an-4'                                                    # the star has animation 1

  # 3. Start: After Previous.
  $start = Find $root @('Start') $T::ComboBox -tries 6
  Mark 'startBox' (Box $start)
  OpenMenu $start
  DumpAll 'startlist'
  try { Mark 'afterPrevious' (Box (FindAnywhere @('After Previous') -tries 6)) } catch { '  MISSING afterPrevious' }
  try { Mark 'withPrevious' (Box (FindAnywhere @('With Previous') -tries 3)) } catch { }
  Grab 'st-2'                                                    # the list open
  RealKey 0x1B
  Start-Sleep -Milliseconds 600
  $seq = $pres.Slides.Item(3).TimeLine.MainSequence
  $seq.Item(1).Timing.TriggerType = 3                            # msoAnimTriggerAfterPrevious
  $star.Select(); Start-Sleep -Milliseconds 1200
  Snap 'st-3'                                                    # Start: After Previous

  # The Animation Pane, for a figure.
  try { Press (Find $root @('Animation Pane') -tries 4); Start-Sleep -Milliseconds 1500; Snap 'ap-1'; Press (Find $root @('Animation Pane') -tries 4) } catch { '  no Animation Pane' }
  Start-Sleep -Milliseconds 800
  Press (Find $root @('Home') $T::TabItem)

  SaveMarks

  # ---- The starter and a done-right copy.
  $st = $pp.Presentations.Add(-1)
  $null = BuildBakery $st
  $st.SaveAs((Join-Path $files 'BakeryShow.pptx'), 24)
  foreach ($s in $st.Slides) { $s.SlideShowTransition.EntryEffect = 3849 }    # ppEffectFadeSmoothly
  $st.Slides.Item(3).TimeLine.MainSequence.AddEffect($st.Slides.Item(3).Shapes.Item(2), 2, 0, 3) | Out-Null   # msoAnimEffectFly, after previous
  $st.SaveAs((Join-Path $files 'BakeryShow-done.pptx'), 24)
  $st.Close()
  if (Test-Path 'G:\My Drive') { New-Item -ItemType Directory -Force $cloud | Out-Null; Copy-Item (Join-Path $files 'BakeryShow.pptx') $cloud -Force; "starter -> $cloud" }
}
catch { "FAILED: $_"; throw }
finally { ClosePowerPoint }
