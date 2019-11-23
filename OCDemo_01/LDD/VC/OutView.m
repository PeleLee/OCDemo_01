//
//  OutView.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/7/3.
//  Copyright © 2019 My. All rights reserved.
//

#import "OutView.h"

@implementation OutView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL flag = NO;
    for (UIView *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)){
            flag = YES;
            break;
        }
    }
    return flag;
}

@end
