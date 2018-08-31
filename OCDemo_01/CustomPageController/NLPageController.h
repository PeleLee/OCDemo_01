//
//  NLPageController.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/10.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController.h"

@class NLPageController;

/**
 缓存设置，默认缓存为无限制，当收到 memoryWarning 时，会自动切换到低缓存模式 (WMPageControllerCachePolicyLowMemory)，并在一段时间后切换到 High .
 收到多次警告后，会停留在到 WMPageControllerCachePolicyLowMemory 不再增长

 - NLPageControllerCachePolicyDisabled: Disable Cache 禁用缓存
 - NLPageControllerCachePolicyNolimit: No limit 无限制
 - NLPageControllerCachePolicyLowMemory: Low Memory but may block when scroll 低内存但滚动时可能会阻塞
 - NLPageControllerCachePolicyBalanced: Balanced ↑ and ↓
 - NLPageControllerCachePolicyHigh: High
 */
typedef NS_ENUM(NSInteger, NLPageControllerCachePolicy) {
    NLPageControllerCachePolicyDisabled  = -1,
    NLPageControllerCachePolicyNolimit   = 0,
    NLPageControllerCachePolicyLowMemory = 1,
    NLPageControllerCachePolicyBalanced  = 3,
    NLPageControllerCachePolicyHigh      = 5
};

typedef NS_ENUM(NSUInteger, NLPageControllerPreloadPolicy) {
    NLPageControllerPreloadPolicyNever     = 0,
    NLPageControllerPreloadPolicyNeighbour = 1,
    NLPageControllerPreloadPolicyNear      = 2
};

@protocol NLPageControllerDataSource <NSObject>
@optional

- (NSInteger)numberOfChildControllersInPageController:(NLPageController *)pageController;

@end

@protocol NLPageControllerDelegate <NSObject>

@end

@interface NLPageController : BaseViewController <NLPageControllerDelegate>

@property (nonatomic, weak) id<NLPageControllerDelegate> delegate;
@property (nonatomic, weak) id<NLPageControllerDataSource> dataSource;

@property (nonatomic, nullable, strong) NSMutableArray<id> *values;
@property (nonatomic, nullable, strong) NSMutableArray<NSString *> *keys;

@property (nonatomic, nullable, copy) NSArray<Class> *viewControllerClasses;

@property (nonatomic, nullable, copy) NSArray<NSString *> *titles;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

@property (nonatomic, assign) int selectIndex;

@property (nonatomic, assign) BOOL pageAnimatable;;

@property (nonatomic, assign) BOOL automaticallyCalculatesItemWidths;

@property (nonatomic, assign) BOOL scrollEnable;

/**
 选中时的标题尺寸
 */
@property (nonatomic, assign) CGFloat titleSizeSelected;

/**
 非选中时的标题尺寸
 */
@property (nonatomic, assign) CGFloat titleSizeNormal;

/**
 标题选中时的颜色
 */
@property (nonatomic, strong) UIColor *titleColorSelected;

/**
 标题非选择时的颜色
 */
@property (nonatomic, strong) UIColor *titleColorNormal;

/**
 导航栏背景色
 */
@property (nonatomic, strong) UIColor *menuBGColor;

/**
 导航栏高度
 */
@property (nonatomic, assign) CGFloat menuHeight;

/**
 每个 MenuItem 的宽度
 */
@property (nonatomic, assign) CGFloat menuItemWidth;

/**
 预加载机制，在停止滑动的时候预加载 n 页
 */
@property (nonatomic, assign) NLPageControllerPreloadPolicy preloadPolicy;

@property (nonatomic, assign) NLPageControllerCachePolicy cachePolicy;

//  构造方法
- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles;

@end
