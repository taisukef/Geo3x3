Public Class Geo3x3
    Public Shared Function Encode(lat As Double, lng As Double, level As Integer) As String
        If level < 1 Then
            Return ""
        End If
        Dim res As String = "E"
        If lng < 0.0 Then
            res = "W"
            lng += 180.0
        End If
        lat += 90.0
        Dim unit As Double = 180.0
        Dim i As Integer
        For i = 1 To level - 1
            unit /= 3.0
            Dim x As Integer = CInt(Math.Floor(lng / unit))
            Dim y As Integer = CInt(Math.Floor(lat / unit))
            Dim n As Integer = x + y * 3 + 1
            res = res & n.ToString
            lng -= x * unit
            lat -= y * unit
        Next
        Return res
    End Function

    Public Shared Function Decode(code As String) As Double()
        Dim res(4) As Double
        Dim clen As Integer = Len(code)
        If clen = 0 Then
            Return res
        End If
        Dim begin As Integer = 0
        Dim flg As Boolean = False
        Dim c As String = Mid(code, 1, 1)
        If c = "-" or c = "W" Then
            flg = True
            begin = 1
        Else If c = "+" or c = "E" Then
            begin = 1
        End If
        Dim unit As Double = 180.0
        Dim lat As Double = 0.0
        Dim lng As Double = 0.0
        Dim level As Integer = 1
        Dim i As Integer
        For i = begin To clen - 1
            Dim n As Integer
            n = InStr("0123456789", Mid(code, i + 1, 1)) - 1
            if n <= 0 Then
                Exit For
            End If
            unit /= 3.0
            n -= 1
            lng += (n mod 3) * unit
            lat += Math.Floor(n / 3) * unit
            level += 1
        Next
        lat += unit / 2.0
        lng += unit / 2.0
        lat -= 90.0
        If flg Then
            lng -= 180.0
        End If
        res(0) = lat
        res(1) = lng
        res(2) = level
        res(3) = unit
        Return res
    End Function
End Class
