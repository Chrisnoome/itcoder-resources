# Real Word 365 screens for catword Grade 12 lesson 'tracking' (content/catword/
# tracking.php, 9 October 2026). Thabo's letter about the matric farewell,
# edited by Ms Naidoo and Mr Khumalo with Track Changes on: the Review tab,
# Track Changes, the Display for Review box (All Markup), the Reviewing Pane,
# Next / Accept / Reject, Compare (IEB) and Restrict Editing (IEB). Also makes
# the upload's starter (Farewell letter.docx - the changes still to be
# decided) in C:\sims\files\catword-tracking\ and G:\My Drive\CAT\Word\, and a
# done-right copy.
#     pwsh -File vm-shots.ps1 catword-tracking
# Pictures cropped here (work\catword-kit.ps1); targets in per cent in
# out\catword-tracking.json. Word's user name is set for each "reviewer" and
# put back at the end.
$Name = 'catword-tracking'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword12-kit.ps1')

$lines = @(
  'Matric Farewell 2026',
  'Dear Parents and Guardians',
  'The Grade 12 matric farewell will be held on Friday 13 November 2026 in the school hall, from 18:00 to 22:00.',
  'Tickets cost R250 for each pupil and R150 for each guest. Each pupil may bring one guest.',
  'Botha''s Bakery will provide the meal and the cake. Please tell us by 30 October if your child has a food allergy.',
  'Pupils must be collected from the school by 22:30. No pupil may leave the hall alone.',
  'Please pay by Friday 23 October 2026, at the school office or by EFT.',
  'Kind regards',
  'Thabo Mokoena (class representative) and Ms P. Naidoo (Grade 12 teacher)'
)

# The reviewers' edits, made with Track Changes on (as each person).
function Edits ($d) {
  $word.UserName = 'Ms Naidoo'; $word.UserInitials = 'PN'
  $d.TrackRevisions = $true
  $r = Words12 $d '22:00.'; $r.SetRange($r.Start, $r.Start + 5); $r.Text = '23:00'                 # end time: 22:00 -> 23:00
  $r = Words12 $d 'R150'; $r.Text = 'R200'                                                          # guest price: R150 -> R200
  $p = ParaLike $d 'Pupils must be collected'; $e = $p.End - 1; $d.Range($e, $e).InsertAfter(' A teacher will be at the gate.')
  $r = Words12 $d '30 October'; $r.Font.Bold = $true                                                # a formatting change
  $word.UserName = 'Mr Khumalo'; $word.UserInitials = 'SK'
  $r = Words12 $d ' or by EFT'; $r.Delete() | Out-Null                                              # payment: no EFT
  $r = Words12 $d 'the meal and the cake'; $r.SetRange($r.Start + 4, $r.Start + 8); $r.InsertAfter(', the drinks')   # "the meal, the drinks and the cake"
  $r = Words12 $d 'school hall'; [void]$d.Comments.Add($r, 'Please check that the hall is free that night.')
  $d.TrackRevisions = $false
}

