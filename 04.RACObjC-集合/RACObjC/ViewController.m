//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "Flag.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self RACTuple];
    
//    [self NSArray];
    
//    [self NSDictionary];
    
    [self Model];
}

- (void)Model {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:plistPath];

    // 方式一:
//    NSMutableArray *arrayM = [NSMutableArray array];
//    [dictArray.rac_sequence.signal subscribeNext:^(NSDictionary *x) {
//        Flag *flag = [Flag flagWithDict:x];
//        [arrayM addObject:flag];
//    } completed:^{
//        NSLog(@"%@", arrayM);
//    }];
    
    // 方式二:
    NSArray *modelArray = [dictArray.rac_sequence map:^id(NSDictionary *value) {
        return [Flag flagWithDict:value];
    }].array;
    NSLog(@"%@", modelArray);
}

- (void)NSDictionary {
    NSDictionary *dictionary = @{@"name": @"willing", @"age": @"26"};
    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        // 方式一:
//        NSString *key = x[0];
//        NSString *value = x[1];
//        NSLog(@"%@: %@", key, value);
        
        // 方式二:
        // RACTupleUnpack: 解析元组, 参数是解析出来的变量名, '=' 右边是被解析的元组.
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"%@: %@", key, value);
    }];
}

- (void)NSArray {
    NSArray *array = @[@"hello", @"R", @"A", @"C", @"."];
    [array.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)RACTuple {
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"hello", @"R", @"A", @"C", @"."]];
    NSLog(@"%@", tuple[0]);
}

@end
