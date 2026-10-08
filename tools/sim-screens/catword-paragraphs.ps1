# Real Word 365 screens for catword lesson 4, 'paragraphs' (content/catword/paragraphs.php,
# 8 October 2026). Ms Naidoo's computer lab rules: Show/Hide, the Title style,
# alignment, the Paragraph dialog box (indent and spacing), line spacing,
# Borders and Shading. Also makes the starter file (Lab rules.docx, in
# C:\sims\files\catword-paragraphs\ and G:\My Drive\CAT\Word\) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-paragraphs
$Name = 'catword-paragraphs'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $lines = @(
    'Computer Lab Rules',
    'Phumlani Secondary School, Room 14',
    'The computer lab is shared by more than 400 pupils.  These rules keep the computers working and make the lab a good place to learn. Read them before your first lesson, and keep to them every time you are here.',
    '',
    'No food or drinks near the computers.',
    'Log off when you leave.',
    'Save your work in the cloud, never on the desktop.',
    'Report any damage to Ms Naidoo at once.',
    'Updated: 8 October 2026'
  )
  $rules = NewDoc $lines

  $word.Visible = $true
  WordWindow
  SaveForPupils $rules 'Lab rules.docx'
  Dump 'home'
  $rules.Range(0, 0).Select()

  # 1. Show/Hide: the marks that are always there.
  Pic 'h-1' $A
  Pct 'showAll' 'h-1' (Box (Ctl @('Show All')))
  $word.ActiveWindow.View.ShowAll = $true
  Pic 'h-2' $A
  $word.ActiveWindow.View.ShowAll = $false
  (Para $rules 4).Delete() | Out-Null                       # the empty paragraph
  $p3 = Para $rules 3
  [void]$p3.Find.Execute('.  ', $false, $false, $false, $false, $false, $true, 0, $false, '. ', 2)

  # 2. The Title style for the heading (from the Styles gallery).
  $rules.Range(3, 3).Select()
  Pic 't-1' $A
  $tile = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -match 'Title$' } | Select-Object -First 1
  if ($tile) { Pct 'titleStyle' 't-1' (Box $tile) } else { '  MISSING Title in the gallery' ; $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | ForEach-Object { "   style tile: $($_.Current.Name)" } }
  (Para $rules 1).Style = -63                               # wdStyleTitle
  (Para $rules 1).ParagraphFormat.Alignment = 1
  (Para $rules 2).ParagraphFormat.Alignment = 1
  Pic 't-2' $A

  # 3. Alignment: justify the long paragraph (Ctrl+J), the date on the right.
  $rules.Range((Para $rules 3).Start + 5, (Para $rules 3).Start + 5).Select()
  Pic 'a-1' $A
  (Para $rules 3).ParagraphFormat.Alignment = 3             # wdAlignParagraphJustify
  Pic 'a-2' $A
  Pct 'dateLine' 'a-2' (TextBox ((Para $rules 8).Duplicate))
  $rules.Range((Para $rules 8).Start + 3, (Para $rules 8).Start + 3).Select()
  Pic 'a-3' $A
  Pct 'alignRight' 'a-3' (Box (Ctl @('Align Right')))
  Pct 'justify'    'a-3' (Box (Ctl @('Justify')))
  (Para $rules 8).ParagraphFormat.Alignment = 2
  Pic 'a-4' $A

  # 4. The Paragraph dialog box: the four rules indented 1 cm, 6 pt after.
  $rules.Range((Para $rules 4).Start, (Para $rules 7).End).Select()
  Pic 'p-1' $A
  Pct 'paraLauncher' 'p-1' (Box (Ctl @('Paragraph...')))
  Pct 'lineSpacing'  'p-1' (Box (Ctl @('Line and Paragraph Spacing')))
  Pct 'incIndent'    'p-1' (Box (Ctl @('Increase Indent')))
  # Word's dialog boxes show little to UI Automation: each state is set through COM and the box opened again
  # to picture it (it shows the selected paragraphs' settings); targets are read off the pictures.
  $sel = $rules.Range((Para $rules 4).Start, (Para $rules 7).End)
  $dlg = OpenDialog (Ctl @('Paragraph...'))
  DumpWin $dlg 'paradlg'
  Pic 'p-2' $null $dlg
  CloseDialog $dlg
  $sel.ParagraphFormat.LeftIndent = $word.CentimetersToPoints(1)
  $sel.Select()
  $dlg = OpenDialog (Ctl @('Paragraph...'))
  Pic 'p-3' $null $dlg
  CloseDialog $dlg
  $sel.ParagraphFormat.SpaceAfter = 6
  $sel.Select()
  $dlg = OpenDialog (Ctl @('Paragraph...'))
  Pic 'p-4' $null $dlg
  CloseDialog $dlg
  $sel = $rules.Range((Para $rules 4).Start, (Para $rules 7).End)
  $sel.ParagraphFormat.LeftIndent = $word.CentimetersToPoints(1)
  $sel.ParagraphFormat.SpaceAfter = 6
  $sel.Select()
  Pic 'p-5' $A

  # 5. Borders and Shading for the school's name line.
  (Para $rules 2).Select()
  Pic 'b-1' $A
  $bsplit = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::SplitButton))) | Where-Object { $_.Current.Name -eq 'Borders' } | Select-Object -First 1
  $barrow = $bsplit.FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'More Options')))
  Pct 'bordersArrow' 'b-1' (Box $barrow)
  $menu = OpenMenu $barrow
  if ($menu -ne [IntPtr]::Zero) {
    DumpWin $menu 'bordersmenu'
    Pic 'b-2' $A $h $menu
    try { Pct 'bottomBorder' 'b-2' (BoxIn (FindIn $menu @('Bottom Border')) $h) } catch { '  (menu names not readable)' }
    try { Pct 'outsideBorders' 'b-2' (BoxIn (FindIn $menu @('Outside Borders')) $h) } catch { }
    [Shot]::PostKey($menu, 0x1B); Start-Sleep -Milliseconds 800
  }
  $pb = (Para $rules 2).ParagraphFormat.Borders
  $pb.Item(-3).LineStyle = 1                                # wdBorderBottom, single
  (Para $rules 2).Select()
  Pic 'b-3' $A
  $ssplit = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::SplitButton))) | Where-Object { $_.Current.Name -eq 'Shading' } | Select-Object -First 1
  $sarrow = $ssplit.FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'More Options')))
  Pct 'shadingArrow' 'b-3' (Box $sarrow)
  $menu = OpenMenu $sarrow
  if ($menu -ne [IntPtr]::Zero) {
    DumpWin $menu 'shadingmenu'
    Pic 'b-4' $A $h $menu
    $gold = $AE::FromHandle($menu).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition) | Where-Object { $_.Current.Name -match 'Gold.*Lighter 80%|Orange.*Lighter 80%' } | Select-Object -First 1
    if ($gold) { "  shade: $($gold.Current.Name)"; Pct 'lightShade' 'b-4' (BoxIn $gold $h) }
    [Shot]::PostKey($menu, 0x1B); Start-Sleep -Milliseconds 800
  }
  (Para $rules 2).ParagraphFormat.Shading.BackgroundPatternColor = 0xCCF2FF   # Gold, Accent 4, Lighter 80% (FFF2CC)
  $rules.Range(0, 0).Select()
  Pic 'b-5' $A

  # 6. Line spacing menu (a picture for the text).
  $rules.Range((Para $rules 3).Start + 5, (Para $rules 3).Start + 5).Select()
  try {
    $menu = OpenMenu (Ctl @('Line and Paragraph Spacing'))
    if ($menu -ne [IntPtr]::Zero) { DumpWin $menu 'spacingmenu'; Pic 'l-1' $A $h $menu; [Shot]::PostKey($menu, 0x1B); Start-Sleep -Milliseconds 800 }
  } catch { "spacing menu failed: $_" }

  # The done-right copy (what the upload asks for): also 'never' bold.
  (Words $rules 6 'never').Font.Bold = $true
  SaveModel $rules 'Lab rules done.docx'
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
