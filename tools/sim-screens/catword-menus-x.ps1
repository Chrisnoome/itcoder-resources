# Real Word 365 screens of the menus the first runs could not picture (9 October
# 2026, the last CAT practical gaps), taken with the VM's REAL mouse and keyboard
# and grabbed FROM THE SCREEN (work\catword-real-kit.ps1: ScreenPic, cropped below
# the title bar). The parts and documents are catword-real10.ps1's (whose pictures
# were lost before they came back), plus Grade 12's Language and Translate menus:
#   fonts       - Change Case > Sentence case.                  -> catword-fonts-cc-<n>
#   paragraphs  - Line and Paragraph Spacing > 1.5               -> catword-paragraphs-ls-<n>
#                 Shading arrow > Gold, Accent 4, Lighter 80%    -> catword-paragraphs-sh-<n>
#   lists       - the Bullets arrow > the Bullet Library's tick   -> catword-lists-bl-<n>
#   pagination  - Review > Language > Set Proofing Language...   -> catword-pagination-lg-<n>
#                 Review > Translate > Translate Selection       -> catword-pagination-tr-<n>
# Each part has a document of its own and is tried on its own. Nothing saved.
#     pwsh -File vm-shots.ps1 catword-menus-x -TimeoutSec 1200
$Name = 'catword-menus-x'
$Only = @('paragraphs')     # the parts this run takes (fonts and lists came on run 1)
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-real-kit.ps1')

$G = @(8, 56, 1290, 656)        # lessons 1-5's crop: the ribbon, the page, the left of the status bar
$P = @(8, 56, 1734, 656)        # pagination's crop (the window's edge left out)

