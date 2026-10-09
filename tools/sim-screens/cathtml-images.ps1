# Screens for Web Design (HTML) lesson 8, Pictures (AIPascalCourse/
# content/cathtml/images.php - courses/cat-practical-writing.md, "Grades 11
# and 12"). Mr Botha's page with a picture: (1) the page in Microsoft Edge,
# the picture showing; (2) the same page with src="koeksisters.jpg" (the file
# is .png) - Edge's broken-picture icon and the alt text.
# The picture (koeksisters.png, drawn for the lesson) is carried in this
# script as base64. The site folder is also left in G:\My Drive\CAT\HTML\botha.
# Run from the host:  pwsh -File vm-shots.ps1 cathtml-images
# Read office-kit.ps1's safety rules: nothing clicks or types at the desktop.
$Name = 'cathtml-images'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$png = [Convert]::FromBase64String('iVBORw0KGgoAAAANSUhEUgAAAlgAAAGQCAIAAAD9V4nPAAAQAklEQVR4nO3dPY4UWRaG4WKEzzaaFbSPgYeEjY3BAmoZLKAN7LaR2msDvzcAswicdrFGmpRKqfyNyoyfc+73PNbMiKqKjDM337iRmVUvfv38/gAAqf6z9QEAwJaEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEe7n1ATCPxw/vnvsln//8y9lfkxnVZ0aZXvz6+X3rY2CN5TqFNM7IjOozI3aEMH3RniOKNzCj+syIY0JY3crr9pgiXmVG9ZkRFwjhIOv209tXz/0Rf/z977P+vSIeMKP6zIgphLDl0r0he3OlUQ7NqAXriOmEsM26XSh+N0cxsIhmVJ8ZcQMhLOHC6l25f88qYlQLzag+M+I2Qlh06W7ev+lFHD6HZlSfGXEPIdxMo6Ubm0Mzqs+MuJ8QFlq9xRN4NYeDtdCM6jMjZiGEa+u+dBNyaEb1mREz8ku3VzXS6j135Jt/cvlOZlSfGTEvO8ItV2/fBF7dGjbdF5pRfWbE7OwIVzLw6j35WDruC82oPjNiCXaEG6ze5RL4+v3HKf/sx9cv62wNG+0Lzag+M2IhQth+9U6M32pR7NhCM3ooz4y2nsDIhLDr6r2zf4sWsVcLzciMZhS7jloTwmbPsLP3b6GV3GUNm9ETM5pX1DrqzptlVtKlgnP9lI5vBTKj+syIJdgRrrHVuH/1rpPA2S9p969nC17MmpEZrWD4dTSAl1sfwJjm/fDA9ApOXHJTvuHsb6J5/PCu1Bo2o5PnxIyso0BCuLg7t4NXo3VDsfa/ZNG95qe3r6b8sd/NmdFDeWa09QRG5tZo6RtuFyo1+45t/2fN+80L3tgxowNmNJeodTQMO8K6zlVwoY/D777t6/cfl/u4/XjMqD4z4io7wqJbjZVX79JKXcya0UlmVF+pGY3ExyeK+vH1y3HzmlZwVGZUnxkxhR1h3bfjH+wOu1ewyMWsGV1gRvUVmdFgvEbYQPcEJjCj+syIc9waBSCaEAIQTQirv/g0jP1zstWf7TWjy8yovgozGo8QAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEM5m/xfgtviz7IG/LNiMLjOj+irMaDxCCEA0IQQgmhACEE0I5+QlqPovbJjROWZUX50ZDUYIAYgmhDOz4ah/GWtGx8yovmozGokQAhBNCOdnw1H/MtaM9plRfTVnNAwhXFzyh+u7PPYux5n82Lsc5xKSH/s6hHARLtnqn5Nqx1NBtXNS7XgqcE6WIIRLcfOt/s0cMzKj+urPaAAvtz6AFH/8/e+nt682+bnP/ZJZjrPjzRwzqs+MWMKLXz+/L/KN+b/HD+/2z8TSLVwoP8897IPDKH4Za0ZmdMA6SiOE7Z9nV957XT3+XhXcMaOH8sxo6wmMTAi7ruHN7z2efBQdK7hjRvWZEQsRwm3W8M05fG7/bvgpt/2I469qVMEdM6rPjFiCELZZw1P6tNBrkDfsPttVcMeM6jMjZieEG6/hq/W6GqGV34w6JYpNK7hjRvWZEfMSwtJr+EJ1NvkwxsRjax1CM2rBOmJGQlh0GZ/LzOb9O3buUIfPoRltzoyYhRDWWsMXFEzg8Dk0o/rMiPsJYYNlXDyBV3PYuoVm1IJ1xD2EsPQybpTA2ByaUR1mxG380u26mj7Dnjvy597CasGM6jMjrrIjHOczwgUN8Cn7HTOqz4y4mR3hxgZevScfS8d9oRnVZ0bcw44w4u8evH7/cco/+/H1y0IH4HeQXmVGN7OOuJMQDrt6Jz6xrhbFji00o4fyzGjrCYxACEdbvXf2b9Ei9mqhGZnRjGLXUQtCOMgz7Oz9W2gld1nDZvTEjOYVtY668GaZjXWp4Fw/peNbgcyoPjPiHnaEW2417l+96yRw9kva/evZghezZmRGKxh+HTXycusDyDLvhwemV3DikpvyDWd/E83jh3el1rAZnTwnZmQdDUwIN3PndvBqtG4o1v6XLLrX/PT21Q1/7Hd9ZvRQnhltPYERuDXa8obbhUrNvmPb/1nzfvOCN3bM6IAZzSVqHbVjR9jPuQou9HH43bd9/f7jch+3H48Z1WdGPLEjbLbVWHn1Lq3UxawZnWRG9ZWaUUc+PtHMj69fjpvXtIKjMqP6zIh9doT93o5/sDvsXsEiF7NmdIEZ1VdkRk15jbCx7glMYEb1mRFujQIQTQgBiCaEXV98Gsb+Odnqz/aa0WVmVF+FGfUlhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoSL2/8FuC3+LHvgLws2o8vMqL4KM+pLCAGIJoQARBNCAKIJ4Rq8BFX/hQ0zOseM6qszo6aEEIBoQrgSG476l7FmdMyM6qs2o46EEIBoQrgeG476l7FmtM+M6qs5o3aEcDPJH67v8ti7HGfyY+9ynEtIfuzzEsJVuWSrf06qHU8F1c5JteOpwDm5hxCuzc23+jdzzMiM6qs/o0Zebn0A6f74+99Pb19t8nOf+yWzHGfHmzlmVJ8ZcY8Xv35+v+sbcJPHD+/2/+vSLVwoP8897IPDKH4Za0ZmdMA6GpUQDvs8u/Le6+rx96rgjhk9lGdGW09gBEI42hre/N7jyUfRsYI7ZlSfGXEnIay1hm/O4XP7d8NPue1HHH9VowrumFF9ZsQ9hLD9Gp7Sp4Veg7xh99mugjtmVJ8ZcTMhLLqGr9braoRWfjPqlCg2reCOGdVnRtxGCFuu4QvV2eTDGBOPrXUIzagF64gbCGGzZXwuM5v379i5Qx0+h2a0OTPiWYSwxxq+oGACh8+hGdVnRkwnhI2XcfEEXs1h6xaaUQvWEVMIYctl3CiBsTk0ozrMiMv80u1+mj7Dnjvy597CasGM6jMjntgRjv8Z4YIG+JT9jhnVZ0ZcZUdY1MCr9+Rj6bgvNKP6zIgp7Aij/+7B6/cfp/yzH1+/LHQAfgfpVWZ0M+uIiYQwbvVOfGJdLYodW2hGD+WZ0dYT6EQIU1bvnf1btIi9WmhGZjSj2HVUihAO/gw7e/8WWsld1rAZPTGjeUWto2q8WaaoLhWc66d0fCuQGdVnRkxhR1hxq3H/6l0ngbNf0u5fzxa8mDUjM1rB8OuooJdbHwDzf3hgegUnLrkp33D2N9E8fnhXag2b0clzYkbW0QCEsJw7t4NXo3VDsfa/ZNG95qe3r274Y7/rM6OH8sxo6wl04tboUDfcLlRq9h3b/s+a95sXvLFjRgfMaC5R66gsO8JxnKvgQh+H333b1+8/Lvdx+/GYUX1mFMiOcJCtxsqrd2mlLmbN6CQzqq/UjCrz8YlB/Pj65bh5TSs4KjOqz4wy2RGO83b8g91h9woWuZg1owvMqL4iMyrOa4QD6p7ABGZUnxnlcGsUgGhCCEA0IXwY7MWnYeyfk63+bK8ZXWZG9VWYUX1CCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQriZ/V+A2+LPsgf+smAzusyM6qswo/qEEIBoQghANCEEIJoQbslLUPVf2DCjc8yovjozKk4IAYgmhBuz4ah/GWtGx8yovmozqkwIAYgmhNuz4ah/GWtG+8yovpozKksIy0n+cH2Xx97lOJMfe5fjXELyY7+NEJbgkq3+Oal2PBVUOyfVjqcC52QKIazCzbf6N3PMyIzqqz+jgoSwqLSbGx0fb8djTnu8HY/5HmmPdy5CWMjB5VvO/6cPHmnly1gzOnkeSjGjk+eBC4SwlsA13KiCO2ZkRgW1W0elCGE5Uc+zTVevGdVnRkz34tfP78/456zl8cO7g//l09tXI53+48B3qeATM6rPjJjCjrCo4yqMtDUcoIJm1IJ1xBR2hM2uZ7tvDU/mvGMFn5hRfWbEZXaEpZ0sRN+t4XgVNKMWrCMusyPsofsl7ZAJPGBG9ZkRJwlh7zVcP4fn9q+DVXDHjOozI44JYTONlnFUAveZUX1mxD4hHGoZVyjihZcwh0/gPjOqz4zYEcIB1/AmRbz6Fp6oCu6YUX1mhBBGrOTlojjl/auB/TtmRvWZUbK6O8Ip/7/kZjekse/HNpoyo/rM6LlqXhmXC6H+AQzvc6Ui1vpAvQoCJHisdM+vyo6w1EkBIGdrWCKEJyv45vfftjiWFN/++e9zv8REVmZG9ZnRLGds8xZuH8LjCnrCBYjK4edNW1jrNUIVBBjem2I3/P5TajtY7ewAsISDZ/tt3yayZQhVECDWmzItrHJr1F4QIM2bGncBq4QQALJCuL8LLnJRAMDK9p//t7o7akcIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiLZZCD//+dfTf/72z3+3OgwANrT//L/fhTXZEQIQrUoIbQoB0nyrcTtwyxAe7IKLnBEAVnDwnL/VfdHtd4RaCBDoW5kKbh/CY/aFAGP7Vuz+34tfP79vfQwPjx/eHf+Pb37/bYtjAWDVBG67HawSwnMtBGBsn7euYKEQ7sghQIjPBRJY8TXCOucFgJBn+1o7wn12hwCD+Vypfw1CCABxt0YBYGVCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQghANCEEIJoQAhBNCAGIJoQARBNCAKIJIQDRhBCAaEIIQDQhBCCaEAIQTQgBiCaEAEQTQgCiCSEA0YQQgGhCCEA0IQQgmhACEE0IAYgmhABEE0IAogkhANGEEIBoQgjAQ7L/ATE00c49KZCrAAAAAElFTkSuQmCC')

