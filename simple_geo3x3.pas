{$mode objfpc}
program simple_geo3x3;

uses
  geo3x3;

var
  res: latlnglevelunit;
begin
  writeln(Geo3x3_encode(35.65858, 139.745433, 14));
  res := Geo3x3_decode('E9139659937288');
  writeln(res[0], res[1], res[2], res[3]);
end.
