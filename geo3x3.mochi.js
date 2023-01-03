import { i32, f32 } from "./mochi/std.js";

export function i_encode(flat, flng, ilevel, pccode) {
  let funit, i, x, y;
  if (ilevel < 1) {
    return 1;
  }
  pccode[0] = 'E';
  if (flng < 0.0) {
    pccode[0] = 'W';
    flng += 180.0;
  }
  flat += 90.0; // 180:the North Pole, 0:the South Pole
  funit = 180.0;
  for (i = 1; i < ilevel; i++) {
    funit /= 3.0;
    x = i32(flng / funit)
    y = i32(flat / funit)
    pccode[i] = x + y * 3 + 49; // 49='1'
    flng -= f32(x) * funit;
    flat -= f32(y) * funit;
  }
  return 0;
}
export function i_decode(pccode, pfres) {
  let iflg, funit, flat, flng, ilevel, i, n, c;
  c = pccode[0];
  if (c == 69) { // 'E'
    iflg = false;
  } else if (c == 87) { // 'W'
    iflg = true;
  } else {
    return 1; // err
  }
  funit = 180.0;
  flat = 0.0;
  flng = 0.0;
  ilevel = 1;
  for (i = 1;; i++) {
    n = pccode[i];
    if (n == 0) {
      break;
    }
    n -= 49;
    if (n < 0 || n > 9) {
      return 1; // err
    }
    funit /= 3.0;
    flng += f32(n % 3) * funit;
    flat += f32(n / 3) * funit;
    ilevel++;
  }
  flat += funit / 2.0;
  flng += funit / 2.0;
  flat -= 90.0;
  if (iflg) {
    flng -= 180.0;
  }
  pfres[0] = flat;
  pfres[1] = flng;
  pfres[2] = f32(ilevel);
  pfres[3] = funit;
  return 0;
}
