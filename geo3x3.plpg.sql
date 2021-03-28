create or replace function Geo3x3_encode(lat real, lng real, level int) returns text as $$
declare
    result text;
    i int = 1;
    unit real = 180.0;
    x int = 0;
    y int = 0;
begin
    if lng >= 0.0 then
        result = 'E';
    else
        lng = lng + 180.0;
        result = 'W';
    end if;
    lat = lat + 90.0;
    while i < level loop
        -- RAISE notice 'lat=%, lng=%, unit=%', lat, lng, unit;
        unit = unit / 3.0;
        x = floor(lng / unit);
        y = floor(lat / unit);
        result = concat(result, x + y * 3 + 1);
        lng = lng - x * unit;
        lat = lat - y * unit;
        i = i + 1;
    end loop;
    return result;
end;
$$ language plpgsql;

create or replace function Geo3x3_decode(in code text)
returns table(
    lat real,
    lng real,
    level int,
    unit real) as $$
declare
    i int = 1;
    clen int = 0;
    flg boolean = false;
    n int = 0;
begin
    unit = 180.0;
    lat = 0.0;
    lng = 0.0;
    level = 1;
    clen = length(code);
    if clen > 0 then
        flg = substr(code, 1, 1) = 'W';
        i = 1;
        while i < clen loop
            n = ascii(substr(code, i + 1, 1)) - 49;
            unit = unit / 3;
            lng = lng + (n % 3) * unit;
            lat = lat + floor(n / 3) * unit;
            level = level + 1;
            i = i + 1;
        end loop;

        lat = lat + unit / 2;
        lng = lng + unit / 2;
        lat = lat - 90;
        if flg then
            lng = lng - 180.0;
        end if;
    end if;
    return next;
end;
$$ language plpgsql;
