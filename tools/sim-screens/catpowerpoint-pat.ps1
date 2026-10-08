# Real PowerPoint 365 screens for Presentations lesson 6, "Presenting your
# PAT" (AIPascalCourse/content/catpowerpoint/pat.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Thabo's PAT summary,
# "Phones for school work"; out\catpowerpoint-pat.json says where things are
# (window pixels). Runs in the CAT VM only (pasting, Paste Options and the
# dialogs use the real mouse and keys - work\catpowerpoint-kit.ps1):
#     pwsh -File vm-shots.ps1 catpowerpoint-pat
# Then: python cat-crop.py catpowerpoint-pat
# It also makes the starters PhonesReport.docx (a Word outline of the report's
# summary) and PhonesSurvey.xlsx (the survey chart), and a done-right
# PhonesPAT-done.pptx, in C:\sims\files\<name>\; the starters also in
# G:\My Drive\CAT\PowerPoint\.
$Name = 'catpowerpoint-pat'
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
function TextBox($range) {
  $w = $pp.ActiveWindow
  $x1 = $w.PointsToScreenPixelsX($range.BoundLeft); $x2 = $w.PointsToScreenPixelsX($range.BoundLeft + $range.BoundWidth)
  $y1 = $w.PointsToScreenPixelsY($range.BoundTop);  $y2 = $w.PointsToScreenPixelsY($range.BoundTop + $range.BoundHeight)
  $win = [WinRect]::Of($h)
  return @(($x1 - $win[0]), ($y1 - $win[1]), ($x2 - $x1), ($y2 - $y1))
}
function TryAnywhere([string]$key, [string[]]$names, $type = $null, [int]$tries = 6) {
  try { $e = FindAnywhere $names $type -tries $tries; Mark $key (Box $e) | Out-Host; return $e } catch { Write-Host "  MISSING $key"; return $null }
}

$outline = @(
  @('Phones for school work', -2), @('Thabo, Grade 10 - CAT PAT', -3),
  @('The question', -2), @('Do Grade 10s use their phones for school work - and how?', -3),
  @('Finding 1: WhatsApp comes first', -2), @('40% use WhatsApp most for school work', -3), @('30% use Google Classroom', -3),
  @('Finding 2: Data is the problem', -2), @('1 in 4 run out of data before month-end', -3),
  @('Conclusion', -2), @('Most Grade 10s already use their phones for school work', -3), @('Mostly through WhatsApp class groups', -3),
  @('Recommendations', -2), @('Allow phones for school work in class', -3), @('Post homework on Google Classroom as well', -3), @('Free Wi-Fi in the library', -3),
  @('Sources', -2), @('My survey of 60 Grade 10 pupils, August 2026', -3), @('Interview with Ms Naidoo, CAT teacher, 12 August 2026', -3), @('BestLessons: From data to a report', -3))

