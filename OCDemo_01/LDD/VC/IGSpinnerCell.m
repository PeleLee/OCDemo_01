//
//  IGSpinnerCell.m
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/25.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGSpinnerCell.h"

@interface IGSpinnerCell ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation IGSpinnerCell

- (IGListSingleSectionController *)spinnerSectionController {
    void (^configureBlock)(id,UICollectionViewCell *) = ^(id item,UICollectionViewCell *cell) {
        IGSpinnerCell *spCell = (IGSpinnerCell *)cell;
        if (spCell) {
            [spCell.activityIndicator startAnimating];
        }
    };
    CGSize (^sizeBlock)(id,id<IGListCollectionContext>) = ^(id item,id<IGListCollectionContext> context) {
        if (context) {
            return CGSizeMake(context.containerSize.width, 100);
        }
        return CGSizeZero;
    };
    return [[IGListSingleSectionController alloc] initWithCellClass:self.class configureBlock:configureBlock sizeBlock:sizeBlock];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    self.activityIndicator.center = CGPointMake(bounds.size.width/2, bounds.size.height/2);
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

@end
