#import <Foundation/Foundation.h>

@interface Geo3x3 : NSObject
+ (NSString*)Encode:(double)lat lng:(double)lng level:(int)level;
+ (NSArray*)Decode:(NSString*)code;
@end
