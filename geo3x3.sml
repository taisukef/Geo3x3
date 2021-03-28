fun geo3x3_encode (lat : real) (lng : real) (level: int) : string =
  if level < 0 then ""
  else
    let
      val (c,lng) = if lng >= 0.0 then (#"E",lng)
                                  else (#"W",lng + 180.0);
      val lng = ref lng;
      val lat = ref (lat + 90.0);
      val unit = ref 180.0;
      val res = ref "";
    in
      let
        fun loop i = if i < level then
                       let
                         val _ = unit := !unit / 3.0;
                         val x = floor (!lng / !unit);
                         val y = floor (!lat / !unit);
                         val c = chr ((ord #"0") + x + y * 3 + 1);
                         val _ = lng := !lng - (Real.fromInt x) * !unit;
                         val _ = lat := !lat - (Real.fromInt y) * !unit;
                       in
                         res := !res ^ str c;
                         loop (i+1)
                       end
                     else ()
      in
        res := !res ^ str c;
        loop (1);
        !res
      end
    end


fun geo3x3_decode (code : string) : (real * real * int * real) =
  if size code = 0 then (0.0, 0.0, 0, 0.0)
  else
    let
      val (begin,isWest) =
              case String.sub (code,0) of
                  #"-" => (1,true)
                | #"W" => (1,true)
                | #"+" => (1,false)
                | #"E" => (1,false)
                | _ => (0,false)
      val unit = ref 180.0;
      val lat = ref 0.0;
      val lng = ref 0.0;
      val level = ref 1;
      val clen = size code;
    in
      let
        fun loop i =
          if i < clen then
            let
              val n = ord (String.sub (code,i)) - ord #"0"
            in
              if 1 <= n andalso n <= 9 then
                let
                  val n = n - 1
                in
                  unit := !unit / 3.0;
                  lng := !lng + (Real.fromInt (n mod 3)) * !unit;
                  lat := !lat + (Real.fromInt (n div 3)) * !unit;
                  level := !level + 1;
                  loop (i+1)
                end
              else ()
            end
          else ()
      in
        loop begin;
        lat := let val lat = !lat + !unit / 2.0 in lat - 90.0 end;
        lng := let val lng = !lng + !unit / 2.0 in if isWest then lng -180.0 else lng end;
        (!lat, !lng, !level, !unit)
      end
    end

