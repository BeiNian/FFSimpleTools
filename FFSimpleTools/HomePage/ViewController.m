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
#import "UIImage+Create.h"

#define COLOR_HEX(r, g, b, a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (nonatomic, nullable, strong) UITableView *tableView;
@property (nonatomic, nullable, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
//    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
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

#pragma mark - UINavigationControllerDelegate
- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    if (viewController == self) {
        //        // 背景设置为黑色
        //        self.navigationController.navigationBar.tintColor = [UIColor clearColor];
        //        // 透明度设置为0.3
        //        self.navigationController.navigationBar.alpha = 0;
        //        // 设置为半透明
        //        self.navigationController.navigationBar.translucent = NO;
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        
    } else {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
        //        // 进入其他视图控制器
        //        self.navigationController.navigationBar.alpha = 1;
        //        // 背景颜色设置为系统默认颜色
        //        self.navigationController.navigationBar.tintColor = nil;
        //        self.navigationController.navigationBar.translucent = NO;
    }
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
                        ];
    }
    return _dataSource;
}
@end
