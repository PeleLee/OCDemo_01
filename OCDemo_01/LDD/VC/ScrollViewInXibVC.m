//
//  ScrollViewInXibVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/7/18.
//  Copyright © 2018年 My. All rights reserved.
//

#import "ScrollViewInXibVC.h"
#import <YYKit.h>

@interface ScrollViewInXibVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintsViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight2;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollTopConstraint;

@end

@implementation ScrollViewInXibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollTopConstraint.constant = k_NavBarMaxY;
    self.constraintsViewHeight.constant = (YYScreenSize().height - k_NavBarMaxY) * 3;
    self.viewHeight1.constant = self.viewHeight2.constant = YYScreenSize().height - k_NavBarMaxY;
    self.label.text = @"使用Xib对UIScrollView进行自动布局,现在完成的效果是竖向滚动。";
}

@end
