# Real PowerPoint 365 screens for Presentations lesson 1, "Slides, layouts and
# designs" (AIPascalCourse/content/catpowerpoint/start.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Thabo's talk "Make your
# data last"; each picture is one moment of a task, and
# out\catpowerpoint-start.json says where things are (window pixels).
# Runs in the CAT VM only (some moments use the real mouse - see
# work\catpowerpoint-kit.ps1):
#     pwsh -File vm-shots.ps1 catpowerpoint-start
# Then: python cat-crop.py catpowerpoint-start
# It also makes the starter file DataTips.pptx and a done-right copy
# (DataTips-done.pptx, for bin/check-uploads.php) in C:\sims\files\<name>\
# and the starter in G:\My Drive\CAT\PowerPoint\.
$Name = 'catpowerpoint-start'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')

$files = "C:\sims\files\$Name"
$cloud = 'G:\My Drive\CAT\PowerPoint'

try {
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11                          # a narrow Slides pane: every thumbnail fits
  $why  = "Videos play in HD`rApps update on mobile data`rWhatsApp downloads every photo"
  $five = "Use Wi-Fi when you can`rTurn off auto-play`rSet apps to update on Wi-Fi only`rStop WhatsApp downloading media`rCheck which apps use the most"
  $null = AddSlide 'Title Slide' @('Make your data last', 'Thabo, Grade 10')
  $null = AddSlide 'Title and Content' @('Why data runs out', $why)
  $null = AddSlide 'Title and Content' @('Five ways to save data', $five)
  $null = AddSlide 'Title and Content' @('Five ways to save data', $five)    # the copy made by mistake
  GoTo 1
  Start-Sleep -Milliseconds 1500
  Dump 'home'
  TryMark 'fontSize'   $root @('Font Size') $T::ComboBox
  TryMark 'newSlide'   $root @('New Slide') $T::Button
  TryMark 'layout'     $root @('Layout') $T::MenuItem
  TryMark 'tabView'    $root @('View') $T::TabItem
  TryMark 'tabDesign'  $root @('Design') $T::TabItem
  TryMark 'tabHome'    $root @('Home') $T::TabItem
  TryMark 'sorterBtn'  $root @('Slide Sorter') $T::Button
  TryMark 'normalBtn'  $root @('Normal') $T::Button

  # The window, for the figure (slide 1, nothing selected).
  Snap 'win'

  # Practice: the subtitle selected - the Font Size box shows its size.
  $sub = $pres.Slides.Item(1).Shapes.Placeholders.Item(2).TextFrame.TextRange
  $null = $sub.Select()
  Start-Sleep -Milliseconds 800
  Snap 'pr-1'
  "subtitle size: $($sub.Font.Size)"
  $sub.Font.Size = 28
  Snap 'pr-2'                                                    # 28 typed: the box says 28
  $sub.Font.Size = 24
  $pp.ActiveWindow.Selection.Unselect()
  GoTo 1

  # 1. Views: Normal, then the View tab, then Slide Sorter.
  Snap 'v-1'                                                     # Home tab, Normal view
  Press (Find $root @('View') $T::TabItem); Start-Sleep -Milliseconds 1200
  Dump 'view'
  TryMark 'sorterRibbon' $root @('Slide Sorter') $T::Button
  Snap 'v-2'                                                     # the View tab
  $pp.ActiveWindow.ViewType = 7                                  # ppViewSlideSorter
  Start-Sleep -Milliseconds 1500
  Snap 'v-3'                                                     # Slide Sorter
  $pp.ActiveWindow.ViewType = 9                                  # back to Normal
  Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 1000
  GoTo 1

  # 2. A new slide after slide 2: click slide 2's thumbnail, then Ctrl+M.
  Snap 'ns-1'                                                    # slide 1 selected
  GoTo 2
  Snap 'ns-2'                                                    # slide 2 selected
  $null = $pres.Slides.AddSlide(3, (Layout 'Title and Content'))
  GoTo 3
  Snap 'ns-3'                                                    # the new, empty slide 3

  # 3. Its layout: Home > Layout > Two Content.
  OpenMenu (Find $root @('Layout') $T::MenuItem)
  Grab 'lay-2'                                                   # the Layout gallery open
  try { Mark 'twoContent' (Box (FindAnywhere @('Two Content') $T::ListItem -tries 8)) } catch { '  MISSING twoContent' }
  try { Mark 'titleOnly' (Box (FindAnywhere @('Title Only') $T::ListItem -tries 4)) } catch { '  MISSING titleOnly' }
  DumpAll 'layoutmenu'
  RealKey 0x1B                                                   # Esc closes it
  Start-Sleep -Milliseconds 600
  $pres.Slides.Item(3).CustomLayout = (Layout 'Two Content')
  GoTo 3
  Snap 'lay-3'                                                   # slide 3 now has two content boxes

  # 4. Delete the copy (slide 5): right-click its thumbnail, Delete Slide.
  GoTo 3
  Snap 'del-1'
  # The thumbnails are not in UI Automation: slide 5's place comes from the picture (cat-crop.py READ_OFF);
  # here, the same place in window pixels, worked out from where the thumbnails sit.
  $thumbs = @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -like 'Slide*' })
  $thumb5 = if ($thumbs.Count -ge 5) { Box $thumbs[4] } else { $null }
  if ($thumb5) { Mark 'thumb5' $thumb5 }
  if ($thumbs.Count -ge 2) { Mark 'thumb2' (Box $thumbs[1]) }
  # A right-click on a thumbnail opens no menu PowerPoint draws for a picture here (VM tests, 8 October
  # 2026), so the lesson deletes with a click and the Delete key: slide 5 selected is the second picture.
  GoTo 5
  Snap 'del-2'
  $pres.Slides.Item(5).Delete()
  GoTo 4
  Snap 'del-3'                                                   # four slides; the last one selected

  # 5. A design: the Design tab, then a theme.
  GoTo 1
  Snap 'des-1'
  Press (Find $root @('Design') $T::TabItem); Start-Sleep -Milliseconds 1500
  Dump 'design'
  foreach ($theme in 'Office Theme', 'Archway', 'Axis', 'Bjorn', 'Dark Gradient', 'Dune') { TryMark "theme $theme" $root @($theme) $T::ListItem }
  TryMark 'slideSize' $root @('Slide Size') $T::MenuItem
  TryMark 'designIdeas' $root @('Design Suggestions', 'Designer') $T::Button
  Snap 'des-2'                                                   # the Design tab
  $tile = Find $root @('Archway') $T::ListItem
  Press $tile
  Start-Sleep -Milliseconds 4000
  try { Press (Find $root @('Design Suggestions') -tries 4); Start-Sleep -Milliseconds 1500 } catch { '  no Design Suggestions to close' }
  DumpAll 'afterTheme'
  Snap 'des-3'                                                   # Dune on every slide

  # The Slide Size menu, for a figure.
  $size = Find $root @('Slide Size') $T::MenuItem
  $p = $null
  if ($size.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand() } else { [PP]::Later($size) }
  Start-Sleep -Milliseconds 1500
  DumpAll 'sizemenu'
  Grab 'sz-1'
  RealKey 0x1B
  Start-Sleep -Milliseconds 600
  Press (Find $root @('Home') $T::TabItem)

  SaveMarks

  # ---- The starter file and a done-right copy, made in real PowerPoint.
  New-Item -ItemType Directory -Force $files | Out-Null
  $st = $pp.Presentations.Add(-1)
  $null = $st.Slides.AddSlide(1, ($st.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq 'Title Slide' } | Select-Object -First 1))
  $st.Slides.Item(1).Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Make your data last'
  $st.Slides.Item(1).Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = 'Thabo, Grade 10'
  $tc = $st.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq 'Title and Content' } | Select-Object -First 1
  foreach ($pair in @(@('Why data runs out', $why), @('Five ways to save data', $five), @('Saving airtime', "Send a please-call-me`rUse WhatsApp calls on Wi-Fi`rBuy a bundle, not out-of-bundle airtime"))) {
    $s = $st.Slides.AddSlide($st.Slides.Count + 1, $tc)
    $s.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = $pair[0]
    $s.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = $pair[1]
  }
  $st.SaveAs((Join-Path $files 'DataTips.pptx'), 24)            # ppSaveAsOpenXMLPresentation
  # Done right: delete Saving airtime; a Two Content slide after slide 2; a Title Only slide at the end.
  $st.Slides.Item(4).Delete()
  $two = $st.Slides.AddSlide(3, ($st.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq 'Two Content' } | Select-Object -First 1))
  $two.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Mobile data or Wi-Fi?'
  $two.Shapes.Placeholders.Item(2).TextFrame.TextRange.Text = "Mobile data`rCosts money`rWorks anywhere"
  $two.Shapes.Placeholders.Item(3).TextFrame.TextRange.Text = "Wi-Fi`rOften free`rAt home, school, the library"
  $last = $st.Slides.AddSlide(5, ($st.SlideMaster.CustomLayouts | Where-Object { $_.Name -eq 'Title Only' } | Select-Object -First 1))
  $last.Shapes.Placeholders.Item(1).TextFrame.TextRange.Text = 'Questions?'
  $st.SaveAs((Join-Path $files 'DataTips-done.pptx'), 24)
  $st.Close()
  if (Test-Path 'G:\My Drive') {
    New-Item -ItemType Directory -Force $cloud | Out-Null
    Copy-Item (Join-Path $files 'DataTips.pptx') $cloud -Force
    "starter -> $cloud"
  } else { '  NO G:\My Drive - the starter is not in the cloud' }
}
catch { "FAILED: $_"; throw }
finally { ClosePowerPoint }
