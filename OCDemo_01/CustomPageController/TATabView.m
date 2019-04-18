//
//  TATabView.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/18.
//  Copyright © 2019 My. All rights reserved.
//

#import "TATabView.h"
#import <Masonry.h>

@implementation TATabModel

@end

@interface TATabView ()

@property (nonatomic, strong) TATabModel *tabModel;
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 跟随选项移动的线
 */
@property (nonatomic, strong) UIView *line_under;
/**
 底部分割线
 */
@property (nonatomic, strong) UIView *line_bottom;

@end

@implementation TATabView

- (instancetype)initWithTabModel:(TATabModel *)model {
    self = [super init];
    if (self) {
        self.tabModel = model;
        [self addMyViews];
        [self layoutMyViews];
    }
    return self;
}

- (void)layoutMyViews {
    
    UIEdgeInsets edges = UIEdgeInsetsMake(0, 0, -0.5, 0);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(edges);
    }];
    
    CGFloat gap = 15.f;
    
    for (NSInteger i = 0; i < self.tabModel.dataList.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1000+i];
        if (i == 0) {
            [btn setSelected:YES];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(gap);
                make.centerY.equalTo(self);
            }];
            [self.line_under mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btn);
                make.top.equalTo(btn.mas_bottom);
                make.height.equalTo(@2);
            }];
        }
        else if (i == self.tabModel.dataList.count - 1) {
            UIButton *lastButton = (UIButton *)[self viewWithTag:1000+i-1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right).offset(gap);
                make.centerY.equalTo(lastButton);
                make.right.offset(-gap);
            }];
        }
        else {
            UIButton *lastButton = (UIButton *)[self viewWithTag:1000+i-1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right).offset(gap);
                make.centerY.equalTo(lastButton);
            }];
        }
    }
    
    [self.line_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-0.5);
        make.height.equalTo(@0.5);
    }];
}

- (void)addMyViews {
    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < self.tabModel.dataList.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:(self.tabModel.normalColor ? self.tabModel.normalColor : [UIColor blackColor]) forState:UIControlStateNormal];
        [btn setTitleColor:(self.tabModel.selectedColor ? self.tabModel.selectedColor : [UIColor orangeColor]) forState:UIControlStateSelected];
        [btn setTitle:self.tabModel.dataList[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [btn addTarget:self action:@selector(selectOption:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [btn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [btn setSelected:NO];
        [self.scrollView addSubview:btn];
    }
    
    self.line_under = [UIView new];
    self.line_under.backgroundColor = self.tabModel.selectedColor ? self.tabModel.selectedColor : [UIColor orangeColor];
    [self.line_under setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.scrollView addSubview:self.line_under];
    
    self.line_bottom = [UIView new];
    self.line_bottom.backgroundColor = self.tabModel.bottomLineColor ? self.tabModel.bottomLineColor : [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self addSubview:self.line_bottom];
}

- (void)selectOption:(UIButton *)btn {
    // 字体颜色变化
    for (NSInteger i = 0; i < self.tabModel.dataList.count; i++) {
        UIButton *btn = (UIButton *)[self.scrollView viewWithTag:1000+i];
        [btn setSelected:NO];
    }
    [btn setSelected:YES];
    
    // 下划线移动
    [self.line_under mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btn);
        make.top.equalTo(btn.mas_bottom);
        make.height.equalTo(@2);
    }];
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag - 1000);
    }
    
    // 将按钮滚动到合适位置
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat contentWidth = self.scrollView.contentSize.width;
    CGFloat btnX = btn.center.x;
    CGPoint contentOffset = self.scrollView.contentOffset;
    
    CGFloat removeX = btnX-screenWidth/2-contentOffset.x;
    CGFloat newOffsetX = contentOffset.x+removeX;
    
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = contentWidth-screenWidth;
    
    if (newOffsetX < minOffsetX) {
        newOffsetX = minOffsetX;
    }
    else if (newOffsetX > maxOffsetX) {
        newOffsetX = maxOffsetX;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(newOffsetX, 0)];
    }];
    
    [self layoutIfNeeded];
}

@end
