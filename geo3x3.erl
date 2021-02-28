-module(geo3x3).
-export([encode/3, decode/1]).

encode_loop(Level, I, Lat, Lng, Unit) ->
    if
        I >= Level -> [];
        true ->
            X = trunc(Lng / Unit),
            Y = trunc(Lat / Unit),
            N = X + Y * 3 + 1,
            Lng2 = Lng - float(X) * Unit,
            Lat2 = Lat - float(Y) * Unit,
            [ N + 48 | encode_loop(Level, I + 1, Lat2, Lng2, Unit / 3.0)]
    end.

encode(Lat, Lng, Level) ->
    if
        Level < 1 -> "";
        true -> 
            {Res, Lng1} =
                if
                    Lng >= 0.0 -> {"E", Lng};
                    true -> {"W", Lng + 180.0}
                end,
            Lng2 = Lng1,
            Lat2 = (Lat + 90.0), % 0:the North Pole,  180:the South Pole
            [Res | encode_loop(Level, 1, Lat2, Lng2, 180.0 / 3.0)]
    end.

decode_loop(Code, Clen, I, Lat, Lng, Level, Unit) ->
    if
        I >= Clen -> {Lat, Lng, Level, Unit};
        true ->
            Unit2 = Unit / 3.0,
            [N | _] = string:substr(Code, I + 1, 1),
            N2 = N - 49, % ignore err check
            Lat2 = Lat + (N2 div 3) * Unit2,
            Lng2 = Lng + (N2 rem 3) * Unit2,
            decode_loop(Code, Clen, I + 1, Lat2, Lng2, Level + 1, Unit2)
    end.

decode(Code) ->
    Clen = length(Code),
    if
        Clen < 1 -> {0.0, 0.0, 0, 180.0}; % err
        true ->
            [C | _] = Code,
            {Flg, Beg} =
                if
                    (C == $-) or (C == $W) -> {true, 1};
                    (C == $+) or (C == $E) -> {false, 1};
                    true -> {false, 0}
                end,
            {Lat, Lng, Level, Unit} = decode_loop(Code, Clen, Beg, 0.0, 0.0, 1, 180.0),
            Lat2 = Lat + (Unit / 2.0),
            Lng2 = Lng + (Unit / 2.0),
            Lat3 = Lat2 - 90.0,
            Lng3 = if
                    Flg -> Lng2 - 180.0;
                    true -> Lng2
                end,
            {Lat3, Lng3, Level, Unit}
    end.
