//
//  BezierPathView.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/7/26.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

- (void)drawRect:(CGRect)rect {
    [[UIColor yellowColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 50, 50)];
    path.lineWidth = 5.f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 90, 100, 50)];
    path1.lineWidth = 5.f;
    path1.lineCapStyle = kCGLineCapRound;
    path1.lineJoinStyle = kCGLineCapRound;
    [path1 stroke];
    
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 moveToPoint:CGPointMake(20, 200)];
    [path2 addQuadCurveToPoint:CGPointMake(120, 200) controlPoint:CGPointMake(70, 220)];
    path2.lineWidth = 5.f;
    [path2 stroke];
    
    UIBezierPath *path3 = [[UIBezierPath alloc] init];
    [path3 moveToPoint:CGPointMake(120, 200)];
    [path3 addLineToPoint:CGPointMake(120, 160)];
    [path3 addLineToPoint:CGPointMake(20, 160)];
    [path3 addLineToPoint:CGPointMake(20, 200)];
    path3.lineWidth = 5.f;
    [path3 stroke];
}

@end
