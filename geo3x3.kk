module geo3x3

import std/num/float64


pub fun geo3x3_encode (lat : float64, lng : float64, level: int) : div string
  fun f ()
    val (c,lng'') = if lng >= 0.0 then ('E',lng)
                                  else ('W',lng + 180.0)
    var lng' := lng''
    var lat' := lat + 90.0
    var unit := 180.0
    var res  := ""

    fun loop (i : int)
      if i < level then
        unit := unit / 3.0
        val x = int(floor (lng' / unit))
        val y = int(floor (lat' / unit))
        val c' = char ((int('0')) + x + y * 3 + 1)
        lng' := lng' - float64(x) * unit
        lat' := lat' - float64(y) * unit
        res := res ++ string (c')
        loop (i+1)
      else ()

    res := res ++ string (c)
    loop(1)
    res

  if level < 0 then "" else f()





pub fun geo3x3_decode (code : string) : div (float64, float64, int, float64)
  fun f ()
    val (begin,isWest) =
      match head-char(code)
        Just ('-') -> (1,True)
        Just ('W') -> (1,True)
        Just ('+') -> (1,False)
        Just ('E') -> (1,False)
        _ -> (0,False)
    var unit  := 180.0
    var lat   := 0.0
    var lng   := 0.0
    var level := 1
    val clen = code.count

    fun loop (i : int)
      if i < clen then
        val n = match code.first.advance(i).string.head-char
                  Just (c) -> int(c) - int('0')
                  _ -> 0
        if 1 <= n && n <= 9 then
          val n' = n - 1
          unit := unit / 3.0
          lng := lng + (float64 (n' % 3)) * unit
          lat := lat + (float64 (n' / 3)) * unit
          level := level + 1
          loop (i+1)
        else ()
      else ()

    loop (begin)

    lat := lat + unit / 2.0
    lng := lng + unit / 2.0

    val lat' = lat - 90.0
    val lng' = if isWest then lng - 180.0 else lng

    (lat', lng', level, unit)


  if is-empty(code) then (0.0, 0.0, 0, 0.0)
  else f()

