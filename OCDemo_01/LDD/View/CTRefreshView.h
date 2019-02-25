//
//  CTRefreshView.h
//  Castle
//
//  Created by Caoguo on 2018/8/30.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTRefreshView : UIView

/**
 弧线的颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 弧线的宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 下拉刷新的进度
 */
@property (nonatomic, assign) CGFloat progress;

/**
 最大宽度
 */
@property (nonatomic, assign) CGFloat maxWidht;

@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) BOOL isLoadingView;

/**
 开始动画(点击tabbar刷新时和loadingView里面调用)
 */
- (void)startAnimation;

/**
 结束动画
 */
- (void)endAnimation;

@end
