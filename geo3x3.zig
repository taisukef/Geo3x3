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
    var _unit: f64 = 180.0;

    var i: u8 = 1;
    while (i < level) {
        _unit /= 3.0;
        const x: u8 = @intFromFloat(_lng / _unit);
        const y: u8 = @intFromFloat(_lat / _unit);
        result[i] = '0' + x + y * 3 + 1;
        _lng -= @as(f64, @floatFromInt(x)) * _unit;
        _lat -= @as(f64, @floatFromInt(y)) * _unit;
        i += 1;
    }
}


pub fn decode(code: []const u8, result: []f64) !void {
    if (code.len == 0) {
        return;
    }

    var begin: u8 = 0;
    var flg: bool = false;

    const c = code[0];
    if (c == '-' or c == 'W') {
        flg = true;
        begin = 1;
    } else if (c == '+' or c == 'E') {
        begin = 1;
    }

    var unit: f64 = 180.0;
    var lat: f64 = 0.0;
    var lng: f64 = 0.0;
    var level: u8 = 1;

    var i: u64 = begin;
    while (i < code.len) {
        var n: u8 = code[i] - '0';
        if (n <= 0) break;
        unit /= 3.0;
        n = n - 1;
        lng += @as(f64, @floatFromInt(n % 3)) * unit;
        lat += @as(f64, @floatFromInt(n / 3)) * unit;
        level += 1;
        i += 1;
    }

    lat += unit / 2.0;
    lng += unit / 2.0;
    lat -= 90.0;
    if (flg) lng -= 180.0;

    result[0] = lat;
    result[1] = lng;
    result[2] = @as(f64, @floatFromInt(level));
    result[3] = unit;
}
