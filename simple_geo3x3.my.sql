source geo3x3.my.sql;

select Geo3x3_encode(35.65858, 139.745433, 14);

call Geo3x3_decode("E913965993728", @lat, @lng, @level, @unit);
select @lat, @lng, @level, @unit;
