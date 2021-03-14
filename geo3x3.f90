module geo3x3
  implicit none
contains
  character(50) function geo3x3_encode(lat, lng, level)
    real lat
    real lng
    integer level

    real flat
    real flng
    real unit
    integer i, x, y

    flat = lat
    flng = lng
    if (lng >= 0.0) then
      geo3x3_encode = "E"
    else
      geo3x3_encode = "W"
      flng = flng + 180.0
    end if
    flat = flat + 90.0
    unit = 180.0
    do i = 1, level - 1
      unit = unit / 3
      x = floor(flng / unit)
      y = floor(flat / unit)
      geo3x3_encode(i + 1: i + 1) = char(x + y * 3 + 1 + 48)
      flng = flng - x * unit
      flat = flat - y * unit
    end do
    !geo3x3_encode = "W"
  end

  function geo3x3_decode(code)
    character(len=*) code
    real geo3x3_decode(4)

    real lat
    real lng
    real level
    real unit
    integer flg, i, n

    lat = 0.0
    lng = 0.0
    level = 0
    unit = 180.0

    if (len(code) > 0) then
      flg = 0
      if (code(1:1) == "W") then
        flg = 1
      end if
      level = level + 1
      do i = 2, len(code)
        n = index("123456789", code(i:i)) - 1
        if (n >= 0) then
          unit = unit / 3
          lng = lng + mod(n, 3) * unit
          lat = lat + n / 3 * unit
          level = level + 1
        end if
      end do

      lat = lat + unit / 2
      lng = lng + unit / 2
      lat = lat - 90
      if (flg == 1) then
        lng = lng - 180.0
      end if
    end if
    geo3x3_decode = [lat, lng, level, unit]
  end
end
