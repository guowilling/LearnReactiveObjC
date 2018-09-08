//
//  CustomView.h
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@interface CustomView : UIView

+ (instancetype)customView;

@property (nonatomic, strong) RACSubject *btnActionSignal;

@end
