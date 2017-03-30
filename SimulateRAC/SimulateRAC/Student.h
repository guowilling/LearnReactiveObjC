//
//  Student.h
//  SimulateRAC
//
//  Created by 郭伟林 on 17/3/30.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreditSubject;

typedef NS_ENUM(NSUInteger, StudentGender) {
    StudentGenderMale,
    StudentGenderFemale
};

typedef BOOL(^SatisfyActionBlock)(NSUInteger credit);

@interface Student : NSObject

@property (nonatomic, strong) CreditSubject *creditSubject;

@property (nonatomic, assign) BOOL isSatisfyCredit;

+ (Student *)create;

- (Student *)name:(NSString *)name;
- (Student *)gender:(StudentGender)gender;
- (Student *)studentNumber:(NSUInteger)number;

- (Student *)sendCredit:(NSUInteger (^)(NSUInteger credit))updateCreditBlock;
- (Student *)inspectIsASatisfyCredit:(SatisfyActionBlock)satisfyBlock;

@end
