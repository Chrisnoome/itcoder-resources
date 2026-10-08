# Real Word 365 screens for catword lesson 2, 'editing' (content/catword/editing.php,
# 8 October 2026). Ms Naidoo's letter about the Grade 10 CAT outing, typed with
# mistakes: select and delete a repeated sentence, undo a slip, move a
# paragraph with Cut and Paste, Find and Replace "Saturday" with "Friday", and
# the Symbol menu. Also makes the starter file (Trip letter.docx, in
# C:\sims\files\catword-editing\ and G:\My Drive\CAT\Word\) and a done-right copy.
#     pwsh -File vm-shots.ps1 catword-editing
$Name = 'catword-editing'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  $lines = @(
    'Phumlani Secondary School',
    'Grade 10 CAT outing to Sci-Bono',
    'Dear Parent',
    'On Saturday 6 November the Grade 10 CAT class will visit the Sci-Bono Discovery Centre in Newtown. The bus leaves the school at 08:00 on Saturday and is back by 14:00.',
    'Please sign the slip below and return it by Monday 2 November.',
    'The outing costs R85, which pays for the bus and the entry.',
    'Bring a packed lunch and water. Bring a packed lunch and water.',
    'Pupils may also buy lunch at the cafe in the centre on Saturday.',
    'Ms Naidoo, CAT teacher'
  )
  $letter = NewDoc $lines
  (Para $letter 1).Font.Bold = $true
  (Para $letter 2).Font.Bold = $true

  $word.Visible = $true
  WordWindow
  SaveForPupils $letter 'Trip letter.docx'
  $letter.Range(0, 0).Select()
  Dump 'home'
  Pic 'e-1' $A
  Pct 'cutBtn'     'e-1' (Box (Ctl @('Cut')))
  Pct 'copyBtn'    'e-1' (Box (Ctl @('Copy')))
  Pct 'pasteBtn'   'e-1' (Box (Ctl @('Paste') $T::Button))
  Pct 'replaceBtn' 'e-1' (Box (Ctl @('Replace...')))
  Pct 'findBtn'    'e-1' (Box (Ctl @('Find') $T::Button))
  for ($i = 1; $i -le 9; $i++) { Pct "para$i" 'e-1' (TextBox ((Para $letter $i).Duplicate)) }

  # 1. The repeated sentence: click before the second "Bring", Shift+End, Delete.
  $p7 = Para $letter 7
  $second = $p7.Text.LastIndexOf('Bring')
  $at = $p7.Start + $second
  $b = TextBox ($letter.Range($at, $at + 2))
  Pct 'secondBring' 'e-1' @(($b[0] - 8), ($b[1] - 2), ($b[2] + 10), ($b[3] + 4))
  $letter.Range($at, $at).Select();                       Pic 's-1' $A
  $letter.Range($at, (Para $letter 7).End - 1).Select();  Pic 's-2' $A
  $word.Selection.Delete() | Out-Null;                     Pic 's-3' $A

  # 2. A slip: the outing-costs paragraph deleted by mistake, then Undo.
  $slip = Para $letter 6
  $slip.Delete() | Out-Null
  $letter.Range((Para $letter 6).Start, (Para $letter 6).Start).Select()
  Pic 'u-1' $A
  $letter.Undo() | Out-Null
  $letter.Range((Para $letter 6).Start, (Para $letter 6).Start).Select()
  Pic 'u-2' $A

  # 3. Move "Please sign..." down to just above Ms Naidoo's name: select it, Cut, click, Ctrl+V.
  (Para $letter 5).Select();                              Pic 'm-1' $A
  $word.Selection.Cut();                                  Start-Sleep -Milliseconds 600
  $last = Para $letter 8                                   # Ms Naidoo, CAT teacher
  $mb = TextBox ($letter.Range($last.Start, $last.Start + 2))
  Pic 'm-2' $A
  Pct 'msStart' 'm-2' @(($mb[0] - 10), ($mb[1] - 2), ($mb[2] + 10), ($mb[3] + 4))
  $letter.Range($last.Start, $last.Start).Select();        Pic 'm-3' $A
  $word.Selection.Paste();                                Start-Sleep -Milliseconds 600
  Pic 'm-4' $A

  # 4. Find and Replace: Saturday -> Friday, Replace All.
  $letter.Range(0, 0).Select()
  Pic 'r-1' $F                                          # Replace is right of the usual crop
  Pct 'replaceBtn' 'r-1' (Box (Ctl @('Replace...')))
  # Word's dialog boxes show little to UI Automation: each state is set through Word's Find object (the box
  # opens with the last search in it) and the box opened again to picture it; targets are read off the pictures.
  $f = $word.Selection.Find
  $f.ClearFormatting(); $f.Replacement.ClearFormatting()
  $f.Text = ''; $f.Replacement.Text = ''
  $dlg = OpenDialog (Ctl @('Replace...'))
  DumpWin $dlg 'replacedlg'
  Pic 'r-2' $null $dlg
  CloseDialog $dlg
  $f.Text = 'Saturday'
  $dlg = OpenDialog (Ctl @('Replace...'))
  Pic 'r-3' $null $dlg
  CloseDialog $dlg
  $f.Replacement.Text = 'Friday'
  $dlg = OpenDialog (Ctl @('Replace...'))
  Pic 'r-4' $null $dlg
  CloseDialog $dlg
  $all = $letter.Content
  [void]$all.Find.Execute('Saturday', $true, $true, $false, $false, $false, $true, 0, $false, 'Friday', 2)
  "after replacing: " + ($letter.Content.Text -replace "`r", ' / ')
  $letter.Range(0, 0).Select()
  Pic 'r-6' $A

  # 5. Insert > Symbol: the menu, and More Symbols.
  try {
    Tab 'Insert'
    Dump 'insert'
    Pic 'y-1' $F
    $sym = Ctl @('Symbol')
    Pct 'symbolBtn' 'y-1' (Box $sym)
    $menu = OpenMenu $sym
    if ($menu -ne [IntPtr]::Zero) {
      DumpWin $menu 'symbolmenu'
      Pic 'y-2' $F $h $menu
    }
    [Shot]::PostKey($h, 0x1B)
    Tab 'Home'
  } catch { "symbol pictures failed: $_" }

  # The done-right copy: cafe -> cafe with an e-acute as well.
  $r = $letter.Content
  [void]$r.Find.Execute('cafe', $true, $true, $false, $false, $false, $true, 0, $false, ('caf' + [char]0xE9), 2)
  "text now: " + $letter.Content.Text
  SaveModel $letter 'Trip letter done.docx'
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
