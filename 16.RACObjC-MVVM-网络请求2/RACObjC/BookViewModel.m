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
        NSLog(@"%@", input);
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[AFHTTPRequestOperationManager manager] GET:@"https://api.douban.com/v2/book/search"
                                              parameters:input
                                                 success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                                     [subscriber sendNext:responseObject];
                                                     [subscriber sendCompleted];
                                                 } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                                                     [subscriber sendError:error];
                                                 }];
            return nil;
        }];
        
        return [requestSignal map:^id _Nullable(id  _Nullable value) {
            NSMutableArray *dictArray = value[@"books"];
            NSArray *modelArray = [dictArray.rac_sequence map:^id(id value) {
                return [Book bookWithDict:value];
            }].array;
            _books = modelArray;
            return nil;
            //return modelArray;
        }];
    }];
}

@end
