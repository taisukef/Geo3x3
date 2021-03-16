Module VBModule
    Sub Main()
        Console.WriteLine(Geo3x3.Encode(35.65858, 139.745433, 14))

        Dim res(4) as Double
        res = Geo3x3.Decode("E9139659937288")
        Console.WriteLine(res(0))
        Console.WriteLine(res(1))
        Console.WriteLine(res(2))
        Console.WriteLine(res(3))
    End Sub
End Module
