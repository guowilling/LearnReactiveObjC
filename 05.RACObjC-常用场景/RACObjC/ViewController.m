//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "RedView.h"
#import <ReactiveObjC.h>
#import <NSObject+RACKVOWrapper.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet RedView *redView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self RAC_delegate];
    
    [self RAC_KVO];
    
    [self RAC_events];
    
    [self RAC_notification];
    
    [self RAC_textFiled];
}

- (void)RAC_textFiled {
    
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
}

- (void)RAC_notification {
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification *x) {
        NSLog(@"UIKeyboardWillShowNotification: %@", x.userInfo);
    }];
}

- (void)RAC_events {
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        NSLog(@"Click button: %@", x.currentTitle);
    }];
}

- (void)RAC_KVO {
    
    [self.redView rac_observeKeyPath:@"frame"
                             options:NSKeyValueObservingOptionNew
                            observer:nil
                               block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
                                   NSLog(@"%@\n%@", value, change);
                               }];
    
    [[self.redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)RAC_delegate {
    
    // 方式一: RACSubject
    
    // 方式二: rac_signalForSelector
    [[self.redView rac_signalForSelector:@selector(didClickRedViewButton:)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"didClickRedViewButton: %@", x);
        UIButton *button = x[0];
        NSLog(@"%@", button.currentTitle);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGRect newFrame = self.redView.frame;
    newFrame.size.height += 50;
    self.redView.frame = newFrame;
}

@end
