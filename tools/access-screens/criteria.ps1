# How Query Design turns what you type in a Criteria cell into SQL - asked of
# Access itself with Application.BuildCriteria, the function the grid uses.
# Access stays INVISIBLE: no window, nothing in front, nothing to type into,
# so no hands-off is needed (26 September 2026). 64-bit PowerShell.
$app = New-Object -ComObject Access.Application
try {
  $app.Visible = $false
  foreach ($pair in @(
      @('SaleDate', 8,  'Between #2026/02/01# And #2026/02/28#'),
      @('SaleDate', 8,  '>=2026/02/01'),
      @('SaleDate', 8,  '#2026/03/20#'),
      @('SaleDate', 8,  '#03/04/2026#'),
      @('SaleDate', 8,  '>Date()-30'),
      @('Category', 10, 'Drinks'),
      @('ProductName', 10, '*chips'),
      @('Price', 5, '<10'))) {
    '{0,-40} -> {1}' -f ($pair[0] + ': ' + $pair[2]), $app.BuildCriteria($pair[0], $pair[1], $pair[2])
  }
} finally {
  $app.Quit(2)
  [Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
}
