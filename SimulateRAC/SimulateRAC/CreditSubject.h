//
//  CreditSubject.h
//  SimulateRAC
//
//  Created by 郭伟林 on 17/3/30.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SubscribeNextActionBlock)(NSUInteger credit);

@interface CreditSubject : NSObject

+ (CreditSubject *)create;

- (CreditSubject *)sendNext:(NSUInteger)credit;
- (CreditSubject *)subscribeNext:(SubscribeNextActionBlock)block;

@end
