
proc encode {lat lng level} {
    if {$level < 1} {return ""}
    set res ""
    if {$lng >= 0} {
	append res "E"
    } else {
	append res "W"
	set lng [expr $lng + 180.0]
    }
    set lat [expr $lat + 90.0]
    set unit 180

    for {set i 1} {$i < $level} {incr i} {
	set unit [expr $unit / 3.0]
	set x [expr floor($lng / $unit)]
	set y [expr floor($lat / $unit)]
	append res [format %c [expr int(48 + $x + $y * 3 + 1)]]
	set lng [expr $lng - $x * $unit]
	set lat [expr $lat - $y * $unit]
    }
    return $res
}

proc decode {code} {
    if {[string length $code] == 0} {return {0.0 0.0 0 0.0}}

    set begin 0
    set flg false
    set c [string index $code 0] 
    if {$c == "-" || $c == "W"} {
	set flg true
	set begin 1
    } elseif {$c == "+" || $c == "E"} {
	set begin 1
    }

    set unit 180.0
    set lat 0.0
    set lng 0.0
    set level 1
    
    set clen [string length $code]
    for {set i $begin} {$i < $clen} {incr i} {
	scan [string index $code $i] %c c
	set n [expr $c - 48]
	if { $n <= 0 || 9 < $n } { break }
	set unit [expr $unit / 3.0]
	set n [expr $n -1]
	set lng [expr $lng + $n % 3 * $unit]
	set lat [expr $lat + $n / 3 * $unit]
	set level [expr $level + 1]
    }
    set lat [expr $lat + $unit / 2]
    set lng [expr $lng + $unit / 2]
    set lat [expr $lat - 90.0]
    if {$flg} {set lng [expr $lng - 180.0]}
    
    return "$lat $lng $level $unit"
}

