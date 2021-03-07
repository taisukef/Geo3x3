{$mode objfpc}
unit geo3x3;

interface

type
  latlnglevelunit = array of real;

function Geo3x3_encode(lat: real; lng: real; level: integer): string;
function Geo3x3_decode(code: string): latlnglevelunit; static;

implementation

uses
  sysutils,
  math;


function Geo3x3_encode(lat: real; lng: real; level: integer): string;
var
  unitsize: real;
  i: integer;
  x: integer;
  y: integer;
begin
	if level < 1 then
		result := ''
  else
  begin
    result := 'E';
    if lng < 0.0 then
    begin
      result := 'W';
      lng := lng + 180.0;
    end;
		lat := lat + 90.0; { 180:the North Pole,  0:the South Pole }
		unitsize := 180.0;
		for i := 1 to level - 1 do
    begin
    	unitsize := unitsize / 3.0;
			x := Floor(lng / unitsize);
			y := Floor(lat / unitsize);
			result := result + IntToStr(x + y * 3 + 1);
			lng := lng - x * unitsize;
			lat := lat - y * unitsize;
		end
  end
end;

function Geo3x3_decode(code: string): latlnglevelunit; static;
var
  flg: boolean;
  unitsize: real;
  lat: real;
  lng: real;
  level: integer;
  n: integer;
  i: integer;
begin
  if length(code) = 0 then
    result := [0, 0, 0, 0]
  else
  begin
    flg := integer(code[1]) = 87; { ascii code of "W" }
		unitsize := 180.0;
		lat := 0.0;
		lng := 0.0;
		level := 1;
		for i := 1 to length(code) - 1 do
    begin
			n := integer(code[i + 1]) - 49; { ascii code of "1" }
      if (n < 0) or (n > 9) then
        break;
			unitsize := unitsize / 3.0;
			lng := lng + (n mod 3) * unitsize;
			lat := lat + Floor(n / 3) * unitsize;
			level := level + 1;
    end;
		lat := lat + unitsize / 2.0;
		lng := lng + unitsize / 2.0;
		lat := lat - 90.0;
    if flg then
      lng := lng - 180.0;
    result := [ lat, lng, level, unitsize];
  end;
end;

end.
