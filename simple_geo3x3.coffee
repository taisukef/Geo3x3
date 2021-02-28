###
npm install --global coffeescript

coffee -o out/ -c simple_geo3x3.coffee Geo3x3.coffee
deno run -A out/simple_geo3x3.js
###
import { Geo3x3 } from "./Geo3x3.js"

console.log Geo3x3.encode(35.65858, 139.745433, 14)
console.log Geo3x3.decode("E3793653391822")
