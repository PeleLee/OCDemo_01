//
//  LQFAlertController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LQFAlertController.h"
#import <Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LQFAlertController ()

@end

@implementation LQFAlertController

- (instancetype)init {
    if (self == [super init]) {
        self.definesPresentationContext = YES;
        self.providesPresentationContextTransitionStyle = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        UIView *blurryView = [UIView new];
        blurryView.backgroundColor = [UIColor blackColor];
        blurryView.alpha = 0.2;
        [self.view addSubview:blurryView];
        [blurryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor yellowColor];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = @"自定义的AlertController";
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button setTitle:@"消失按钮" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        }];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(10);
            make.centerX.equalTo(label);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
