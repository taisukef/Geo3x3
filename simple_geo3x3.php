<?php

require __DIR__ . '/Geo3x3.php';

$code = Geo3x3::encode(35.65858, 139.745433, 14);
echo "{$code}\n";

[$lat, $lng, $level, $unit] = Geo3x3::decode('E9139659937288');
echo "{$lat} {$lng} {$level} {$unit}\n";
