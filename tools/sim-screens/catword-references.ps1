# Real Word 365 screens for catword lesson 11, 'references' (content/catword/
# references.php - Chris, 8 October 2026: the CAPS Grade 10 lines "basic
# styles linked to a table of contents" and "basic referencing"). Thabo's
# report "Phones in class": Heading 2 from the Styles gallery, the
# Navigation pane, References > Table of Contents, Update Table, Insert
# Citation (a source already in the list, and Add New Source's Create Source
# box), and Bibliography. Also makes the upload's starter file (Phones in
# class.docx, in C:\sims\files\catword-references\ and G:\My Drive\CAT\Word\)
# and the done-right copy.
#     pwsh -File vm-shots.ps1 catword-references
# Read office-kit.ps1's safety rules first. Pictures are cropped here
# (work\catword-kit.ps1) and the targets written in per cent to
# out\catword-references.json. Document.SaveAs2 hangs in the CAT VM, so files
# are saved the way catword-kit does (File > Save As in Word's own window);
# each document's WordOpenXML is written beside it as well (<file>.xml, flat
# OPC) in case that save fails too.
$Name = 'catword-references'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catword-kit.ps1')

Add-Type @'
using System; using System.Runtime.InteropServices;
public static class RfWin {
  [DllImport ("user32.dll")] public static extern bool PostMessage (IntPtr h, uint m, IntPtr w, IntPtr l);
  public static void Chars (IntPtr h, string s) { foreach (char c in s) { PostMessage (h, 0x0102, new IntPtr (c), IntPtr.Zero); System.Threading.Thread.Sleep (40); } }
}
'@

