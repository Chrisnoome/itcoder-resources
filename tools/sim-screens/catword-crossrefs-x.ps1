# Real Word 365 screens for catword lesson 'crossrefs', simCrossRef's last
# choices (9 October 2026): the Cross-reference box's two lists opened by
# clicks posted to the box (real input), Bookmark and Page number clicked in
# them, Insert. Pictures out\catword-crossrefs-x-<n>.png -> the lesson's
# catword-crossrefs-x-3 .. x-8. Nothing saved.
#     pwsh -File vm-shots.ps1 catword-crossrefs-x
$Name = 'catword-crossrefs-x'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword11-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$filler = 'The school uses water for drinking, cleaning, the toilets and the garden. Each use was measured for four weeks with the meter at the gate and a simple tally sheet at each block of toilets.'
function Report ($d, [string]$tableRef, [string]$pageRef, [string]$headRef) {
  $lines = @(
    'Saving water at Phumlani Secondary',
    'A PAT report by Thabo Mokoena, Grade 12',
    'Introduction',
    ('Phumlani Secondary pays for every litre of water it uses. This report asks how the school could use less. The meter readings are in ' + $tableRef + ' on page ' + $pageRef + ', and what the school should do is under ' + $headRef + '.'),
    $filler, $filler,
    'How much water we use',
    'The school uses about 18 000 litres on a school day and about 2 000 litres on a weekend day.',
    $filler, $filler, $filler, $filler,
    'TABLEHERE',
    $filler, $filler,
    'Where the water goes',
    'Flushing uses 60% of the water, the taps 25%, the garden 10% and cleaning 5%.',
    $filler,
    'Recommendations',
    'Fix the leaking cisterns first: it costs little and saves the most.'
  )
  $d.Content.Text = ($lines -join "`r")
  (Para $d 1).Style = -63
  foreach ($p in $d.Paragraphs) { if ($p.Range.Text.Trim() -in 'Introduction', 'How much water we use', 'Where the water goes', 'Recommendations') { $p.Style = -2 } }
  $at = ParaLike $d 'TABLEHERE'
  $at.Text = ''
  $t = $d.Tables.Add($at, 5, 3)
  $cells = @(@('Week', 'School days', 'Weekend'), @('Week 1', '90 500', '4 100'), @('Week 2', '88 900', '3 800'), @('Week 3', '91 200', '4 400'), @('Week 4', '87 600', '3 900'))
  for ($r = 0; $r -lt 5; $r++) { for ($c = 0; $c -lt 3; $c++) { $t.Cell($r + 1, $c + 1).Range.Text = $cells[$r][$c] } }
  $t.Style = 'Table Grid'
  [void]$t.Range.InsertCaption('Table', ' - Meter readings in litres, Term 1', '', 0)   # a real caption (SEQ Table), above the table
  return $t
}

# The X after "on page " in the introduction (found in the paragraph's own text, not with Find).
function PageX ($d) {
  $p = ParaLike $d 'Phumlani Secondary pays'
  $i = $p.Text.IndexOf('on page ')
  if ($i -lt 0) { throw "No 'on page' in: $($p.Text)" }
  return $d.Range($p.Start + $i + 8, $p.Start + $i + 9)
}

$word = New-Object -ComObject Word.Application
try {
  $word.DisplayAlerts = 0
  LocalUser
  $doc = $word.Documents.Add()
  $doc.PageSetup.PaperSize = 7
  [void](Report $doc 'Table 1' 'X' 'Recommendations')
  $cap = ParaLike $doc 'Table 1'
  [void]$doc.Bookmarks.Add('MeterTable', $doc.Range($cap.Start, $cap.End - 1))
  $word.Visible = $true
  WordWindow
  $intro = ParaLike $doc 'Phumlani Secondary pays'
  $x = PageX $doc
  $x.Select()
  Show $intro
  Tab 'Insert'
  $dlg = OpenDialog (Ctl @('Cross-reference...', 'Cross-reference'))
  Pic '2' $null $dlg
  "  dialog: $([WinRect]::Of($dlg) -join ',')"

  # Reference type: its list opened with F4 (posted clicks do not reach the box's button), Bookmark chosen
  # with the arrow keys and Enter - the screens are the same as for a click.
  function Key ($w, $vk) { [Shot]::PostKey($w, $vk); Start-Sleep -Milliseconds 700 }
  $before = [Later]::Windows($script:wpid)
  Key $dlg 0x73
  $pop = NewWindow $before @() 20
  "  list 1: $(if ($pop -ne [IntPtr]::Zero) { [WinRect]::Of($pop) -join ',' } else { 'NONE' })"
  Pic '3' $null $dlg $pop
  $kw = if ($pop -ne [IntPtr]::Zero) { $pop } else { $dlg }
  Key $kw 0x28; Key $kw 0x28; Key $kw 0x0D                              # Down, Down (Bookmark), Enter
  Pic '4' $null $dlg

  # Insert reference to: Tab to it, F4, Page number (Down), Enter
  Key $dlg 0x09
  $before = [Later]::Windows($script:wpid)
  Key $dlg 0x73
  $pop = NewWindow $before @() 20
  "  list 2: $(if ($pop -ne [IntPtr]::Zero) { [WinRect]::Of($pop) -join ',' } else { 'NONE' })"
  Pic '5' $null $dlg $pop
  $kw = if ($pop -ne [IntPtr]::Zero) { $pop } else { $dlg }
  Key $kw 0x28; Key $kw 0x0D
  Pic '6' $null $dlg

  # Insert (the default button: Enter), then the box closed
  Key $dlg 0x0D
  Start-Sleep -Milliseconds 800
  Pic '7' $null $dlg
  CloseAll
  Show $intro
  Pic '8' $F
  "  intro now: $((ParaLike $doc 'Phumlani Secondary pays').Text)"
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; CloseAll }
finally {
  RestoreUser
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
