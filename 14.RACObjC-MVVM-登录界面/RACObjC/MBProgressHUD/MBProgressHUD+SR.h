//
//  MBProgressHUD+SR.h
//  yixun
//
//  Created by 郭伟林 on 16/6/16.
//  Copyright © 2016年 again. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (SR)

#pragma mark - Show HUD

// Just text
+ (MBProgressHUD *)sr_showMessage:(NSString *)message;
+ (MBProgressHUD *)sr_showMessage:(NSString *)message onView:(UIView *)view;

// Indeterminate icon and test
+ (MBProgressHUD *)sr_showIndeterminateWithMessage:(NSString *)message;
+ (MBProgressHUD *)sr_showIndeterminateWithMessage:(NSString *)message onView:(UIView *)view;

// Success icon and text
+ (MBProgressHUD *)sr_showSuccessWithMessage:(NSString *)message;
+ (MBProgressHUD *)sr_showSuccessWithMessage:(NSString *)message onView:(UIView *)view;
+ (MBProgressHUD *)sr_showSuccessWithMessage:(NSString *)message onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

// Error icon and text
+ (MBProgressHUD *)sr_showErrorWithMessage:(NSString *)message;
+ (MBProgressHUD *)sr_showErrorWithMessage:(NSString *)message onView:(UIView *)view;
+ (MBProgressHUD *)sr_showErrorWithMessage:(NSString *)message onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

// Info icon and text
+ (MBProgressHUD *)sr_showInfoWithMessage:(NSString *)message;
+ (MBProgressHUD *)sr_showInfoWithMessage:(NSString *)message onView:(UIView *)view;
+ (MBProgressHUD *)sr_showInfoWithMessage:(NSString *)message onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

// Icon
+ (MBProgressHUD *)sr_showIconName:(NSString *)iconName message:(NSString *)message onView:(UIView *)view;
+ (MBProgressHUD *)sr_showIconName:(NSString *)iconName message:(NSString *)message onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

#pragma mark - Hide HUD

+ (void)sr_hideHUD;
+ (void)sr_hideHUDForView:(UIView *)view;
+ (void)sr_hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay;

@end