# A control anywhere: the window, a menu window, or the desktop (Office menus show up under any of them).
function FindAny ($hwnd, [string[]]$names, $type = $null) {
  $roots = @($root, $AE::RootElement)
  if ($hwnd -and $hwnd -ne [IntPtr]::Zero) { $roots = @($AE::FromHandle($hwnd)) + $roots }
  foreach ($r in $roots) { try { return (Find $r $names $type 3) } catch { } }
  throw "No control called '$($names -join "' or '")'"
}
# Every named item of a menu window, and list items / menu items on the desktop, into a text file (to learn their names).
function DumpMenu ($menu, $file) {
  $lines = @()
  if ($menu -ne [IntPtr]::Zero) { $lines += foreach ($e in $AE::FromHandle($menu).FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { $c = $e.Current; if ($c.Name) { "menu`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } } }
  foreach ($type in $T::ListItem, $T::MenuItem) {
    $lines += foreach ($e in $AE::RootElement.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $type)))) { try { $c = $e.Current; if ($c.Name -and -not $c.IsOffscreen) { "desk`t$($c.Name)`t$($c.ControlType.ProgrammaticName)`t$((BoxIn $e $h) -join ',')" } } catch { } }
  }
  $lines | Set-Content (Join-Path $out "$Name-$file.txt") -Encoding utf8
}
function Flat ($d, $file) {
  New-Item -ItemType Directory -Force "C:\sims\files\$Name" | Out-Null
  try { [IO.File]::WriteAllText((Join-Path "C:\sims\files\$Name" ($file + '.xml')), $d.WordOpenXML, [Text.Encoding]::UTF8); "  flat $file.xml" } catch { "  NO FLAT XML: $_" }
}
function Show ($range) { $word.ActiveWindow.ScrollIntoView($range, $true); Start-Sleep -Milliseconds 700 }
function ShowToc { $word.ActiveWindow.ScrollIntoView($doc.TablesOfContents.Item(1).Range, $true); Start-Sleep -Milliseconds 700 }
# A COM call again while Word says it is busy (RPC_E_CALL_REJECTED just after a dialog box closes).
function Retry ([scriptblock]$sb) { for ($i = 0; $i -lt 30; $i++) { try { return (& $sb) } catch { if ($i -eq 29) { throw }; Start-Sleep -Milliseconds 500 } } }
# Insert Citation > the survey (the source already in the document). $n: picture the open menu as that name. True when done.
function CiteFromMenu ($n) {
  try {
    $menu = OpenMenu (Ctl @('Insert Citation') $T::MenuItem)
    if ($n) { DumpMenu $menu 'citemenu'; Pic $n $A $h $menu }
    $item = $null
    foreach ($r in @($AE::FromHandle($menu), $AE::RootElement)) {
      foreach ($e in $r.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { try { if ($e.Current.Name -match 'Naidoo' -and -not $e.Current.IsOffscreen) { $item = $e; break } } catch { } }
      if ($item) { break }
    }
    if (-not $item) { '  MISSING source item' | Out-Host; [Shot]::PostKey($menu, 0x1B); Start-Sleep -Milliseconds 800; return $false }
    if ($n) { Pct 'source' $n (BoxIn $item $h) | Out-Host; try { Pct 'addNew' $n (BoxIn (FindAny $menu @('Add New Source...')) $h) | Out-Host } catch { } }
    [Later]::Invoke($item); Start-Sleep -Milliseconds 2500
    return $true
  } catch { "  citation menu: $_" | Out-Host; return $false }
}

$lines = @(
  'Phones in class',
  'A report by Thabo Mokoena, Grade 10, 2026',
  '',
  'Introduction',
  'Our school is deciding whether pupils may use their phones during lessons. This report looks at what the Grade 10 pupils think, and what the school should do.',
  'What the survey found',
  'In a survey of 120 Grade 10 pupils, 84 said they use their phones for schoolwork every day.',
  'Phones for learning',
  'Pupils look up words, watch lesson videos and check their answers on their phones. For several of them, a phone is the only device at home that can go online.',
  'Phones as distractions',
  'Notifications break concentration, and some pupils admitted to playing games during lessons.',
  'Conclusion',
  'Phones help pupils learn when they are used for schoolwork. The school should allow them in class, with clear rules about when they are used.',
  ''
)
$source = '<b:Source xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography"><b:Tag>Nai26</b:Tag><b:SourceType>Report</b:SourceType><b:Author><b:Author><b:NameList><b:Person><b:Last>Naidoo</b:Last><b:First>P.</b:First></b:Person></b:NameList></b:Author></b:Author><b:Title>Phones at school: a survey of Grade 10 pupils</b:Title><b:Year>2026</b:Year><b:Publisher>Phumlani Secondary School</b:Publisher><b:City>Soweto</b:City></b:Source>'

$word = New-Object -ComObject Word.Application
$doc = $null
try {
  $word.DisplayAlerts = 0
  $doc = NewDoc $lines
  $doc.PageSetup.PaperSize = 7                                        # A4
  (Para $doc 1).Style = -63                                          # wdStyleTitle
  (Para $doc 4).ParagraphFormat.PageBreakBefore = $true               # the report starts on page 2

  $word.Visible = $true
  WordWindow
  Flat $doc 'Phones in class.docx'
  SaveForPupils $doc 'Phones in class.docx'
  [Shot]::Back($h); Start-Sleep -Milliseconds 800
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false            # the save was in Word's own window: start the picture guard afresh
  Get-ChildItem "$env:ProgramFiles\Microsoft Office\root\Office16\Bibliography\Style", "$env:APPDATA\Microsoft\Bibliography\Style" -Filter *.xsl -ErrorAction SilentlyContinue | ForEach-Object { "  xsl: $($_.Name)" }
  foreach ($st in 'HarvardAnglia2008OfficeOnline', 'Harvard - Anglia', 'HarvardAnglia', 'HarvardAnglia2008', '\HarvardAnglia2008OfficeOnline.xsl') {
    try { $doc.Bibliography.BibliographyStyle = $st; "  style set: $st"; break } catch { "  style $st refused" }
  }
  "  bibliography style: $($doc.Bibliography.BibliographyStyle)"

  # ---- 1. Heading styles: Heading 1 done, then Heading 2 on Phones for learning (simulation)
  foreach ($i in 4, 6, 12) { (Para $doc $i).Style = -2 }             # wdStyleHeading1
  (Para $doc 4).ParagraphFormat.PageBreakBefore = $true
  (Para $doc 10).Style = -3                                          # Phones as distractions already Heading 2
  Show (Para $doc 6)
  $doc.Range((Para $doc 7).Start, (Para $doc 7).Start).Select()
  Dump 'home'
  Pic 'h-1' $F
  Pct 'learning' 'h-1' (TextBox ((Para $doc 8).Duplicate))
  $doc.Range((Para $doc 8).Start + 3, (Para $doc 8).Start + 3).Select()
  Pic 'h-2' $F
  $tile = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -match '^Heading 2$' } | Select-Object -First 1
  if ($tile) { Pct 'heading2' 'h-2' (Box $tile) } else { '  MISSING Heading 2 tile'; $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | ForEach-Object { "   tile: $($_.Current.Name)" } }
  $t1 = $root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem))) | Where-Object { $_.Current.Name -match '^Heading 1$' } | Select-Object -First 1
  if ($t1) { Pct 'heading1' 'h-2' (Box $t1) }
  (Para $doc 8).Style = -3
  Pic 'h-3' $F
  Pct 'viewTab' 'h-3' (Box (Ctl @('View') $T::TabItem))

  # ---- 2. The Navigation pane (simulation: View tab, Navigation Pane)
  Tab 'View'
  Dump 'view'
  Pic 'n-1' $F
  try { Pct 'navPane' 'n-1' (Box (Ctl @('Navigation Pane') $T::CheckBox)) } catch { '  MISSING navPane' }
  $word.ActiveWindow.DocumentMap = $true
  Start-Sleep -Milliseconds 2000
  Pic 'n-2' $F
  Dump 'navpane'
  $word.ActiveWindow.DocumentMap = $false
  Start-Sleep -Milliseconds 1200

  # ---- 3. The table of contents (simulation: References tab, Table of Contents, Automatic Table 1)
  Tab 'Home'
  $doc.Range((Para $doc 3).Start, (Para $doc 3).Start).Select()
  Show $doc.Range(0, 0)
  Pic 't-1' $A
  Pct 'refTab' 't-1' (Box (Ctl @('References') $T::TabItem))
  Pct 'emptyLine' 't-1' (TextBox ((Para $doc 3).Duplicate))
  Tab 'References'
  Dump 'references'
  Pic 't-2' $A
  foreach ($k in @(@('toc', @('Table of Contents'), $T::MenuItem), @('updateTable', @('Update Table...'), $T::Button), @('insertCitation', @('Insert Citation'), $T::MenuItem), @('style', @('Style'), $T::ComboBox), @('biblio', @('Bibliography'), $T::MenuItem), @('manage', @('Manage Sources...', 'Manage Sources'), $null))) {
    try { Pct $k[0] 't-2' (Box (Ctl $k[1] $k[2])) } catch { "  MISSING $($k[0])" }
  }
  $tocDone = $false
  try {
    $menu = OpenMenu (Ctl @('Table of Contents') $T::MenuItem)
    DumpMenu $menu 'tocmenu'
    Pic 't-3' $A $h $menu
    $auto = FindAny $menu @('Automatic Table 1')
    Pct 'auto1' 't-3' (BoxIn $auto $h)
    [Later]::Invoke($auto)
    Start-Sleep -Milliseconds 3000
    $tocDone = ($doc.TablesOfContents.Count -gt 0)
  } catch { "  toc menu: $_"; try { [Shot]::PostKey($h, 0x1B) } catch { } }
  if (-not $tocDone) {
    '  TOC by COM'
    [Shot]::PostKey($h, 0x1B); Start-Sleep -Milliseconds 800
    [void]$doc.TablesOfContents.Add((Para $doc 3), $true, 1, 3)
  }
  "  tables of contents: $($doc.TablesOfContents.Count)"
  ShowToc
  Pic 't-4' $A

  # ---- 4. A new section, then Update Table (simulation: Update Table, Update entire table, OK)
  $c = $null
  foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like 'Conclusion*' -and $p.Range.Start -gt $doc.TablesOfContents.Item(1).Range.End) { $c = $p.Range; break } }
  $at = $c.Start
  $doc.Range($at, $at).InsertBefore("What teachers said`rMost teachers want phones switched off unless a lesson needs them.`r")
  foreach ($p in $doc.Paragraphs) {
    if ($p.Range.Text -like 'What teachers said*') { $p.Style = -2 }
    if ($p.Range.Text -like 'Most teachers want*') { $p.Style = -1 }
  }
  foreach ($p in $doc.Paragraphs) { "  [$($p.Style.NameLocal)] $($p.Range.Text.Trim())" }
  $doc.Range(0, 0).Select()
  ShowToc
  Pic 'u-1' $A
  try { Pct 'updateTable' 'u-1' (Box (Ctl @('Update Table...') $T::Button)) } catch { '  MISSING update' }
  try {
    $dlg = OpenDialog (Ctl @('Update Table...') $T::Button)
    Pic 'u-2' $null $dlg
    [Shot]::PostKey($dlg, 0x28); Start-Sleep -Milliseconds 800             # Down arrow: the second choice
    Pic 'u-3' $null $dlg
    [Shot]::PostKey($dlg, 0x0D); Start-Sleep -Milliseconds 2500            # Enter: OK
  } catch { "  update dialog: $_" }
  Retry { $doc.TablesOfContents.Item(1).Update() }
  Start-Sleep -Milliseconds 1500
  $doc.Range(0, 0).Select()
  ShowToc
  Pic 'u-4' $A

  # ---- 5. Citations: a source in the list (simulation), and Add New Source's box (a figure)
  [void]$doc.Bibliography.Sources.Add($source)
  "  sources: $($doc.Bibliography.Sources.Count)"
  $p9 = $null
  foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like 'Pupils look up words*') { $p9 = $p.Range; break } }
  $dot = $p9.End - 2                                                  # before the last full stop
  $doc.Range($dot, $dot).Select()
  Show $p9
  Pic 'c-1' $A
  try { Pct 'insertCitation' 'c-1' (Box (Ctl @('Insert Citation') $T::MenuItem)) } catch { '  MISSING insertCitation' }
  $cited = CiteFromMenu 'c-2'
  if (-not $cited -or -not ($p9.Text -match 'Naidoo')) {
    '  citation by COM'
    $doc.Range($dot, $dot).Select()
    [void]$word.Selection.Fields.Add($word.Selection.Range, 96, 'Nai26 \l 7177', $false)   # wdFieldCitation
  }
  Show $p9
  Pic 'c-3' $A
  "  paragraph now: $($p9.Text)"

  # The Create Source box (Add New Source...), filled in by posting keys to it (its controls are not exposed), then cancelled
  $p7 = $null
  foreach ($p in $doc.Paragraphs) { if ($p.Range.Text -like 'In a survey*') { $p7 = $p.Range; break } }
  $dot7 = $p7.End - 2
  $doc.Range($dot7, $dot7).Select()
  try {
    $menu = OpenMenu (Ctl @('Insert Citation') $T::MenuItem)
    $add = FindAny $menu @('Add New Source...', 'Add New Source')
    $before = [Later]::Windows($script:wpid)
    [Later]::Invoke($add)
    $dlg = NewWindow $before @('bosa_sdm_msword', '#32770', 'NUIDialog') 40
    if ($dlg -eq [IntPtr]::Zero) { throw 'no Create Source box' }
    Start-Sleep -Milliseconds 1500
    Pic 's-1' $null $dlg
    [RfWin]::Chars($dlg, 'R'); Start-Sleep -Milliseconds 800
    foreach ($k in 1..2) { [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300 }
    [RfWin]::Chars($dlg, 'Naidoo, P.'); Start-Sleep -Milliseconds 500
    Pic 's-2' $null $dlg
    foreach ($k in 1..3) { [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300 }
    [RfWin]::Chars($dlg, 'Phones at school: a survey of Grade 10 pupils'); [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300
    [RfWin]::Chars($dlg, '2026'); [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300
    [RfWin]::Chars($dlg, 'Soweto'); [Shot]::PostKey($dlg, 0x09); Start-Sleep -Milliseconds 300
    [RfWin]::Chars($dlg, 'Phumlani Secondary School'); Start-Sleep -Milliseconds 800
    Pic 's-3' $null $dlg
    [void][RfWin]::PostMessage($dlg, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero)   # WM_CLOSE: Cancel
    for ($i = 0; $i -lt 20 -and ([Later]::Windows($script:wpid) | Where-Object { $_ -like "$dlg`t*" }); $i++) { Start-Sleep -Milliseconds 300 }
    Start-Sleep -Milliseconds 1200
  } catch { "  create source: $_"; try { [Shot]::PostKey($h, 0x1B) } catch { } }
  Retry { $doc.Range($dot7, $dot7).Select() }
  if (-not (CiteFromMenu $null)) { [void]$word.Selection.Fields.Add($word.Selection.Range, 96, 'Nai26 \l 7177', $false) }
  "  survey paragraph: $($p7.Text)"

  # ---- 6. The bibliography at the end (Bibliography gallery, the built-in Bibliography)
  $last = $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  $doc.Range($last.Start, $last.Start).Select()
  Show $last
  Pic 'b-1' $A
  try { Pct 'biblio' 'b-1' (Box (Ctl @('Bibliography') $T::MenuItem)) } catch { '  MISSING biblio' }
  $bibDone = $false
  try {
    $menu = OpenMenu (Ctl @('Bibliography') $T::MenuItem)
    DumpMenu $menu 'bibmenu'
    Pic 'b-2' $A $h $menu
    $bib = $null
    foreach ($r in @($AE::FromHandle($menu), $AE::RootElement)) {
      foreach ($e in $r.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ListItem)))) { try { if ($e.Current.Name -match '^Bibliography' -and -not $e.Current.IsOffscreen) { $bib = $e; break } } catch { } }
      if ($bib) { break }
    }
    if ($bib) { "  gallery item: $($bib.Current.Name)"; Pct 'builtin' 'b-2' (BoxIn $bib $h); [Later]::Invoke($bib); Start-Sleep -Milliseconds 3000; $bibDone = $true }
    else { '  MISSING Bibliography item'; [Shot]::PostKey($menu, 0x1B); Start-Sleep -Milliseconds 800 }
  } catch { "  bibliography gallery: $_" }
  "  bibliography by the gallery: $bibDone"
  Show $doc.Paragraphs.Item($doc.Paragraphs.Count).Range
  Pic 'b-3' $A

  # ---- 7. The done-right copy: without the extra section, the table of contents updated
  foreach ($p in @($doc.Paragraphs)) { $t = $p.Range.Text; if ($t -like 'What teachers said*' -or $t -like 'Most teachers want*') { $p.Range.Delete() | Out-Null } }
  $doc.TablesOfContents.Item(1).Update()
  Start-Sleep -Milliseconds 1500
  foreach ($p in $doc.Paragraphs) { "  [$($p.Style.NameLocal)] $($p.Range.Text.Trim())" }
  Show $doc.Range(0, 0)
  Pic 'd-1' $A
  $word.ActiveWindow.DocumentMap = $true
  Start-Sleep -Milliseconds 1500
  Pic 'd-2' $A
  $word.ActiveWindow.DocumentMap = $false
  Flat $doc 'Phones in class done.docx'
  # The done-right copy: Save As failed here once (the CAT folder left Backstage's Recent list) - the flat XML above is packaged into a .docx on the host instead
  SavePct
}
catch { "FAILED: $_"; $_.ScriptStackTrace; SavePct; throw }
finally {
  foreach ($d in @($word.Documents)) { try { $d.Saved = $true; $d.Close(0) } catch { } }
  try { $word.Quit() } catch { }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word)
  Remove-Item 'G:\My Drive\CAT\Word\Phones in class done.docx' -ErrorAction SilentlyContinue   # the cloud keeps the starter only
}
