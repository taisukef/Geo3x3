with Geo3x3; use Geo3x3;
with Ada.Text_IO; use Ada.Text_IO;

procedure Simple_Geo3x3 is
   T: WGS84;
begin
   Put_Line(Encode(35.65858, 139.745433, 14));
   T := Decode("E9139659937288");
   Put_Line (Long_Float'Image(T.Lat) & " " & Long_Float'Image(T.Lng) & " " & Integer'Image(T.Level) & " " & Long_Float'Image(T.Unit));
end Simple_Geo3x3;
