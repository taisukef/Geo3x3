Import-Module -Name ./ -Verbose
$code = ConvertTo-Geo3x3 35.65858 139.745433 14
Write-Output $code

$pos = ConvertFrom-Geo3x3 "E9139659937288"
Write-Output $pos
