# Real Word 365 screens for catword lesson 13, 'multilevel' (content/catword/multilevel.php,
# Grade 11, 9 October 2026). The Grade 11 Science Expo rules: Define New Bullet
# (the Bullets arrow), Set Numbering Value (a number's right-click menu), the
# Define New Number Format box, a heading-linked multilevel list (Multilevel List),
# and a drop cap (Insert > Drop Cap > Dropped). Also makes the upload's starter
# file (Science expo.docx, in C:\sims\files\catword-multilevel\ and G:\My
# Drive\CAT\Word\) and the done-right copy (Science expo done.docx).
#     pwsh -File vm-shots.ps1 catword-multilevel
$Name = 'catword-multilevel'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')

$lines = @(
  'Grade 11 Science Expo',
  'Every Grade 11 pupil enters one project in the expo on 14 August. Projects are judged in the school hall, and the best three go on to the district expo in September. Read these rules before you start, and keep them with your project.',
  'Entering',
  'Who may enter',
  'Every Grade 11 pupil enters one project, alone or with one partner.',
  'What to hand in',
  'A project file, a poster and a working model or a display.',
  'On the day',
  'What to bring',
  'An extension cord',
  'Prestik and scissors',
  'Your project file',
  'Judging',
  'The judges look at four things:',
  'The question you asked',
  'How you tested it',
  'What you found',
  'How well you explain it',
  ''
)
$h1 = 3, 8, 13
$h2 = 4, 6, 9

