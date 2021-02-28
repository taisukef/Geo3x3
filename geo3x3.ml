open String;;

let encode lat lng level =
    if level < 1 then
        ""
    else
        let (res, lng1) =
            if lng >= 0.0 then
                ("E", lng)
            else
                ("W", lng +. 180.0) in
        let lng2 = lng1 in
        let lat2 = lat +. 90.0 in (* 180:the North Pole,  0:the South Pole *)
        let rec loop i lat lng unit =
            if i >= level then
                ""
            else
                let x = int_of_float (lng /. unit) in
                let y = int_of_float (lat /. unit) in
                let n = x + y * 3 + 1 in
                let lng2 = lng -. (float_of_int x) *. unit in
                let lat2 = lat -. (float_of_int y) *. unit in
                (string_of_int n) ^ (loop (i + 1) lat2 lng2 (unit /. 3.0)) in
        res ^ (loop 1 lat2 lng2 (180.0 /. 3.0));;

let decode code = (* (35., 135., 14, 0.1);; *)
    let clen = String.length code in
    if clen < 1 then
        (0.0, 0.0, 0, 180.0) (* err *)
    else
        let c = code.[0] in
        let (flg, beg) =
            if c = '-' || c = 'W' then
                (true, 1)
            else if c = '+' || c = 'E' then
                (false, 1)
            else
                (false, 0) in
        let rec loop i lat lng level unit =
            if i >= clen then
                (lat, lng, level, unit)
            else
                let unit2 = unit /. 3.0 in
                let n = (int_of_char code.[i]) - 49 in (* ignore err check *)
                let lat2 = lat +. (float_of_int (n / 3)) *. unit2 in
                let lng2 = lng +. (float_of_int (n mod 3)) *. unit2 in
                loop (i + 1) lat2 lng2 (level + 1) unit2 in
        let (lat, lng, level, unit) = loop beg 0.0 0.0 1 180.0 in
        let lat2 = lat +. (unit /. 2.0) in
        let lng2 = lng +. (unit /. 2.0) in
        let lat3 = lat2 -. 90.0 in
        let lng3 = if flg then lng2 -. 180.0 else lng2 in
        (lat3, lng3, level, unit);;
