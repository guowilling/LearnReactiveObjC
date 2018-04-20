//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "LoginViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation ViewController

- (LoginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.loginVM, username) = self.textField1.rac_textSignal;
    RAC(self.loginVM, password) = self.textField2.rac_textSignal;
    
    RAC(self.loginBtn, enabled) = self.loginVM.loginBtnEnableSignal;
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self myResignFirstResponder];
        [self.loginVM.loginCommand execute:@"发送登录请求"];
    }];
}

- (void)myResignFirstResponder {
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}

@end
