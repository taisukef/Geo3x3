function [lat, lng, level, unit] = geo3x3_decode (code)
  c = substr(code, 1, 1);
  flg = c == "W";
  unit = 180.0;
  lat = 0.0;
  lng = 0.0;
  level = 1;
  for i = 1 : length(code) - 1
    n = str2num(substr(code, i + 1, 1));
    if n == 0
      break;
    end
    unit = unit / 3;
    n = n - 1;
    lng = lng + mod(n, 3) * unit;
    lat = lat + floor(n / 3) * unit;
    level = level + 1;
  end
  lat = lat + unit / 2;
  lng = lng + unit / 2;
  lat -= 90.0;
  if flg
    lng = lng - 180.0;
  end
end
