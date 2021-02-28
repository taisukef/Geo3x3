#import <Foundation/Foundation.h>
#import "Geo3x3.objc.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%@", [Geo3x3 Encode:35.65858 lng:139.745433 level:14]);

        NSArray* res = [Geo3x3 Decode:@"E9139659937288"];
        for (NSNumber* num in res) {
            NSLog(@"%f", num.doubleValue);
        }
    }
    return 0;
}