$word = New-Object -ComObject Word.Application
$doc = $null
$oldName = $word.UserName; $oldInit = $word.UserInitials
try {
  $word.DisplayAlerts = 0
  LocalUser
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7
  (Para $doc 1).Style = -63
  $word.Visible = $true
  WordWindow; Wide
  Edits $doc
  "  revisions: $($doc.Revisions.Count)  comments: $($doc.Comments.Count)"
  Flat $doc 'Farewell letter.docx'
  SaveDoc12 $doc 'Farewell letter.docx' $true
  $word.UserName = 'Thabo Mokoena'; $word.UserInitials = 'TM'

  # ---- 1. Turn on Track Changes (simulation: Review tab, Track Changes) - on a clean copy of the letter
  $clean = NewDoc $lines
  (Para $clean 1).Style = -63
  $doc.Activate()
  $clean.Activate(); WordWindow; Wide
  $clean.Range(0, 0).Select()
  Pic 'o-1' $W
  TryPct 'reviewTab' 'o-1' { Box (Ctl @('Review') $T::TabItem) }
  Tab 'Review'
  Dump 'review'
  Pic 'o-2' $W
  Dump 'review'
  foreach ($grp in 'Tracking', 'Changes', 'Protect') { try { $m = @(OpenMenu (Ctl @($grp) $T::MenuItem))[-1]; DumpMenu $m "group-$grp"; Pic "g-$grp" $W $h $m | Out-Host; EscMenu $m } catch { "  no folded group $grp" } }
  foreach ($k in @(@('trackChanges', @('Track Changes')), @('display', @('Display for Review')), @('showMarkup', @('Show Markup')), @('pane', @('Reviewing Pane')),
                   @('accept', @('Accept')), @('reject', @('Reject')), @('prev', @('Previous')), @('next', @('Next')), @('compare', @('Compare')), @('restrict', @('Restrict Editing')),
                   @('blockAuthors', @('Block Authors')), @('newComment', @('New Comment')), @('wordCount', @('Word Count')), @('language', @('Language')), @('translate', @('Translate')), @('access', @('Check Accessibility')))) {
    TryPct $k[0] 'o-2' { Box (Ctl $k[1]) }
  }
  $clean.TrackRevisions = $true
  Start-Sleep -Milliseconds 800
  $r = Words12 $clean '22:00.'; $r.SetRange($r.Start, $r.Start + 5)
  Pic 'o-3' $W
  TryPct 'endTime' 'o-3' { TextBox $r }
  $r.Text = '23:00'
  $word.ActiveWindow.View.RevisionsFilter.Markup = 2          # All Markup
  Start-Sleep -Milliseconds 800
  Pic 'o-4' $W
  $clean.TrackRevisions = $false
  $clean.Saved = $true; $clean.Close(0)
  $doc.Activate(); WordWindow; Wide
  Tab 'Review'

  # ---- 2. Simple Markup -> All Markup (simulation: the Display for Review box, then All Markup)
  $word.ActiveWindow.View.RevisionsFilter.Markup = 1          # Simple Markup
  $word.ActiveWindow.View.RevisionsFilter.View = 0
  $doc.Range(0, 0).Select()
  Pic 'm-1' $W
  TryPct 'display' 'm-1' { Box (Ctl @('Display for Review')) }
  $menu = MenuPic @('Display for Review') $null 'm-2' $W
  if ($menu -ne [IntPtr]::Zero) { TryPct 'allMarkup' 'm-2' { BoxIn (FindAny $menu @('All Markup')) $h }; TryPct 'noMarkup' 'm-2' { BoxIn (FindAny $menu @('No Markup')) $h }; TryPct 'original' 'm-2' { BoxIn (FindAny $menu @('Original')) $h } }
  EscMenu $menu
  $word.ActiveWindow.View.RevisionsFilter.Markup = 2
  Start-Sleep -Milliseconds 900
  Pic 'm-3' $W
  # Show Markup menu (Balloons) as a figure
  $menu = MenuPic @('Show Markup') $null 'm-4' $W
  EscMenu $menu
  # No Markup and Original, for figures
  $word.ActiveWindow.View.RevisionsFilter.Markup = 0; Start-Sleep -Milliseconds 900; Pic 'm-5' $W
  $word.ActiveWindow.View.RevisionsFilter.View = 1; Start-Sleep -Milliseconds 900; Pic 'm-6' $W
  $word.ActiveWindow.View.RevisionsFilter.View = 0; $word.ActiveWindow.View.RevisionsFilter.Markup = 2; Start-Sleep -Milliseconds 900

  # The Reviewing Pane (a figure)
  try { Press (Ctl @('Reviewing Pane') $T::Button); Start-Sleep -Milliseconds 2000; Pic 'p-1' $W; Dump 'pane'; Press (Ctl @('Reviewing Pane') $T::Button); Start-Sleep -Milliseconds 1200 } catch { "  reviewing pane: $_" }
  Start-Sleep -Milliseconds 900

  # ---- 3. Next, Accept, Reject (simulation)
  $doc.Range(0, 0).Select()
  Pic 'a-1' $W
  TryPct 'next' 'a-1' { Box (Ctl @('Next') $T::Button) }
  $first = $doc.Revisions.Item(1).Range
  $first.Select()
  Pic 'a-2' $W
  TryPct 'accept' 'a-2' { Box (Ctl @('Accept')) }
  TryPct 'reject' 'a-2' { Box (Ctl @('Reject')) }
  "  first revision: $($doc.Revisions.Item(1).Type) '$($first.Text)'"
  $doc.Revisions.Item(1).Accept()
  # the next one, then
  $second = $doc.Revisions.Item(1).Range
  "  next revision: $($doc.Revisions.Item(1).Type) '$($second.Text)' by $($doc.Revisions.Item(1).Author)"
  $second.Select()
  Pic 'a-3' $W
  TryPct 'accept' 'a-3' { Box (Ctl @('Accept')) }
  TryPct 'reject' 'a-3' { Box (Ctl @('Reject')) }
  TryPct 'acceptBelow' 'a-3' { Box (Ctl @('Accept') $T::MenuItem) }
  Start-Sleep -Milliseconds 400
  Pic 'a-4' $W
  # The Accept menu (Accept All Changes ...) as a figure
  $menu = MenuPic @('Accept') $T::MenuItem 'a-5' $W
  EscMenu $menu

  # ---- 4. Compare (IEB): the Compare menu, then the Compare Documents box
  Pic 'c-1' $W
  TryPct 'compare' 'c-1' { Box (Ctl @('Compare') $T::MenuItem) }
  $menu = MenuPic @('Compare') $T::MenuItem 'c-2' $W
  if ($menu -ne [IntPtr]::Zero) {
    TryPct 'compareItem' 'c-2' { BoxIn (FindAny $menu @('Compare...', 'Compare')) $h }
    TryPct 'combineItem' 'c-2' { BoxIn (FindAny $menu @('Combine...', 'Combine')) $h }
    try {
      $before = [Later]::Windows($script:wpid)
      [Later]::Invoke((FindAny $menu @('Compare...')))
      $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
      if ($dlg -ne [IntPtr]::Zero) { Start-Sleep -Milliseconds 1500; Pic 'c-3' $null $dlg; DumpWin $dlg 'comparebox'; CloseDialog $dlg; CloseAll }
    } catch { "  compare box: $_" }
  }
  EscMenu $menu

  # ---- 5. Restrict Editing (IEB): the pane, Tracked changes
  try {
    Press (Ctl @('Restrict Editing')); Start-Sleep -Milliseconds 2000
    Pic 'r-1' $W
    Dump 'restrict'
    try {
      $box = Ctl @('Allow only this type of editing in the document:', 'Allow only this type of editing in the document') $T::CheckBox
      Pct 'allowOnly' 'r-1' (Box $box)
      Press $box; Start-Sleep -Milliseconds 1200
      Pic 'r-2' $W
      Dump 'restrict2'
      $combo = $null
      foreach ($e in $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ComboBox)))) { try { if ((Box $e)[0] -gt 1300) { $combo = $e } } catch { } }
      if ($combo) {
        Pct 'editingKind' 'r-2' (Box $combo)
        $p = $null
        if ($combo.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $p.Expand(); Start-Sleep -Milliseconds 1000; Pic 'r-3' $W; DumpMenu ([IntPtr]::Zero) 'restrictlist' }
        $item = $null
        foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) { try { if ($e.Current.Name -eq 'Tracked changes') { $item = $e } } catch { } }
        if ($item) { Pct 'trackedItem' 'r-3' (Box $item); $sp = $null; if ($item.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern, [ref]$sp)) { $sp.Select() }; Start-Sleep -Milliseconds 1000 }
        try { $p.Collapse() } catch { }
        Start-Sleep -Milliseconds 800
        Pic 'r-4' $W
        TryPct 'enforce' 'r-4' { Box (Ctl @('Yes, Start Enforcing Protection')) }
      }
    } catch { "  restrict pane: $_" }
  } catch { "  restrict editing: $_" }
  try { $word.ActiveWindow.ActivePane.View.Type = 3 } catch { }
  try { $word.TaskPanes.Item(5).Visible = $false } catch { }   # wdTaskPaneDocumentProtection

  # ---- 6. The done-right copy: accept the end time, reject the guest price, reject the EFT deletion, accept the rest; then a tracked change of Thabo's
  foreach ($rev in @($doc.Revisions)) {
    $t = $rev.Range.Text
    if ($t -match 'R200|R150|the drinks' -or $t -match 'or by EFT') { $rev.Reject() } else { $rev.Accept() }   # the drinks rejected: the tuck shop sells them
  }
  foreach ($rev in @($doc.Revisions)) { $rev.Accept() }
  foreach ($c in @($doc.Comments)) { $c.Delete() }
  $doc.TrackRevisions = $true
  $p = ParaLike $doc 'Please pay by'; $e = $p.End - 1; $doc.Range($e, $e).InsertAfter(' Dress: formal.')
  $doc.TrackRevisions = $false
  foreach ($rev in @($doc.Revisions)) { $rev.Accept() }
  foreach ($p in $doc.Paragraphs) { "  | $($p.Range.Text.Trim())" }
  $doc.Range(0, 0).Select()
  Pic 'd-1' $W
  Flat $doc 'Farewell letter done.docx'
  SaveDoc12 $doc 'Farewell letter done.docx' $false
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  try { $word.UserName = $oldName; $word.UserInitials = $oldInit } catch { }
  RestoreUser
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
}
