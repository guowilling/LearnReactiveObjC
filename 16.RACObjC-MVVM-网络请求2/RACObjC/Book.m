//
//  Book.m
//  RACObjC
//
//  Created by Willing Guo on 2017/2/13.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (instancetype)bookWithDict:(NSDictionary *)dict {
    Book *book = [[Book alloc] init];
    book.title = dict[@"title"];
    book.subtitle = dict[@"subtitle"];
    return book;
}

@end
