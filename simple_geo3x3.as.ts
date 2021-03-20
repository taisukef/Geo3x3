import { Geo3x3 } from "./Geo3x3.as";

console.log(Geo3x3.encode(35.65858, 139.745433, 14));
const pos = Geo3x3.decode("E9139659937288");
console.log(pos[0].toString() + " " + pos[1].toString() + " " + pos[2].toString() + " " + pos[3].toString());