function PageWith ([string]$src) {
@"
<html>
<head>
<title>Botha's Bakery</title>
</head>
<body bgcolor="lightyellow">
<h1 align="center">Botha's Bakery</h1>
<img src="$src" alt="Nine golden koeksisters on a wooden board" width="300">
<p>Koeksisters: 6 for R40. Fresh every morning, in Centurion.</p>
</body>
</html>
"@
}

$dir = 'C:\sims\files\cathtml-images\botha'
New-Item -ItemType Directory -Force $dir | Out-Null
$utf8 = New-Object System.Text.UTF8Encoding($false)
[IO.File]::WriteAllBytes((Join-Path $dir 'koeksisters.png'), $png)
[IO.File]::WriteAllText((Join-Path $dir 'index.html'), (PageWith 'koeksisters.png').Replace("`r`n", "`n").Replace("`n", "`r`n"), $utf8)
[IO.File]::WriteAllText((Join-Path $dir 'broken.html'), (PageWith 'koeksisters.jpg').Replace("`r`n", "`n").Replace("`n", "`r`n"), $utf8)
$cloud = 'G:\My Drive\CAT\HTML\botha'
if (Test-Path 'G:\My Drive') { New-Item -ItemType Directory -Force $cloud | Out-Null; Copy-Item (Join-Path $dir '*') $cloud -Force; "copied to $cloud"; $dir = $cloud } else { 'NO G:\My Drive - the cloud copy was not made' }

