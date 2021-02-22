defmodule Geo3x3 do
  def encode(_lat, _lng, level) when level < 1, do: ""
  def encode(lat, lng, level) do
    {res, lng} = if lng >= 0, do: {"E", lng}, else: {"W", lng + 180}
    lat = 90 - lat # 0:the North Pole,  180:the South Pole
    unit = 180.0

    {_, _, _, res} =
      1..level-1
      |> Enum.reduce({unit, lng, lat, res}, fn _lv, {unit, lng, lat, res} ->
        unit = unit / 3
        x = floor(lng / unit)
        y = floor(lat / unit)
        res = "#{res}#{x + y * 3 + 1}"
        lng = lng - x * unit
        lat = lat - y * unit

        {unit, lng, lat, res}
      end)

    res
  end

  def decode(code) do
    {flg, code} =
      case code do
        "-" <> rest -> {true, rest}
        "W" <> rest -> {true, rest}
        "+" <> rest -> {false, rest}
        "E" <> rest -> {false, rest}
        _ -> {false, code}
      end

    {lat, lng, level, unit} =
      code
      |> String.codepoints()
      |> Enum.reduce_while({0.0, 0.0, 1, 180.0}, fn c, {lat, lng, level, unit} = acc ->
        with {n, _} <- Integer.parse(c), true <- n > 0 do
          n = n - 1
          unit = unit / 3
          lat = lat + div(n, 3) * unit
          lng = lng + rem(n, 3) * unit

          {:cont, {lat, lng, level + 1, unit}}
        else
          _ -> {:halt, acc}
        end

      end)

    lat = lat + (unit / 2)
    lat = 90 - lat

    lng = lng + (unit / 2)
    lng = if flg, do: lng - 180.0, else: lng

    [lat, lng, level, unit]
  end

end
