export function encode(lat: f64, lng: f64, level: i32): string {
	if (level < 1) {
		return "";
	}
	let res = "E";
	if (lng < 0.0) {
		res = "W";
		lng += 180.0;
	}
	lat += 90.0; // 180:the North Pole, 0:the South Pole
	let unit = 180.0;
	for (let i = 1; i < level; i++) {
		unit /= 3.0;
		const x: i32 = (lng / unit) as i32;
		const y: i32 = (lat / unit) as i32;
		res += (x + y * 3 + 1).toString();
		lng -= x * unit;
		lat -= y * unit;
	}
	res += "\0";
	return res;
}

@external("env", "sendFloat64Array")
declare function sendFloat64Array(pointer: Array<f64>, length: i32): void;

//const res = new Array<f64>(4);

// interface
const membuf = new Uint8Array(100);
const membuf2 = new Uint8Array(100);
export function mem(): Uint8Array {
	return membuf;
}
export function mem2(): Uint8Array {
	return membuf2;
}

//export function decode(code: string, res2: Array<f64>): Array<f64> {
export function decode(codex: string): Array<f64> {
	const res = new Array<f64>(4);
	/*
	res[0] = 1000.0;
	res[1] = 2.0;
	res[2] = 3.0;
	res[3] = 4.0;
	*/
	
	//const flg = membuf[0] == "W".charCodeAt(0);
	
	for (let i = 0; i < 4; i++)
		res[i] = membuf[i]; //code.charCodeAt(i);
	return res;
	let unit = 180.0;
	let lat = 0.0;
	let lng = 0.0;
	let level = 1;
	for (let i = 1;; i++) {
		let n = "123456789".indexOf(code.charAt(i));
		if (n < 0) {
			break;
		}
		unit /= 3;
		lng += (n % 3) * unit;
		lat += Math.floor(n / 3) * unit;
		level++;
	}
	lat += unit / 2.0;
	lng += unit / 2.0;
	lat -= 90.0;
	if (flg) {
		lng -= 180.0;
	}
	res[0] = lat;
	res[1] = lng;
	res[2] = level;
	res[3] = unit;
	return res;
	//return [0, 0, 0, 0];
	//return;
}




/*
static getCoords(code: String): [ { lat: f64, lng: f64 }, { lat: f64, lng: f64 }, { lat: f64, lng: f64 }, { lat: f64, lng: f64 }, ] {
	const pos = this.decode(code);
	const x = pos.lng;
	const y = pos.lat;
	const u2 = pos.unit / 2;
	return [
		{ "lat" : y - u2, "lng" : x - u2 },
		{ "lat" : y - u2, "lng" : x + u2 },
		{ "lat" : y + u2, "lng" : x + u2 },
		{ "lat" : y + u2, "lng" : x - u2 }
	];
}
static getMeshSize(code: String): { x: f64, y: f64 } { // m
	const lls = this.getCoords(code);
	const xy = new Array(4);
	for (let i = 0; i < xy.length; i++) {
		xy[i] = this.ll2xy(lls[i].lat, lls[i].lng);
	}
	const x = xy[1].x - xy[0].x;
	const y = xy[2].y - xy[1].y;
	return { x, y };
}
static R2_EARTH: f64 = 12756274.0; // m from https://ja.wikipedia.org/wiki/%E5%9C%B0%E7%90%83
static RPI_EARTH: f64 = Geo3x3.R2_EARTH * Math.PI / 2.0 / 180.0;
static ll2xy(lat: f64, lng: f64): { x: f64, y: f64 } {
	const x = this.RPI_EARTH * lng;
	const y = this.RPI_EARTH * Math.log(Math.tan((90 + lat) * Math.PI / 360)) / (Math.PI / 180);
	return { x, y };
}
static xy2ll(x: f64, y: f64): { lat: f64, lng: f64 } {
	const lng = x / this.RPI_EARTH;
	let lat = y / this.RPI_EARTH;
	lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180)) - Math.PI / 2);
	return { lat, lng };
}
*/
