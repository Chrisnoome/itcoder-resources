# Starter files for the Web Design (HTML) course's Grade 10 lessons
# (AIPascalCourse/content/cathtml/*.php - courses/cat-practical-writing.md,
# Chris, 8 October 2026: "cat files also must be stored using the cloud -
# google drive"). Each file is the starter of one lesson's html block, the
# same as public/assets/practical/cathtml/<file> on the site (made from the
# lessons by the writer's script; keep the two the same). Saved in
# C:\sims\files\cathtml-files\ (they come back to files\cathtml-files\) and in
# G:\My Drive\CAT\HTML\ for the pupils' cloud folder. Plain text, UTF-8, no
# Office needed; nothing clicks or types.
# Run from the host:  pwsh -File vm-shots.ps1 cathtml-files
$ErrorActionPreference = 'Stop'
$files = [ordered]@{
  'first-page.html' = @'
<html>
<head>
<title></title>
</head>
<body>
<h1>Botha's Bakery<h1>
<p>Fresh bread every morning, in Centurion.<p>
</body>
</html>
'@
  'prices.html' = @'
<html>
<head>
<body>
<title>Botha's Bakery - Prices</title>
<h1>Our prices</h1>
<p>White bread R20, brown bread R19, koeksisters R8 each.</p>
<body>
'@
  'botha-headings.html' = @'
<html>
<head>
<title>Botha's Bakery</title>
</head>
<body>
Botha's Bakery
<p>Fresh bread every morning, in Centurion.</p>
Our bread
<p>White bread, brown bread and rolls, baked before six.</p>
Opening times
<p>Monday to Saturday, from six in the morning.</p>
</body>
</html>
'@
  'find-us.html' = @'
<html>
<head>
<title>Botha's Bakery - Find us</title>
</head>
<body>
<h1>Find us</h1>
Botha's Bakery
12 Church Street
Centurion
012 345 6789
Open Monday to Saturday, from six in the morning.
Closed on Sundays.
</body>
</html>
'@
  'poem.html' = @'
<html>
<head>
<title>Thabo's poem</title>
</head>
<body>
Load shedding
The lights go out at six,
the fridge forgets to hum,
we play cards by a candle
until the power comes.
- Thabo
</body>
</html>
'@
  'specials.html' = @'
<html>
<head>
<title>Botha's Bakery - Specials</title>
</head>
<body>
<h1>This week's specials</h1>
<p><b>Koeksisters<b> - R8 each</p>
<p><i>Fresh</b> brown bread - R19</i></p>
<p><b><i>Closed on Sundays</b></i></p>
<p>Order a cake <u>two days before</u>.</p>
</body>
</html>
'@
  'market-day.html' = @'
<html>
<head>
<title>Market Day</title>
</head>
<body>
<h1>Market Day</h1>
<p>Grade 10 is holding a market day on Friday 14 November, from 10:00 to 13:00.</p>
<p>Entry is free, and everyone is welcome.</p>
<p>Bring cash or a card.</p>
</body>
</html>
'@
  'botha-colours.html' = @'
<html>
<head>
<title>Botha's Bakery</title>
</head>
<body bgcolour="lightyellow">
<h1><font colour="maroon">Botha's Bakery</font></h1>
<hr wide="50%" size="4">
<p><font face="Arial" size="9">Fresh bread every morning, in Centurion.</font></p>
</body>
</html>
'@
}
$dir   = 'C:\sims\files\cathtml-files'
$cloud = 'G:\My Drive\CAT\HTML'
New-Item -ItemType Directory -Force $dir | Out-Null
$haveCloud = Test-Path 'G:\My Drive'
if ($haveCloud) { New-Item -ItemType Directory -Force $cloud | Out-Null } else { 'NO G:\My Drive - the cloud copies were not made' }
$utf8 = New-Object System.Text.UTF8Encoding($false)
foreach ($name in $files.Keys) {
  $text = ($files[$name] -replace "`r?`n", "`r`n") + "`r`n"
  [IO.File]::WriteAllText((Join-Path $dir $name), $text, $utf8)
  if ($haveCloud) { [IO.File]::WriteAllText((Join-Path $cloud $name), $text, $utf8) }
  "$name ($($text.Length) characters)"
}
if ($haveCloud) { "in $cloud :"; Get-ChildItem $cloud -File | ForEach-Object { '  ' + $_.Name } }