# NB: not $name - PowerShell's names ignore case, and a $name here overwrote the script's $Name, so the
# pictures were saved as <part>-<n>.png and never came back (as catword-real10's did).
function Part ([string]$partName, [scriptblock]$sb) {
  if ($Only -and $partName -notin $Only) { return }
  Trace "part $partName"; "==== $partName"
  try { & $sb } catch { "PART $partName FAILED: $_"; $_.ScriptStackTrace; try { RKeys 'esc'; RKeys 'esc' } catch { }; CloseAll }
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  Start-Sleep -Milliseconds 800
}
function Win { WordWindow; Front }
function ArrowOf ($el, [double]$part = 0.3) { $b = BoxIn $el $h; return @(([int]($b[0] + $b[2] * (1 - $part))), $b[1], ([int]($b[2] * $part)), $b[3]) }
function ClickBox ($b) { RClick ([int]($b[0] + $b[2] / 2)) ([int]($b[1] + $b[3] / 2)) }
function Split ($name) { foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, $name)))) { try { if ($e.Current.ControlType -eq $T::SplitButton -and -not $e.Current.IsOffscreen) { return $e } } catch { } }; return (Ctl @($name)) }

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  try { $script:oldLocal = $word.Options.UseLocalUserInfo; $word.Options.UseLocalUserInfo = $true } catch { }

  Part 'fonts' {
    $f = NewDoc @("Botha's Bakery", 'Weekend specials', 'Chelsea buns: 6 for R45 (was R60)', 'Koeksisters: 12 for R50',
      'Milk tart: a whole tart for R95', 'Celebrating our 25th birthday!', 'PLEASE ORDER BY THURSDAY.', 'Phone 012 345 6789 or WhatsApp us.')
    $b = Words $f 3 'Chelsea buns'; $b.Font.Bold = $true; $b.Font.Color = 0x0000C0
    $ttl = Para $f 1; $ttl.Font.Name = 'Arial Black'; $ttl.Font.Size = 28
    $ws = Words $f 2 'Weekend specials'; $ws.Font.Color = 0x0000FF; $ws.HighlightColorIndex = 7; $ws.Font.SmallCaps = $true
    (Words $f 3 'R60').Font.StrikeThrough = $true; (Words $f 6 'th').Font.Superscript = $true
    $word.Visible = $true
    Win
    $s = Para $f 7; $f.Range($s.Start, $s.End - 1).Select()
    ScreenPic 'cc-1' $G
    $cc = Ctl @('Change Case')
    Pct 'changeCase' 'cc-1' (BoxIn $cc $h)
    RClickEl $cc
    ScreenPic 'cc-2' $G
    DumpScreen 'cc-2menu' 'case|CASE'
    $sc = OnScreen '^Sentence case'
    if (-not $sc) { throw 'no Sentence case.' }
    Pct 'sentence' 'cc-2' (BoxIn $sc $h)
    RClickEl $sc
    ScreenPic 'cc-3' $G
    "  line 7 now: $((Para $f 7).Text)"
  }

  Part 'paragraphs' {
    $p = NewDoc @('Computer Lab Rules', 'Phumlani Secondary School, Room 14',
      'The computer lab is shared by more than 400 pupils. These rules keep the computers working and make the lab a good place to learn. Read them before your first lesson, and keep to them every time you are here.',
      'No food or drinks near the computers.', 'Log off when you leave.', 'Save your work in the cloud, never on the desktop.', 'Report any damage to Ms Naidoo at once.', 'Updated: 8 October 2026')
    (Para $p 1).Style = -63; (Para $p 1).ParagraphFormat.Alignment = 1; (Para $p 2).ParagraphFormat.Alignment = 1
    (Para $p 3).ParagraphFormat.Alignment = 3; (Para $p 8).ParagraphFormat.Alignment = 2
    $rules = $p.Range((Para $p 4).Start, (Para $p 7).End); $rules.ParagraphFormat.LeftIndent = $word.CentimetersToPoints(1); $rules.ParagraphFormat.SpaceAfter = 6
    $word.Visible = $true
    Win
    $p.Range((Para $p 3).Start + 5, (Para $p 3).Start + 5).Select()
    ScreenPic 'ls-1' $G
    $ls = Ctl @('Line and Paragraph Spacing')
    Pct 'lineSpacing' 'ls-1' (BoxIn $ls $h)
    RClickEl $ls
    ScreenPic 'ls-2' $G
    DumpScreen 'ls-2menu' '^[0-9]|Spacing|Line'
    $one5 = OnScreen '^1\.5$'
    if (-not $one5) { throw 'no 1.5' }
    Pct 'one5' 'ls-2' (BoxIn $one5 $h)
    RClickEl $one5
    ScreenPic 'ls-3' $G
    "  line spacing now: $((Para $p 3).LineSpacing)"
    $nm = Para $p 2
    $nm.Borders.Item(-3).LineStyle = 1                                # wdBorderBottom
    $nm.Select()                                                     # the whole paragraph, its mark too: shading from margin to margin
    ScreenPic 'sh-1' $G
    $sh = Split 'Shading'
    $arrow = ArrowOf $sh
    Pct 'shadingArrow' 'sh-1' $arrow
    ClickBox $arrow
    ScreenPic 'sh-2' $G
    DumpScreen 'sh-2menu' 'Accent 4|No Color'
    $gold = OnScreen 'Accent 4, Lighter 80%$'
    if (-not $gold) { throw 'no Accent 4, Lighter 80%' }
    "  shading item: $($gold.Current.Name)"
    Pct 'gold80' 'sh-2' (BoxIn $gold $h)
    RClickEl $gold
    $p.Range(0, 0).Select()
    ScreenPic 'sh-3' $G
    "  shading now: $($nm.Shading.BackgroundPatternColor)"
  }

  Part 'lists' {
    $l = NewDoc @("Gogo's scones", 'Ingredients', 'Self-raising flour, 3 cups', 'Butter, 125 g', 'Milk, 1 cup', 'Eggs, 2', 'Sugar, 2 tablespoons', 'Method', 'Heat the oven to 200 °C.')
    (Para $l 1).Style = -2
    $word.Visible = $true
    Win
    $l.Range((Para $l 3).Start, (Para $l 7).End).Select()
    ScreenPic 'bl-1' $G
    $bl = Split 'Bullets'
    $arrow = ArrowOf $bl 0.35
    Pct 'bulletsArrow' 'bl-1' $arrow
    ClickBox $arrow
    ScreenPic 'bl-2' $G
    DumpScreen 'bl-2menu' '.'
    $tick = $null
    foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) {
      try { $n = $e.Current.Name; if (-not $e.Current.IsOffscreen -and ($n -match '✓|✔|check|tick|ü')) { $tick = $e; break } } catch { }
    }
    if (-not $tick) { throw 'no tick in the Bullet Library (see bl-2menu)' }
    "  tick: $($tick.Current.Name)"
    Pct 'tick' 'bl-2' (BoxIn $tick $h)
    RClickEl $tick
    $l.Range(0, 0).Select()
    ScreenPic 'bl-3' $G
  }

  Part 'pagination' {
    $g = NewDoc @('Saving water at Phumlani Secondary', 'A PAT report by Thabo Mokoena, Grade 12', 'Introduction',
      'Phumlani Secondary pays for every litre of water it uses. This report asks how the school could use less, and what each pupil can do to help.',
      'The school uses about 18 000 litres on a school day and about 2 000 litres on a weekend day. Flushing uses 60% of the water, the taps 25%, the garden 10% and cleaning 5%.',
      'Recommendations', 'Fix the leaking cisterns first: it costs little and saves the most.')
    (Para $g 1).Style = -63
    foreach ($i in 3, 6) { (Para $g $i).Style = -2 }
    $g.Content.LanguageID = 1033                                     # English (United States), as the lesson's starter
    $word.Visible = $true
    Win
    $g.Content.Select()
    Tab 'Review'; Front
    ScreenPic 'lg-1' $P
    # At this width the Language group is folded into one button: it opens a panel with Translate and Language.
    $grp = Ctl @('Language')
    Pct 'languageGroup' 'lg-1' (BoxIn $grp $h)
    RClickEl $grp
    ScreenPic 'lg-2' $P
    $inner = $null
    foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Language')))) { try { if (-not $e.Current.IsOffscreen -and (BoxIn $e $h)[1] -gt 180) { $inner = $e } } catch { } }
    if (-not $inner) { throw 'no Language button in the folded group' }
    Pct 'language' 'lg-2' (BoxIn $inner $h)
    RClickEl $inner
    ScreenPic 'lg-3' $P
    DumpScreen 'lg-3menu' 'Language|Proofing'
    $set = OnScreen '^Set Proofing Language'
    if (-not $set) { throw 'no Set Proofing Language...' }
    Pct 'setProofing' 'lg-3' (BoxIn $set $h)
    RClickEl $set
    Start-Sleep -Milliseconds 1500
    ScreenPic 'lg-4' $P
    RKeys 'esc'; CloseAll

    # Translate: a sentence selected, Review > Translate > Translate Selection, the Translator pane.
    $s = Para $g 7; $g.Range($s.Start, $s.End - 1).Select()
    Front
    ScreenPic 'tr-1' $P
    Pct 'languageGroup' 'tr-1' (BoxIn (Ctl @('Language')) $h)
    $grp = Ctl @('Language')
    RClickEl $grp
    ScreenPic 'tr-2' $P
    $tr = $null
    foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Translate')))) { try { if (-not $e.Current.IsOffscreen -and (BoxIn $e $h)[1] -gt 180) { $tr = $e } } catch { } }
    if (-not $tr) { throw 'no Translate button in the folded group' }
    Pct 'translate' 'tr-2' (BoxIn $tr $h)
    RClickEl $tr
    ScreenPic 'tr-3' $P
    DumpScreen 'tr-3menu' 'Translat'
    $sel = OnScreen '^Translate Selection'
    if (-not $sel) { throw 'no Translate Selection' }
    Pct 'trSelection' 'tr-3' (BoxIn $sel $h)
    RClickEl $sel
    Start-Sleep -Milliseconds 6000
    ScreenPic 'tr-4' $P
    DumpScreen 'tr-4pane' 'Translat|Insert|From|To|Afrikaans|English'
    PaintScreenNames 'tr-4'
  }
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace }
finally {
  SavePct
  try { $word.Options.UseLocalUserInfo = $script:oldLocal } catch { }
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.NormalTemplate.Saved = $true } catch { }
  try { $word.Quit(0) } catch { }
  Start-Sleep 2
  Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
}
