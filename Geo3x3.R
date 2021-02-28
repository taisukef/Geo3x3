Geo3x3_encode <- function(lat, lng, level) {
  if (level < 1) {
    return ("")
  }
  res = "E"
  if (lng < 0) {
    res = "W"
    lng <- lng + 180.
  }
  lat <- lat + 90. # 180:the North Pole,  0:the South Pole
  unit <- 180.
  for (i in 1:level - 1) {
    unit <- unit / 3
    x <- floor(lng / unit)
    y <- floor(lat / unit)
    res <- paste(res, x + y * 3 + 1, sep="")
    lng <- lng - x * unit
    lat <- lat - y * unit
  }
  return (res)
}
Geo3x3_decode <- function(code) {
  clen <- nchar(code)
  if (clen == 0) {
    return (NA);
  }
  flg <- substring(code, 1, 1) == 'W'
  unit <- 180.
  lat <- 0.
  lng <- 0.
  level <- 1
  print(clen)
  for (i in 1:(clen - 1)) {
    c <- substring(code, i + 1, i + 1)
    if (c < '0' || c > '9') {
      break
    }
    n <- strtoi(charToRaw(c)) - strtoi(charToRaw('0'))
    if (n == 0) {
      break
    }
    unit <- unit / 3
    n <- n - 1
    lng <- lng + (n %% 3) * unit
    lat <- lat + floor(n / 3) * unit
    level <- level + 1
  }
  lat <- lat + unit / 2
  lng <- lng + unit / 2
  lat <- lat - 90
  if (flg) {
    lng <- lng - 180
  }
  return (list(lat=lat, lng=lng, level=level, unit=unit))
}
