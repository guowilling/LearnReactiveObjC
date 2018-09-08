//
//  PersonListViewModel.m
//  RACObjC-基本使用
//
//  Created by Willing Guo on 2018/8/5.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "PersonListViewModel.h"

@implementation PersonListViewModel

- (RACSignal *)loadPersons {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        _personList = [NSMutableArray array];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1.0];
            for (NSInteger i = 0; i < 20; i++) {
                Person *person = [[Person alloc] init];
                person.name = [@"name " stringByAppendingFormat:@"%zd", i];
                person.age = 10 + arc4random_uniform(20);
                [_personList addObject:person];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                BOOL isError = NO;
                if (isError) {
                    [subscriber sendError:[NSError errorWithDomain:@"com.willing.error" code:1001 userInfo:@{@"msg": @"错误信息"}]];
                } else {
                    [subscriber sendNext:self];
                }
                [subscriber sendCompleted];
            });
        });
        
        return nil;
    }];
}

@end
