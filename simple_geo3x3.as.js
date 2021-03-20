const buf = await Deno.readFile("./Geo3x3.wasm");
const importObj = {
    module: {},
    env: {
        memory: new WebAssembly.Memory({ initial: 64 * 1024 }),
        table: new WebAssembly.Table({ initial: 0, element: 'anyfunc' }),
        abort(e) {
            console.log(e);
        },
        sendFloat64Array(pointer, length) {
            const data = new Float64Array(membuf, pointer, length);
            console.log(data, pointer, length);
            console.log(new Float64Array(membuf, pointer + 48, 4));
        },
    },
    /*
    index: {
        "console.logi": (n) => {
            console.log(n);
        },
    },
    */
};
const wasm = await WebAssembly.instantiate(buf, importObj);
const Geo3x3 = wasm.instance.exports;
const membuf = wasm.instance.exports.memory.buffer;
const memToString = (p) => {
    const mem = new Uint8Array(membuf);
    const s = [];
    for (let i = 0;; i += 2) {
        const n = mem[p + i] + (mem[p + i + 1] << 8);
        if (!n) {
            break;
        }
        s.push(String.fromCharCode(n));
    }
    return s.join("");
};
const stringToMem = (s) => {
    const off = Geo3x3.mem();
    console.log("off", off);
    const s2 = new Uint8Array(membuf, off, s.length + 1);
    for (let i = 0; i < s.length; i++) {
        s2[i] = s.charCodeAt(i);
    }
    s2[s2.length - 1] = 0;
    return off;
};
const memToDoubleArray4 = (p) => {
    console.log(p);
    return new Float64Array(membuf, p + 48, 4);
    //return wasm.instance.getArray(Float64Array, p);
};

console.log(memToString(Geo3x3.encode(35.65858, 139.745433, 14)));
console.log("mem2", Geo3x3.mem2());
//console.log(memToDoubleArray4(Geo3x3.decode(stringToMem("E9139659937288"), Geo3x3.mem2())));
console.log(memToDoubleArray4(Geo3x3.decode(stringToMem("E9139659937288"))));
//console.log(pos[0].toString() + " " + pos[1].toString() + " " + pos[2].toString() + " " + pos[3].toString());
