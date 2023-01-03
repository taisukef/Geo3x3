import { pc2s, s2pc } from "https://code4fukui.github.io/Mochi/wasmutil.js";

import { i_encode, i_decode } from "./geo3x3.mochi.js";

const pccode = new Uint8Array(15);
const res = i_encode(35.65858, 139.745433, 14, pccode);
console.log(res, pc2s(pccode));

const pires = new Float32Array(4);
const res2 = i_decode(s2pc("E9139659937288"), pires);
console.log(res2, pires);

const res3 = i_decode(s2pc("EA139659937288"), pires);
console.log(res3, pires);
