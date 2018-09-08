//
//  ViewController.m
//  RACObjC-基本使用
//
//  Created by Willing Guo on 2018/8/5.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "ViewController.h"
#import "PersonListViewModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController {
    PersonListViewModel *_personListVM;
    
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _personListVM = [[PersonListViewModel alloc] init];
    [[_personListVM loadPersons] subscribeNext:^(id x) {
        [_tableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    } completed:^{
        NSLog(@"完成");
    }];
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _personListVM.personList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.text = _personListVM.personList[indexPath.row].name;
    return cell;
}

@end