function Sub ($a, $b) { $doc.Range((Para $doc $a).Start, (Para $doc $b).End) }
function FindIt ($like) { foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like $like) { return $p.Range } }; throw "no paragraph like $like" }
function At ($n, $k = 3) { $doc.Range((Para $doc $n).Start + $k, (Para $doc $n).Start + $k).Select() }

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  $doc.ShowGrammaticalErrors = $false; $doc.ShowSpellingErrors = $false
  (Para $doc 1).Style = -63
  foreach ($i in $h1) { (Para $doc $i).Style = -2 }
  foreach ($i in $h2) { (Para $doc $i).Style = -3 }
  (Sub 15 18).ListFormat.ApplyNumberDefault()
  $word.Visible = $true
  WordWindow
  Fresh
  SaveDoc $doc 'Science expo.docx' $true
  Dump 'home'

  # ---- 1. Define New Bullet: the Bullets arrow > Define New Bullet... > the box (Font... for the colour)
  (Sub 10 12).ListFormat.ApplyBulletDefault()
  (Sub 10 12).Select()
  Show (Para $doc 8)
  P 'b-1' $A
  $bul = Ctl @('Bullets') $T::SplitButton
  $arrow = $null
  foreach ($e in $bul.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -eq 'More Options') { $arrow = $e } } catch { } }
  if ($arrow) { Pct 'bulletArrow' 'b-1' (Box $arrow) } else { $bb = Box $bul; Pct 'bulletArrow' 'b-1' @(($bb[0] + 30), $bb[1], 19, $bb[3]) }
  try {
    $menu = OpenMenu $bul
    if ($menu -eq [IntPtr]::Zero -and $arrow) { $menu = OpenMenu $arrow }
    DumpMenu $menu 'bulletmenu'
    P 'b-2' $A $h $menu
    $def = FindAny $menu @('Define New Bullet...', 'Define New Bullet')
    Pct 'defineBullet' 'b-2' (BoxIn $def $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($def)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1500
      DumpWin $dlg 'definebullet'
      P 'b-3' $null $dlg
      [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
    } else { '  NO Define New Bullet box'; Esc $menu }
  } catch { "  bullet menu: $_"; Esc $null }
  Fresh
  # the custom bullet: a maroon tick (Wingdings 252)
  Retry { (Sub 10 12).ListFormat.ApplyBulletDefault() } | Out-Null
  if (-not (Sub 10 12).ListFormat.ListType) { (Sub 10 12).ListFormat.ApplyBulletDefault() }
  $lt = (Sub 10 12).ListFormat.ListTemplate
  $lv = $lt.ListLevels.Item(1)
  $lv.NumberFormat = [string][char]0xF0FC
  $lv.Font.Name = 'Wingdings'
  $lv.Font.Color = 128                                              # maroon: 800000 (BGR 0x000080)
  (Sub 10 12).ListFormat.ApplyListTemplate($lt, $false)
  At 13 0
  Show (Para $doc 8)
  P 'b-4' $A

  # ---- 2. Set Numbering Value: right-click the number 1 of the judging list > Set Numbering Value... > 5
  Show (Para $doc 13)
  At 15 0
  P 's-1' $A
  $tb = TextBox ((Para $doc 15).Duplicate)
  $num = @(($tb[0] - 40), $tb[1], 34, $tb[3])                     # the number hangs left of the text
  Pct 'number' 's-1' $num
  $menu = DocMenu
  "  number menu window: $menu"
  DumpMenu $menu 'numbermenu'
  P 's-2' $A $h $menu
  try {
    $set = FindAny $menu @('Set Numbering Value...', 'Set Numbering Value')
    Pct 'setValue' 's-2' (BoxIn $set $h)
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($set)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) {
      Start-Sleep -Milliseconds 1500
      DumpWin $dlg 'setvalue'
      P 's-3' $null $dlg
      [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500
    } else { '  NO Set Numbering Value box'; Esc $menu }
  } catch { "  numbering menu: $_"; Esc $menu }
  Fresh
  $lt2 = (Sub 15 18).ListFormat.ListTemplate
  $lt2.ListLevels.Item(1).StartAt = 5
  (Sub 15 18).ListFormat.ApplyListTemplate($lt2, $false)
  At 14 0
  Show (Para $doc 13)
  P 's-4' $A

  # The Define New Number Format box (a figure): the Numbering arrow's menu
  try {
    $numb = Ctl @('Numbering') $T::SplitButton
    At 16 2
    $menu = OpenMenu $numb
    DumpMenu $menu 'numberingmenu'
    P 'nf-0' $A $h $menu
    $def = FindAny $menu @('Define New Number Format...', 'Define New Number Format')
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($def)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; DumpWin $dlg 'numberformat'; P 'nf-1' $null $dlg; [void][K11]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero); Start-Sleep -Milliseconds 1500 }
    else { Esc $menu }
  } catch { "  number format: $_"; Esc $null }
  Fresh

  # ---- 3. A multilevel list linked to the headings: Multilevel List > the 1 / 1.1 heading list
  At 3 2
  Show $doc.Range(0, 0)
  P 'm-1' $A
  $ml = Ctl @('Multilevel List')
  Pct 'multilevel' 'm-1' (Box $ml)
  $applied = $false
  try {
    $menu = OpenMenu $ml
    DumpMenu $menu 'multimenu'
    P 'm-2' $A $h $menu
    $pick = $null
    foreach ($r in @($AE::FromHandle($menu), $AE::RootElement)) {
      foreach ($e in $r.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) {
        try { $nm = $e.Current.Name; if (-not $e.Current.IsOffscreen -and $nm -match 'Number Format: 1, Aligned at:\s+0 cm, Indent at:\s+0\.76') { $pick = $e; break } } catch { }
      }
      if ($pick) { break }
    }
    if ($pick) { "  list item: $($pick.Current.Name)"; Pct 'headingList' 'm-2' (BoxIn $pick $h); [Later]::Invoke($pick); Start-Sleep -Milliseconds 2500; $applied = $true }
    else { '  MISSING heading list'; Esc $menu }
  } catch { "  multilevel menu: $_"; Esc $null }
  Fresh
  "  Heading 1 numbered: $((Para $doc 3).Range.ListFormat.ListString) / Heading 2: $((Para $doc 4).Range.ListFormat.ListString)"
  At 3 2
  Show $doc.Range(0, 0)
  P 'm-3' $A

  # ---- 4. A drop cap on the opening paragraph: Insert > Drop Cap > Dropped
  At 2 5
  Tab 'Home'
  P 'd-1' $F
  Pct 'insertTab' 'd-1' (Box (Ctl @('Insert') $T::TabItem))
  Tab 'Insert'
  Dump 'insert'
  P 'd-2' $F
  $dc = Ctl @('Drop Cap')
  Pct 'dropCap' 'd-2' (Box $dc)
  try {
    $menu = OpenMenu $dc
    DumpMenu $menu 'dropmenu'
    P 'd-3' $F $h $menu
    $dropped = FindAny $menu @('Dropped')
    Pct 'dropped' 'd-3' (BoxIn $dropped $h)
    try { Pct 'options' 'd-3' (BoxIn (FindAny $menu @('Drop Cap Options...')) $h) } catch { }
    [Later]::Invoke($dropped); Start-Sleep -Milliseconds 2500
  } catch { "  drop cap menu: $_"; Esc $null }
  Fresh
  if ($doc.Paragraphs.Item(2).DropCap.Position -eq 0) { '  drop cap by COM'; $doc.Paragraphs.Item(2).DropCap.Position = 1; $doc.Paragraphs.Item(2).DropCap.LinesToDrop = 3 }
  $e1 = FindIt 'Entering*'
  $doc.Range($e1.Start, $e1.Start).Select()
  Show $doc.Range(0, 0)
  P 'd-4' $F

  # ---- 5. The done-right copy
  foreach ($p in $doc.Paragraphs) { "  [$($p.Style.NameLocal)] [$($p.Range.ListFormat.ListString)] $($p.Range.Text.Trim())" }
  SaveDoc $doc 'Science expo done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
