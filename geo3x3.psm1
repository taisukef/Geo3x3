function Encode-Geo3x3 {
    param (
        [double]$lat,
        [double]$lng,
        [int]$level
    )
    if ($level -lt 1) {
        return $null
    }
    [string]$res = ""
    if ($lng -ge 0) {
        $res = "E"
    }else {
        $res = "W"
        $lng += 180
    }
    $lat += 90
    [double]$unit = 180
    for ($i = 1; $i -lt $level; $i++) {
        $unit /= 3
        $x = [Math]::Floor($lng / $unit)
        $y = [Math]::Floor($lat / $unit)
        $res += $x + $y * 3 + 1
        $lng -= [double]$x * $unit
        $lat -= [double]$y * $unit
    }
    return $res
}

function Decode-Geo3x3 {
    param (
        [string]$code
    )
    [int]$clen = $code.Length
    if ($clen -eq 0) {
        return $null
    }
    [int]$begin = 0
    [bool]$flg = $false
    [char]$c = $code[0]
    if (($c -eq '-') -or ($c -eq 'W')) {
        $flg = $true
        $begin = 1
    }elseif (($c -eq '+') -or ($c -eq 'E')) {
        $begin = 1
    }
    [double]$unit = 180
    [double]$lat = 0
    [double]$lng = 0
    [int]$level = 1
    for ($i = $begin; $i -lt $clen; $i++) {
        $n = "0123456789".IndexOf($code[$i])
        if ($n -le 0) {
            return $null
        }
        $unit /= 3
        $n -= 1
        $lng += [double]$n % 3 * $unit
        $lat += [double]$n / 3 * $unit
        $level += 1
    }
    $lat += $unit / 2
    $lng += $unit / 2
    $lat -= 90
    if ($flg) {
        $lng -= 180
    }
    return ($lat, $lng, $level,$unit)
}
