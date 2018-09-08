//
//  ViewController.m
//  RACObjC-更多使用
//
//  Created by Willing Guo on 2018/8/5.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic) UIButton *demoButton;

@end

@implementation ViewController {
    Person *_person;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _person = [[Person alloc] init];
    _person.name = @"zhangsan";
    _person.age = 18;
    
    [self demoBothwayBinding];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)demoBothwayBinding { 
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, 300, 40)];
    ageTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:ageTextField];
    
    // Model => UI
    RAC(nameTextField, text) = RACObserve(_person, name); // name(string) -> text(string)
    NSLog(@"%@", RACObserve(_person, name));
    // age(NSInteger) -> text(string) RAC 中传递的数据都是 id 类型
    // 如果使用基本数据类型绑定 UI, 需要使用 map 函数, 在 block 中对 value 的数值进行转换之后才能够绑定
    RAC(ageTextField, text) = [RACObserve(_person, age) map:^id(id value) {
        NSLog(@"%@ %@", value, [value class]);
        //return [NSString stringWithFormat:@"%zd", value];
        return [value description]; // value 是 NSNumber 类型
    }];
    
    // UI => Model
    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, ageTextField.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        _person.name = [x first];
        _person.age = [[x second] integerValue];
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"%@ %zd", _person.name, _person.age); // 循环引用 !!!
    }];
}

- (void)demoCombineField3 {
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextField];
    
    @weakify(self)
    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, pwdTextField.rac_textSignal]
                       reduce:^id(NSString *name, NSString *pwd) {
                           NSLog(@"%@ %@", name, pwd);
                           return @(name.length > 0 && pwd.length > 0);
                       }] subscribeNext:^(id x) {
                           NSLog(@"%@", x);
                           @strongify(self)
                           self.demoButton.enabled = [x boolValue];
                       }];
}

- (void)demoCombineField2 {
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextField];
    
    [[RACSignal combineLatest:@[nameTextField.rac_textSignal, pwdTextField.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        NSString *name = x.first;
        NSString *pwd = x.second;
        NSLog(@"%@ %@", name, pwd);
    }];
}

- (void)demoCombineField1 {
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:pwdTextField];
    
    [[nameTextField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@ %@", x, [x class]);
    }];
    [[pwdTextField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@ %@", x, [x class]);
    }];
}

- (void)demoTextFieldRAC {
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 300, 40)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:nameTextField];
    [[nameTextField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@ %@", x, [x class]);
    }];
}

- (void)demoButtonRAC {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    _demoButton = btn;
}

@end
