//
//  UIView+CLoadingIndicatorView.h
//  CCommonUIFramework
//
//  Created by Caoguo on 2018/9/7.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLoadingIndicatorBaseView : UIControl



@end

@interface UIView (CLoadingIndicatorView)

@property (nonatomic, strong) CLoadingIndicatorBaseView *loadingIndicatorBaseView;

// 自定义动画的Y值，默认是该view的中心点
- (void) loadingIndicatorFrameY:(CGFloat)y;

//显示并开始加载动画(自动调用startLoading)
- (void) showLoadingIndicatorlView;


//开始加载
- (void) startIndicatorLoading;
//加载出错
- (void) errorIndicatorLoading;
//完成加载
- (void) completeIndicatorLoading;


@end
