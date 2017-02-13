//
//  BookViewModel.h
//  RACObjC
//
//  Created by Willing Guo on 2017/2/13.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface BookViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, copy, readonly) NSArray *books;


@end
