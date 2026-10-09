# The Word e-waste upload (catword lesson 8, illustrations, upEwaste): the
# starter E-waste project.docx and a done-right copy E-waste project done.docx,
# made by real Word in the CAT VM - the illustrations part of
# catword-b-files.ps1 on its own, so the other lessons' files are not remade.
# Word runs in a job of its own. Word's SaveAs2 hangs in the VM (9 October
# 2026, again), so each file is packed from Document.WordOpenXML the way the
# kit's SaveDoc does (work/catword11-kit.ps1, FlatToDocx) - no Word save.
#     pwsh -File vm-shots.ps1 catword-ewaste-files
$Name = 'catword-ewaste-files'
$dir = "C:\sims\files\$Name"
$work = Join-Path $PSScriptRoot 'work'
New-Item -ItemType Directory -Force $dir | Out-Null

$job = Start-Job -ArgumentList $dir, $work {
  param($dir, $work)
  $ErrorActionPreference = 'Stop'
  Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
  # A flat OPC string (Document.WordOpenXML) -> a .docx file at $path.
  function FlatToDocx ([string]$flat, [string]$path) {
    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true
    $xml.LoadXml($flat)
    $ns = New-Object System.Xml.XmlNamespaceManager $xml.NameTable
    $ns.AddNamespace('pkg', 'http://schemas.microsoft.com/office/2006/xmlPackage')
    if (Test-Path $path) { Remove-Item $path -Force }
    $fs = [IO.File]::Open($path, 'Create')
    $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
    $types = New-Object System.Text.StringBuilder
    [void]$types.Append('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">')
    foreach ($part in $xml.SelectNodes('//pkg:part', $ns)) {
      $name = $part.GetAttribute('name', 'http://schemas.microsoft.com/office/2006/xmlPackage').TrimStart('/')
      $ct   = $part.GetAttribute('contentType', 'http://schemas.microsoft.com/office/2006/xmlPackage')
      [void]$types.Append(('<Override PartName="/{0}" ContentType="{1}"/>' -f $name, $ct))
      $entry = $zip.CreateEntry($name)
      $s = $entry.Open()
      $data = $part.SelectSingleNode('pkg:xmlData', $ns)
      if ($data) {
        $inner = $data.FirstChild
        while ($inner -and $inner.NodeType -ne [System.Xml.XmlNodeType]::Element) { $inner = $inner.NextSibling }
        $bytes = [Text.Encoding]::UTF8.GetBytes('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "`r`n" + $inner.OuterXml)
      } else {
        $bytes = [Convert]::FromBase64String(($part.SelectSingleNode('pkg:binaryData', $ns).InnerText -replace '\s', ''))
      }
      $s.Write($bytes, 0, $bytes.Length); $s.Dispose()
    }
    [void]$types.Append('</Types>')
    $entry = $zip.CreateEntry('[Content_Types].xml')
    $s = $entry.Open(); $b = [Text.Encoding]::UTF8.GetBytes($types.ToString()); $s.Write($b, 0, $b.Length); $s.Dispose()
    $zip.Dispose(); $fs.Dispose()
  }
  
  function OwnStyles ($d) { foreach ($style in $d.Styles) { try { if ($style.QuickStyle -and -not $style.BuiltIn) { $style.QuickStyle = $false } } catch { } } }
  function Para ($d, $text) { foreach ($p in $d.Paragraphs) { if ($p.Range.Text -like "*$text*") { return $p } }; throw "no paragraph with $text" }
  $word = New-Object -ComObject Word.Application
  $start = $null
  try {
    $word.DisplayAlerts = 0
    $pic = Join-Path $dir 'e-waste.jpg'
    Copy-Item (Join-Path $work 'catword-ewaste.jpg') $pic -Force
    $start = $word.Documents.Add()
    OwnStyles $start
    $start.PageSetup.PaperSize = 7
    $start.Content.Text = (@(
      '',
      'By Thabo Mokoena, Grade 10',
      'Old phones, laptops, chargers and batteries are e-waste. They hold lead, mercury and other poisons that leak into the soil and the water when they are thrown away with the rubbish. They also hold copper, silver and gold that can be used again.',
      'South Africa throws away tonnes of e-waste every year, and only a small part of it is recycled. The rest ends up on rubbish dumps, where people burn the cables to get the copper out and breathe in the smoke.',
      'What our school can do',
      '',
      'Bring your old phones, chargers and batteries to school. A recycler collects them every month, takes them apart and sells what can be used again.') -join "`r")
    $start.Paragraphs.Item(5).Style = -2
    FlatToDocx $start.WordOpenXML (Join-Path $dir 'E-waste project.docx'); '  saved starter'
    $first = $start.Paragraphs.Item(1).Range
    $wa = $start.Shapes.AddTextEffect(0, 'Say no to e-waste', 'Aptos Display', 36, -1, 0, 70, 20, $first)
    $wa.WrapFormat.Type = 4
    $at = (Para $start 'Old phones').Range
    $at.Collapse(1)
    $ip = $start.InlineShapes.AddPicture($pic, $false, $true, $at)
    $ip.LockAspectRatio = -1; $ip.Width = 170
    $sh = $ip.ConvertToShape()
    $sh.WrapFormat.Type = 0
    $layout = $null
    foreach ($l in $word.SmartArtLayouts) { if ($l.Name -eq 'Basic Process') { $layout = $l; break } }
    if (-not $layout) { throw 'no Basic Process layout' }
    $sa = $start.Shapes.AddSmartArt($layout, 70, 330, 400, 90, $start.Paragraphs.Item(6).Range)
    $nodes = $sa.SmartArt.AllNodes
    $words = 'Collect', 'Sort', 'Recycle'
    for ($i = 1; $i -le 3; $i++) { $nodes.Item($i).TextFrame2.TextRange.Text = $words[$i - 1] }
    $tb = $start.Shapes.AddTextbox(1, 330, 470, 170, 50, $start.Paragraphs.Item(7).Range)
    $tb.TextFrame.TextRange.Text = 'Drop-off box at the school office'
    FlatToDocx $start.WordOpenXML (Join-Path $dir 'E-waste project done.docx'); '  saved done'
    $start.Close(0); $start = $null
    'done'
  } finally {
    if ($start) { try { $start.Saved = $true; $start.Close(0) } catch { } }
    $word.Quit()
  }
}
if (Wait-Job $job -Timeout 300) { Receive-Job $job } else {
  Stop-Job $job; Receive-Job $job
  Get-Process WINWORD -ErrorAction SilentlyContinue | Stop-Process -Force
  'FAILED: Word hung'
}
Remove-Job $job -Force
Get-ChildItem $dir | ForEach-Object { "  $($_.Name) $($_.Length)" }
