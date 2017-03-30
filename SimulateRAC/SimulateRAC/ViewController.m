//
//  ViewController.m
//  SimulateRAC
//
//  Created by 郭伟林 on 17/3/30.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "Student.h"
#import "CreditSubject.h"

@interface ViewController ()

@property (nonatomic, strong) Student  *student;

@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UILabel  *currentCreditLabel;
@property (nonatomic, strong) UILabel  *isSatisfyLabel;

@end

@implementation ViewController

- (UIButton *)testButton {
    
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testButton setTitle:@"增加5个积分" forState:UIControlStateNormal];
        [_testButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:_testButton];
        [_testButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    return _testButton;
}

- (UILabel *)currentCreditLabel {
    
    if (!_currentCreditLabel) {
        _currentCreditLabel = [[UILabel alloc] init];
        _currentCreditLabel.textColor = [UIColor lightGrayColor];
    }
    return _currentCreditLabel;
}

- (UILabel *)isSatisfyLabel {
    
    if (!_isSatisfyLabel) {
        _isSatisfyLabel = [[UILabel alloc] init];
        _isSatisfyLabel.textAlignment = NSTextAlignmentRight;
        _isSatisfyLabel.textColor = [UIColor lightGrayColor];
    }
    return _isSatisfyLabel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.student = [[[[[Student create] name:@"willing"] gender:StudentGenderMale] studentNumber:123] inspectIsASatisfyCredit:^BOOL(NSUInteger credit) {
        if (credit >= 50) {
            self.isSatisfyLabel.text = @"合格";
            self.isSatisfyLabel.textColor = [UIColor redColor];
            return YES;
        } else {
            self.isSatisfyLabel.text = @"不合格";
            return NO;
        }
    }];
    
    [self setupUI];
    
    [self subscribeStudent];
}

- (void)setupUI {
    
    [self.view addSubview:self.currentCreditLabel];
    [self.currentCreditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(50);
    }];
    
    [self.view addSubview:self.isSatisfyLabel];
    [self.isSatisfyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
    }];
    
    @weakify(self);
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.student sendCredit:^NSUInteger(NSUInteger credit) {
            credit += 5;
            [self.student.creditSubject sendNext:credit];
            return credit;
        }];
    }];
}

- (void)subscribeStudent {
    
    [self.student.creditSubject subscribeNext:^(NSUInteger credit) {
        NSLog(@"第一个订阅者处理积分: %lu", credit);
        self.currentCreditLabel.text = [NSString stringWithFormat:@"%lu",credit];
        if (credit < 25) {
            self.currentCreditLabel.textColor = [UIColor lightGrayColor];
        } else if(credit < 50) {
            self.currentCreditLabel.textColor = [UIColor purpleColor];
        } else {
            self.currentCreditLabel.textColor = [UIColor redColor];
        }
    }];
    
    [self.student.creditSubject subscribeNext:^(NSUInteger credit) {
        NSLog(@"第二个订阅者处理积分: %lu", credit);
        if (!(credit > 0)) {
            self.currentCreditLabel.text = @"0";
            self.isSatisfyLabel.text = @"未设置";
        }
    }];
}

@end
