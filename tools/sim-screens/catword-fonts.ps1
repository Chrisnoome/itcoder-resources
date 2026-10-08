# Real Word 365 screens for catword lesson 3, 'fonts' (content/catword/fonts.php,
# 8 October 2026). Mr Botha's weekend specials: the font and size boxes, Font
# Color and Text Highlight Color, the Font dialog box (Small caps),
# strikethrough, superscript, Change Case and the Format Painter. Also makes
# the starter file (Specials.docx, in C:\sims\files\catword-fonts\ and
# G:\My Drive\CAT\Word\) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-fonts
$Name = 'catword-fonts'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $lines = @(
    'Botha''s Bakery',
    'Weekend specials',
    'Chelsea buns: 6 for R45 (was R60)',
    'Koeksisters: 12 for R50',
    'Milk tart: a whole tart for R95',
    'Celebrating our 25th birthday!',
    'PLEASE ORDER BY THURSDAY.',
    'Phone 012 345 6789 or WhatsApp us.'
  )
  $flyer = NewDoc $lines
  $buns = Words $flyer 3 'Chelsea buns'
  $buns.Font.Bold = $true
  $buns.Font.Color = 0x0000C0              # Dark Red (C00000) - Word colours are BGR

  $word.Visible = $true
  WordWindow
  SaveForPupils $flyer 'Specials.docx'
  Dump 'home'

  # 1. The title: Font box, Arial Black; Font Size box, 28.
  (Para $flyer 1).Select()
  $word.Selection.MoveEnd(1, -1) | Out-Null           # the words, not the paragraph mark
  Pic 'f-1' $A
  Pct 'fontBox' 'f-1' (Box (Ctl @('Font') $T::Edit))
  Pct 'sizeBox' 'f-1' (Box (Ctl @('Font Size') $T::Edit))
  $word.Selection.Font.Name = 'Arial Black'
  Pic 'f-2' $A
  Pct 'sizeBox' 'f-2' (Box (Ctl @('Font Size') $T::Edit))
  $word.Selection.Font.Size = 28
  Pic 'f-3' $A
  Pct 'growBtn' 'f-3' (Box (Ctl @('Grow Font')))

  # 2. Weekend specials: Font Color (red), then Text Highlight Color (yellow).
  $ws = Words $flyer 2 'Weekend specials'
  $ws.Select()
  Pic 'c-1' $A
  Pct 'fontColour' 'c-1' (Box (Ctl @('Font Color Red', 'Font Color')))
  Pct 'highlight'  'c-1' (Box (Ctl @('Text Highlight Color Yellow', 'Text Highlight Color')))
  $ws.Font.Color = 0x0000FF                            # Red (FF0000)
  Pic 'c-2' $A
  $ws.HighlightColorIndex = 7                          # wdYellow
  Pic 'c-3' $A

  # 3. The Font dialog box: Small caps for Weekend specials.
  Pct 'fontLauncher' 'c-3' (Box (Ctl @('Font...')))
  # Word's dialog boxes show little to UI Automation, so each state is set through COM and the box opened
  # again to picture it (the box shows the selection's formatting); targets are read off the pictures.
  $dlg = OpenDialog (Ctl @('Font...'))
  DumpWin $dlg 'fontdlg'
  Pic 'd-1' $null $dlg
  CloseDialog $dlg
  $ws.Font.SmallCaps = $true
  $dlg = OpenDialog (Ctl @('Font...'))
  Pic 'd-2' $null $dlg
  CloseDialog $dlg
  "small caps now: $($ws.Font.SmallCaps)"
  Pic 'd-3' $A

  # 4. The old price: Strikethrough. 25th: Superscript.
  $old = Words $flyer 3 'R60'
  $old.Select();                Pic 's-1' $A
  Pct 'strike' 's-1' (Box (Ctl @('Strikethrough')))
  Pct 'super'  's-1' (Box (Ctl @('Superscript')))
  Pct 'sub'    's-1' (Box (Ctl @('Subscript')))
  $old.Font.StrikeThrough = $true
  $th = Words $flyer 6 'th'
  $th.Select();                 Pic 's-2' $A
  $th.Font.Superscript = $true
  $flyer.Range((Para $flyer 6).End - 1, (Para $flyer 6).End - 1).Select()
  Pic 's-3' $A

  # 5. Change Case: the menu, Sentence case.
  $shout = Para $flyer 7
  $flyer.Range($shout.Start, $shout.End - 1).Select()
  Pic 'k-1' $A
  $cc = Ctl @('Change Case')
  Pct 'changeCase' 'k-1' (Box $cc)
  try {
    $menu = OpenMenu $cc
    if ($menu -ne [IntPtr]::Zero) {
      DumpWin $menu 'casemenu'
      Pic 'k-2' $A $h $menu
      Pct 'sentenceCase' 'k-2' (BoxIn (FindIn $menu @('Sentence case.')) $h)
      [Shot]::PostKey($menu, 0x1B); Start-Sleep -Milliseconds 800
    }
  } catch { "change case menu failed: $_" }
  $word.Selection.Range.Case = 4                       # wdTitleSentence: Sentence case
  "case now: " + $word.Selection.Range.Text
  Pic 'k-3' $A

  # 6. The Format Painter: Chelsea buns' look onto Koeksisters.
  $flyer.Range($buns.Start + 2, $buns.Start + 2).Select()
  Pic 'g-1' $A
  Pct 'painter' 'g-1' (Box (Ctl @('Format Painter')))
  $k = Words $flyer 4 'Koeksisters'
  $kb = TextBox $k
  Press (Ctl @('Format Painter')); Start-Sleep -Milliseconds 800
  Pic 'g-2' $A
  Pct 'koek' 'g-2' $kb
  try { [Shot]::PostKey($h, 0x1B) } catch { }
  $k.Font.Bold = $true; $k.Font.Color = 0x0000C0
  $flyer.Range($k.End, $k.End).Select()
  Pic 'g-3' $A

  # The done-right copy: also Sentence case fixed (Thursday), the phone line in italics, Milk tart underlined.
  $shout = Para $flyer 7
  $flyer.Range($shout.Start, $shout.End - 1).Text = 'Please order by Thursday.'
  (Para $flyer 8).Font.Italic = $true
  $mt = Para $flyer 5; $flyer.Range($mt.Start, $mt.End - 1).Font.Underline = 1
  SaveModel $flyer 'Specials done.docx'
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
