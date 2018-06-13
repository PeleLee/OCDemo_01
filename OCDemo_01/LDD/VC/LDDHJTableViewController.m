//
//  LDDHJTableViewController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/6/12.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDHJTableViewController.h"
#import "HJDefaultTabViewBar.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import <Masonry.h>

@interface LDDHJTableViewController ()<HJTabViewControllerDelagate,HJTabViewControllerDataSource,HJDefaultTabViewBarDelegate>

@end

@implementation LDDHJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabDataSource = self;
    self.tabDelegate = self;
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.equalTo(@20);
    }];
    label.text = @"other";
    
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
}

#pragma mark - HJDefaultTabViewBarDelegate

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return 2;
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"标题1";
    }
    else if (index == 1) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"定制标题2"];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 2)];
        return attString;
    }
    else {
        return @"其他标题";
    }
    return @"";
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.curIndex) > 1 ? NO : YES;
    [self scrollToIndex:index animated:anim];
}

#pragma mark -
- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    UIViewController *vc = [UIViewController new];
    if (index == 0) {
        vc.view.backgroundColor = [UIColor orangeColor];
        
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        label.text = @"只是为了验证TabBar的高度对LDDHJTableViewController的containerInsetsForTabViewController属性的影响，结论是没有影响";
        [vc.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@60);
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
        }];
    }
    else {
        vc.view.backgroundColor = [UIColor colorWithRed:127/255.0 green:215/255.0 blue:255/255.0 alpha:1];
    }
    return vc;
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(100, 0, 100, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
