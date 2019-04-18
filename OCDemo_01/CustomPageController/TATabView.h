//
//  TATabView.h
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/18.
//  Copyright © 2019 My. All rights reserved.

//  Tack:适用于title个数较多,跟随布局

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TATabModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *dataList;
@property (nonatomic, strong) UIColor *_Nullable normalColor;
@property (nonatomic, strong) UIColor *_Nullable selectedColor;
@property (nonatomic, strong) UIColor *_Nullable bottomLineColor;

@end

@interface TATabView : UIView

@property (nonatomic, strong) void(^selectedBlock)(NSInteger index);

- (instancetype)initWithTabModel:(TATabModel *)model;

@end

NS_ASSUME_NONNULL_END
