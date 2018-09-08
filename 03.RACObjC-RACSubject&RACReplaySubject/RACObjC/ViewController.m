//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, strong) CustomView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self RACSubject];
    
//    [self RACReplaySubject];
    
    _customView = [CustomView customView];
    _customView.center = self.view.center;
    [_customView.btnActionSignal subscribeNext:^(UIButton *x) {
        NSLog(@"testBtnAction: %@", x.currentTitle);
    }];
    [self.view addSubview:_customView];
}

- (void)RACSubject {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者一接收到信号: %@", x);
    }];
    
    // 发送数据
    [subject sendNext:@"hello, RAC."];
    
    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者二接收到信号: %@",x);
    }];
}

- (void)RACReplaySubject {
    // 创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"订阅者一接收到信号: %@", x);
    }];
    
    // 发送数据
    [replaySubject sendNext:@"hello, RAC."];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"订阅者二接收到信号: %@",x);
    }];
}

@end
