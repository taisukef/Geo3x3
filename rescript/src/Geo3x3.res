module Geo3x3 = {
  let rec encode_fn = (code, level, i, lat, lng, unit) => {
    if i >= level {
      code
    } else {
      encode_fn(
        code ++ Js.String2.make(1 + Js.Math.floor_int(lng /. unit) + Js.Math.floor_int(lat /. unit) * 3),
        level,
        i + 1,
        lat -. Js.Math.floor_float(lat /. unit) *. unit,
        lng -. Js.Math.floor_float(lng /. unit) *. unit,
        unit /. 3.0
      )
    }
  }
  let encode = (lat, lng, level) => {
    if level < 1 {
      ""
    } else {
      encode_fn(
        lng >= 0.0 ? "E" : "W",
        level,
        1,
        lat +. 90.0,
        lng >= 0.0 ? lng : lng +. 180.0,
        180.0 /. 3.0
      )
    }
  }

  let rec decode_fn = (code, lat, lng, level, unit) => {
    if Js.String2.length(code) == 0 {
      [lat +. unit *. 3.0 /. 2.0 -. 90.0, lng +. unit *. 3.0 /. 2.0, level, unit *. 3.0]
    } else {
      let n = Belt.Float.toInt(Js.String2.charCodeAt(code, 0)) - 49
      decode_fn(
        Js.String2.substr(~from=1, code),
        lat +. Belt.Int.toFloat(n / 3) *. unit,
        lng +. Belt.Int.toFloat(mod(n, 3)) *. unit,
        level +. 1.0,
        unit /. 3.0
      )
    }
  }
  let decode_fne = (code) => {
    decode_fn(code, 0.0, 0.0, 1.0, 180.0 /. 3.0)
  }
  let decode_fnw = (code) => {
    let pos = decode_fne(code)
    [pos[0], pos[1] -. 180.0, pos[2], pos[3]]
  }
  let decode = (code) => {
    let c = Js.String2.charAt(code, 0)
    if c == "W" {
      decode_fnw(Js.String2.substr(~from=1, code))
    } else {
      decode_fne(Js.String2.substr(~from=1, code))
    }
  }
}

Js.log(Geo3x3.encode(35.65858, 139.745433, 14))
Js.log(Geo3x3.decode("E9139659937288"))