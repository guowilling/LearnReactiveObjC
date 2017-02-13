//
//  ModalViewController.m
//  RACObjC
//
//  Created by Willing Guo on 2017/2/11.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ModalViewController.h"
#import <ReactiveObjC.h>

@interface ModalViewController ()

@property (nonatomic, strong) RACSignal *signal;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSLog(@"%@", self);
        return nil;
    }];
    _signal = signal;
}

- (IBAction)dimissAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end
