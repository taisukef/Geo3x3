import { encodeGPU, decodeGPU, getGPUDevice } from "./geo3x3_WGSL.ts";

const device = await getGPUDevice();

const data = { lat: 35.65858, lng: 139.745433, level: 14 };
const lats = new Float32Array([data.lat]);
const lngs = new Float32Array([data.lng]);
const gpuCodes = await encodeGPU(device, lats, lngs, data.level);
console.log(gpuCodes);

const code = "E9139659937288";
const gpuDec = await decodeGPU(device, [code], code.length);
console.log(gpuDec);
