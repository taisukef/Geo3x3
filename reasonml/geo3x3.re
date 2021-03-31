let encode = (lat: float, lng: float, level: int) => {
    let res = if (lng < 0.0) {contents: "W"} else {contents:"E"}
    let lng = if (lng < 0.0) {lng +. 180.0;} else {lng;}
    let lat = lat +. 90.0;
    let unit = ref(180.0);
    let lat2 = ref(lat);
    let lng2 = ref(lng);
    let level = ref(level);
    
    while (level^ > 0) {
      unit := unit^ /. 3.0;
      let x: int = int_of_float(lng2^ /. unit^);
      let y: int = int_of_float(lat2^ /. unit^);
      
      res := res^ ++ string_of_int(x + y * 3 + 1);
      
      lng2 := lng2^ -. float_of_int(x) *. unit^;
      lat2 := lat2^ -. float_of_int(y) *. unit^;
      
      level := level^ - 1
    }
    
    res^;
}
  
let decode = (code: string) => {
    let unit = ref(180.0);
    let lat = ref(0.0);
    let lng = ref(0.0);
    let level = ref(1);
    let c = (code.[0]);

    let flg = if (c == 'W') {true;} else {false;}

    for (i in 1 to String.length(code)-1) {
        let n = String.index("0123456789", code.[i])
        
        unit := unit^ /. 3.0;
        lng := lng^ +. float_of_int((n-1) mod 3) *. unit^;
        lat := lat^ +. float_of_int((n-1) / 3) *. unit^;
        level := level^ + 1;
    }

    lat := lat^ +. unit^ /. 2.0;
    lng := lng^ +. unit^ /. 2.0;
    lat := lat^ -. 90.0;
    lng := if (flg) {lng^ -. 180.0;} else {lng^;}
    
    let result = (lat, lng, level, unit);

    result;
}