function WindowOf ([string[]]$procs, [string]$like, [int]$tries = 60) {
  for ($i = 0; $i -lt $tries; $i++) {
    $p = Get-Process -Name $procs -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 -and $_.MainWindowTitle -like $like } | Select-Object -First 1
    if ($p) { return [IntPtr]$p.MainWindowHandle }
    Start-Sleep -Milliseconds 500
  }
  throw "No window like '$like' ($($procs -join ', '))"
}

$edge = @('C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe', 'C:\Program Files\Microsoft\Edge\Application\msedge.exe') | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $edge) { throw 'No Microsoft Edge in the VM' }
$n = 0
foreach ($page in 'index.html', 'broken.html') {
  $n++
  $profileDir = "C:\sims\edge-cathtml-$n"
  Remove-Item $profileDir -Recurse -Force -ErrorAction SilentlyContinue
  $file = Join-Path $dir $page
  try {
    Start-Process $edge -ArgumentList "--user-data-dir=$profileDir", '--no-first-run', '--no-default-browser-check', '--disable-sync', '--new-window', "file:///$($file.Replace('\', '/').Replace(' ', '%20'))" | Out-Null
    $h = WindowOf @('msedge') "*Botha*"
    [Shot]::Place($h, 40, 40, 900, 620); Start-Sleep -Milliseconds 3500
    Snap $n
  } finally {
    Get-CimInstance Win32_Process -Filter "Name = 'msedge.exe'" | Where-Object { $_.CommandLine -like "*edge-cathtml-$n*" } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
    Start-Sleep -Milliseconds 1500
  }
}
SaveMarks
