class Geo3x3 {
  static encode(lat, lng, level) {
    if (level < 1 || !level || level >= 1000) {
      return null;
    }
    if (typeof lat == "string") {
      lat = parseFloat(lat);
    }
    if (typeof lng == "string") {
      lng = parseFloat(lng);
    }
    if (isNaN(lat) || isNaN(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) {
      return null;
    }
    let res = "E";
    if (lng < 0.0) {
      res = "W";
      lng += 180.0;
    }
    lat += 90.0; // 180:the North Pole,  0:the South Pole
    let unit = 180.0;
    for (let i = 1; i < level; i++) {
      unit /= 3.0;
      const x = Math.floor(lng / unit);
      const y = Math.floor(lat / unit);
      res += x + y * 3 + 1;
      lng -= x * unit;
      lat -= y * unit;
    }
    return res;
  }
  static decode(code) {
    if (!code || typeof code !== "string" || !code.length) {
      return null;
    }
    let flg = false;
    let begin = 0;
    const c = code.charAt(0);
    if (c == "W") {
      flg = true;
      begin = 1;
    } else if (c == "E") {
      begin = 1;
    } else {
      return null;
    }
    let unit = 180.0;
    let lat = 0.0;
    let lng = 0.0;
    let level = 1;
    for (let i = begin; i < code.length; i++) {
      let n = "0123456789".indexOf(code.charAt(i));
      if (n == 0) {
        break;
      }
      if (n < 0) {
        return null; // err
      }
      unit /= 3;
      n--;
      lng += (n % 3) * unit;
      lat += Math.floor(n / 3) * unit;
      level++;
    }
    lat += unit / 2;
    lng += unit / 2;
    lat -= 90.0;
    if (flg) {
      lng -= 180.0;
    }
    return { lat, lng, level, unit };
  }
  static getCoords(code) {
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
  static getMeshSize(code) { // m
    const lls = this.getCoords(code);
    const xy = new Array(4);
    for (let i = 0; i < xy.length; i++) {
      xy[i] = this.ll2xy(lls[i].lat, lls[i].lng);
    }
    const x = xy[1].x - xy[0].x;
    const y = xy[2].y - xy[1].y;
    return { x, y };
  }
  static ll2xy(lat, lng) {
    const x = this.RPI_EARTH * lng;
    const y = this.RPI_EARTH * Math.log(Math.tan((90 + lat) * Math.PI / 360)) / (Math.PI / 180);
    return { x, y };
  }
  static xy2ll(x, y) {
    const lng = x / this.RPI_EARTH;
    let lat = y / this.RPI_EARTH;
    lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180)) - Math.PI / 2);
    return { lat, lng };
  }
}
Geo3x3.R2_EARTH = 12756274; // m from https://ja.wikipedia.org/wiki/%E5%9C%B0%E7%90%83
Geo3x3.RPI_EARTH = Geo3x3.R2_EARTH * Math.PI / 2 / 180;

export { Geo3x3 };
