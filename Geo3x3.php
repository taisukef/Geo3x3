<?php

class Geo3x3 {
  public static function encode(float $lat, float $lng, int $level): string {
    if ($level < 1) {
      return "";
    }
    if ($lng >= 0) {
      $res = "E";
    } else {
      $res = "W";
      $lng += 180;
    }
    $lat += 90;
    $unit = 180.0;
    for ($i = 1; $i < $level; $i++) {
      $unit /= 3;
      $x = (int)($lng / $unit);
      $y = (int)($lat / $unit);
      $res = $res . chr(ord('0') + $x + $y * 3 + 1);
      $lng -= $x * $unit;
      $lat -= $y * $unit;
    }
    return $res;
  }
  public static function decode(string $code): array {
    $c = $code[0];
    $begin = 0;
    $flg = false;
    if ($c == "-" || $c == "W") {
      $flg = true;
      $begin++;
    } else if ($c == "E" || $c == "+") {
      $begin++;
    }
    $unit = 180.0;
    $lat = 0.0;
    $lng = 0.0;
    $level = 1;
    $clen = strlen($code);
    for ($i = $begin; $i < $clen; $i++) {
      $c = $code[$i];
      $n = (int)$c;
      if ($n == 0) {
        break;
      }

      $unit /= 3;
      $n--;
      $lng += $n % 3 * $unit;
      $lat += (int)($n / 3) * $unit;
      $level++;
    }
    $lat += $unit / 2;
    $lng += $unit / 2;
    $lat -= 90;
    if ($flg) {
      $lng -= 180.0;
    }
    return [$lat, $lng, $level, $unit];
  }
}
?>
