//
//  ViewController.m
//  RACObjC
//
//  Created by 郭伟林 on 17/2/10.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "BookViewModel.h"
#import "Book.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) BookViewModel *bookVM;

@end

@implementation ViewController

- (BookViewModel *)bookVM {
    
    if (!_bookVM) {
        _bookVM = [[BookViewModel alloc] init];
    }
    return _bookVM;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [self.bookVM.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [tableView reloadData];
    }];
    
//    @weakify(self);
//    [self.bookVM.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//        @strongify(self);
//        [self.tableView reloadData];
//    }];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = @"基础";
    [self.bookVM.requestCommand execute:parameters];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bookVM.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Book *book = self.bookVM.books[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    return cell;
}

@end
