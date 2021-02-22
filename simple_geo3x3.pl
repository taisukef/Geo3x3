#!/usr/bin/perl
 
use lib qw(./);
use geo3x3;

my $code = geo3x3::encode(35.65858, 139.745433, 14);
print $code . "\n";

my ($lat, $lng, $level, $unit) = geo3x3::decode("E3793653391822");
print $lat . " " . $lng . " " . $level . " " . $unit . "\n";
