
module Geo3x3
  module_function
  def encode(lat, lng, level)
    raise ArgumentError if level < 1
    lat = lat.to_f
    lng = lng.to_f

    if lng >= 0
      result = "E"
    else
      result = "W"
      lng += 180
    end

    lat = 90 - lat

    unit = 180.0

    (level - 1).times do
      unit /= 3
      x = (lng / unit).to_i
      y = (lat / unit).to_i
      result << "#{x + y * 3 + 1}"
      lng -= x * unit
      lat -= y * unit 
    end

    result
  end

  def encode_int(lat, lng, level)
    code = encode(lat, lng, level)
    raise ArgumentError unless code

    result = code[1..-1].to_i
    result = -result if code[0] == "W"

    result
  end

  def decode(code)
    if code.is_a? Integer
      code = code < 0 ? "W#{-code}" : "E#{code}"
    elsif code.is_a? String
      code = nil if code.length == 0
    else
      code = nil
    end

    raise ArgumentError unless code

    c = code[0]
    flg = true if c == "-" or c == "W"
    code = code[1..-1] if flg or c == "+" or c == "E"

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
      lat += n / 3 * unit
      level += 1
    end

    lat += unit / 2
    lng += unit / 2
    lat = 90 - lat
    lng -= 180.0 if flg

    [lat, lng, level, unit]
  end

  def coords(code)
    pos = decode(code)
    x = pos[0]
    y = pos[1]
    u2 = pos[3] / 2
    [
      y - u2, x - u2,
      y - u2, x + u2,
      y + u2, x + u2,
      y + u2, x - u2
    ]
  end
end
