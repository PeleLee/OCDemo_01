//
//  EDTabView.h
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/18.
//  Copyright © 2019 My. All rights reserved.


//  equally distributed:适用于title个数较少(5个以内),均分布局

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDTabModel : NSObject

/**
 count <= 5
 */
@property (nonatomic, strong) NSArray<NSString *> *dataList;
@property (nonatomic, strong) UIColor *_Nullable normalColor;
@property (nonatomic, strong) UIColor *_Nullable selectedColor;
@property (nonatomic, strong) UIColor *_Nullable bottomLineColor;

@end

@interface EDTabView : UIView

@property (nonatomic, strong) void(^selectedBlock)(NSInteger index);

- (instancetype)initWithTabModel:(EDTabModel *)model;

@end

NS_ASSUME_NONNULL_END
