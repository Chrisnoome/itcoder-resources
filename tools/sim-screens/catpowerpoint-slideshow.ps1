# Real PowerPoint 365 screens for Presentations lesson 5, "Running a slide
# show" (AIPascalCourse/content/catpowerpoint/slideshow.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Mr Botha's bakery show
# for the TV in the shop; out\catpowerpoint-slideshow.json says where things
# are (window pixels). Runs in the CAT VM only (dialogs use the real mouse -
# work\catpowerpoint-kit.ps1):
#     pwsh -File vm-shots.ps1 catpowerpoint-slideshow
# Then: python cat-crop.py catpowerpoint-slideshow
# The full-screen show itself is saved as out\catpowerpoint-slideshowfull.png
# (not cropped like the window - copied as it is).
$Name = 'catpowerpoint-slideshow'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')

function ShapeBox($shape) {
  $w = $pp.ActiveWindow
  $x1 = $w.PointsToScreenPixelsX($shape.Left); $x2 = $w.PointsToScreenPixelsX($shape.Left + $shape.Width)
  $y1 = $w.PointsToScreenPixelsY($shape.Top);  $y2 = $w.PointsToScreenPixelsY($shape.Top + $shape.Height)
  $win = [WinRect]::Of($h)
  return @(($x1 - $win[0]), ($y1 - $win[1]), ($x2 - $x1), ($y2 - $y1))
}

