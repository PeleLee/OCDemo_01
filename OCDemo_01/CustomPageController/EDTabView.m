//
//  EDTabView.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/18.
//  Copyright © 2019 My. All rights reserved.
//

#import "EDTabView.h"
#import <Masonry.h>

@implementation EDTabModel

@end

@interface EDTabView ()

@property (nonatomic, strong) EDTabModel *tabModel;
/**
 跟随选项移动的线
 */
@property (nonatomic, strong) UIView *line_under;
/**
 底部分割线
 */
@property (nonatomic, strong) UIView *line_bottom;

@end

@implementation EDTabView

- (instancetype)initWithTabModel:(EDTabModel *)model {
    self = [super init];
    if (self) {
        self.tabModel = model;
        [self addMyViews];
        [self layoutMyViews];
    }
    return self;
}

- (void)layoutMyViews {
    for (NSUInteger i = 0; i < self.tabModel.dataList.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1000+i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.mas_equalTo([self getCenterXWithIndex:i]);
        }];
        if (i == 0) {
            [btn setSelected:YES];
            [self.line_under mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btn);
                make.top.equalTo(btn.mas_bottom);
                make.height.equalTo(@2);
            }];
        }
    }
    
    [self.line_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-0.5);
        make.height.equalTo(@0.5);
    }];
}

- (CGFloat)getCenterXWithIndex:(NSUInteger)index {
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    CGFloat count = self.tabModel.dataList.count;
    CGFloat molecule = 1 + index*2;
    CGFloat denominator = count*2;
    CGFloat scale1 = molecule/denominator;
    CGFloat scale2 = 1/2.0;
    CGFloat scale = scale1 - scale2;
    CGFloat centerX = scale*screenW;
    return centerX;
}

- (void)addMyViews {
    
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
        [self addSubview:btn];
    }
    
    self.line_under = [UIView new];
    self.line_under.backgroundColor = self.tabModel.selectedColor ? self.tabModel.selectedColor : [UIColor orangeColor];
    [self.line_under setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.line_under];
    
    self.line_bottom = [UIView new];
    self.line_bottom.backgroundColor = self.tabModel.bottomLineColor ? self.tabModel.bottomLineColor : [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self addSubview:self.line_bottom];
}

- (void)selectOption:(UIButton *)btn {
    // 字体颜色变化
    for (NSInteger i = 0; i < self.tabModel.dataList.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:1000+i];
        [btn setSelected:NO];
    }
    [btn setSelected:YES];
    
    // 下划线移动
    [UIView animateWithDuration:0.25 animations:^{
        [self.line_under mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(btn);
            make.top.equalTo(btn.mas_bottom);
            make.height.equalTo(@2);
        }];
        [self layoutIfNeeded];
    }];
    
    if (self.selectedBlock) {
        self.selectedBlock(btn.tag - 1000);
    }
}

@end
