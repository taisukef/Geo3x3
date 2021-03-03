class
    GEO3X3

feature

    encode (plat: DOUBLE; plng: DOUBLE; level: INTEGER) : STRING
        local
           res: STRING
           lat: DOUBLE
           lng: DOUBLE
           unit: DOUBLE
           i: INTEGER
           x: INTEGER
           y: INTEGER
        do 
           if level < 1 then
             Result := ""
           else
             res := ""
             lat := plat
             lng := plng

             if lng >= 0 then
               res.append_character ('E')
             else
               res.append_character ('W')
               lng := lng + 180
             end
             lat := lat + 90
             unit := 180

             from
               i := 1
             until
               i = level
             loop
                unit := unit / 3
                x := (lng / unit).floor
                y := (lat / unit).floor
                res.append_character ((('0').code + x + y * 3 + 1).to_character_8)
                lng := lng - x * unit
                lat := lat - y * unit
                i := i + 1
             end
             Result := res
           end
        end


    decode (code: STRING): TUPLE[lat: DOUBLE; lng: DOUBLE; level:INTEGER; unit:DOUBLE]
        local
           lat: DOUBLE
           lng: DOUBLE
           unit: DOUBLE
           level: INTEGER
           begin: INTEGER
           iswest: BOOLEAN
           c: CHARACTER
           clen: INTEGER
           i: INTEGER
           n: INTEGER
        do
           if code.count = 0 then
             Result := [0.0, 0.0, 0, 0.0]
           else
             -- [MEMO] STRING index start from 1
             begin := 0
             iswest := False
             c := code[1]
             if c = '-' or c = 'W' then
                iswest := True
                begin := 1
             elseif c = '+' or c = 'E' then
                begin := 1
             end

             unit := 180
             lat := 0
             lng := 0
             level := 1

             clen := code.count
             from
               i := begin
             until
               i = clen
             loop
                 n := code.item(i+1).code - ('0').code
                 if n <= 0 or 9 < n  then
                   i := clen
                 else
                   unit := unit / 3
                   n := n - 1
                   lng := lng + n \\ 3 * unit
                   lat := lat + n // 3 * unit
                   level := level + 1
                   i := i + 1
                 end
             end
             lat := lat + unit / 2
             lng := lng + unit / 2
             lat := lat - 90
             if iswest then
               lng := lng - 180
             end

             Result := [lat, lng, level, unit]
           end
        end
    end
