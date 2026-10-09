# Real Word 365 screens for catword lesson 12, 'styles' (content/catword/styles.php,
# Grade 11, 9 October 2026). Ms Naidoo's school handbook: Modify Style from the
# Styles gallery's right-click menu, Update Heading 1 to Match Selection, the
# Styles pane (Ctrl+Alt+Shift+S) and a new style (Note), and the Design tab's
# theme Fonts. Also makes the upload's starter file (School handbook.docx, in
# C:\sims\files\catword-styles\ and G:\My Drive\CAT\Word\) and the done-right
# copy (School handbook done.docx, not in the cloud).
#     pwsh -File vm-shots.ps1 catword-styles
# Read office-kit.ps1's safety rules first. Pictures cropped here (work\catword-kit.ps1),
# the Add-ins group painted out (work\catword11-kit.ps1), targets in per cent in out\catword-styles.json.
$Name = 'catword-styles'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$fontPick = 'Corbel'          # the theme fonts the lesson and the upload use (Design > Fonts)

$lines = @(
  'Phumlani Secondary School',
  'Handbook for Grade 10 pupils, 2027',
  'Welcome',
  'Welcome to Phumlani Secondary. This handbook tells you how our school works: when to be here, what to wear and what we expect of you.',
  'Remember: keep this handbook in your school bag.',
  'School times',
  'School starts at 07:30 and ends at 14:30. The gate closes at 07:40, and late pupils sign in at the office.',
  'Uniform',
  'Summer uniform',
  'Grey trousers or a grey skirt, a white shirt and the school tie.',
  'Winter uniform',
  'Add the maroon jersey or blazer. No other jerseys may be worn.',
  'Remember: put your name on every piece of uniform.',
  'Homework',
  'Every pupil gets homework four days a week. Write it in your homework diary.',
  'Remember: late work is accepted only with a note from home.',
  ''
)
$h1 = 3, 6, 8, 14
$h2 = 9, 11
$notes = 5, 13, 16

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  (Para $doc 1).Style = -63                                        # Title
  foreach ($i in $h1) { (Para $doc $i).Style = -2 }
  foreach ($i in $h2) { (Para $doc $i).Style = -3 }
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'School handbook.docx' $true
  Dump 'home'

  # ---- 1. Modify Style: right-click Heading 1 in the gallery > Modify... > the size box
  $doc.Range((Para $doc 6).Start + 3, (Para $doc 6).Start + 3).Select()
  Show $doc.Range(0, 0)
  P 'm-1' $F
  $tile = Tile '^Heading 1$'
  if (-not $tile) { '  MISSING Heading 1 tile'; Tile '.' } else { Pct 'tile' 'm-1' (Box $tile) }
  $menu = RightClickEl $tile
  "  tile menu window: $menu"
  DumpMenu $menu 'tilemenu'
  P 'm-2' $F $h $menu
  $modify = $null
  try { $modify = FindAny $menu @('Modify...', 'Modify'); Pct 'modify' 'm-2' (BoxIn $modify $h) } catch { '  MISSING Modify...' }
  try { $upd = FindAny $menu @('Update Heading 1 to Match Selection'); Pct 'updateItem' 'm-2' (BoxIn $upd $h) } catch { '  MISSING update item' }
  if ($modify) {
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($modify)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1500
      DumpWin $dlg 'modify'
      P 'm-3' $null $dlg
      Chars $dlg '24'                                              # the size box has the focus? the picture says
      Start-Sleep -Milliseconds 600
      P 'm-3b' $null $dlg
      [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero)   # WM_CLOSE: Cancel
      Start-Sleep -Milliseconds 1500
    } else { '  NO Modify Style box'; Esc $menu }
  } else { Esc $menu }
  Fresh
  Retry { $doc.Styles.Item('Heading 1').Font.Size = 24 }
  Show $doc.Range(0, 0)
  P 'm-4' $F

  # ---- 2. Update Heading 1 to Match Selection: Welcome made dark red by hand, then the style updated
  $r = Para $doc 3
  $w = $doc.Range($r.Start, $r.End - 1)
  $w.Font.Color = 192                                              # wdColorDarkRed: C00000 (BGR 0x0000C0)
  $w.Select()
  Show $doc.Range(0, 0)
  P 'u-1' $F
  $tile = Tile '^Heading 1$'
  if ($tile) { Pct 'tile' 'u-1' (Box $tile) }
  $menu = RightClickEl $tile
  P 'u-2' $F $h $menu
  try { $upd = FindAny $menu @('Update Heading 1 to Match Selection'); Pct 'updateItem' 'u-2' (BoxIn $upd $h); [Later]::Invoke($upd); Start-Sleep -Milliseconds 2000 } catch { '  MISSING update item'; Esc $menu }
  Fresh
  if ($doc.Styles.Item('Heading 1').Font.Color -ne 192) { '  update by COM'; Retry { $doc.Styles.Item('Heading 1').Font.Color = 192 } }
  $w.Font.Reset()
  $doc.Range((Para $doc 6).Start + 3, (Para $doc 6).Start + 3).Select()
  Show $doc.Range(0, 0)
  P 'u-3' $F

  # ---- 3. A new style, Note: the Styles pane (launcher or Ctrl+Alt+Shift+S), New Style, the name
  $doc.Range((Para $doc 5).Start + 3, (Para $doc 5).Start + 3).Select()
  P 'n-1' $F
  try { Pct 'launcher' 'n-1' (Box (Ctl @('Styles...') $T::Button)) } catch { '  MISSING launcher' }
  $before = [Later]::Windows($script:wpid)
  Press (Ctl @('Styles...') $T::Button); Start-Sleep -Milliseconds 2500
  $pane = NewWindow $before @() 12
  "  styles pane window: $pane - $(([Later]::Windows($script:wpid) | Where-Object { $before -notcontains $_ }) -join ' | ')"
  Dump 'stylespane'
  $new = $null
  if ($pane -ne [IntPtr]::Zero) {
    DumpWin $pane 'stylespanewin'
    P 'n-2' $null $pane
    foreach ($e in $AE::FromHandle($pane).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -match '^New Style') { $new = $e; break } } catch { } }
    if ($new) { $pb = [WinRect]::Of($pane); $r = $new.Current.BoundingRectangle; $script:pct['newStyle@n-2'] = @([math]::Round(($r.X - $pb[0]) / $script:crops['n-2'][2] * 100, 1), [math]::Round(($r.Y - $pb[1]) / $script:crops['n-2'][3] * 100, 1), [math]::Round($r.Width / $script:crops['n-2'][2] * 100, 1), [math]::Round($r.Height / $script:crops['n-2'][3] * 100, 1)); "  newStyle@n-2 = $($script:pct['newStyle@n-2'] -join ', ')" } else { '  MISSING New Style' }
  } else {
    P 'n-2' $F
    try { $new = Ctl @('New Style', 'New Style...'); Pct 'newStyle' 'n-2' (Box $new) } catch { '  MISSING New Style' }
  }
  # the pane stays a figure; the simulation makes the style from the gallery: More > Create a Style > the name
  try { $word.TaskPanes.Item(0).Visible = $false } catch { }
  if ($pane -ne [IntPtr]::Zero) { [void][K11]::PostMessage($pane, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) }
  Start-Sleep -Milliseconds 1200
  # format the first note by hand (italic, dark blue), then More > Create a Style
  $nr = Para $doc 5
  $nt = $doc.Range($nr.Start, $nr.End - 1)
  $nt.Font.Italic = $true; $nt.Font.Color = 8388608
  $doc.Range($nr.Start + 3, $nr.Start + 3).Select()
  Show $doc.Range(0, 0)
  P 'c-1' $F
  $more = $null
  foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))) { try { if ($e.Current.Name -eq 'Styles' -and -not $e.Current.IsOffscreen) { $more = $e; break } } catch { } }
  if ($more) {
    Pct 'more' 'c-1' (Box $more)
    try {
      $menu = OpenMenu $more
      DumpMenu $menu 'gallerymenu'
      P 'c-2' $F $h $menu
      $create = FindAny $menu @('Create a Style')
      Pct 'createStyle' 'c-2' (BoxIn $create $h)
      $before = [Later]::Windows($script:wpid)
      [Later]::Invoke($create)
      $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
      if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'createstyle'; P 'c-3' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
      else { '  NO Create a Style box'; Esc $menu }
    } catch { "  gallery menu: $_"; Esc $null }
  } else { '  MISSING gallery More button' }
  $nt.Font.Reset()
  Fresh
  $note = Retry { $doc.Styles.Add('Note', 1) }
  $note.BaseStyle = 'Normal'
  $note.Font.Italic = $true
  $note.Font.Color = 8388608                                       # wdColorDarkBlue? (BGR 0x800000 = navy)
  $note.QuickStyle = $true
  foreach ($i in $notes) { (Para $doc $i).Style = 'Note' }
  $doc.Range((Para $doc 5).Start + 3, (Para $doc 5).Start + 3).Select()
  Show $doc.Range(0, 0)
  P 'c-4' $F
  Start-Sleep -Milliseconds 1200

  # ---- 4. Theme fonts: Design tab > Fonts > the pick
  Tab 'Home'
  P 't-1' $F
  Pct 'designTab' 't-1' (Box (Ctl @('Design') $T::TabItem))
  Tab 'Design'
  Dump 'design'
  P 't-2' $F
  foreach ($k in @(@('themes', @('Themes')), @('colors', @('Colors')), @('fonts', @('Fonts')), @('spacing', @('Paragraph Spacing')), @('effects', @('Effects')), @('setDefault', @('Set as Default')))) {
    try { Pct $k[0] 't-2' (Box (Ctl $k[1])) } catch { "  MISSING $($k[0])" }
  }
  try {
    $menu = OpenMenu (Ctl @('Fonts'))
    DumpMenu $menu 'fontsmenu'
    P 't-3' $F $h $menu
    $pick = $null
    foreach ($r in @($AE::FromHandle($menu), $AE::RootElement)) {
      foreach ($e in $r.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) { try { if ($e.Current.Name -match "^$fontPick" -and -not $e.Current.IsOffscreen) { $pick = $e; break } } catch { } }
      if ($pick) { break }
    }
    if ($pick) { "  font item: $($pick.Current.Name)"; Pct 'fontPick' 't-3' (BoxIn $pick $h); [Later]::Invoke($pick); Start-Sleep -Milliseconds 2500 }
    else { '  MISSING font pick'; Esc $menu }
  } catch { "  fonts menu: $_" }
  Fresh
  Start-Sleep -Milliseconds 3000
  try { Retry { "  body font now: $((Para $doc 7).Font.Name)" } } catch { }
  Retry { Show $doc.Range(0, 0) }
  P 't-4' $F
  # Themes and Colors galleries: figures only
  try { $menu = OpenMenu (Ctl @('Themes')); P 'th-1' $F $h $menu; DumpMenu $menu 'themesmenu'; Esc $menu } catch { "  themes menu: $_" }
  Fresh
  try { $menu = OpenMenu (Ctl @('Colors')); P 'co-1' $F $h $menu; DumpMenu $menu 'colorsmenu'; Esc $menu } catch { "  colors menu: $_" }
  Fresh

  # ---- 5. The done-right copy: Heading 1 18 pt dark red, Note on the three Remember lines, the theme fonts
  foreach ($p in $doc.Paragraphs) { "  [$($p.Style.NameLocal)] $($p.Range.Text.Trim())" }
  SaveDoc $doc 'School handbook done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
