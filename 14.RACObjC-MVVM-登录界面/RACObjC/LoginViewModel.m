//
//  LoginViewModel.m
//  RACObjC
//
//  Created by Willing Guo on 2017/2/13.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "LoginViewModel.h"
#import "MBProgressHUD+SR.h"

@implementation LoginViewModel

- (instancetype)init {
    
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self setupLoginBtnEnableSiganl];
    
    [self setupLoginCommand];
}

- (void)setupLoginBtnEnableSiganl {
    
    _loginBtnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)]
                                              reduce:^id(NSString *username,NSString *password){
                                                  return @(username.length && password.length);
                                              }];
}

- (void)setupLoginCommand {
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"完成登录请求"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [[_loginCommand.executing skip:1] subscribeNext:^(id x) { // skip 1!
        if ([x boolValue] == YES) {
            [MBProgressHUD sr_showIndeterminateWithMessage:@"正在登录..."];
            NSLog(@"正在执行命令");
        } else {
            [MBProgressHUD sr_hideHUD];
            NSLog(@"完成执行命令");
        }
    }];
}

@end
