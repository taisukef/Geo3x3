#import <Foundation/Foundation.h>
#import "Geo3x3.objc.h"

@implementation Geo3x3
+ (NSString*)Encode:(double)lat lng:(double)lng level:(int)level {
    if (level < 1) {
        return @"";
    }
    NSString* res = nil;
    if (lng >= 0) {
        res = @"E";
    } else {
        res = @"W";
        lng += 180.0;
    }
    lat += 90.0;
    double unit = 180.0;
    for (int i = 1; i < level; i++) {
        unit /= 3.0;
        const int x = (int)(lng / unit);
        const int y = (int)(lat / unit);
        const int n = x + y * 3 + 1;
        NSString* c = [[NSNumber numberWithInt:n] stringValue];
        res = [res stringByAppendingString:c];
        lng -= x * unit;
        lat -= y * unit;
    }
    return res;
}
+ (NSArray*)Decode:(NSString*)code {
    const int clen = [code length];
    if (code == nil || clen == 0) {
        return nil;
    }
    NSString* c = [code substringWithRange:NSMakeRange(0, 1)];
    bool flg = false;
    int begin = 0;
    if ([c isEqualToString:@"W"] || [c isEqualToString:@"-"]) {
        flg = true;
        begin = 1;
    } else if ([c isEqualToString:@"E"] || [c isEqualToString:@"+"]) {
        begin = 1;
    }
    double unit = 180.0;
    double lat = 0.0;
    double lng = 0.0;
    int level = 1;
    for (int i = begin; i < clen; i++) {
        NSString* c = [code substringWithRange:NSMakeRange(i, 1)];
        const NSRange range = [@"123456789" rangeOfString:c];
        if (range.location == NSNotFound) {
            break;
        }
        const int n = range.location;
        unit /= 3;
        lng += (double)(n % 3) * unit;
        lat += (double)(n / 3) * unit;
        level++;
    }
    lat += unit / 2;
    lng += unit / 2;
    lat -= 90.0;
    if (flg) {
        lng -= 180.0;
    }
    return [NSArray arrayWithObjects:
        [NSNumber numberWithFloat:lat],
        [NSNumber numberWithFloat:lng],
        [NSNumber numberWithFloat:level],
        [NSNumber numberWithFloat:unit],
        nil
    ];
}
@end
