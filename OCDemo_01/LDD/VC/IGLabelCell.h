//
//  IGLabelCell.h
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/24.
//  Copyright © 2019年 My. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGLabelCell : UICollectionViewCell

@property (nonatomic, copy) NSString *text;

- (CGFloat)testHeightWithText:(NSString *)text width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
