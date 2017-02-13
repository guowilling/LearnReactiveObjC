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
    
@property (nonatomic, strong) id<RACSubscriber> subscriber;

@property (nonatomic, strong) RACDisposable *disposable;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber ) {
        _subscriber = subscriber;
        [subscriber sendNext:@"hello, RAC."];
        return [RACDisposable disposableWithBlock:^{
            // 默认订阅者释放时会自动取消订阅, 所以只要订阅者没有释放, 就不会自动取消信号订阅.
            NSLog(@"信号被取消订阅了!");
        }];
    }];
    _disposable = [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 主动取消订阅信号
    [_disposable dispose];
}
    
@end
