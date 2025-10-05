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
