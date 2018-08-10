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

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RACObserve(self.view, frame) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    RACTuple *tuple = RACTuplePack(@"hello", @"RAC");
    NSLog(@"%@", tuple[0]);
    
//    [_textField.rac_textSignal subscribeNext:^(id x) {
//        _label.text = x;
//    }];
    RAC(_label, text) = _textField.rac_textSignal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self liftSelector];
}

- (void)liftSelector {
    // 需求: 多个请求全部完成后再刷新 UI
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求热销模块数据");
        [subscriber sendNext:@"热销模块数据"];
        return nil;
    }];
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求最新模块数据");
        [subscriber sendNext:@"最新模块数据"];
        return nil;
    }];
    // withSignalsFromArray 中的所有信号都发送数据后才会执行 selector, selector 的参数就是每个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData {
    // 刷新 UI
    NSLog(@"%@", hotData);
    NSLog(@"%@", newData);
}

@end
