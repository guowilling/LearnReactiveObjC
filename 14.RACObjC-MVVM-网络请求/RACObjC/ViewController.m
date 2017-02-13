//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "BookViewModel.h"
#import "Book.h"

@interface ViewController ()

@property (nonatomic, strong) BookViewModel *bookVM;

@end

@implementation ViewController

- (BookViewModel *)bookVM {
    
    if (!_bookVM) {
        _bookVM = [[BookViewModel alloc] init];
    }
    return _bookVM;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    RACSignal *signal = [self.bookVM.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        Book *book = x[0];
        NSLog(@"%@", book);
    }];
}

@end
