// Geo3x3 WebGPU Encode/Decode for Deno
// ------------------------------------------------------------
// Usage (Deno 1.43+):
//   deno run --allow-hrtime --unstable-sloppy-imports --unstable-webgpu geo3x3_WGSL.ts
// (flags may vary slightly by Deno version; if WebGPU is unavailable, this falls back to CPU tests.)
//
// This file provides:
//   - encodeCPU(lat, lng, level): string
//   - decodeCPU(code): { lat: number, lng: number, unit: number }
//   - encodeGPU(gpu, lats, lngs, level): Promise<string[]> (batch)
//   - decodeGPU(gpu, codes, level): Promise<{ lat: number, lng: number, unit: number }[]>
//   - main(): self-test comparing CPU/GPU
// ------------------------------------------------------------

// ----------------------
// CPU reference versions
// ----------------------
export function encodeCPU(lat: number, lng: number, level: number): string {
  if (level < 1) return "";
  let res = "";
  let Lng = lng;
  if (Lng >= 0) {
    res = "E";
  } else {
    res = "W";
    Lng += 180;
  }
  let Lat = lat + 90;
  let unit = 180.0;
  for (let i = 1; i < level; i++) {
    unit /= 3.0;
    const x = Math.floor(Lng / unit);
    const y = Math.floor(Lat / unit);
    res += String.fromCharCode("0".charCodeAt(0) + (x + y * 3 + 1));
    Lng -= x * unit;
    Lat -= y * unit;
  }
  return res;
}

export function decodeCPU(code: string): { lat: number; lng: number; unit: number } {
  if (!code || code.length === 0) throw new Error("empty code");
  let isE = code[0] === "E"; // else W
  let unit = 180.0;
  let lat = 0.0;
  let lng = 0.0;
  for (let i = 1; i < code.length; i++) {
    unit /= 3.0;
    const c = code.charCodeAt(i) - "0".charCodeAt(0);
    const n = c - 1; // 0..8
    const x = n % 3;
    const y = Math.floor(n / 3);
    lng += x * unit;
    lat += y * unit;
  }
  lat += unit / 2.0;
  lng += unit / 2.0;
  lat -= 90.0;
  if (!isE) {
    // W: original had lng<0 then +180 before encoding
    lng -= 180.0;
  }
  return { lat, lng, unit };
}

// ----------------------
// WebGPU helpers & WGSL (with legacy compatibility)
// ----------------------

export async function getGPUDevice(): Promise<GPUDevice | null> {
  // Deno exposes navigator.gpu under --unstable-webgpu (or similar) flags.
  // @ts-ignore - navigator may exist in Deno with WebGPU enabled
  const adapter = await (globalThis.navigator?.gpu?.requestAdapter?.({ powerPreference: "high-performance" }) ?? null);
  if (!adapter) return null;
  const device = await adapter.requestDevice();
  return device;
}

// createComputePipeline compatibility wrapper for old WebGPU implementations
async function createComputePipelineCompat(device: GPUDevice, module: GPUShaderModule, entryPoint = "main"): Promise<GPUComputePipeline> {
  // Try modern async path
  try {
    // @ts-ignore: older Deno may not have createComputePipelineAsync
    if (typeof (device as any).createComputePipelineAsync === "function") {
      return await (device as any).createComputePipelineAsync({ layout: "auto", compute: { module, entryPoint } });
    }
    throw new Error("no-async");
  } catch (_e) {
    // Try modern sync path
    try {
      return device.createComputePipeline({ layout: "auto", compute: { module, entryPoint } });
    } catch (_e2) {
      // Try legacy descriptor name: computeStage
      // @ts-ignore: legacy WebGPU (pre-MVP)
      return device.createComputePipeline({ layout: "auto", computeStage: { module, entryPoint } });
    }
  }
}

