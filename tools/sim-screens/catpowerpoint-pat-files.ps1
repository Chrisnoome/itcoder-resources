# The Word starter for Presentations lesson 6 (PhonesReport.docx, a Word outline of Thabo's report summary),
# made again on its own in real Word (8 October 2026: the first PhonesReport.docx came out with every line
# Heading 2). catpowerpoint-pat.ps1 makes it the same way. Into C:\sims\files\<name>\ and G:\My Drive\CAT\PowerPoint.
$Name = 'catpowerpoint-pat-files'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catpowerpoint-kit.ps1')
$files = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $files | Out-Null
$outline = @(
  @('Phones for school work', -2), @('Thabo, Grade 10 - CAT PAT', -3),
  @('The question', -2), @('Do Grade 10s use their phones for school work - and how?', -3),
  @('Finding 1: WhatsApp comes first', -2), @('40% use WhatsApp most for school work', -3), @('30% use Google Classroom', -3),
  @('Finding 2: Data is the problem', -2), @('1 in 4 run out of data before month-end', -3),
  @('Conclusion', -2), @('Most Grade 10s already use their phones for school work', -3), @('Mostly through WhatsApp class groups', -3),
  @('Recommendations', -2), @('Allow phones for school work in class', -3), @('Post homework on Google Classroom as well', -3), @('Free Wi-Fi in the library', -3),
  @('Sources', -2), @('My survey of 60 Grade 10 pupils, August 2026', -3), @('Interview with Ms Naidoo, CAT teacher, 12 August 2026', -3), @('BestLessons: From data to a report', -3))
WordOutline (Join-Path $files 'PhonesReport.docx') $outline
if (Test-Path 'G:\My Drive') { Copy-Item (Join-Path $files 'PhonesReport.docx') 'G:\My Drive\CAT\PowerPoint' -Force; 'starter -> G:\My Drive\CAT\PowerPoint' }
