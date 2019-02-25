//
//  CTRefreshView.m
//  Castle
//
//  Created by Caoguo on 2018/8/30.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import "CTRefreshView.h"

@interface CTRefreshView ()

@property (nonatomic, strong) CAShapeLayer *firstLayer;
@property (nonatomic, strong) CAShapeLayer *secondLayer;
@property (nonatomic, strong) CABasicAnimation *rotationAnimation;

@end

@implementation CTRefreshView

@synthesize lineColor = _lineColor;
@synthesize lineWidth = _lineWidth;

- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = [UIColor colorWithRed:(236/255.0) green:(70/255.0) blue:(82/255.0) alpha:1];
    }
    return _lineColor;
}

- (CGFloat)lineWidth {
    if (_lineWidth == 0.f) {
        _lineWidth = 2.f;
    }
    return _lineWidth;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.firstLayer.strokeColor = lineColor.CGColor;
    self.secondLayer.strokeColor = lineColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.firstLayer.lineWidth = _lineWidth;
    self.secondLayer.lineWidth = _lineWidth;
}

- (CABasicAnimation *)rotationAnimation {
    if (_rotationAnimation == nil) {
        // Rotation
        _rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        _rotationAnimation.fromValue = @0;
        _rotationAnimation.toValue = @(2*M_PI);
        _rotationAnimation.duration = 0.5f;
        _rotationAnimation.repeatCount = INFINITY;
        _rotationAnimation.removedOnCompletion = NO;
    }
    return _rotationAnimation;
}

- (void)setProgress:(CGFloat)progress {
    if (progress <= 1) {
        _progress = progress;
    } else {
        _progress = 1;
    }
    CGFloat radius = (MIN(self.maxWidht, self.maxWidht) / 2.0 - self.lineWidth / 2.0) * _progress;
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height - _progress * (self.bounds.size.height / 2.f));
    
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_4 + _progress * M_PI * 4 endAngle:M_PI_4 + _progress * M_PI * 4 clockwise:YES];
    UIBezierPath *secondPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:3*M_PI_4 + _progress * M_PI * 4 endAngle:(5*M_PI_4) + _progress * M_PI * 4 clockwise:YES];
    
    self.firstLayer.path = firstPath.CGPath;
    self.firstLayer.frame = self.bounds;
    
    self.secondLayer.path = secondPath.CGPath;
    self.secondLayer.frame = self.bounds;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [self initialSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup {
    self.firstLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.firstLayer];
    
    self.secondLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.secondLayer];
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.lineWidth = self.lineWidth;
    self.lineColor = self.lineColor;
    
    self.firstLayer.fillColor = nil;
    self.secondLayer.fillColor = nil;
    
    self.isAnimation = NO;
}

- (void)startAnimation {
    [self.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
    self.isAnimation = YES;
}

- (void)endAnimation {
    [self.layer removeAnimationForKey:@"rotationAnimation"];
    self.isAnimation = NO;
}



@end
