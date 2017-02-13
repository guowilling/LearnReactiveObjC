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

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //[self filter];
    
    //[self ignore];
    
    //[self take];
    
    //[self distinctUntilChanged];
    
    [self skip];
}

- (void)skip {
    
    // skip: 跳过 skipCount 次信号.
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"数据A"];
    [subject sendNext:@"数据B"];
    [subject sendNext:@"数据C"];
}

- (void)distinctUntilChanged {
    
    // distinctUntilChanged: 如果信号发送的数据和上一次相同, 则忽略此次信号.
    
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"数据A"];
    [subject sendNext:@"数据B"];
    [subject sendNext:@"数据B"];
    [subject sendNext:@"数据C"];
}

- (void)take {
    
    RACSubject *subject = [RACSubject subject];
    
    // take: 只接收信号发送的前面 count 次数据.
//    [[subject take:1] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    // takeLast: 只接收信号发送的后面 count 次数据, 必须调用 sendCompleted.
//    [[subject takeLast:1] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    RACSubject *signal = [RACSubject subject];
    // takeUntil: 只要 signalTrigger 信号发送了任意数据或者发送完成, 就不能在接收原信号发送的内容了.
    [[subject takeUntil:signal] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"数据A"];
    
    [signal  sendNext:@"数据B"]; // | [signal sendCompleted];
    
    [subject sendNext:@"数据C"];
    [subject sendNext:@"数据D"];
    
    //[subject sendCompleted];
}

- (void)ignore {
    
    RACSubject *subject = [RACSubject subject];
    // ignore: 忽略指定内容.
    // ignoreValues: 忽略所有的内容.
    //RACSignal *ignoreSignal = [subject ignore:@"数据A"];
    RACSignal *ignoreSignal = [subject ignoreValues];
    [ignoreSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [subject sendNext:@"数据A"];
    [subject sendNext:@"数据B"];
    [subject sendNext:@"数据C"];
}

- (void)filter {
    
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
       return  [value length] > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

@end
