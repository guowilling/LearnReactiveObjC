//
//  Book.h
//  RACObjC
//
//  Created by Willing Guo on 2017/2/13.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

+ (instancetype)bookWithDict:(NSDictionary *)dict;

@end
