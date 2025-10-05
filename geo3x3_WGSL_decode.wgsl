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
