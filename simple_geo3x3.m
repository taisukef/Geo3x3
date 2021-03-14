disp(geo3x3_encode(35.65858, 139.745433, 14));

[lat, lng, level, unit] = geo3x3_decode("E9139659937288");
printf("%f %f %d %f", lat, lng, level, unit)
