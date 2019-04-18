//
//  LDDVC3.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/18.
//  Copyright © 2019 My. All rights reserved.
//

#import "LDDVC3.h"
#import "EDTabView.h"
#import "TATabView.h"

@interface LDDVC3 ()

@end

@implementation LDDVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    switch (self.index) {
        case 52:
        {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
            [self.view addGestureRecognizer:pan];
            [self customPageVC];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 53.CustomPageVC

- (void)customPageVC {
    EDTabModel *model = [EDTabModel new];
    model.dataList = @[@"便利",@"雪亮",@"贵虎",@"冰袋",@"爱国者"];
    
    UILabel *label_1 = [self createLabel];
    label_1.text = model.dataList[0];
    [self.view addSubview:label_1];
    
    EDTabView *tabView = [[EDTabView alloc] initWithTabModel:model];
    tabView.selectedBlock = ^(NSInteger index) {
        label_1.text = model.dataList[index];
    };
    [self.view addSubview:tabView];
    
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(k_NavBarMaxY);
        make.height.equalTo(@50);
    }];
    
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tabView);
        make.top.equalTo(tabView.mas_bottom).offset(20);
    }];
    
    TATabModel *taModel = [TATabModel new];
    taModel.dataList = @[@"福",@"百草味",@"草莓夹心",@"白巧克力",@"香砂养胃丸",@"顺丰速运",@"MacBook Pro",@"大派送",@"U便利",@"弹跳杯"];
    
    UILabel *label_2 = [self createLabel];
    label_2.text = taModel.dataList[0];
    [self.view addSubview:label_2];
    
    TATabView *taTabView = [[TATabView alloc] initWithTabModel:taModel];
    taTabView.selectedBlock = ^(NSInteger index) {
        label_2.text = taModel.dataList[index];
    };
    [self.view addSubview:taTabView];
    
    [taTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(label_1.mas_bottom).offset(20);
        make.height.equalTo(@50);
    }];
    
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(taTabView);
        make.top.equalTo(taTabView.mas_bottom).offset(20);
    }];
}

#pragma mark - Factory

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    return label;
}

@end
