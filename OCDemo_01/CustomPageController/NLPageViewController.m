//
//  NLPageViewController.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/17.
//  Copyright © 2019 My. All rights reserved.
//

#import "NLPageViewController.h"
#import <Masonry.h>
#import "MyMacro.h"
#import "EDTabView.h"
#import "TATabView.h"
#import "NLPageViewController.h"

@interface NLPageViewController ()

@property (nonatomic, strong) id tabModel;
@property (nonatomic, strong) UIView *tabView;

@end

@implementation NLPageViewController

- (instancetype)initWithTabModel:(id)tabModel {
    self = [super init];
    if (self) {
        self.tabModel = tabModel;
        [self addMyViews];
        [self layoutMyViews];
    }
    return self;
}

- (void)layoutMyViews {
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(k_NavBarMaxY);
        make.height.equalTo(@50);
    }];
}

- (void)addMyViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    [self.view addGestureRecognizer:pan];
    
    if ([self.tabModel isKindOfClass:[EDTabModel class]]) {
        self.tabView = [[EDTabView alloc] initWithTabModel:self.tabModel];
    }
    else if ([self.tabModel isKindOfClass:[TATabModel class]]) {
        self.tabView = [[TATabView alloc] initWithTabModel:self.tabModel];
    }
    
    [self.view addSubview:self.tabView];
}

@end
