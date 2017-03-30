//
//  Student.m
//  SimulateRAC
//
//  Created by 郭伟林 on 17/3/30.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "Student.h"
#import "CreditSubject.h"

@interface Student ()

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, assign) StudentGender gender;
@property (nonatomic, assign) NSUInteger studentNumber;

@property (nonatomic, assign) NSUInteger credit;
@property (nonatomic, strong) SatisfyActionBlock satisfyBlock;

@end

@implementation Student

- (CreditSubject *)creditSubject {
    
    if (!_creditSubject) {
        _creditSubject = [CreditSubject create];
    }
    return _creditSubject;
}

+ (Student *)create {
    
    Student *student = [[self alloc] init];
    return student;
}

- (Student *)name:(NSString *)name {
    
    _name = name;
    return self;
}

- (Student *)gender:(StudentGender)gender {
    
    _gender = gender;
    return self;
}

- (Student *)studentNumber:(NSUInteger)number {
    
    _studentNumber = number;
    return self;
}

- (Student *)sendCredit:(NSUInteger (^)(NSUInteger credit))updateCreditBlock {
    
    if (updateCreditBlock) {
        self.credit = updateCreditBlock(self.credit);
        if (self.satisfyBlock) {
            self.isSatisfyCredit = self.satisfyBlock(self.credit);
            if (self.isSatisfyCredit) {
                NSLog(@"satisfy");
            } else {
                NSLog(@"not satisfy");
            }
        }
    }
    return self;
}

- (Student *)inspectIsASatisfyCredit:(SatisfyActionBlock)satisfyBlock {
    
    if (satisfyBlock) {
        self.satisfyBlock = satisfyBlock;
        self.isSatisfyCredit = self.satisfyBlock(self.credit);
    }
    return self;
}

@end
