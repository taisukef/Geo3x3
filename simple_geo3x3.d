import std.stdio;
import Geo3x3;

void main() {
    // get Geo3x3 code from latitude / longitude / level
    char[14] code;
    if (Geo3x3.encode(35.65858, 139.745433, 14, code)) {
        writeln(code);
    }

    // get location from Geo3x3 code
    auto pos = Geo3x3.decode("E3793653391822");
    writeln(pos);
}
