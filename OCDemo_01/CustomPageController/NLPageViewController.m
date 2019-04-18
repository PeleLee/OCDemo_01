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

@interface TabModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *dataList;
@property (nonatomic, strong) UIColor *_Nullable normalColor;
@property (nonatomic, strong) UIColor *_Nullable selectedColor;
@property (nonatomic, strong) UIColor *_Nullable bottomLineColor;
/**
 title的数量等于该数量及少于该数量时,均分布局;否则按宽度自适应布局
 */
@property (nonatomic, assign) NSUInteger equalizationCount;

@end

@implementation TabModel

@end

@interface TabView : UIScrollView

@property (nonatomic, strong) TabModel *tabModel;
/**
 跟随选项移动的线
 */
@property (nonatomic, strong) UIView *line_under;
/**
 底部分割线
 */
@property (nonatomic, strong) UIView *line_bottom;

@end

@implementation TabView

- (instancetype)initWithTabModel:(TabModel *)model {
    self = [super init];
    if (self) {
        self.tabModel = model;
        [self addMyViews];
        [self layoutMyViews];
    }
    return self;
}

- (void)layoutMyViews {
    
    CGFloat gap = 15.f;
    
    if (self.tabModel.dataList.count <= self.tabModel.equalizationCount) {
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
    }
    else {
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
    }
    
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    [self.line_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(49);
        make.height.equalTo(@0.5);
        make.width.mas_equalTo(screenW);
        make.bottom.offset(0);
    }];
    
    CGSize size1 = self.contentSize;
    NSLog(@"111 ContentSiz: width--%@ height--%@",@(size1.width),@(size1.height));
    [self layoutIfNeeded];
    CGSize size2 = self.contentSize;
    NSLog(@"222 ContentSiz: width--%@ height--%@",@(size2.width),@(size2.height));
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
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
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
    self.line_bottom.backgroundColor = self.tabModel.bottomLineColor ? self.tabModel.bottomLineColor : [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
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
    
    // 按钮移动到合适位置
    CGFloat width = self.contentSize.width;
    NSLog(@"Self width:%@",@(width));
    CGFloat btnX = btn.center.x;
    NSLog(@"Button centerX:%@",@(btnX));
    
}

@end

@interface NLPageViewController ()

@property (nonatomic, strong) TabView *tabView;

@end

@implementation NLPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMyViews];
    [self layoutMyViews];
}

- (void)layoutMyViews {
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(k_NavBarMaxY);
        make.height.equalTo(@50);
    }];
}

- (void)addMyViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    [self.view addGestureRecognizer:pan];
    
    TabModel *tabModel = [TabModel new];
    tabModel.equalizationCount = 5;
    tabModel.dataList = @[@"持续",@"延续",@"历时",@"最后",@"钱包",@"你也可以",@"写文赚赞赏"];
    self.tabView = [[TabView alloc] initWithTabModel:tabModel];
    [self.view addSubview:self.tabView];
}

@end
