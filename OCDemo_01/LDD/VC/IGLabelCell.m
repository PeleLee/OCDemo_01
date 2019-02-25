//
//  IGLabelCell.m
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/24.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGLabelCell.h"
#import <IGListKit/IGListKit.h>

@interface IGLabelCell ()<IGListBindable>

@end

@implementation IGLabelCell {
    UIEdgeInsets _insets;
    UIFont *_font;
    CGFloat _singleLineHeight;
    UILabel *_label;
    CALayer *_separator;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self otherInit];
        [self.contentView addSubview:_label];
        [self.contentView.layer addSublayer:_separator];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    _label.frame = UIEdgeInsetsInsetRect(bounds, _insets);
    CGFloat height = 0.5;
    CGFloat left = _insets.left;
    _separator.frame = CGRectMake(left, bounds.size.height - height, bounds.size.width - left, height);
}

- (BOOL)isHighlighted {
    self.contentView.backgroundColor = [UIColor colorWithWhite:(self.isHighlighted ? 0.9 : 1) alpha:1];
    return self.isHighlighted;
}

- (void)bindViewModel:(id)viewModel {
    if (![viewModel isKindOfClass:[NSString class]]) {
        return;
    }
    _label.text = viewModel;
}

- (CGFloat)testHeightWithText:(NSString *)text width:(CGFloat)width {
    CGSize constrainedSize = CGSizeMake(width - _insets.left - _insets.right, CGFLOAT_MAX);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:0];
    [attributes setObject:_font forKey:NSFontAttributeName];
    NSStringDrawingOptions options = NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin;
    CGRect bounds = [text boundingRectWithSize:constrainedSize options:options attributes:attributes context:nil];
    return ceil(bounds.size.height) + _insets.top + _insets.bottom;
}

- (void)otherInit {
    _insets = UIEdgeInsetsMake(8, 15, 8, 15);
    
    _font = [UIFont systemFontOfSize:17];
    
    _singleLineHeight = _font.lineHeight + _insets.top + _insets.bottom;
    
    _label = [UILabel new];
    _label.backgroundColor = [UIColor clearColor];
    _label.numberOfLines = 0;
    _label.font = _font;
    
    _separator = [CALayer new];
    _separator.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1].CGColor;
    
    
}

- (NSString *)text {
    return _label.text;
}

- (void)setText:(NSString *)text {
    _label.text = text;
}

@end
