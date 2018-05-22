//
//  NotificationVC.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/21.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController.h"

@interface NotificationVC : BaseViewController

@property (nonatomic, copy) NSString *testStr;

@property (nonatomic, assign) BOOL isRemoveNotification;

- (void)addLeakObserver;

- (void)addNormalObserver;

- (void)postNotification;

@end
