class Geo3x3
  def Geo3x3.encode(lat : Float64, lng : Float64, level : Int32) : String | Nil
    if level > 1
      lat = lat.to_f
      lng = lng.to_f

      if lng >= 0
        result = "E"
      else
        result = "W"
        lng += 180
      end

      lat += 90
      
      unit = 180.0

      (level - 1).times do
        unit /= 3
        x = (lng / unit).to_i
        y = (lat / unit).to_i
        result += "#{x + y * 3 + 1}"
        lng -= x * unit
        lat -= y * unit 
      end
    end

    result
  end

  def Geo3x3.decode(code : String) : Tuple(Float64, Float64, Int32, Float64) | Nil
    if code.bytesize > 0
      c = code[0]
      flg = true if c == 'W'
      code = code[1..-1] if flg || c == 'E'

      unit = 180.0
      lat = 0.0
      lng = 0.0
      level = 1

      code.each_char do |c|
        n = c.to_i
        break if n == 0

        unit = unit / 3
        n -= 1
        lng += n % 3 * unit
        lat += (n / 3).to_i * unit
        level += 1
      end

      lat += unit / 2
      lng += unit / 2
      lat -= 90
      lng -= 180.0 if flg

      { lat, lng, level, unit }
    end
  end
end
