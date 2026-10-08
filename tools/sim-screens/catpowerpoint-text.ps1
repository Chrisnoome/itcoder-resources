# Real PowerPoint 365 screens for Presentations lesson 2, "Text and lists on
# slides" (AIPascalCourse/content/catpowerpoint/text.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Thabo's talk "Make your
# data last", in the Archway design from lesson 1; out\catpowerpoint-text.json
# says where things are (window pixels). Runs in the CAT VM only (some moments
# use the real mouse and keys - work\catpowerpoint-kit.ps1):
#     pwsh -File vm-shots.ps1 catpowerpoint-text
# Then: python cat-crop.py catpowerpoint-text
# It also makes the starter files TextTips.pptx and MoreTips.docx (a Word
# outline) and a done-right copy TextTips-done.pptx in C:\sims\files\<name>\,
# and the starters in G:\My Drive\CAT\PowerPoint\.
$Name = 'catpowerpoint-text'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')

$files = "C:\sims\files\$Name"
$cloud = 'G:\My Drive\CAT\PowerPoint'
New-Item -ItemType Directory -Force $files | Out-Null

# Where a piece of text on the current slide is (window pixels).
function TextBox($range) {
  $w = $pp.ActiveWindow
  $x1 = $w.PointsToScreenPixelsX($range.BoundLeft); $x2 = $w.PointsToScreenPixelsX($range.BoundLeft + $range.BoundWidth)
  $y1 = $w.PointsToScreenPixelsY($range.BoundTop);  $y2 = $w.PointsToScreenPixelsY($range.BoundTop + $range.BoundHeight)
  $win = [WinRect]::Of($h)
  return @(($x1 - $win[0]), ($y1 - $win[1]), ($x2 - $x1), ($y2 - $y1))
}
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
  $null = AddSlide 'Title Slide' @('Make your data last', 'Thabo, Grade 10')
  $null = AddSlide 'Title and Content' @('Why data runs out', "Videos play in HD`rApps update on mobile data`rWhatsApp downloads every photo")
  $two  = AddSlide 'Two Content' @($null, "Mobile data`rCosts money`rWorks anywhere", "Wi-Fi`rOften free`rAt home, school or the library")
  $two = $pres.Slides.Item(3)
  $null = AddSlide 'Title and Content' @('Five ways to save data', "Use Wi-Fi when you can`rTurn off auto-play on your cellphone`rSet apps to update on Wi-Fi only`rStop WhatsApp downloading media`rCheck which apps use data on your cellphone")
  # The Archway design, as at the end of lesson 1.
  Press (Find $root @('Design') $T::TabItem); Start-Sleep -Milliseconds 1200
  Press (Find $root @('Archway') $T::ListItem); Start-Sleep -Milliseconds 4000
  try { Press (Find $root @('Design Suggestions') -tries 4); Start-Sleep -Milliseconds 1500 } catch { }
  Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 1000
  Dump 'home'
  foreach ($n in 'Bold', 'Italic', 'Underline', 'Increase List Level', 'Decrease List Level', 'Bullets', 'Numbering', 'Center', 'Align Left', 'Line Spacing', 'Font Color', 'Font Size', 'Font', 'Text Highlight Color', 'Find and Replace', 'Replace', 'Find', 'New Slide', 'Cut', 'Copy', 'Paste') { TryMark $n $root @($n) }

  # 1. A title typed into an empty placeholder (slide 3).
  GoTo 3
  $titleShape = $pres.Slides.Item(3).Shapes.Placeholders.Item(1)
  Mark 'titlePh' (ShapeBox $titleShape)
  Snap 't-1'                                                     # Click to add title
  $null = $titleShape.TextFrame.TextRange.Select()
  Start-Sleep -Milliseconds 600
  Snap 't-2'                                                     # the cursor in the empty title
  $titleShape.TextFrame.TextRange.Text = 'Mobile data or Wi-Fi?'
  $null = $titleShape.TextFrame.TextRange.Characters(22, 0).Select()
  Start-Sleep -Milliseconds 600
  Snap 't-3'                                                     # typed

  # 2. A sub-point: two lines selected in the left box, then Tab.
  $left = $two.Shapes.Placeholders.Item(2).TextFrame.TextRange
  $null = $left.Paragraphs(2, 2).Select()
  Start-Sleep -Milliseconds 600
  Mark 'leftLines' (TextBox ($left.Paragraphs(2, 2)))
  Snap 'lv-1'                                                    # Costs money / Works anywhere selected
  $left.Paragraphs(2, 2).IndentLevel = 2
  $right = $two.Shapes.Placeholders.Item(3).TextFrame.TextRange
  Start-Sleep -Milliseconds 600
  Snap 'lv-2'                                                    # indented, smaller bullets
  $right.Paragraphs(2, 2).IndentLevel = 2

  # 3. Highlight one word: double-click HD, then Text Highlight Color.
  $pp.ActiveWindow.Selection.Unselect()
  GoTo 2
  $body = $pres.Slides.Item(2).Shapes.Placeholders.Item(2).TextFrame.TextRange
  $hd = $body.Paragraphs(1).Characters(16, 2)                    # "Videos play in HD"
  Mark 'wordHD' (TextBox $hd)
  Snap 'hl-1'
  $null = $hd.Select(); Start-Sleep -Milliseconds 600
  Snap 'hl-2'                                                    # HD selected
  $pres.Slides.Item(2).Shapes.Placeholders.Item(2).TextFrame2.TextRange.Paragraphs(1).Characters(16, 2).Font.Highlight.RGB = 65535   # yellow
  Start-Sleep -Milliseconds 600
  Snap 'hl-3'                                                    # highlighted (still selected)
  $pp.ActiveWindow.Selection.Unselect()

  # 4. Replace: Ctrl+H opens the Find and Replace pane (PowerPoint 365, 2026 - no longer a dialog box);
  # cellphone, phone, Replace All. Places in the pane read off the first run's pictures (window pixels).
  GoTo 4
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'rp-1'
  RealClick (ShapeBox $pres.Slides.Item(4).Shapes.Placeholders.Item(2)) 'left' 0.9 0.95   # into the list, at its end
  RealKey 0x48 -Ctrl                                             # Ctrl+H
  Start-Sleep -Milliseconds 2000
  try { RealClick (Box (FindAnywhere @('Got it') -tries 6)); Start-Sleep -Milliseconds 800 } catch { }   # the "Using multiple panes?" tip
  $findBox = @(1464, 272, 318, 28); $replBox = @(1464, 372, 318, 28); $allBtn = @(1678, 414, 98, 30)
  Mark 'findWhat' $findBox; Mark 'replaceWith' $replBox; Mark 'replaceAll' $allBtn
  Grab 'rp-2'                                                    # the pane, Find what empty
  RealClick $findBox; Start-Sleep -Milliseconds 500; RealClick $findBox
  RealType 'cellphone'
  Grab 'rp-3'
  RealClick $replBox
  RealType 'phone'
  Grab 'rp-4'
  RealClick $allBtn
  Start-Sleep -Milliseconds 1500
  Grab 'rp-5'                                                    # replaced
  try { RealClick (Box (FindAnywhere @('OK') $T::Button -tries 3)) } catch { }
  RealClick @(1752, 240, 20, 20)                                 # the pane's X
  Start-Sleep -Milliseconds 800
  foreach ($sh in $pres.Slides.Item(4).Shapes) { if ($sh.HasTextFrame) { $null = $sh.TextFrame.TextRange.Replace('cellphone', 'phone'); $null = $sh.TextFrame.TextRange.Replace('cellphone', 'phone') } }   # as Replace All did
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'rp-6'                                                    # the slide says phone

  # 5. Slides from Outline: the New Slide arrow, then Slides from Outline.
  # The New Slide list reaches below an 880-high window: these pictures come from a 1010-high one, cropped
  # (9, 58, 1791, 1001) by hand, not by cat-crop.py's box.
  [Shot]::Place($h, 30, 30, 1800, 1010); Start-Sleep -Milliseconds 2000
  GoTo 4
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'ol-1'
  $ns = Find $root @('New Slide') $T::SplitButton
  $nb = Box $ns
  Mark 'newSlideArrow' @($nb[0], ($nb[1] + 48), $nb[2], ($nb[3] - 48))
  RibbonClick @($nb[0], ($nb[1] + 48), $nb[2], ($nb[3] - 48))
  Start-Sleep -Milliseconds 1500
  DumpAll 'newslidemenu'
  try { Mark 'fromOutline' (Box (FindAnywhere @('Slides from Outline...', 'Slides from Outline') -tries 8)) } catch { '  MISSING fromOutline' }
  Grab 'ol-2'
  try { RealClick (Box (FindAnywhere @('Slides from Outline...', 'Slides from Outline') -tries 4)) } catch { RealKey 0x1B }
  Start-Sleep -Milliseconds 2500
  DumpAll 'outlinedialog'
  Grab 'ol-3'                                                    # the Insert Outline dialog
  RealKey 0x1B
  Start-Sleep -Milliseconds 800

  SaveMarks

  # ---- The Word outline (Heading 1 = a slide's title, Heading 2 = its points), made in real Word.
  $lines = @(@('Apps that eat data', -2), @('YouTube and TikTok', -3), @('Instagram', -3), @('Netflix', -3),
             @('Free Wi-Fi spots', -2), @('Libraries', -3), @('Shopping centres', -3), @('Fast-food restaurants', -3))
  WordOutline (Join-Path $files 'MoreTips.docx') $lines

  # ---- The starter presentation and a done-right copy.
  $st = $pp.Presentations.Add(-1)
  $lay = { param($n) $st.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq $n } | Select-Object -First 1 }
  $s = $st.Slides.AddSlide(1, (& $lay 'Title Slide'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Make your data last'
  $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = 'Thabo, Grade 10'
  $s = $st.Slides.AddSlide(2, (& $lay 'Title and Content'))      # no title yet: the pupil types it
  $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = "Videos play in HD`rApps update on mobile data`rWhatsApp downloads every photo to your cellphone"
  $s = $st.Slides.AddSlide(3, (& $lay 'Title and Content'))
  $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Five ways to save data'
  $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = "Use Wi-Fi when you can`rTurn off auto-play on your cellphone`rSet apps to update on Wi-Fi only`rStop WhatsApp downloading media`rCheck which apps use data on your cellphone"
  $st.SaveAs((Join-Path $files 'TextTips.pptx'), 24)
  # Done right: the title typed, cellphone replaced, the outline's two slides at the end.
  $st.Slides.Item(2).Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Why data runs out'
  foreach ($sl in $st.Slides) { foreach ($sh in $sl.Shapes) { if ($sh.HasTextFrame) { $null = $sh.TextFrame.TextRange.Replace('cellphone', 'phone'); $null = $sh.TextFrame.TextRange.Replace('cellphone', 'phone') } } }
  foreach ($pair in @(@('Apps that eat data', "YouTube and TikTok`rInstagram`rNetflix"), @('Free Wi-Fi spots', "Libraries`rShopping centres`rFast-food restaurants"))) {
    $s = $st.Slides.AddSlide($st.Slides.Count + 1, (& $lay 'Title and Content'))
    $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = $pair[0]
    $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = $pair[1]
  }
  $st.SaveAs((Join-Path $files 'TextTips-done.pptx'), 24)
  $st.Close()
  if (Test-Path 'G:\My Drive') {
    New-Item -ItemType Directory -Force $cloud | Out-Null
    Copy-Item (Join-Path $files 'TextTips.pptx'), (Join-Path $files 'MoreTips.docx') $cloud -Force
    "starters -> $cloud"
  }
}
catch { "FAILED: $_"; throw }
finally { ClosePowerPoint }
