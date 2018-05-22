//
//  AppDelegate.m
//  OCDemo_01
//
//  Created by liqunfei on 2018/4/20.
//  Copyright © 2018年 My. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTableViewController.h"
#import <YYKit/YYKit.h>
#import <IQKeyboardManager.h>
#import "MyMacro.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configuration];
    
    RootTableViewController *myTV = [[RootTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:myTV];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configuration {
    // 导航栏字体颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    // 导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:54/255.0 green:57/255.0 blue:61/255.0 alpha:1]];
    // 返回按钮箭头和文字的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 返回按钮的文字不显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-YYScreenSize().width*2, 0) forBarMetrics:UIBarMetricsDefault];
    // 返回按钮字体颜色 上一行代码设置后该句代码设置不起效
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;
    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
}

- (void)postNotification {
    [k_NotificationCenter postNotificationName:@"changeCellText" object:@"Cell text had change."];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
