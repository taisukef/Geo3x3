<<__EntryPoint>>
function main(): void {
  require('Geo3x3.hack');
  
  $code = Geo3x3::encode(35.65858, 139.745433, 14);
  echo $code . "\n";

  $pos = Geo3x3::decode('E9139659937288');
  echo $pos[0] . " " . $pos[1] . " " . $pos[2] . " " . $pos[3] . "\n";
}
