//
//  LDDTabBarViewController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/6/13.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDTabBarViewController.h"
#import "LDDHJTableViewController.h"
#import <Masonry.h>

@interface LDDTabBarViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configuration];
}

- (void)configuration {
    LDDHJTableViewController *vc = [LDDHJTableViewController new];
    vc.title = @"22效果";
    vc.tabBarItem.image = [UIImage imageNamed:@"mine_normal"];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_select"];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:vc];
    
    UIViewController *vc1 = [UIViewController new];
    vc1.title = @"24效果";
    vc1.tabBarItem.image = [UIImage imageNamed:@"mine_normal"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_select"];
    vc1.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:vc1];
    
    // 验证TabBarController对TableViewFooter的影响
    UILabel *label = [UILabel new];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.text = @"1.在某些iOS版本上TabBar会影响TableView的Footer的显示，已知的一个有影响的版本是iOS 10.3.2 \n2.本控制器的范围包含TabBar后面那一部分区域，TableView的区域也包含那一部分区域，在正常的iOS版本中系统会做到使TabBar不遮挡TableView，是可以完全正常显示的 \n3.在非正常iOS版本中(如iOS 10.3.2)，会出现遮挡情况 \n4.其实还是因为布局出现了问题，布局的时候要注意不能使TableView的区域包含TabBar后面，应该就可以保证所有版本都不会出现遮挡问题。 \5.现在的代码是有瑕疵的，可以使用iOS 10.3.2的系统看一下效果。";
    [vc1.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [vc1.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.right.left.bottom.equalTo(@0);
    }];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-->%ld",indexPath.section,indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerOrHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerOrHeaderID"];
    if (!footerOrHeader) {
        footerOrHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerOrHeaderID"];
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 101;
        [footerOrHeader addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(footerOrHeader);
        }];
    }
    UILabel *label = (UILabel *)[footerOrHeader viewWithTag:101];
    label.text = [NSString stringWithFormat:@"header %ld",section];
    return footerOrHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerOrHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerOrHeaderID"];
    if (!footerOrHeader) {
        footerOrHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerOrHeaderID"];
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 101;
        [footerOrHeader addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(footerOrHeader);
        }];
    }
    UILabel *label = (UILabel *)[footerOrHeader viewWithTag:101];
    label.text = [NSString stringWithFormat:@"footer %ld",section];
    return footerOrHeader;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