try {
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11
  $null = AddSlide 'Title Slide' @('Botha''s Bakery', 'Fresh every morning in Centurion')
  $s2 = AddSlide 'Title and Content' @('This week''s prices')
  $s2 = $pres.Slides.Item(2)
  $ph = $s2.Shapes.Placeholders.Item(2)
  $t = $s2.Shapes.AddTable(4, 2, $ph.Left, $ph.Top, $ph.Width, 200); $t = @($s2.Shapes | Where-Object { $_.HasTable })[0];  $prices = @(@('Item', 'Price'), @('Bread', 'R18'), @('Milk tart', 'R25'), @('Koeksisters (6)', 'R30'))
  for ($r = 1; $r -le 4; $r++) { for ($c = 1; $c -le 2; $c++) { $t.Table.Cell($r, $c).Shape.TextFrame.TextRange.Text = $prices[$r - 1][$c - 1] } }
  $s3 = AddSlide 'Title Only' @('New: rusks!')
  $s3 = $pres.Slides.Item(3)
  $star = $s3.Shapes.AddShape(92, 520, 170, 220, 210); $star.TextFrame.TextRange.Text = 'New!'; $star.TextFrame.TextRange.Font.Size = 32
  $null = AddSlide 'Title and Content' @('Open every day', "Monday to Friday: 06:00 to 18:00`rSaturday: 06:00 to 14:00`rSunday: 07:00 to 12:00")
  foreach ($s in $pres.Slides) { $s.SlideShowTransition.EntryEffect = 3849 }
  GoTo 1
  $pp.ActiveWindow.Selection.Unselect()
  $thumbs = @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -like 'Slide*' })
  if ($thumbs.Count -ge 3) { Mark 'thumb3' (Box $thumbs[2]) } else { Mark 'thumb3' @(54, 442, 124, 70) }   # as in catpowerpoint-start
  TryMark 'tabSlideShow' $root @('Slide Show') $T::TabItem
  TryMark 'fileTab' $root @('File Tab', 'File')

  # 1. The show from slide 3: click its thumbnail, Shift+F5.
  Snap 'sh-1'
  GoTo 3
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'sh-2'
  $set = $pres.SlideShowSettings
  $set.StartingSlide = 3; $set.EndingSlide = 4; $set.RangeType = 2   # ppShowSlideRange
  $null = $set.Run()
  Start-Sleep -Milliseconds 3500
  # The whole screen (the show fills it), straight from the screen.
  $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
  $bmp = New-Object System.Drawing.Bitmap($bounds.Width, $bounds.Height)
  $g = [System.Drawing.Graphics]::FromImage($bmp); $g.CopyFromScreen($bounds.Left, $bounds.Top, 0, 0, $bmp.Size); $g.Dispose()
  $bmp.Save((Join-Path $out 'catpowerpoint-slideshowfull.png'), [System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
  Calm
  "picture show"
  $pres.SlideShowWindow.View.Exit()
  $set.RangeType = 1                                             # ppShowAll again
  Start-Sleep -Milliseconds 1500

  # 2. Notes: click in the Notes pane, type.
  GoTo 3
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'nt-1'
  $notes = $s3.NotesPage.Shapes.Placeholders.Item(2).TextFrame.TextRange
  try { $pp.ActiveWindow.Panes.Item(3).Activate(); $null = $notes.Select() } catch { "  notes select: $_" }
  Start-Sleep -Milliseconds 800
  Snap 'nt-2'                                                    # the cursor in the notes
  $notes.Text = 'Rusks: R45 a packet. Baked in our own oven - try one free today!'
  Start-Sleep -Milliseconds 800
  Snap 'nt-3'
  $pp.ActiveWindow.Panes.Item(2).Activate()
  GoTo 1
  $pp.ActiveWindow.Selection.Unselect()

  # 3. Set Up Slide Show: Browsed at a kiosk.
  Mark 'notesPane' @(215, 806, 1540, 34)                         # read off nt-1 (the pane is not in UI Automation)
  $script:root = $AE::FromHandle($h)
  Press (Find $root @('Slide Show') $T::TabItem); Start-Sleep -Milliseconds 1500
  Dump 'slideshowtab'
  foreach ($n in 'From Beginning', 'From Current Slide', 'Set Up Slide Show...', 'Hide Slide', 'Rehearse Timings', 'Record', 'Use Timings', 'Show Media Controls', 'Play Narrations', 'Use Presenter View', 'Monitor') { TryMark "ssb $n" $root @($n) }
  Snap 'su-1'
  OpenDialog (Find $root @('Set Up Slide Show...', 'Set Up Slide Show') -tries 6)
  DumpAll 'setup'
  try { Mark 'kiosk' (Box (FindAnywhere @('Browsed at a kiosk (full screen)') -tries 8)) } catch { '  MISSING kiosk' }
  try { Mark 'loop' (Box (FindAnywhere @('Loop continuously until ''Esc''') -tries 3)) } catch { '  MISSING loop' }
  try { Mark 'setupOK' (Box (FindAnywhere @('OK') $T::Button -tries 4)) } catch { '  MISSING setupOK' }
  Grab 'su-2'
  try { RealClick (Box (FindAnywhere @('Browsed at a kiosk (full screen)') -tries 4)); Start-Sleep -Milliseconds 800 } catch { }
  Grab 'su-3'
  RealKey 0x1B                                                   # cancel - the setting is made through COM
  Start-Sleep -Milliseconds 800
  $pres.SlideShowSettings.ShowType = 3                           # ppShowTypeKiosk
  Snap 'su-4'

  # 4. A PDF: File, Export, Create PDF/XPS - Backstage through UI Automation (a real click on File only shows
  # its tooltip here); Backstage is part of the window, so PrintWindow draws it.
  Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 800
  Snap 'pdf-1'
  Press (Find $root @('File Tab', 'File') -tries 6)
  Start-Sleep -Milliseconds 3000
  Dump 'backstage'
  TryMark 'export' $root @('Export') 
  Snap 'pdf-2'                                                   # Backstage: Home
  try { Press (Find $root @('Export') -tries 6) } catch { '  no Export' }
  Start-Sleep -Milliseconds 2500
  Dump 'exportpage'
  TryMark 'createPdf' $root @('Create PDF/XPS', 'Create PDF/XPS Document')
  Snap 'pdf-3'                                                   # the Export page
  try { OpenDialog (Find $root @('Create PDF/XPS', 'Create PDF/XPS Document') -tries 4); Start-Sleep -Milliseconds 1500; Grab 'pdf-4'; RealKey 0x1B } catch { '  no PDF dialog' }
  Start-Sleep -Milliseconds 1000
  try { Press (Find $root @('Print') -tries 6); Start-Sleep -Milliseconds 3000; Snap 'pr-1' } catch { '  no Print page' }
  try { Press (Find $root @('Back') -tries 3) } catch { RealKey 0x1B }
  Start-Sleep -Milliseconds 1000

  SaveMarks
}
catch { "FAILED: $_"; throw }
finally { try { if ($pres.SlideShowWindow) { $pres.SlideShowWindow.View.Exit() } } catch { }; ClosePowerPoint }
