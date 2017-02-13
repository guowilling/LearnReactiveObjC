//
//  CustomView.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (RACSubject *)testBtnActionSignal {
    
    if (!_testBtnActionSignal) {
        _testBtnActionSignal = [RACSubject subject];
    }
    return _testBtnActionSignal;
}

+ (instancetype)customView {
    
    return [[self alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        
        UIButton *testBtn = [[UIButton alloc] init];
        testBtn.backgroundColor = [UIColor redColor];
        testBtn.frame = CGRectMake(0, 0, 100, 50);
        testBtn.center = self.center;
        [testBtn setTitle:@"Click Me!" forState:UIControlStateNormal];
        [testBtn addTarget:self action:@selector(testBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:testBtn];
    }
    return self;
}

- (void)testBtnAction:(UIButton *)sender {
    
    [self.testBtnActionSignal sendNext:sender];
}

@end
