# Real Word 365 screens for the CAT pilot's Word lesson (content/catpilot/
# word.php - Chris, 5 October 2026). A Market Day notice; each picture is one
# moment of a task, and out\cat-word.json says where the words and buttons
# are (window pixels). Read office-kit.ps1's safety rules first: hands off the
# keyboard and mouse while it runs (about a minute).
#     powershell -ExecutionPolicy Bypass -File cat-word.ps1
# Then: python cat-crop.py cat-word
$Name = 'cat-word'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$word = New-Object -ComObject Word.Application
$doc  = $null
try {
  $word.DisplayAlerts = 0
  $doc = $word.Documents.Add()
  $text = @(
    'Market Day',
    'Friday 14 November, 10:00 to 13:00',
    'Grade 10 is running a market day to raise money for the matric farewell. Entry is free, and everyone is welcome. There will be food, games and a raffle, and the school band will play at twelve.',
    'Cupcakes',
    'Boerewors rolls',
    'Lemonade',
    'Bring cash or a card. Every stall takes cards.',
    'Stall holders: set up by 09:30 and take everything home at 13:30.'
  ) -join "`r"
  $doc.Content.Text = $text
  # Only Word's own styles in the gallery (Chris's Normal template adds its own, like "MC Option").
  foreach ($style in $doc.Styles) { try { if ($style.QuickStyle -and -not $style.BuiltIn) { $style.QuickStyle = $false } } catch { } }
  $p = { param($n) $doc.Paragraphs.Item($n).Range }

  $word.Visible = $true
  $word.WindowState = 0                                    # wdWindowStateNormal
  $h = [IntPtr]$word.ActiveWindow.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 720)   # sized twice: the ribbon lays itself out again at the full width
  $word.ActiveWindow.View.Type = 3                         # wdPrintView
  $word.ActiveWindow.View.Zoom.Percentage = 100
  $word.ActiveWindow.DisplayRulers = $false
  $doc.Range(0, 0).Select()
  $word.ActiveWindow.ScrollIntoView($doc.Range(0, 0), $true)
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  # Where a piece of text is on the picture (window pixels).
  function TextBox ($range) {
    $l = 0; $t = 0; $w = 0; $ht = 0
    $word.ActiveWindow.GetPoint([ref]$l, [ref]$t, [ref]$w, [ref]$ht, $range)
    $win = [WinRect]::Of($h)
    return @(($l - $win[0]), ($t - $win[1]), $w, $ht)
  }
  function WordRange ($para, $find) {
    $r = & $p $para
    $i = $r.Text.IndexOf($find)
    return $doc.Range($r.Start + $i, $r.Start + $i + $find.Length)
  }

  Dump 'home'
  Mark 'title'  (TextBox ((& $p 1).Duplicate))
  $tile = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -like '*Heading 1' } | Select-Object -First 1
  if ($tile) { Mark 'heading1' (Box $tile) } else { '  MISSING heading1' }
  TryMark 'center'   $root @('Center', 'Centre')
  TryMark 'bullets'  $root @('Bullets')
  TryMark 'tabInsert' $root @('Insert') $T::TabItem
  TryMark 'tabHome'   $root @('Home') $T::TabItem

  # 1. The title as Heading 1.
  $doc.Range((& $p 8).End - 1, (& $p 8).End - 1).Select(); Snap 'h-1'   # the cursor at the end
  $doc.Range(3, 3).Select();                         Snap 'h-2'   # clicked in the title
  (& $p 1).Style = -2                                              # wdStyleHeading1
  Snap 'h-3'
  Mark 'date'   (TextBox ((& $p 2).Duplicate))                   # where the date is after the heading grew

  # 2. Centre the date line.
  $doc.Range((& $p 2).Start + 4, (& $p 2).Start + 4).Select(); Snap 'c-1'
  (& $p 2).ParagraphFormat.Alignment = 1                           # wdAlignParagraphCenter
  Snap 'c-2'
  Mark 'free'   (TextBox (WordRange 3 'free'))

  # 3. Bold one word: double-click it, then Ctrl+B.
  (WordRange 3 'free').Select();                    Snap 'b-1'   # the word selected
  (WordRange 3 'free').Font.Bold = $true;           Snap 'b-2'

  # 4. A bulleted list.
  $doc.Range((& $p 4).Start, (& $p 6).End - 1).Select(); Snap 'l-1'
  $doc.Range((& $p 4).Start, (& $p 6).End).ListFormat.ApplyBulletDefault()
  Snap 'l-2'
  Mark 'stall'  (TextBox (WordRange 8 'Stall'))

  # 5. A page break before the last paragraph, from the Insert tab.
  $s = (& $p 8).Start
  $doc.Range($s, $s).Select();                      Snap 'p-1'   # clicked before "Stall"
  Press (Find $root @('Insert') $T::TabItem)
  Start-Sleep -Milliseconds 900
  TryMark 'pageBreak' $root @('Page Break')
  Dump 'insert'
  Snap 'p-2'                                                       # the Insert tab
  $doc.Range($s, $s).InsertBreak(7)                                # wdPageBreak
  Start-Sleep -Milliseconds 600
  Snap 'p-3'
  Press (Find $root @('Home') $T::TabItem)

  SaveMarks
}
catch {
  "FAILED: $_"
  throw
}
finally {
  if ($doc) { try { $doc.Saved = $true; $doc.Close() } catch { } }
  $word.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
