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

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self concat];
    
//    [self then];

//    [self merge];

//    [self zipWith];

    [self combineLatest];
}

- (void)combineLatest {
    RACSignal *comineSiganl = [RACSignal combineLatest:@[self.textField1.rac_textSignal, self.textField2.rac_textSignal]
                                                reduce:^id _Nullable(NSString *username, NSString *password){
                                                    NSLog(@"username: %@, password: %@", username, password);
                                                    return @(username.length && password.length);
                                                }];
    // 订阅组合信号
//    [comineSiganl subscribeNext:^(id x) {
//        _loginBtn.enabled = [x boolValue];
//    }];
    RAC(_loginBtn, enabled) = comineSiganl;
}

- (void)zipWith {
    // 需求: 一个界面有多个请求, 所有请求完成才更新 UI.
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSignal *zipSignal = [signalA zipWith:signalB];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signalA sendNext:@"数据A"];
    [signalB sendNext:@"数据B"];
}

- (void)merge {
    // 任意信号发送完成都会调用 nextBlock block.
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSignal *mergeSiganl = [signalA merge:signalB];
    [mergeSiganl subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signalA sendNext:@"数据A"];
    [signalB sendNext:@"数据B"];
}

- (void)then {
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送A请求");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送B请求");
        [subscriber sendNext:@"数据B"];
        return nil;
    }];
    
    // then: 组合信号, 忽悠掉第一个信号.
    RACSignal *thenSiganl = [siganlA then:^RACSignal *{
        return siganlB; // 需要组合的信号
    }];
    
    [thenSiganl subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)concat {
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送A请求");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送B请求");
        [subscriber sendNext:@"数据B"];
        return nil;
    }];
    
    // concat: 顺序链接组合信号
    // 注意: concat 方法的 第一个信号必须要调用 sendCompleted.
    RACSignal *concatSignal = [siganlA concat:siganlB];
    
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

@end
