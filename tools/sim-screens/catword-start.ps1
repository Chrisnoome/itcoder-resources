# Real Word 365 screens for catword lesson 1, 'start' (content/catword/start.php -
# AIResources/courses/cat-practical-writing.md, 8 October 2026). Mr Botha's
# notice for the bakery door: the Word window, a new document, the ruler,
# typing, and File > Save As into the CAT folder on Google Drive
# (G:\My Drive\CAT\Word).
#     pwsh -File vm-shots.ps1 catword-start          (runs in the CAT VM)
# Read office-kit.ps1's safety rules first. Pictures are cropped here
# (work\catword-kit.ps1) and the targets written in per cent to
# out\catword-start.json. Backstage's middle column names the school's
# OneDrive account: no picture keeps it - the Save As pictures are the
# right-hand column only, and Info leaves out the author's name.
$Name = 'catword-start'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')

$word = New-Object -ComObject Word.Application
$folder = 'G:\My Drive\CAT\Word'
$saved  = Join-Path $folder 'Botha notice 2026-12-16.docx'
try {
  $word.DisplayAlerts = 0
  New-Item -ItemType Directory -Force $folder | Out-Null
  Remove-Item $saved -ErrorAction SilentlyContinue
  $notice = NewDoc @('Botha''s Bakery', 'Closed on Wednesday 16 December', 'We are closed for the Day of Reconciliation. We open again on Thursday 17 December at 07:00.', 'Thank you for your support!')
  $word.Visible = $true
  WordWindow
  $notice.Range($notice.Content.End - 1, $notice.Content.End - 1).Select()
  Dump 'home'

  # 1. The notice on the Home tab - the 'find it' picture.
  Pic 'doc' $A
  Pct 'fileTab'   'doc' (Box (Ctl @('File Tab')))
  Pct 'insertTab' 'doc' (Box (Ctl @('Insert') $T::TabItem))
  Pct 'viewTab'   'doc' (Box (Ctl @('View') $T::TabItem))
  Pct 'fontDlg'   'doc' (Box (Ctl @('Font...')))
  Pct 'paraGroup' 'doc' (Box (Ctl @('Paragraph') $T::Group))
  Pct 'clipGroup' 'doc' (Box (Ctl @('Clipboard') $T::Group))
  try { Pct 'words'  'doc' (Box (Status 'Word Count*')) } catch { '  MISSING words' }
  try { Pct 'pageNo' 'doc' (Box (Status 'Page Number*')) } catch { '  MISSING pageNo' }
  Pct 'title' 'doc' (TextBox ((Para $notice 1).Duplicate))

  # 2. File: the Home page of Backstage (new documents, recent files).
  Press (Ctl @('File Tab')); Start-Sleep -Milliseconds 2500
  Dump 'backstage'
  Pic 'home' $F
  try { Pct 'blank' 'home' (Box (Find $root @('Blank document') $null 6)) } catch { '  MISSING blank' }
  Pct 'saveAsNav' 'home' (Box (Find $root @('Save As') $T::ListItem))
  Pct 'infoNav'   'home' (Box (Find $root @('Info') $T::ListItem))

  # 3. Info: protect, inspect, version history (the left part: the right shows the author's name).
  Press (Find $root @('Info') $T::ListItem); Start-Sleep -Milliseconds 2000
  Pic 'info' @(0, 56, 1000, 656)

  # 4. Save As: Recent folders, the CAT Word folder on Google Drive, a file name, Save.
  Press (Find $root @('Save As') $T::ListItem); Start-Sleep -Milliseconds 2500
  try { Press (Find $root @('Recent') $T::TabItem) } catch { '  no Recent tab' }
  Start-Sleep -Milliseconds 2000
  Dump 'sarecent'
  $R = @(620, 56, 1010, 656)   # the right-hand column only
  Pic 'sa-1' @(620, 56, 1010, 340)     # Today only: 'Older' lists the school's OneDrive by name
  $target = $null
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) {
    try { $bx = Box $e; if ($e.Current.Name -eq 'Word' -and $bx[0] -gt 600 -and -not $e.Current.IsOffscreen) { $target = $e; break } } catch { }
  }
  if (-not $target) { foreach ($e in $root.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -match 'My Drive|Word' -and -not $e.Current.IsOffscreen) { "  candidate: $($e.Current.Name) [$($e.Current.ControlType.ProgrammaticName)] $((Box $e) -join ',')" } } catch { } } }
  if ($target) {
    "  the folder: $($target.Current.Name)"
    Pct 'cloudWord' 'sa-1' (Box $target)
    Press $target; Start-Sleep -Milliseconds 2500
    Dump 'saword'
    $nameBox = Find $root @('Enter file name here') $T::Edit
    Pic 'sa-2' $R
    Pct 'nameBox' 'sa-2' (Box $nameBox)
    $vp = $null; if ($nameBox.TryGetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern, [ref]$vp)) { $vp.SetValue('Botha notice 2026-12-16') }
    Start-Sleep -Milliseconds 800
    $save = Find $root @('Save') $T::Button
    Pic 'sa-3' $R
    Pct 'saveBtn' 'sa-3' (Box $save)
    [Later]::Invoke($save)
    for ($i = 0; $i -lt 40 -and -not (Test-Path $saved); $i++) { Start-Sleep -Milliseconds 250 }
    Start-Sleep -Milliseconds 2500
    "saved: $(Test-Path $saved)"
  } else { '  NO CLOUD FOLDER in Recent' }

  # 5. File > Home again: the file at the top of the recent list.
  try { try { [void](Find $root @('File Tab') $null 4) } catch { [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 1500 }; Press (Ctl @('File Tab')); Start-Sleep -Milliseconds 2500; Press (Find $root @('Home') $T::ListItem); Start-Sleep -Milliseconds 2500; Pic 'saved' $F } catch { "no saved picture: $_" }
  try { Press (Find $root @('Back') $null 4) } catch { [Shot]::PostKey($h, 0x1B) }
  Start-Sleep -Milliseconds 1500

  # 6. A new blank document: the window's parts, the View tab and the ruler, typing.
  $blank = NewDoc @()
  WordWindow
  Pic 'new' $A
  Pic 'newfull' $F
  $at = TextBox ($blank.Range(0, 0))
  Pct 'firstLine' 'new' @($at[0], ($at[1] - 4), 520, ($at[3] + 8))
  Pct 'viewTab'   'new' (Box (Ctl @('View') $T::TabItem))
  foreach ($k in @(@('fileTabF', @('File Tab'), $null), @('tabsF', @('Ribbon Tabs'), $T::Tab), @('fontGroupF', @('Font'), $T::Group), @('fontDlgF', @('Font...'), $null), @('zoomF', @('Zoom'), $T::Slider), @('printLayoutF', @('Print Layout'), $null), @('readModeF', @('Read Mode'), $null))) {
    try { Pct $k[0] 'newfull' (Box (Find $root $k[1] $k[2] 6)) } catch { "  MISSING $($k[0])" }
  }
  try { Pct 'wordsF'  'newfull' (Box (Status 'Word Count*')) } catch { }
  try { Pct 'pageNoF' 'newfull' (Box (Status 'Page Number*')) } catch { }
  Pct 'cursorF' 'newfull' @($at[0], $at[1], 4, $at[3])

  Tab 'View'
  Dump 'view'
  Pic 'view' $A
  try { Pct 'ruler' 'view' (Box (Find $root @('Ruler') $T::CheckBox 6)) } catch { Pct 'ruler' 'view' (Box (Ctl @('Ruler'))) }
  $word.ActiveWindow.DisplayRulers = $true
  Start-Sleep -Milliseconds 1200
  Pic 'ruler' $A
  $word.ActiveWindow.DisplayRulers = $false
  Tab 'Home'

  $blank.Range(0, 0).InsertAfter('Botha''s Bakery')
  $blank.Content.InsertParagraphAfter()
  $blank.Range($blank.Content.End - 1, $blank.Content.End - 1).Select()
  Pic 'typed' $A

  # The model answer for the lesson's upload: the notice, saved by real Word.
  if (Test-Path $saved) { New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null; Copy-Item $saved "C:\sims\files\$Name\Botha notice 2026-12-16.docx" }
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
