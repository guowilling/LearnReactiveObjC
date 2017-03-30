//
//  CreditSubject.m
//  SimulateRAC
//
//  Created by 郭伟林 on 17/3/30.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "CreditSubject.h"

@interface CreditSubject ()

@property (nonatomic, assign) NSUInteger credit;

@property (nonatomic, strong) SubscribeNextActionBlock subscribeNextBlock;

@property (nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation CreditSubject

- (NSMutableArray *)blockArray {
    
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

+ (CreditSubject *)create {
    
    CreditSubject *subject = [[self alloc] init];
    return subject;
}

- (CreditSubject *)sendNext:(NSUInteger)credit {
    
    self.credit = credit;
    
    if (self.blockArray.count > 0) {
        for (SubscribeNextActionBlock block in self.blockArray) {
            block(self.credit);
        }
    }
    return self;
}

- (CreditSubject *)subscribeNext:(SubscribeNextActionBlock)block {
    
    if (block) {
        block(self.credit);
    }
    [self.blockArray addObject:block];
    return self;
}

@end
