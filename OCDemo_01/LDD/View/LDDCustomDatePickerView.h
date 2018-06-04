//
//  LDDCustomDatePickerView.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/28.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseView.h"

@interface LDDCustomDatePickerView : BaseView

@property (nonatomic, copy) void (^selectedDateBlock)(NSInteger year,NSInteger month,NSInteger day);

- (instancetype)initWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate defaultDate:(NSDate *)defaultDate;

- (void)showView;

@end
