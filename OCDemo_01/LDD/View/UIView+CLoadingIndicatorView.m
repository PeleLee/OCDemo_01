//
//  UIView+CLoadingIndicatorView.m
//  CCommonUIFramework
//
//  Created by Caoguo on 2018/9/7.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import "UIView+CLoadingIndicatorView.h"
#import <objc/runtime.h>
#import "CTRefreshView.h"

@interface CLoadingIndicatorBaseView ()

@property (nonatomic, strong) UIView           *loadView;
@property (nonatomic, strong) CTRefreshView    *indicatorView;
@property (nonatomic, strong) UILabel          *tipLabel;

@end


@implementation CLoadingIndicatorBaseView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loadView];
        [self.loadView addSubview:self.indicatorView];
        [self.loadView addSubview:self.tipLabel];
    }
    return self;
}

#pragma mark - Getter

- (CTRefreshView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[CTRefreshView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.loadView.frame) - 50) / 2.0, 10, 50, 50)];
        _indicatorView.isLoadingView = YES;
        _indicatorView.maxWidht = 50;
        _indicatorView.progress = 1.0;
    }
    return _indicatorView;
}

-(UIView *)loadView {
    if (!_loadView) {
        _loadView = [[UIView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(self.frame) - 90) / 2.0,CGRectGetWidth(self.frame), 50 * 2.0 + 20 )];
        _loadView.backgroundColor = [UIColor clearColor];
        _loadView.hidden = YES;
        _loadView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _loadView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indicatorView.frame) + 10, CGRectGetWidth(self.loadView.frame), 20)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"正在加载中";
        _tipLabel.font = [UIFont systemFontOfSize:14.f];
        _tipLabel.textColor = [UIColor lightGrayColor];
    }
    return _tipLabel;
}

@end



@implementation UIView (CLoadingIndicatorView)
@dynamic loadingIndicatorBaseView;

- (CLoadingIndicatorBaseView *)loadingIndicatorBaseView {
    CLoadingIndicatorBaseView *_loadingIndicatorBaseView = objc_getAssociatedObject(self, _cmd);
    if (!_loadingIndicatorBaseView) {
        _loadingIndicatorBaseView = [[CLoadingIndicatorBaseView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//        [_loadingIndicatorBaseView addTarget:self action:@selector(touchImageAction:) forControlEvents:UIControlEventTouchUpInside];
        _loadingIndicatorBaseView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        objc_setAssociatedObject(self, _cmd, _loadingIndicatorBaseView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _loadingIndicatorBaseView;
}

- (IBAction)touchImageAction:(id)sender {
//    if (self.loadingPanelBaseView.reloadBlock) {
//        [self showLoadingPanelView];
//        self.loadingPanelBaseView.reloadBlock();
//        self.loadingPanelBaseView.reloadBlock = nil;
//    }
}

- (void) loadingIndicatorFrameY:(CGFloat)y {
    CGRect indicatorViewFrame = self.loadingIndicatorBaseView.loadView.frame;
    indicatorViewFrame.origin.y = y;
    self.loadingIndicatorBaseView.loadView.frame = indicatorViewFrame;
}

- (void) showLoadingIndicatorlView {
    if (![self.subviews containsObject:self.loadingIndicatorBaseView]) {
        [self addSubview:self.loadingIndicatorBaseView];
    }
    [self startIndicatorLoading];
}

//开始加载
- (void)startIndicatorLoading {
    self.loadingIndicatorBaseView.hidden = NO;
    self.loadingIndicatorBaseView.loadView.hidden = NO;
    [self.loadingIndicatorBaseView.indicatorView startAnimation];
}

//加载出错
- (void)errorIndicatorLoading {
    self.loadingIndicatorBaseView.loadView.hidden = YES;
    [self.loadingIndicatorBaseView.indicatorView endAnimation];
}

//完成加载
- (void)completeIndicatorLoading {
    self.loadingIndicatorBaseView.loadView.hidden = YES;
    [self.loadingIndicatorBaseView.indicatorView endAnimation];
    [self.loadingIndicatorBaseView removeFromSuperview];
}


@end

