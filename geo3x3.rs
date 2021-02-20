use std::char::from_u32;

pub fn encode(lat: f64, lng: f64, level: i32) -> String {
	if level < 1 {
		return "".to_string();
	}
	let mut res = String::new();
	let mut lng2 = lng;
	if lng >= 0.0 {
		res.push_str("E");
	} else {
		res.push_str("W");
		lng2 += 180.0;
	}
	let mut lat2 = 90.0 - lat; // 0:the North Pole,  180:the South Pole
	let mut unit = 180.0;
	for _ in 1 .. level {
		unit /= 3.0;
		let x = (lng2 / unit) as i32;
		let y = (lat2 / unit) as i32;
		//println!("{}", from_u32((x + y * 3 + 1) as u32).unwrap());
		let s = from_u32(('0' as i32 + x + y * 3 + 1) as u32).unwrap();
		res.push(s);
		lng2 -= (x as f64) * unit;
		lat2 -= (y as f64) * unit;
	}
	return res.to_string();
}

pub fn decode(code: String) -> (f64, f64, i32, f64) {
	let mut unit = 180.0;
	let mut lat = 0.0;
	let mut lng = 0.0;
	let mut level = 1;

	let mut begin = 0;
	let mut flg = false;
	let c = code.chars().nth(0).unwrap();
	if c == '-' || c == 'W' {
		flg = true;
		begin = 1;
	} else if c == '+' || c == 'E' {
		begin = 1;
	}
	let clen = code.len();
	for i in begin .. clen {
		let c = code.chars().nth(i).unwrap();
		if c < '1' || c > '9' {
			break;
		}
		let n = c as i32 - '1' as i32;
		unit /= 3.0;
		lng += (n % 3) as f64 * unit;
		lat += (n / 3) as f64 * unit;
		level += 1;
	}
	lat += unit / 2.0;
	lng += unit / 2.0;
	lat = 90.0 - lat;
	if flg {
		lng -= 180.0;
	}
	return (lat, lng, level, unit);
}
