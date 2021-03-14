function res = geo3x3_encode (lat, lng, level)
  if level < 1
    res = "";
  else
    res = "";
    if lng >= 0.0
      res = "E";
    else
      res = "W";
      lng = lng + 180.0;
    end
    lat += 90.0;
    unit = 180.0;
    for i = 1 : level - 1
      unit = unit / 3;
      x = floor(lng / unit);
      y = floor(lat / unit);
      res = strcat(res, num2str(x + y * 3 + 1));
      lng = lng - x * unit;
      lat = lat - y * unit;
    end
  end
end
