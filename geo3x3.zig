const std = @import("std");

pub fn encode(lat: f64, lng: f64, level: u8, result: []u8) !void {
    if (level < 1) {
        return;
    }

    if (result.len < level) {
        return;
    }

    var _lng = lng;
    var _lat = lat;

    if (_lng >= 0.0) {
        result[0] = 'E';
    } else {
        result[0] = 'W';
        _lng += 180.0;
    }

    _lat += 90.0;
    var _unit:f64 = 180.0;

    var i:u8 = 1;
    while (i < level) {
        _unit /= 3.0;
        var x = @floatToInt(u8, _lng / _unit);
        var y = @floatToInt(u8, _lat / _unit);
        result[i] = '0' + x + y * 3 + 1;
        _lng -= @intToFloat(f64,x) * _unit;
        _lat -= @intToFloat(f64,y) * _unit;
        i += 1;
    }
}


pub fn decode(code: [] const u8, result: []f64) !void {
    if (code.len == 0) {
        return;
    }

    var begin:u8 = 0;
    var flg:bool = false;

    var c = code[0];
    if (c == '-' or c == 'W') {
        flg = true;
        begin = 1;
    } else if (c == '+' or c == 'E') {
        begin = 1;
    }

    var unit:f64 = 180.0;
    var lat:f64 = 0.0;
    var lng:f64 = 0.0;
    var level:u8 = 1;

    var i:u64 = begin;
    while (i < code.len) {
        var n:u8 = code[i] - '0';
        if (n <= 0) break;
        unit /= 3.0;
        n = n -1;
        lng += @intToFloat(f64, n % 3) * unit;
        lat += @intToFloat(f64, n / 3) * unit;
        level += 1;
        i += 1;
    }

    lat += unit / 2.0;
    lng += unit / 2.0;
    lat -= 90.0;
    if (flg) lng -= 180.0;

    result[0] = lat;
    result[1] = lng;
    result[2] = @intToFloat(f64,level);
    result[3] = unit;
}
