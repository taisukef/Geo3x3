const geo3x3 = @import("geo3x3.zig");
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var enc = [_]u8{0}**14;
    try geo3x3.encode(35.65858, 139.745433, 14, &enc);
    try stdout.print("{s}\n",.{enc});
    
    var dec = [_]f64{0}**4;
    try geo3x3.decode("E9139659937288", &dec);
    try stdout.print("{} {} {d:.0} {}\n",.{dec[0],dec[1],dec[2],dec[3]});
}
