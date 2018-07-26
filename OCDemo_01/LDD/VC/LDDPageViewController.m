//
//  LDDPageViewController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/7/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDPageViewController.h"
#import "ContentViewController.h"

@interface LDDPageViewController ()

@end

@implementation LDDPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    ContentViewController *vc = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    vc.content = [NSString stringWithFormat:@"WMPageViewController childViewController:%ld",index];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"Title %ld",index];
}

@end
