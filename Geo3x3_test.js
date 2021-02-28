import { assertEquals } from "https://deno.land/std@0.69.0/testing/asserts.ts";
import { Geo3x3 } from "./Geo3x3.mjs";

Deno.test("decode", () => {
	assertEquals(Geo3x3.decode("W28644"), { lat: -40, lng: -86.2962962962963, level: 6, unit: 0.7407407407407408 });
	assertEquals(Geo3x3.decode("E28644"), { lat: -40, lng: 93.7037037037037, level: 6, unit: 0.7407407407407408 });
	assertEquals(Geo3x3.decode(null), null);
});
Deno.test("decode int", () => {
	assertEquals(Geo3x3.decode(-28644), { lat: -40, lng: -86.2962962962963, level: 6, unit: 0.7407407407407408 });
	assertEquals(Geo3x3.decode(28644), { lat: 40, lng: 93.7037037037037, level: 6, unit: 0.7407407407407408 });
	assertEquals(Geo3x3.decode("-28644"), { lat: 40, lng: -86.2962962962963, level: 6, unit: 0.7407407407407408 });
	assertEquals(Geo3x3.decode("28644"), { lat: 40, lng: 93.7037037037037, level: 6, unit: 0.7407407407407408 });
});
Deno.test("encode west", () => {
	assertEquals(Geo3x3.encode(40, -86.2962962962963, 6), "W28644");
});
Deno.test("encode east", () => {
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 6), "E28644");
});
Deno.test("encode levels", () => {
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 0), "");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 1), "E");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 2), "E2");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 3), "E28");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 4), "E286");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 5), "E2864");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 6), "E28644");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 7), "E286445");
	assertEquals(Geo3x3.encode(40, 93.7037037037037, 8), "E2864455");
});
Deno.test("getCoords", () => {
	assertEquals(Geo3x3.getCoords("E379219883294"), [
		{ lat: 35.950651154126234, lng: 136.18249250622367 },
		{ lat: 35.950651154126234, lng: 136.18283120797983 },
		{ lat: 35.9509898558824, lng: 136.18283120797983 },
		{ lat: 35.9509898558824, lng: 136.18249250622367 },
	]);
});
Deno.test("getMeshSize", () => {
	assertEquals(Geo3x3.getMeshSize("E379219883294"), { x: 37.70410702750087, y: 46.57581070903689 });
});
Deno.test("ll2xy xy2ll", () => {
	const pos = Geo3x3.decode("E379219883294");
	const xy = Geo3x3.ll2xy(pos.lat, pos.lng);
	assertEquals(xy, { x: 15159784.572805127, y: 4293856.4577055145 });
	const ll = Geo3x3.xy2ll(xy.x, xy.y);
	assertEquals(ll, { lat: 35.950820505004316, lng: 136.18266185710175 });
});