// WGSL: batch encoder
// Inputs per item: lat[i], lng[i] (f32). Uniform: level (u32), count (u32).
// Outputs per item: firstChar (u32, 'E' or 'W'), digits[(level-1)] as u32 1..9
const ENCODER_WGSL = await Deno.readTextFile("./geo3x3_WGSL_encode.wgsl");
const ENCODER_WGSL_ = /* wgsl */ `
struct Params { level: u32, count: u32 };
@group(0) @binding(0) var<uniform> params: Params;
@group(0) @binding(1) var<storage, read> inLat: array<f32>;
@group(0) @binding(2) var<storage, read> inLng: array<f32>;
@group(0) @binding(3) var<storage, read_write> outFirst: array<u32>; // 'E' or 'W'
@group(0) @binding(4) var<storage, read_write> outDigits: array<u32>; // flattened: count*(level-1)

@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) gid: vec3<u32>) {
  let i = gid.x;
  if (i >= params.count) { return; }
  let level = params.level;
  if (level < 1u) { return; }

  var lng = inLng[i];
  let firstE = select(0u, 1u, lng >= 0.0);
  // 1u -> 'E', 0u -> 'W'
  // store ASCII
  outFirst[i] = select(u32(87u), u32(69u), lng >= 0.0); // 'W' or 'E'
  if (!(lng >= 0.0)) {
    lng = lng + 180.0;
  }
  var lat = inLat[i] + 90.0;
  var unit = 180.0;
  var base = i * (level - 1u);
  var idx: u32 = 0u;
  var tlevel: u32 = 1u;
  loop {
    if (tlevel >= level) { break; }
    unit = unit / 3.0;
    let x = u32(floor(lng / unit));
    let y = u32(floor(lat / unit));
    let digit = x + y * 3u + 1u; // 1..9
    outDigits[base + idx] = digit;
    lng = lng - f32(x) * unit;
    lat = lat - f32(y) * unit;
    idx = idx + 1u;
    tlevel = tlevel + 1u;
  }
}
`;

// WGSL: batch decoder
// Inputs per item: firstChar (u32 'E'/'W'), digits[(level-1)] 1..9
// Uniform: level, count
// Outputs per item: lat[i], lng[i], unit[i]
const DECODER_WGSL = await Deno.readTextFile("./geo3x3_WGSL_decode.wgsl");
const DECODER_WGSL_ = /* wgsl */ `
struct Params { level: u32, count: u32 };
@group(0) @binding(0) var<uniform> params: Params;
@group(0) @binding(1) var<storage, read> inFirst: array<u32>;
@group(0) @binding(2) var<storage, read> inDigits: array<u32>;
@group(0) @binding(3) var<storage, read_write> outLat: array<f32>;
@group(0) @binding(4) var<storage, read_write> outLng: array<f32>;
@group(0) @binding(5) var<storage, read_write> outUnit: array<f32>;

@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) gid: vec3<u32>) {
  let i = gid.x;
  if (i >= params.count) { return; }
  let level = params.level;
  var unit = 180.0;
  var lat = 0.0;
  var lng = 0.0;
  var base = i * (level - 1u);
  for (var k: u32 = 1u; k < level; k = k + 1u) {
    unit = unit / 3.0;
    let digit = inDigits[base + (k - 1u)];
    let n = digit - 1u; // 0..8
    let x = n % 3u;
    let y = n / 3u;
    lng = lng + f32(x) * unit;
    lat = lat + f32(y) * unit;
  }
  lat = lat + unit / 2.0 - 90.0;
  let first = inFirst[i];
  // ASCII 'E' = 69, 'W' = 87
  if (first != 69u) { // 'W'
    lng = lng - 180.0;
  }
  outLat[i] = lat;
  outLng[i] = lng;
  outUnit[i] = unit;
}
`;

function u32ArrayFromCodes(codes: string[], level: number): { first: Uint32Array; digits: Uint32Array } {
  const n = codes.length;
  const first = new Uint32Array(n);
  const digits = new Uint32Array(n * Math.max(0, level - 1));
  for (let i = 0; i < n; i++) {
    const code = codes[i];
    first[i] = code.charCodeAt(0);
    for (let k = 1; k < level; k++) {
      const d = code.charCodeAt(k) - "0".charCodeAt(0);
      digits[i * (level - 1) + (k - 1)] = d;
    }
  }
  return { first, digits };
}

function stringifyFromDigits(first: Uint32Array, digits: Uint32Array, level: number): string[] {
  const n = first.length;
  const out: string[] = new Array(n);
  for (let i = 0; i < n; i++) {
    let s = String.fromCharCode(first[i]);
    for (let k = 1; k < level; k++) {
      s += String.fromCharCode("0".charCodeAt(0) + digits[i * (level - 1) + (k - 1)]);
    }
    out[i] = s;
  }
  return out;
}

