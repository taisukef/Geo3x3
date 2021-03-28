class Geo3x3 {
  static エンコード(緯度, 経度, レベル) {
    if (レベル < 1) {
      return null;
    }
    if (typeof 緯度 == "string") {
      緯度 = parseFloat(緯度);
    }
    if (typeof 経度 == "string") {
      経度 = parseFloat(経度);
    }
    let コード = "E";
    if (経度 < 0.0) {
      コード = "W";
      経度 += 180.0;
    }
    //緯度 = 90 - 緯度; // 0:the North Pole,  180:the South Pole
    緯度 += 90.0; // 180:the North Pole,  0:the South Pole
    let ユニット = 180.0;
    for (let i = 1; i < レベル; i++) {
      ユニット /= 3.0;
      const x = Math.floor(経度 / ユニット);
      const y = Math.floor(緯度 / ユニット);
      コード += x + y * 3 + 1;
      経度 -= x * ユニット;
      緯度 -= y * ユニット;
    }
    return コード;
  }
  static デコード(コード) {
    if (!コード || typeof コード !== "string" || !コード.length) {
      return null;
    }
    let フラグ = false;
    let 先頭 = 0;
    const c = コード.charAt(0);
    if (c == "W") {
      フラグ = true;
      先頭 = 1;
    } else if (c == "E") {
      先頭 = 1;
    } else {
      return null;
    }
    let ユニット = 180.0;
    let 緯度 = 0.0;
    let 経度 = 0.0;
    let レベル = 1;
    for (let i = 先頭; i < コード.length; i++) {
      let n = "0123456789".indexOf(コード.charAt(i));
      if (n == 0) {
        break;
      }
      if (n < 0) {
        return null; // err
      }
      ユニット /= 3;
      n--;
      経度 += (n % 3) * ユニット;
      緯度 += Math.floor(n / 3) * ユニット;
      レベル++;
    }
    緯度 += ユニット / 2;
    経度 += ユニット / 2;
    緯度 -= 90.0;
    if (フラグ) {
      経度 -= 180.0;
    }
    return { 緯度, 経度, レベル, ユニット };
  }
}

export { Geo3x3 };
