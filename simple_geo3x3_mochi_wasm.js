import { importWASM } from "https://code4fukui.github.io/Mochi/wasmutil.js";

const { i_encode, i_decode, memory } = await importWASM("./geo3x3.wasm");

const pccode = 0;
const res = i_encode(35.65858, 139.745433, 14, pccode);
const pccodemem = new Uint8Array(memory.buffer, 0, 14);
const code = new TextDecoder().decode(pccodemem);
console.log(res, code);

const pfres = 16;
const res2 = i_decode(pccode, pfres);
const geo2 = new Float32Array(memory.buffer, pfres, 4);
console.log(res2, geo2);

pccodemem[0] = "A";
const res3 = i_decode(pccode, pfres);
console.log(res3, geo2);
