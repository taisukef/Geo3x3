package geo3x3;
 
use Exporter;
@ISA = (Exporter);
@EXPORT = qw(encode, decode);

use strict;
use warnings;
use POSIX;
 
sub encode {
  my $lat = $_[0];
  my $lng = $_[1];
  my $level = $_[2];
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
  $lat = 90.0 - $lat;
  my $unit = 180.0;
  for (my $i = 1; $i < $level; $i++) {
    $unit /= 3;
    my $x = floor($lng / $unit);
    my $y = floor($lat / $unit);
    $res = $res . ($x + $y * 3 + 1);
    $lng -= $x * $unit;
    $lat -= $y * $unit;
  }
  return $res;
}

sub decode {
  my $code = $_[0];
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
  for (my $i = $begin; $i < length $code; $i++) {
    $cc = unpack("C", substr($code, $i, $i + 1));
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
  $lat = 90.0 - $lat;
  if ($flg) {
    $lng -= 180.0;
  }
  return ($lat, $lng, $level, $unit);
}
