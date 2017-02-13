
#import <Foundation/Foundation.h>

@interface Flag : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *icon;

+ (instancetype)flagWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