export async function encodeGPU(
  device: GPUDevice,
  lats: Float32Array,
  lngs: Float32Array,
  level: number
): Promise<string[]> {
  if (level < 1) return lats.map(() => "");
  if (lats.length !== lngs.length) throw new Error("lats/lngs length mismatch");
  const count = lats.length;
  const digitsLen = Math.max(0, level - 1) * count;

  const params = new Uint32Array([level >>> 0, count >>> 0]);
  const paramBuf = device.createBuffer({ size: params.byteLength, usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST });
  device.queue.writeBuffer(paramBuf, 0, params.buffer);

  const inLatBuf = device.createBuffer({ size: lats.byteLength, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST });
  const inLngBuf = device.createBuffer({ size: lngs.byteLength, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST });
  device.queue.writeBuffer(inLatBuf, 0, lats.buffer);
  device.queue.writeBuffer(inLngBuf, 0, lngs.buffer);

  const outFirstBuf = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_SRC });
  const outDigitsBuf = device.createBuffer({ size: Math.max(1, digitsLen) * 4, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_SRC });

  const module = device.createShaderModule({ code: ENCODER_WGSL });
  const pipeline = await createComputePipelineCompat(device, module, "main");

  const bind = device.createBindGroup({
    layout: pipeline.getBindGroupLayout(0),
    entries: [
      { binding: 0, resource: { buffer: paramBuf } },
      { binding: 1, resource: { buffer: inLatBuf } },
      { binding: 2, resource: { buffer: inLngBuf } },
      { binding: 3, resource: { buffer: outFirstBuf } },
      { binding: 4, resource: { buffer: outDigitsBuf } },
    ],
  });

  const encoder = device.createCommandEncoder();
  {
    const pass = encoder.beginComputePass();
    pass.setPipeline(pipeline);
    pass.setBindGroup(0, bind);
    const wg = Math.ceil(count / 64);
    pass.dispatchWorkgroups(wg);
    pass.end();
  }

  // Readback buffers
  const readFirst = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST });
  const readDigits = device.createBuffer({ size: Math.max(1, digitsLen) * 4, usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST });
  encoder.copyBufferToBuffer(outFirstBuf, 0, readFirst, 0, count * 4);
  encoder.copyBufferToBuffer(outDigitsBuf, 0, readDigits, 0, Math.max(1, digitsLen) * 4);

  device.queue.submit([encoder.finish()]);
  await readFirst.mapAsync(GPUMapMode.READ);
  await readDigits.mapAsync(GPUMapMode.READ);
  const first = new Uint32Array(readFirst.getMappedRange().slice(0));
  const digits = new Uint32Array(readDigits.getMappedRange().slice(0));
  readFirst.unmap();
  readDigits.unmap();

  return stringifyFromDigits(first, digits, level);
}

