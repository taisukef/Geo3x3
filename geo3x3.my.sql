delimiter //

create or replace function Geo3x3_encode(lat real, lng real, level int) returns char(50) deterministic
begin
    set @result = "";
    if lng >= 0.0 then
        set @result = "E";
    else
        set lng = lng + 180.0;
        set @result = "W";
    end if;
    set lat = lat + 90.0;
    set @unit = 180.0;
    set @i = 1;
    while @i < level - 1 do
        set @unit = @unit / 3;
        set @x = lng div @unit;
        set @y = lat div @unit;
        set @result = concat(@result, @x + @y * 3 + 1);
        set lng = lng - @x * @unit;
        set lat = lat - @y * @unit;
        set @i = @i + 1;
    end while;
    return @result;
end;//

create or replace procedure Geo3x3_decode(in code char(50),
    out lat real,
    out lng real,
    out level int,
    out unit real)
begin
    set unit = 180.0;
    set lat = 0.0;
    set lng = 0.0;
    set level = 1;
    set @clen = length(code);
    if @clen > 0 then
        set @flg = substr(code, 1, 1) = "W";
        set @i = 1;
        while @i <= @clen do
            set @n = ascii(substr(code, @i + 1, 1)) - 49;
            set unit = unit / 3;
            set lng = lng + (@n mod 3) * unit;
            set lat = lat + (@n div 3) * unit;
            set level = level + 1;
            set @i = @i + 1;
        end while;

        set lat = lat + unit / 2;
        set lng = lng + unit / 2;
        set lat = lat - 90;
        if @flg then
            set lng = lng - 180.0;
        end if;
    end if;
end;//

delimiter ;
