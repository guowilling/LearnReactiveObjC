//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //[self basicUseSignal];

    //[self timeout];
    
    //[self interval];
    
    //[self delay];
}

- (void)delay {
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"hello, RAC."];
        return nil;
    }] delay:2.0] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

- (void)interval {
    
    [[RACSignal interval:2.0 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)timeout {
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"hello, RAC."];
        return nil;
    }] timeout:2.0 onScheduler:[RACScheduler currentScheduler]];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)basicUseSignal {
    
    // RACSignal 使用步骤: 1.创建信号; 2.订阅信号; 3.发送信号;
    
    // 1.创建信号(冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 3.发送信号
        [subscriber sendNext:@"hello, RAC."];
        return nil;
    }];
    // 2.订阅信号(热信号)
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // RACDynamicSignal 信号执行顺序(注意: 不同类型的信号处理的方式不同)
    // 1. 订阅信号会执行, 创建信号时传入的 didSubscribe block 参数里的代码.
    // 2. 发送信号会执行, 订阅信号时传入的 nextBlock block 参数里的代码.
}

@end
