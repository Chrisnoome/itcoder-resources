# The Layout gallery open for Presentations lesson 1 (catpowerpoint-start's lay-2 picture): the
# lesson script's own try leaves the gallery shut, so this short run takes that one moment, the
# same way catpowerpoint-dbg did (a fresh PowerPoint, then a real click on Layout). Cropped by hand
# with the cat-crop box (9, 58, 1791, 871) into catpowerpoint-start-lay-2.png.
$Name = 'catpowerpoint-startlay'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')
try {
  StartPowerPoint 1800 880
  $pp.ActiveWindow.SplitHorizontal = 11
  $why  = "Videos play in HD`rApps update on mobile data`rWhatsApp downloads every photo"
  $five = "Use Wi-Fi when you can`rTurn off auto-play`rSet apps to update on Wi-Fi only`rStop WhatsApp downloading media`rCheck which apps use the most"
  $null = AddSlide 'Title Slide' @('Make your data last', 'Thabo, Grade 10')
  $null = AddSlide 'Title and Content' @('Why data runs out', $why)
  $null = AddSlide 'Title and Content' @()
  $null = AddSlide 'Title and Content' @('Five ways to save data', $five)
  $null = AddSlide 'Title and Content' @('Five ways to save data', $five)
  GoTo 3
  $lay = Box (Find $root @('Layout') $T::MenuItem)
  Snap 'a'
  RealClick $lay
  Start-Sleep -Milliseconds 1000
  Grab '1'
  try { Mark 'twoContent' (Box (FindAnywhere @('Two Content') -tries 4)) } catch { '  MISSING twoContent' }
  RealKey 0x1B
  SaveMarks
}
catch { "FAILED: $_"; throw }
finally { ClosePowerPoint }
