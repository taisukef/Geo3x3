package Geo3x3 is
   function Encode (PLat: in Long_Float; PLng: in Long_Float; Level: in Integer) return String;

   type WGS84 is record
      Lat   : Long_Float;
      Lng   : Long_Float;
      Level : Integer;
      Unit  : Long_Float;
   end record;

   function Decode (Code: in String) return WGS84;

end Geo3x3;
