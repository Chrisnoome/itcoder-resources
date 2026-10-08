# Real Word 365 screens for catword lesson 5, 'lists' (content/catword/lists.php,
# 8 October 2026). Gogo Dlamini's scones: Bullets,
# Sort, Numbering and a second list level (Tab), and a price list lined up
# with a right tab stop and dot leaders (the Tabs dialog box). Also makes the
# starter file (Scones.docx, in C:\sims\files\catword-lists\ and
# G:\My Drive\CAT\Word\) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-lists
$Name = 'catword-lists'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $deg = [string][char]0xB0
  $lines = @(
    'Gogo''s scones',
    'Ingredients',
    'Self-raising flour, 3 cups',
    'Butter, 125 g',
    'Milk, 1 cup',
    'Eggs, 2',
    'Sugar, 2 tablespoons',
    'Method',
    "Heat the oven to 200 $($deg)C.",
    'Rub the butter into the flour.',
    'Beat the eggs and the milk together.',
    'Keep 2 tablespoons aside to brush on top.',
    'Mix the rest into the flour to make a soft dough.',
    'Cut out the scones and bake for 12 to 15 minutes.',
    'Church market prices',
    "Scones`tR5 each",
    "Strawberry jam`tR30 a jar",
    "Tea or coffee`tR10 a cup"
  )
  $recipe = NewDoc $lines

  $word.Visible = $true
  WordWindow
  SaveForPupils $recipe 'Scones.docx'
  Dump 'home'

  # 1. Bullets for the ingredients.
  $recipe.Range((Para $recipe 3).Start, (Para $recipe 7).End).Select()
  Pic 'l-1' $A
  $bsplit = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::SplitButton))) | Where-Object { $_.Current.Name -eq 'Bullets' } | Select-Object -First 1
  $barrow = $bsplit.FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'More Options')))
  Pct 'bulletsArrow' 'l-1' (Box $barrow)
  Pct 'bulletsBtn'   'l-1' (Box (Ctl @('Bullets') $T::Button))
  Pct 'numberingBtn' 'l-1' (Box (Ctl @('Numbering') $T::Button))
  Pct 'sortBtn'      'l-1' (Box (Ctl @('Sort...')))
  # (The Bullet Library is a menu that PrintWindow and UI Automation do not reach here: the Bullets button itself.)
  if (-not $recipe.Range((Para $recipe 3).Start, (Para $recipe 7).End).ListFormat.ListType) {
    $recipe.Range((Para $recipe 3).Start, (Para $recipe 7).End).ListFormat.ApplyBulletDefault()
  }
  $recipe.Range((Para $recipe 3).Start, (Para $recipe 7).End).Select()
  Pic 'l-3' $A

  # 2. Sort the ingredients A to Z (Sort Text dialog box, OK).
  Pic 'o-1' $A
  Pct 'sortBtn' 'o-1' (Box (Ctl @('Sort...')))
  # Word's dialog boxes show little to UI Automation: pictured, closed, and the job done through COM;
  # targets are read off the pictures.
  $dlg = OpenDialog (Ctl @('Sort...'))
  DumpWin $dlg 'sortdlg'
  Pic 'o-2' $null $dlg
  CloseDialog $dlg
  $recipe.Range((Para $recipe 3).Start, (Para $recipe 7).End).Sort()
  "sorted: " + ((3..7 | ForEach-Object { (Para $recipe $_).Text.Trim() }) -join ' / ')
  $recipe.Range((Para $recipe 3).Start, (Para $recipe 7).End).Select()
  Pic 'o-3' $A

  # 3. Numbering for the method, then a second level (Tab) for the step that belongs to the one above it.
  $recipe.Range((Para $recipe 9).Start, (Para $recipe 14).End).Select()
  Pic 'n-1' $A
  Pct 'numberingBtn' 'n-1' (Box (Ctl @('Numbering') $T::Button))
  $recipe.Range((Para $recipe 9).Start, (Para $recipe 14).End).ListFormat.ApplyNumberDefault()
  Pic 'n-2' $A
  $p12 = Para $recipe 12
  Pct 'keepLine' 'n-2' (TextBox ($recipe.Range($p12.Start, $p12.Start + 2)))
  $recipe.Range($p12.Start, $p12.Start).Select()
  Pic 'n-3' $A
  (Para $recipe 12).ListFormat.ListIndent()                       # what Tab at the start of the item does: one level in
  $recipe.Range((Para $recipe 12).Start, (Para $recipe 12).Start).Select()
  Pic 'n-4' $A

  # 4. The price list: a right tab stop at 10 cm with dot leaders - Paragraph dialog box > Tabs.
  $recipe.Range((Para $recipe 16).Start, (Para $recipe 18).End).Select()
  $word.ActiveWindow.View.ShowAll = $true
  Pic 'x-1' $A
  $word.ActiveWindow.View.ShowAll = $false
  Pic 't-1' $A
  Pct 'paraLauncher' 't-1' (Box (Ctl @('Paragraph...')))
  $pdlg = OpenDialog (Ctl @('Paragraph...'))
  Pic 't-2' $null $pdlg
  CloseDialog $pdlg
  $prices = $recipe.Range((Para $recipe 16).Start, (Para $recipe 18).End)
  $prices.Select()
  $tdlg = ShowWordDialog 179                                # wdDialogFormatTabs
  DumpWin $tdlg 'tabsdlg'
  Pic 't-3' $null $tdlg
  CloseDialog $tdlg
  [void]$prices.ParagraphFormat.TabStops.Add($word.CentimetersToPoints(10), 0, 0)     # 10 cm, left, no leader: as typed
  $prices.Select()
  $tdlg = ShowWordDialog 179
  Pic 't-4' $null $tdlg
  CloseDialog $tdlg
  $prices.ParagraphFormat.TabStops.ClearAll()
  [void]$prices.ParagraphFormat.TabStops.Add($word.CentimetersToPoints(10), 2, 0)     # right
  $prices.Select()
  $tdlg = ShowWordDialog 179
  Pic 't-5' $null $tdlg
  CloseDialog $tdlg
  $prices.ParagraphFormat.TabStops.ClearAll()
  $prices.Select()
  $prices = $recipe.Range((Para $recipe 16).Start, (Para $recipe 18).End)
  [void]$prices.ParagraphFormat.TabStops.Add($word.CentimetersToPoints(10), 2, 1)   # right, dots
  $prices.Select()
  try { $tdlg = ShowWordDialog 179; Pic 't-6' $null $tdlg; CloseDialog $tdlg } catch { "t-6: $_" }
  $recipe.Range(0, 0).Select()
  $word.ActiveWindow.ScrollIntoView((Para $recipe 15), $true)
  Pic 't-7' $A
  $word.ActiveWindow.DisplayRulers = $true
  $prices.Select()
  Pic 't-8' $A
  $word.ActiveWindow.DisplayRulers = $false

  # The done-right copy: also the title in Heading 1.
  (Para $recipe 1).Style = -2
  SaveModel $recipe 'Scones done.docx'
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
