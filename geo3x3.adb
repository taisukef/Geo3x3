with Ada.Strings.Unbounded;

package body Geo3x3 is
   function Encode (PLat: in Long_Float; PLng: in Long_Float; Level: in Integer) return String is
      use Ada.Strings.Unbounded;
      Res:  Unbounded_String;
      Lat:  Long_Float;
      Lng:  Long_Float;
      Unit: Long_Float;
   begin
      Lng := PLng;
      Lat := PLat;
      
      if Lng >= 0.0 then
	 Append (Res,'E');
      else
	 Append (Res,'W');
	 Lng := Lng + 180.0;
      end if;
      Lat := Lat + 90.0;
      Unit := 180.0;
      
      declare
	 I: Integer;
	 X: Integer;
	 Y: Integer;
	 C: Integer;
      begin
	 I := 1;
	 loop
	    exit when I = Level;
	    Unit := Unit / 3.0;
	    X := Integer(Long_Float'Floor(Lng / Unit));
	    Y := Integer(Long_Float'Floor(Lat / Unit));
	    C := Character'Pos('0') + X + Y * 3 + 1;
	    Append (Res,Character'Val(C));
	    Lng := Lng - Long_Float(X) * Unit;
	    Lat := Lat - Long_Float(Y) * Unit;
	    I := I + 1;
	 end loop;
      end;      
      
      return To_String(Res);
   end Encode;
   
   function Decode (Code: in String) return WGS84 is
      Lat  : Long_Float;
      Lng  : Long_Float;
      Unit : Long_Float;
      Level: Integer;
   begin
      declare
	 Init   : Integer;
	 IsWest : Boolean;
	 C      : Character;
	 CLen   : Integer;
      begin
	 Init := 0;
	 IsWest := False;
	 C := Code(Code'First);
	 if C = '-' or C = 'W' then
	    IsWest := True;
	    Init   := 1;
	 elsif C = '+' or C = 'E' then
	    Init   := 1;
	 end if;
	 
	 Unit  := 180.0;
	 Lat   := 0.0;
	 Lng   := 0.0;
	 Level := 1;
	 
	 CLen := Code'Length;
	 declare
	    I: Integer;
	    N: Integer;
	 begin
	    I := Init;
	    loop
	       exit when I = Clen;
	       N := Character'Pos(Code(I+1)) - Character'Pos('0');
	       if N <= 0 or 9 < N then
		  I := Clen;
	       else
		  Unit := Unit / 3.0;
		  N := N - 1;
		  Lng := Lng + Long_Float(N rem 3) * Unit;
		  Lat := Lat + Long_Float(N /   3) * Unit;
		  Level := Level + 1;
		  I := I + 1;
	       end if;
	    end loop;
	 end;      
	 
	 Lat := Lat + Unit / 2.0;
	 Lng := Lng + Unit / 2.0;
	 Lat := Lat - 90.0;
	 if IsWest then
	    Lng := Lng -180.0;
	 end if;
	 
	 return (Lat, Lng, Level, Unit);
      end;
   end Decode;
   
end Geo3x3;

