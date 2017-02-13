//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "MBProgressHUD+SR.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loginBtnEnable];
    
    [self loginAction];
}

- (void)loginBtnEnable {
    
    RACSignal *loginBtnEnableSiganl = [RACSignal combineLatest:@[self.textField1.rac_textSignal, self.textField2.rac_textSignal]
                                                        reduce:^id(NSString *account,NSString *pwd){
                                                            return @(account.length && pwd.length);
                                                        }];
    RAC(self.loginBtn, enabled) = loginBtnEnableSiganl;
}

- (void)loginAction {
    
    RACCommand *loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"完成登录请求"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [[loginCommand.executing skip:1] subscribeNext:^(id x) { // skip 1!
        if ([x boolValue] == YES) {
            [MBProgressHUD sr_showIndeterminateWithMessage:@"正在登录..."];
            NSLog(@"正在执行命令");
        } else {
            [MBProgressHUD sr_hideHUD];
            NSLog(@"完成执行命令");
        }
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self myResignFirstResponder];
        [loginCommand execute:@"发送登录请求"];
    }];
}

- (void)myResignFirstResponder {
    
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}

@end
