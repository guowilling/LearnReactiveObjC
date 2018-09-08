//
//  Person.m
//  RACObjC-基本使用
//
//  Created by Willing Guo on 2018/8/5.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    NSArray *keys = @[@"name", @"age"];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
