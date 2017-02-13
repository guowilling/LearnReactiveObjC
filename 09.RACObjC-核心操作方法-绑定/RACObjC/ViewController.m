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
    
    // 1.原信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal *(id value, BOOL *stop) {
            NSLog(@"原信号发送的内容: %@", value);
            value = [NSString stringWithFormat:@"New%@",value];
            // 不能 return nil, 可以 return [RACSignal empty].
            return [RACReturnSignal return:value];
        };
    }];
    
    // 3.订阅绑定信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"绑定信号发送的内容: %@", x);
    }];
    
    // 4.原信号发送数据
    [subject sendNext:@"JSON数据"];
}

@end
