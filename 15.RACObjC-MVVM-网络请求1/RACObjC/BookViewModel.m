//
//  BookViewModel.m
//  RACObjC
//
//  Created by Willing Guo on 2017/2/13.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "BookViewModel.h"
#import "AFNetworking.h"
#import "Book.h"

@implementation BookViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:@"https://api.douban.com/v2/book/search"
              parameters:@{@"q": @"动物"}
                 success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * _Nonnull responseObject) {
                     NSArray *dictArray = responseObject[@"books"];
                     NSArray *modelArray = [dictArray.rac_sequence map:^id(id value) {
                         return [Book bookWithDict:value];
                     }].array;
                     [subscriber sendNext:modelArray];
                 }
                 failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) { }];
            return nil;
        }];
        return requestSignal;
    }];
}

@end
