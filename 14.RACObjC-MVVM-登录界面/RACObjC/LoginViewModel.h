//
//  LoginViewModel.h
//  RACObjC
//
//  Created by Willing Guo on 2017/2/13.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong, readonly) RACSignal  *loginBtnEnableSiganl;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
