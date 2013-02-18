/*
	Geo3x3 ver 1.02
		what is Geo3x3
			geo zone encoding
		creator
			Taisuke Fukuno
			http://fukuno.jig.jp/2012/geo3x3
		licence
			CC BY 3.0
			http://creativecommons.org/licenses/by/3.0/
		doc
			recursive divisiton 3x3(9th)
				       East  West
				North 1 2 3 1 2 3
				      4 5 6 4 5 6
				South 7 8 9 7 8 9
				(0 = dummy)
				origin = lat 90, lng 0 -> lat -90, lng 90(E) -90(W)
			divide the earth to two (West or East)
				W5555555 = level 8
				E1384700 = level 6
				longer is more in detail
		history
			ver 1.02 2013.2.18 add Java version, lincense CC BY-ND -> CC BY
			ver 1.01 2012.1.15 change coding
			ver 1.00 2012.1.15 first release
*/

(function(win) {
	win.Geo3x3 = {};
	win.Geo3x3.encode = function(lat, lng, level) {
		var res = "";
		if (lng > 0) {
			res += "E";
		} else {
			res += "W";
			lng += 180;
		}
		lat = 90 - lat; // 0:the North Pole,  180:the South Pole
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
	};
	win.Geo3x3.decode = function(code) {
		if (code == null || code.length == 0)
			return null;
		var flg = code.charAt(0) == "W";
		var unit = 180;
		var lat = 0;
		var lng = 0;
		var level = 1;
		for (var i = 1; i < code.length; i++) {
			var n = "0123456789".indexOf(code.charAt(i));
			if (n == 0)
				break;
			unit /= 3;
			n--;
			lng += (n % 3) * unit;
			lat += Math.floor(n / 3) * unit;
			level++;
		}
		lat += unit / 2;
		lng += unit / 2;
		lat = 90 - lat;
		if (flg)
			lng -= 180;
		return { "lat" : lat, "lng" : lng, "level" : level, "unit" : unit };
	};
	win.Geo3x3.getCoords = function(code) {
		var pos = this.decode(code);
		var x = pos.lng;
		var y = pos.lat;
		var u2 = pos.unit / 2;
		return [
			{ "lat" : y - u2, "lng" : x - u2 },
			{ "lat" : y - u2, "lng" : x + u2 },
			{ "lat" : y + u2, "lng" : x + u2 },
			{ "lat" : y + u2, "lng" : x - u2 }
		];
	};
	win.Geo3x3.ll2xy = function(lat, lng) {
		var x = lng * 111319.49079327355; // == 12756274 * Math.PI / 2
		var y = Math.log(Math.tan((90 + lat) * Math.PI / 360)) / (Math.PI / 180);
		y *= 111319.49079327355;
		return { "x" : x, "y" : y };
	};
	win.Geo3x3.xy2ll = function(x, y) {
		var lng = x / 111319.49079327355;
		var lat = y / 111319.49079327355;
		lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180)) - Math.PI / 2);
		return { "lat" : lat, "lng" : lng };
	};
})(this);
