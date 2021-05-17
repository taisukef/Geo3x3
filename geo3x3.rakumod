unit module geo3x3;

sub encode ($lat, $lng, $level) is export {
  if ($level < 1) {
    return "";
  }
  my $res = "";
  if ($lng >= 0.0) {
    $res = "E";
  } else {
    $res = "W";
    $lng += 180.0;
  }
  my $mlat = $lat + 90.0;
  my $mlng = $lng;
  my $unit = 180.0;
  loop (my $i = 1; $i < $level; $i++) {
    $unit /= 3;
    my $x = floor($mlng / $unit);
    my $y = floor($mlat / $unit);
    $res = $res ~ ($x + $y * 3 + 1);
    $mlng -= $x * $unit;
    $mlat -= $y * $unit;
  }
  return $res;
}

sub decode ($code) is export {
  my $c = substr($code, 0, 1);
  my $begin = 0;
  my $flg = 0;
  if ($c eq "-" or $c eq "W") {
    $flg = 1;
    $begin = 1;
  } elsif ($c eq "+" or $c eq "E") {
    $begin = 1;
  }
  my $unit = 180.0;
  my $lat = 0.0;
  my $lng = 0.0;
  my $level = 1;
  my $cc;
  my $n;
  loop (my $i = $begin; $i < $code.chars; $i++) {
    $cc = $code.substr($i, $i + 1).ords[0];
    $n = $cc - 48;
    if ($n == 0) {
      last;
    }
    $unit /= 3;
    $n--;
    $lng += floor($n % 3) * $unit;
    $lat += floor($n / 3) * $unit;
    $level++;
  }
  $lat += $unit / 2;
  $lng += $unit / 2;
  $lat -= 90.0;
  if ($flg) {
    $lng -= 180.0;
  }
  return ($lat, $lng, $level, $unit);
}
