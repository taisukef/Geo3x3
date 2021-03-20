function geo3x3_encode(lat, lng, level) {
    if (level < 1) {
        return "";
    }
    var res = "E";
    if (lng < 0) {
        res = "W";
        lng += 180;
    }
    lat += 90; // 180:the North Pole,  0:the South Pole
    var unit = 180;
    for (var i = 1; i < level; i++) {
        unit /= 3;
        var x = Math.floor(lng / unit);
        var y = Math.floor(lat / unit);
        res += x + y * 3 + 1;
        lng -= x * unit;
        lat -= y * unit;
    }
    return res;
}
function gex3x3_decode(code) {
    if (code == null || code.length == 0) {
        return null;
    }
    var flg = code.charAt(0) == "W";
    var unit = 180;
    var lat = 0;
    var lng = 0;
    var level = 1;
    for (var i = 1; i < code.length; i++) {
        var n = "0123456789".indexOf(code.charAt(i));
        if (n == 0) {
            break;
        }
        unit /= 3;
        n--;
        lng += (n % 3) * unit;
        lat += Math.floor(n / 3) * unit;
        level++;
    }
    lat += unit / 2;
    lng += unit / 2;
    lat -= 90;
    if (flg) {
        lng -= 180;
    }
    return [lat, lng, level, unit];
}

WScript.Echo(geo3x3_encode(35.65858, 139.745433, 14));
WScript.Echo(gex3x3_decode("E9139659937288"));
