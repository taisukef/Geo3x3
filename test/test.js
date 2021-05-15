import * as t from "https://deno.land/std/testing/asserts.ts";
import { Geo3x3 } from "../Geo3x3.js";

Deno.test("encode", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 14), "E9139659937288");
});
Deno.test("decode", () => {
  t.assertEquals(Geo3x3.decode("E9139659937288"), {
    lat: 35.6586337900162,
    lng: 139.74546563023935,
    level: 14,
    unit: 0.00011290058538953522,
  });
});
Deno.test("east west", () => {
  t.assertEquals(Geo3x3.decode("E9"), {
    lat: 60,
    lng: 150,
    level: 2,
    unit: 60,
  });
  t.assertEquals(Geo3x3.decode("W9"), {
    lat: 60,
    lng: -30,
    level: 2,
    unit: 60,
  });
  t.assertEquals(Geo3x3.decode("W9139659937288"), {
    lat: 35.6586337900162,
    lng: 139.74546563023935 - 180,
    level: 14,
    unit: 0.00011290058538953522,
  });
});
Deno.test("level 1", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 1), "E");
});
Deno.test("level 2", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 2), "E9");
});
Deno.test("level 100", () => {
  const code =
    "E913965993728812367735494361339689965777626353895646471699754229785643135985754627611663513952577254";
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 100), code);
});
Deno.test("level", () => {
  const code = "E91396599372881236773549436133";
  for (let i = 1; i < 30; i++) {
    const code2 = code.substring(0, i);
    t.assertEquals(Geo3x3.encode(35.65858, 139.745433, i), code2);
    t.assertEquals(Geo3x3.decode(code2).level, code2.length);
  }
});

Deno.test("illegal level", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433), null);
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 0), null);
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, -1), null);
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, NaN), null);
});
Deno.test("encode string number", () => {
  t.assertEquals(
    Geo3x3.encode("35.65858", "139.745433", "14"),
    "E9139659937288",
  );
  t.assertEquals(Geo3x3.encode(35.65858, "139.745433", "14"), "E9139659937288");
  t.assertEquals(Geo3x3.encode("35.65858", 139.745433, "14"), "E9139659937288");
  t.assertEquals(Geo3x3.encode("35.65858", "139.745433", 14), "E9139659937288");
});
Deno.test("encode illegal param", () => {
  t.assertEquals(
    Geo3x3.encode("35.65858E", "139.745433", "14"),
    "E9139659937288",
  );
  t.assertEquals(Geo3x3.encode("E", "F", "14"), null);
});
Deno.test("encode out of the earth", () => {
  t.assertEquals(Geo3x3.encode(-90.1, 139.745433, "14"), null);
  t.assertEquals(Geo3x3.encode(90, 139.745433, "14"), "E12133323331222");
  t.assertEquals(Geo3x3.encode(90.1, 139.745433, "14"), null);
  t.assertEquals(Geo3x3.encode(90, 180, "14"), "E13111111111111");
  t.assertEquals(Geo3x3.encode(90, 180.1, "14"), null);
  t.assertEquals(Geo3x3.encode(90, -180.1, "14"), null);
});
Deno.test("decode null code -> null", () => {
  t.assertEquals(Geo3x3.decode(null), null);
});
Deno.test("decode not string code -> null", () => {
  t.assertEquals(Geo3x3.decode(123), null);
  t.assertEquals(Geo3x3.decode({ lat: 123 }), null);
});
Deno.test("not string code -> null", () => {
  t.assertEquals(Geo3x3.decode(123), null);
});
Deno.test("level 1000 -> null (max: 999)", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 1000), null);
});
Deno.test("level Infinity -> null (max: 999)", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, Infinity), null);
});
Deno.test("level 3.5 -> as level 4", () => {
  t.assertEquals(Geo3x3.encode(35.65858, 139.745433, 3.5), "E913");
});
