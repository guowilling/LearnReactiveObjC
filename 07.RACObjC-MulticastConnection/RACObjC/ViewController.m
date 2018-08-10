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
    
    // 需求: 每次订阅信号时不要都发送网络请求, 只发送一次网络请求, 但是每次订阅信号时都要能得到数据
    
//    [self RACSignalRequestBUG];
    
//    [self RACSubject];
    
//    [self RACMulticastConnection];
}

- (void)RACMulticastConnection {
    NSLog(@"Fix BUG");
    
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // connection connect 时执行此 block.
        NSLog(@"网络请求");
        [subscriber sendNext:@"JSON数据"];
        return nil;
    }];
    
    // 2.信号转换成连接类
    //RACMulticastConnection *connection = [signal publish];
    RACMulticastConnection *connection = [signal multicast:[RACReplaySubject subject]];
    
    // 3.订阅连接类的信号
    [connection.signal subscribeNext:^(id x) {
        // subscriber sendNext 时执行此 block
        NSLog(@"订阅者一: %@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
        // subscriber sendNext 时执行此 block
        NSLog(@"订阅者二: %@",x);
    }];
    
    // 4.连接
    [connection connect];
}

- (void)RACSubject {
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者一: %@", x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者二: %@", x);
    }];
    [subject sendNext:@"网络数据"];
}

- (void)RACSignalRequestBUG {
    NSLog(@"BUG");
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"网络请求");
        [subscriber sendNext:@"JSON数据"];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"订阅者一: %@", x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"订阅者二: %@", x);
    }];
}

@end