try {
  # ---- The starters: the Word outline and the survey workbook with its chart.

  $xl = New-Object -ComObject Excel.Application
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Survey'
  $rows = @(@('App used most', 'Pupils (%)'), @('WhatsApp', '40'), @('Google Classroom', '30'), @('YouTube', '20'), @('Other', '10'))
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt 2; $c++) { $ws.Cells.Item($r + 1, $c + 1).Formula = [string]$rows[$r][$c] } }
  $ws.Columns.Item(1).ColumnWidth = 18; $ws.Columns.Item(2).ColumnWidth = 12
  $co = $ws.Shapes.AddChart2(-1, 51, 200, 10, 420, 260)          # xlColumnClustered
  $co.Chart.SetSourceData($ws.Range('A1:B5'))
  $co.Chart.ChartTitle.Text = 'App used most for school work'
  $wb.SaveAs((Join-Path $files 'PhonesSurvey.xlsx'), 51)

  # ---- The presentation, built as far as the moment of each task.
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11
  $null = AddSlide 'Title Slide' @('Phones for school work', 'Thabo, Grade 10 - CAT PAT')
  $null = AddSlide 'Title and Content' @('The question', 'Do Grade 10s use their phones for school work - and how?')
  $s3 = AddSlide 'Title Only' @('Finding 1: WhatsApp comes first')
  $s3 = $pres.Slides.Item(3)
  $null = AddSlide 'Title and Content' @('Finding 2: Data is the problem', '1 in 4 run out of data before month-end')
  $null = AddSlide 'Title and Content' @('Conclusion', "Most Grade 10s already use their phones for school work`rMostly through WhatsApp class groups")
  $null = AddSlide 'Title and Content' @('Recommendations', "Allow phones for school work in class`rPost homework on Google Classroom as well`rFree Wi-Fi in the library")
  $s7 = AddSlide 'Title and Content' @('Sources', "My survey of 60 Grade 10 pupils, August 2026`rInterview with Ms Naidoo, CAT teacher, 12 August 2026`rBestLessons: From data to a report")
  $s7 = $pres.Slides.Item(7)
  Press (Find $root @('Design') $T::TabItem); Start-Sleep -Milliseconds 1200
  Press (Find $root @('Axis') $T::ListItem); Start-Sleep -Milliseconds 4000
  try { Press (Find $root @('Design Suggestions') -tries 4); Start-Sleep -Milliseconds 1500 } catch { }
  Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 1000
  GoTo 1
  $pp.ActiveWindow.Selection.Unselect()
  $thumbs = @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -like 'Slide*' })
  if ($thumbs.Count -ge 3) { Mark 'thumb3' (Box $thumbs[2]) }
  Snap 'deck'                                                    # the whole plan, slide 1

  # 1. The chart from Excel: copied there, Ctrl+V on slide 3, Paste Options, Link.
  $co.Chart.ChartArea.Copy()
  Start-Sleep -Milliseconds 800
  GoTo 3
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'ch-1'                                                    # slide 3, the chart copied in Excel
  RealClick (ShapeBox $s3.Shapes.Placeholders.Item(1)) 'left' 0.5 3.5   # an empty part of the slide, below the title
  $pp.ActiveWindow.Selection.Unselect()
  RealKey 0x56 -Ctrl                                             # Ctrl+V
  Start-Sleep -Milliseconds 2500
  DumpAll 'pasted'
  Mark 'pasteOptions' @(972, 648, 74, 28)                        # the (Ctrl) button: not in UI Automation - read off ch-2
  # The Designer pane opens after the paste: "Stop suggesting ideas until I restart PowerPoint" shuts it for the run.
  try { RealClick (Box (FindAnywhere @('Stop suggesting ideas until I restart PowerPoint') -tries 8)); Start-Sleep -Milliseconds 1200 } catch { '  no Designer link' }
  try { RealClick (Box (FindAnywhere @('Got it') -tries 3)); Start-Sleep -Milliseconds 600 } catch { }
  Snap 'ch-2'                                                    # the chart pasted, the Paste Options button by it
  Start-Sleep -Milliseconds 800
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'ch-4'                                                    # the chart on the slide
  $wb.Close($false); $xl.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl); $xl = $null

  # 2. A link on the sources slide: select the text, Ctrl+K, type the address, OK.
  GoTo 7
  $src = $s7.Shapes.Placeholders.Item(2).TextFrame.TextRange.Paragraphs(3)
  $src = $src.Characters(1, $src.Text.TrimEnd("`r").Length)
  $null = $src.Select(); Start-Sleep -Milliseconds 800
  Mark 'sourceText' (TextBox $src)
  Snap 'ln-1'                                                    # BestLessons: From data to a report, selected
  RealKey 0x4B -Ctrl                                             # Ctrl+K
  Start-Sleep -Milliseconds 2000
  DumpAll 'linkdialog'
  if (-not (TryAnywhere 'address' @('Address:', 'Address') $T::Edit)) { Mark 'address' @(680, 552, 520, 24) }
  if (-not (TryAnywhere 'linkOK' @('OK') $T::Button)) { Mark 'linkOK' @(1114, 592, 96, 26) }
  Grab 'ln-2'
  RealType 'https://www.bestlessons.co.za'
  Grab 'ln-3'
  RealKey 0x1B
  Start-Sleep -Milliseconds 800
  $src.ActionSettings.Item(1).Hyperlink.Address = 'https://www.bestlessons.co.za'
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'ln-4'                                                    # the link, underlined

  # 3. Slide numbers: Insert, Header & Footer, Slide number, Don't show on title slide, Apply to All.
  GoTo 2
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'hf-1'
  Press (Find $root @('Insert') $T::TabItem); Start-Sleep -Milliseconds 1200
  TryMark 'tabInsert' $root @('Insert') $T::TabItem
  TryMark 'headerFooter' $root @('Header & Footer...', 'Header & Footer')
  Snap 'hf-2'
  try { OpenDialog (Find $root @('Header & Footer...', 'Header & Footer') -tries 4) } catch { }
  DumpAll 'hfdialog'
  $null = TryAnywhere 'slideNumber' @('Slide number') $T::CheckBox
  $null = TryAnywhere 'notOnTitle' @('Don''t show on title slide') $T::CheckBox
  $null = TryAnywhere 'applyAll' @('Apply to All') $T::Button
  Grab 'hf-3'
  $e = TryAnywhere 'slideNumber2' @('Slide number') $T::CheckBox -tries 3
  if ($e) { RealClick (Box $e); Start-Sleep -Milliseconds 600 }
  Grab 'hf-4'
  $e = TryAnywhere 'notOnTitle2' @('Don''t show on title slide') $T::CheckBox -tries 3
  if ($e) { RealClick (Box $e); Start-Sleep -Milliseconds 600 }
  Grab 'hf-5'
  RealKey 0x1B
  Start-Sleep -Milliseconds 800
  foreach ($s in $pres.Slides) { $s.HeadersFooters.SlideNumber.Visible = -1 }
  $pres.Slides.Item(1).HeadersFooters.SlideNumber.Visible = 0
  Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 800
  GoTo 2
  $pp.ActiveWindow.Selection.Unselect()
  Snap 'hf-6'                                                    # the number at the bottom right

  # Spelling, for a figure: Review > Spelling with one mistake.
  $pres.Slides.Item(6).Shapes.Placeholders.Item(2).TextFrame.TextRange.Paragraphs(3).Text = "Free Wi-Fi in the libary"
  GoTo 6
  Press (Find $root @('Review') $T::TabItem); Start-Sleep -Milliseconds 1200
  TryMark 'spelling' $root @('Spelling', 'Spelling...', 'Check Document')
  try { Press (Find $root @('Spelling', 'Spelling...', 'Check Document') -tries 4); Start-Sleep -Milliseconds 3000; DumpAll 'spell'; Grab 'sp-1' } catch { '  no Spelling pane' }
  Press (Find $root @('Home') $T::TabItem)

  SaveMarks
  WordOutline (Join-Path $files 'PhonesReport.docx') $outline

  # ---- A done-right copy of the pupil's task (made through COM).
  try { $null = $pres.Slides.Item(6).Shapes.Placeholders.Item(2).TextFrame.TextRange.Replace('libary', 'library') } catch { "  could not fix libary: $_" }
  $pres.SaveAs((Join-Path $files 'PhonesPAT-done.pptx'), 24)
  if (Test-Path 'G:\My Drive') {
    New-Item -ItemType Directory -Force $cloud | Out-Null
    Copy-Item (Join-Path $files 'PhonesReport.docx'), (Join-Path $files 'PhonesSurvey.xlsx') $cloud -Force
    "starters -> $cloud"
  }
}
catch { "FAILED: $_"; throw }
finally {
  if ($xl) { try { $wb.Close($false) } catch { }; $xl.Quit() }
  ClosePowerPoint
}
