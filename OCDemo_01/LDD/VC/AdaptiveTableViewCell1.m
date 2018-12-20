//
//  AdaptiveTableViewCell1.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/12/17.
//  Copyright © 2018年 My. All rights reserved.
//

#import "AdaptiveTableViewCell1.h"
#import <YYKit.h>
#import <Masonry.h>

@interface AdaptiveTableViewCell1 ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *communityNameLabel;
@property (nonatomic, strong) UILabel *streetNameLabel;

@end

@implementation AdaptiveTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addMyViews];
        [self addMyContrains];
    }
    return self;
}

- (void)addMyContrains {
    CGFloat scaleWidth = YYScreenSize().width/750;
    CGFloat bgHeight = scaleWidth*527;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.mas_equalTo(bgHeight);
        make.bottom.equalTo(@-10);
    }];
    [self.communityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(bgHeight/527*115);
        make.height.mas_equalTo(scaleWidth*45);
    }];
    [self.streetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.communityNameLabel.mas_bottom);
        make.height.equalTo(@15);
    }];
}

- (void)addMyViews {
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.communityNameLabel];
    [self.contentView addSubview:self.streetNameLabel];
}

#pragma mark - Lazy load

- (UILabel *)streetNameLabel {
    if (!_streetNameLabel) {
        _streetNameLabel = [UILabel new];
        _streetNameLabel.backgroundColor = [UIColor colorWithHexString:@"#9F9456"];
        _streetNameLabel.textColor = [UIColor whiteColor];
        _streetNameLabel.font = [UIFont systemFontOfSize:12.f];
        _streetNameLabel.layer.masksToBounds = YES;
        _streetNameLabel.layer.cornerRadius = 7.5f;
        _streetNameLabel.text = @" hahahahaha ";
    }
    return _streetNameLabel;
}

- (UILabel *)communityNameLabel {
    if (!_communityNameLabel) {
        _communityNameLabel = [UILabel new];
        _communityNameLabel.textColor = [UIColor colorWithHexString:@"#9F9456"];
        _communityNameLabel.font = [UIFont systemFontOfSize:17.0f];
        _communityNameLabel.text = @"啦啦啦啦啦啦";
    }
    return _communityNameLabel;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_home"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

#pragma mark - Other

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
