class 
    SIMPLE_GEO3X3

create
    make

feature
    make
        local
            t: TUPLE[lat: DOUBLE; lng: DOUBLE; level:INTEGER; unit:DOUBLE]
            geo3x3: GEO3X3
        do 
            create geo3x3
            print (geo3x3.encode (35.65858, 139.745433, 14) + "%N")
            t := geo3x3.decode ("E9139659937288")
            print (t.lat.out + " " + t.lng.out + " " + t.level.out + " " + t.unit.out + "%N")
        end
end
