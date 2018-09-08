//
//  PersonListViewModel.h
//  RACObjC-基本使用
//
//  Created by Willing Guo on 2018/8/5.
//  Copyright © 2018年 SR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Person.h"

@interface PersonListViewModel : NSObject

@property (nonatomic) NSMutableArray<Person *> *personList;

- (RACSignal *)loadPersons;

@end
