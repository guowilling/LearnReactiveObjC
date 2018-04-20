//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import <RACReturnSignal.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self flattenMap];
    
//    [self map];
    
    [self flattenMapSignalOfSignals];
}

- (void)flattenMapSignalOfSignals {
    // flattenMap 使用场景: 信号中的信号.
    
    RACSubject *signalOfsignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    // 订阅信号
//    [signalOfsignals subscribeNext:^(RACSignal *x) {
//        [x subscribeNext:^(id x) {
//            NSLog(@"%@",x);
//        }];
//    }];
    
//    RACSignal *bindSignal = [signalOfsignals flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        NSLog(@"%@", value);
//        return value;
//    }];
//    [bindSignal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    [[signalOfsignals flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        NSLog(@"%@", value);
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [signalOfsignals sendNext:signal];
    [signal sendNext:@"JSON数据"];
}

- (void)map {
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
        NSLog(@"%@", value);
        return [NSString stringWithFormat:@"解析后的%@", value];
    }];
    
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"JSON数据"];
    [subject sendNext:@"XML数据"];
}

- (void)flattenMap {
    RACSubject *subject = [RACSubject subject];
    
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        NSLog(@"%@", value);
        value = [NSString stringWithFormat:@"解析后的%@", value];
        return [RACReturnSignal return:value];
    }];
    
    // 此处订阅的就是 flattenMap block 中返回的信号.
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"JSON数据"];
}

@end