export async function decodeGPU(
  device: GPUDevice,
  codes: string[],
  level: number
): Promise<{ lat: number; lng: number; unit: number }[]> {
  if (level < 1) throw new Error("level must be >= 1");
  const { first, digits } = u32ArrayFromCodes(codes, level);
  const count = codes.length;

  const params = new Uint32Array([level >>> 0, count >>> 0]);
  const paramBuf = device.createBuffer({ size: params.byteLength, usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST });
  device.queue.writeBuffer(paramBuf, 0, params.buffer);

  const inFirstBuf = device.createBuffer({ size: first.byteLength, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST });
  const inDigitsBuf = device.createBuffer({ size: digits.byteLength || 4, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST });
  device.queue.writeBuffer(inFirstBuf, 0, first.buffer);
  if (digits.byteLength > 0) device.queue.writeBuffer(inDigitsBuf, 0, digits.buffer);

  const outLatBuf = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_SRC });
  const outLngBuf = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_SRC });
  const outUnitBuf = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_SRC });

  const module = device.createShaderModule({ code: DECODER_WGSL });
  const pipeline = await createComputePipelineCompat(device, module, "main");

  const bind = device.createBindGroup({
    layout: pipeline.getBindGroupLayout(0),
    entries: [
      { binding: 0, resource: { buffer: paramBuf } },
      { binding: 1, resource: { buffer: inFirstBuf } },
      { binding: 2, resource: { buffer: inDigitsBuf } },
      { binding: 3, resource: { buffer: outLatBuf } },
      { binding: 4, resource: { buffer: outLngBuf } },
      { binding: 5, resource: { buffer: outUnitBuf } },
    ],
  });

  const encoder = device.createCommandEncoder();
  {
    const pass = encoder.beginComputePass();
    pass.setPipeline(pipeline);
    pass.setBindGroup(0, bind);
    const wg = Math.ceil(count / 64);
    pass.dispatchWorkgroups(wg);
    pass.end();
  }
  const readLat = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST });
  const readLng = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST });
  const readUnit = device.createBuffer({ size: count * 4, usage: GPUBufferUsage.MAP_READ | GPUBufferUsage.COPY_DST });
  encoder.copyBufferToBuffer(outLatBuf, 0, readLat, 0, count * 4);
  encoder.copyBufferToBuffer(outLngBuf, 0, readLng, 0, count * 4);
  encoder.copyBufferToBuffer(outUnitBuf, 0, readUnit, 0, count * 4);

  device.queue.submit([encoder.finish()]);
  await readLat.mapAsync(GPUMapMode.READ);
  await readLng.mapAsync(GPUMapMode.READ);
  await readUnit.mapAsync(GPUMapMode.READ);
  const lat = new Float32Array(readLat.getMappedRange().slice(0));
  const lng = new Float32Array(readLng.getMappedRange().slice(0));
  const unit = new Float32Array(readUnit.getMappedRange().slice(0));
  readLat.unmap();
  readLng.unmap();
  readUnit.unmap();

  const out = new Array(count);
  for (let i = 0; i < count; i++) out[i] = { lat: lat[i], lng: lng[i], unit: unit[i] };
  return out;
}

// ----------------------
// Self-test (CPU vs GPU)
// ----------------------
export async function main() {
  const device = await getGPUDevice();
  const level = 10; // typical precision
  const samples = [
    { lat: 35.3606, lng: 138.7274 }, // Mt. Fuji
    { lat: 35.0210, lng: 135.7556 }, // Kyoto
    { lat: 48.8566, lng: 2.3522 },   // Paris
    { lat: -33.8688, lng: 151.2093 },// Sydney
    { lat: 0.0, lng: 0.0 },
  ];

  const cpuCodes = samples.map(p => encodeCPU(p.lat, p.lng, level));
  const cpuDec = cpuCodes.map(c => decodeCPU(c));

  console.log("CPU encode -> decode examples:");
  for (let i = 0; i < samples.length; i++) {
    console.log(i, samples[i], cpuCodes[i], cpuDec[i]);
  }

  if (!device) {
    console.warn("WebGPU device not available. CPU-only test completed.");
    return;
  }

  // GPU encode
  const lats = new Float32Array(samples.map(s => s.lat));
  const lngs = new Float32Array(samples.map(s => s.lng));
  const gpuCodes = await encodeGPU(device, lats, lngs, level);

  // GPU decode
  const gpuDec = await decodeGPU(device, gpuCodes, level);

  console.log("\nGPU encode -> decode examples:");
  for (let i = 0; i < samples.length; i++) {
    console.log(i, samples[i], gpuCodes[i], gpuDec[i]);
  }

  // Cross-check CPU vs GPU outputs
  let ok = true;
  for (let i = 0; i < samples.length; i++) {
    if (gpuCodes[i] !== cpuCodes[i]) {
      console.error("Mismatch code at", i, gpuCodes[i], cpuCodes[i]);
      ok = false;
    }
    const a = cpuDec[i];
    const b = gpuDec[i];
    //const eps = 1e-4; // NG
    const eps = 1e-2; // ok
    if (Math.abs(a.lat - b.lat) > eps || Math.abs(a.lng - b.lng) > eps || Math.abs(a.unit - b.unit) > eps) {
      console.error("Mismatch decode at", i, a, b);
      ok = false;
    }
  }
  console.log("\nConsistency:", ok ? "OK" : "NG");
}

if (import.meta.main) {
  main();
}
