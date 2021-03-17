Function Geo3x3_encode(lat, lng, level)
    If level < 1 Then
        Return ""
    End If
    res = "E"
    If lng < 0 Then
        res = "W"
        lng = lng + 180.0
    End If
    lat = lat + 90.0
    unit = 180.0
    For i = 1 To level - 1
        unit = unit / 3.0
        x = Int(lng / unit)
        y = Int(lat / unit)
        n = x + y * 3 + 1
        res = res & n
        lng = lng - x * unit
        lat = lat - y * unit
    Next
    Geo3x3_encode = res
End Function

Function Geo3x3_decode(code)
    clen = Len(code)
    If clen = 0 Then
        Return ""
    End If
    begin = 1
    flg = 0
    c = Mid(code, 1, 1)
    If c = "-" or c = "W" Then
        flg = 1
        begin = 1
    ElseIf c = "+" or c = "E" Then
        begin = 1
    End If
    unit = 180.0
    lat = 0.0
    lng = 0.0
    level = 1
    For i = begin To clen - 1
        n = InStr("0123456789", Mid(code, i + 1, 1)) - 1
        If n <= 0 Then
            Exit For
        End If
        unit = unit / 3
        n = n - 1
        lng = lng + (n mod 3) * unit
        lat = lat + Int(n / 3) * unit
        level = level + 1
    Next
    lat = lat + unit / 2.0
    lng = lng + unit / 2.0
    lat = lat - 90.0
    If flg Then
        lng = lng - 180.0
    End If
    Geo3x3_decode = Array(lat, lng, level, unit)
End Function

WScript.Echo Geo3x3_encode(35.65858, 139.745433, 14)

pos = Geo3x3_decode("E9139659937288")
WScript.Echo pos(0)
WScript.Echo pos(1)
WScript.Echo pos(2)
WScript.Echo pos(3)
