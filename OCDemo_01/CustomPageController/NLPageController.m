//
//  NLPageController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/10.
//  Copyright © 2018年 My. All rights reserved.
//

#import "NLPageController.h"

static NSInteger const kNLUndefinedIndex = -1;
static NSInteger const kNLControllerCountUndefined = -1;

@interface NLPageController () {
    NSInteger _initializedIndex,_markedSelectIndex,_controllerCount;
}

@property (nonatomic, strong) NSCache *memCache;
@property (nonatomic, strong) NSMutableDictionary *backgroundCache;

@property (nonatomic, readonly) NSInteger childControllersCount;

@end

@implementation NLPageController

#pragma mark - Lazy Loading
- (NSMutableDictionary *)backgroundCache {
    if (!_backgroundCache) {
        _backgroundCache = [[NSMutableDictionary alloc] init];
    }
    return _backgroundCache;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Public Methods

- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles {
    if (self = [super init]) {
        NSParameterAssert(classes.count == titles.count);
        _viewControllerClasses = [NSArray arrayWithArray:classes];
        _titles = [NSArray arrayWithArray:titles];
        
        [self nl_setup];
    }
    return self;
}

- (void)setCachePolicy:(NLPageControllerCachePolicy)cachePolicy {
    _cachePolicy = cachePolicy;
    if (cachePolicy != NLPageControllerCachePolicyDisabled) {
        self.memCache.countLimit = _cachePolicy;
    }
}

#pragma mark - Notification
- (void)willResignActive:(NSNotification *)notification {
    for (int i = 0; i < self.childControllersCount; i++) {
        id obj = [self.memCache objectForKey:@(i)];
        if (obj) {
            [self.backgroundCache setObject:obj forKey:@(i)];
        }
    }
}

- (void)willEnterForeground:(NSNotification *)notification {
    for (NSNumber *key in self.backgroundCache.allKeys) {
        if (![self.memCache objectForKey:key]) {
            [self.memCache setObject:self.backgroundCache[key] forKey:key];
        }
    }
    [self.backgroundCache removeAllObjects];
}

#pragma mark - Data Source
- (NSInteger)childControllersCount {
    if (_controllerCount == kNLControllerCountUndefined) {
        if ([self.dataSource respondsToSelector:@selector(numberOfChildControllersInPageController:)]) {
            _controllerCount = [self.dataSource numberOfChildControllersInPageController:self];
        }
        else {
            _controllerCount = self.viewControllerClasses.count;
        }
    }
    return _controllerCount;
}

- (void)nl_setup {
    
    _titleSizeSelected  = 18.0f;
    _titleSizeNormal    = 15.0f;
    _titleColorSelected = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    _titleColorNormal   = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    _menuBGColor   = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    _menuHeight    = 30.0f;
    _menuItemWidth = 65.0f;
    
    _memCache = [[NSCache alloc] init];
    _initializedIndex = kNLUndefinedIndex;
    _markedSelectIndex = kNLUndefinedIndex;
    _controllerCount = kNLControllerCountUndefined;
    _scrollEnable = YES;
    
    self.automaticallyCalculatesItemWidths = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.preloadPolicy = NLPageControllerPreloadPolicyNear;
    self.cachePolicy = NLPageControllerCachePolicyNolimit;
    
    self.delegate = self;
    self.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}


@end
