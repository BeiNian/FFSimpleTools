//
//  ViewController.m
//  FFSimpleTools
//
//  Created by cts on 2018/1/12.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerCell.h"
#import <objc/runtime.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, nullable, strong) UITableView *tableView;
@property (nonatomic, nullable, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell" forIndexPath:indexPath];
    
    cell.contentLabel.text = self.dataSource[indexPath.row][@"titeText"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController =  [[NSClassFromString(self.dataSource[indexPath.row][@"viewController"]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - set & get
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"ViewControllerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ViewControllerCell"];
        _tableView.rowHeight =  UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 200; 
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[
                        @{@"titeText":@"钥匙串的访问",
                          @"viewController":@"FFKeychainViewController"},
                        @{@"titeText":@"Toast提示",
                          @"viewController":@"CKToastViewController"},
                        @{@"titeText":@"设备信息",
                          @"viewController":@"FFDeviceViewController"},
                        @{@"titeText":@"钥匙串的访问",
                          @"viewController":@"FFKeychainViewController"},
                        @{@"titeText":@"钥匙串的访问",
                          @"viewController":@"FFKeychainViewController"},
                        ];
    }
    return _dataSource;
}
@end
