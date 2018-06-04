//
//  LDDCustomDatePickerView.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/28.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDCustomDatePickerView.h"

#define TopBarHeight          44.0
#define PickerHeight          216.0
#define PickerLabelWidth      50.0

@interface LDDCustomDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView        *contentView;
@property (nonatomic, strong) UIView        *topBar;
@property (nonatomic, strong) UIButton      *cancelButton;
@property (nonatomic, strong) UIButton      *confirmButton;
@property (nonatomic, strong) UIPickerView  *datePicker;
@property (nonatomic, strong) NSDate        *beginDate;
@property (nonatomic, strong) NSDate        *endDate;
@property (nonatomic, strong) NSDate        *defaultDate;
@property (nonatomic, strong) NSArray       *yearTitles;
@property (nonatomic, assign) NSInteger     beginYear;
@property (nonatomic, assign) NSInteger     beginMonth;
@property (nonatomic, assign) NSInteger     beginDay;
@property (nonatomic, assign) NSInteger     endYear;
@property (nonatomic, assign) NSInteger     endMonth;
@property (nonatomic, assign) NSInteger     endDay;
@property (nonatomic, assign) NSInteger     defaultYear;
@property (nonatomic, assign) NSInteger     defaultMonth;
@property (nonatomic, assign) NSInteger     defaultDay;

@end;

@implementation LDDCustomDatePickerView

- (instancetype)initWithBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate defaultDate:(NSDate *)defaultDate {
    if (self = [super initWithFrame:CGRectMake(0, 0, YYScreenSize().width, YYScreenSize().height)]) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        
        if (!beginDate) {
            self.beginDate = [[NSDate date] dateByAddingYears:-100];
        }
        else {
            self.beginDate = beginDate;
        }
        
        if (!endDate) {
            self.endDate = [NSDate date];
        }
        else {
            self.endDate = endDate;
        }
        
        if (!defaultDate) {
            self.defaultDate = [NSDate date];
        }
        else {
            self.defaultDate = defaultDate;
        }
        
        [self getYears];
        
        [self setViews];
    }
    return self;
}

- (void)getYears {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.beginYear = [calendar component:NSCalendarUnitYear fromDate:self.beginDate];
    self.endYear = [calendar component:NSCalendarUnitYear fromDate:self.endDate];
    self.defaultYear = [calendar component:NSCalendarUnitYear fromDate:self.defaultDate];
    self.beginMonth = [calendar component:NSCalendarUnitMonth fromDate:self.beginDate];
    self.endMonth = [calendar component:NSCalendarUnitMonth fromDate:self.endDate];
    self.defaultMonth = [calendar component:NSCalendarUnitMonth fromDate:self.defaultDate];
    self.beginDay = [calendar component:NSCalendarUnitDay fromDate:self.beginDate];
    self.endDay = [calendar component:NSCalendarUnitDay fromDate:self.endDate];
    self.defaultDay = [calendar component:NSCalendarUnitDay fromDate:self.defaultDate];
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = self.beginYear; i <= self.endYear; i++) {
        [tmpArr addObject:[NSString stringWithFormat:@"%04ld",i]];
    }
    self.yearTitles = [tmpArr copy];
}

- (void)showView {
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
    [self layoutIfNeeded];
    self.alpha = 1;
    
    NSInteger defaultYearIndex = self.defaultYear - self.beginYear;
    NSInteger defaultMonthIndex = self.defaultMonth-1;
    if (self.defaultYear == self.beginYear) {
        defaultMonthIndex = self.defaultMonth - self.beginMonth;
    }
    NSInteger defaultDayIndex = self.defaultDay-1;
    if (self.defaultYear == self.beginYear && self.defaultMonth == self.beginMonth) {
        defaultDayIndex = self.defaultDay - self.beginDay;
    }
    [self.datePicker selectRow:defaultYearIndex inComponent:0 animated:NO];
    [self.datePicker selectRow:defaultMonthIndex inComponent:1 animated:NO];
    [self.datePicker selectRow:defaultDayIndex inComponent:2 animated:NO];
    [self.datePicker reloadAllComponents];
    [self.datePicker selectRow:defaultDayIndex inComponent:2 animated:NO];

    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).offset(-TopBarHeight-PickerHeight);
            make.left.right.equalTo(@0);
            make.height.equalTo(@(TopBarHeight+PickerHeight));
        }];
        [self layoutIfNeeded];
        self.alpha = 1;
    } completion:nil];
    
}

- (void)dismissContactView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.right.equalTo(@0);
            make.height.equalTo(@(TopBarHeight+PickerHeight));
        }];
        [self layoutIfNeeded];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)layoutViews {
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(PickerHeight+TopBarHeight);
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(TopBarHeight);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(self.topBar);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(self.cancelButton);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.topBar.mas_bottom);
    }];
    
    UILabel *yearLabel = [UILabel new];
    yearLabel.textColor = [UIColor blackColor];
    yearLabel.font = [UIFont systemFontOfSize:17];
    yearLabel.text = @"年";
    [self.datePicker addSubview:yearLabel];
    
    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.datePicker);
        make.left.mas_offset(YYScreenSize().width/7*3/2+PickerLabelWidth/2);
    }];
    
    UILabel *monthLabel = [UILabel new];
    monthLabel.textColor = [UIColor blackColor];
    monthLabel.font = [UIFont systemFontOfSize:17];
    monthLabel.text = @"月";
    [self.datePicker addSubview:monthLabel];
    
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.datePicker);
        make.left.mas_offset(YYScreenSize().width/7*4);
    }];
    
    UILabel *dayLabel = [UILabel new];
    dayLabel.textColor = [UIColor blackColor];
    dayLabel.font = [UIFont systemFontOfSize:17];
    dayLabel.text = @"日";
    [self.datePicker addSubview:dayLabel];
    
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.datePicker);
        make.left.mas_offset(YYScreenSize().width/7*6+10);
    }];
}

- (void)setViews {
    UIView *converView = [[UIView alloc] initWithFrame:self.bounds];
    converView.backgroundColor = [UIColor blackColor];
    converView.alpha = 0.3;
    [self addSubview:converView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self dismissContactView];
    }];
    [converView addGestureRecognizer:tap];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topBar];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView addSubview:self.confirmButton];
    [self.contentView addSubview:self.datePicker];
    [self layoutViews];
}

#pragma mark - UIPickerView About
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return YYScreenSize().width/7*3;
    }
    return YYScreenSize().width/7*2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearTitles.count;
    }
    else if (component == 1) {
        NSInteger selectYearIndex = [pickerView selectedRowInComponent:0];
        if (selectYearIndex == 0) {
            // 开始年份对应的月份数
            return 12-self.beginMonth+1;
        }
        else if (selectYearIndex == self.yearTitles.count-1) {
            // 结束年份对应的月份数
            return self.endMonth;
        }
        else {
            return 12;
        }
    }
    else if (component == 2) {
        NSInteger selectYearIndex = [pickerView selectedRowInComponent:0];
        NSInteger selectMonthIndex = [pickerView selectedRowInComponent:1];
        NSInteger beginDays = [self getNumberOfDaysInYear:self.beginYear month:self.beginMonth];
        if (selectYearIndex == 0) {
            if (selectMonthIndex == 0) {
                // 开始年份月份对应的天数
                return beginDays-self.beginDay+1;
            }
            else {
                return [self getNumberOfDaysInYear:self.beginYear month:self.beginMonth+selectMonthIndex];
            }
        }
        else if (selectYearIndex == self.yearTitles.count-1 && selectMonthIndex == self.endMonth-1) {
            // 结束年份月份对应的天数
            return self.endDay;
        }
        else {
            NSString *selectYearStr = self.yearTitles[selectYearIndex];
            return [self getNumberOfDaysInYear:selectYearStr.integerValue month:selectMonthIndex+1];
        }
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, PickerLabelWidth, 30)];
        label.font = [UIFont systemFontOfSize:17];
    }
    NSString *string;
    NSInteger selectYearIndex = [pickerView selectedRowInComponent:0];
    NSInteger selectMonthIndex = [pickerView selectedRowInComponent:1];
    if (component == 0) {
        string = self.yearTitles[row];
    }
    else if (component == 1) {
        if (selectYearIndex == 0) {
            string = [NSString stringWithFormat:@"%ld",self.beginMonth+row];
        }
        else {
            string = [NSString stringWithFormat:@"%ld",row+1];
        }
    }
    else if (component == 2) {
        if (selectYearIndex == 0 && selectMonthIndex == 0) {
            string = [NSString stringWithFormat:@"%ld",self.beginDay+row];
        }
        else {
            string = [NSString stringWithFormat:@"%ld",row+1];
        }
    }
    label.text = string;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if (component == 1) {
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [pickerView reloadAllComponents];
}

//获取该月总天数
- (NSInteger)getNumberOfDaysInYear:(NSInteger)year month:(NSInteger)month {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *component = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:[NSDate date]];
    component.year = year;
    component.month = month;
    
    NSDate * date  = [calendar dateFromComponents:component];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

#pragma mark - lazy

- (UIPickerView *)datePicker {
    if (!_datePicker) {
        _datePicker = [UIPickerView new];
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
        _datePicker.showsSelectionIndicator = YES;
    }
    return _datePicker;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [[_confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (weakSelf.selectedDateBlock) {
                NSInteger selectedYearIndex = [weakSelf.datePicker selectedRowInComponent:0];
                NSInteger year = selectedYearIndex + weakSelf.beginYear;
                NSInteger selectedMonthIndex = [weakSelf.datePicker selectedRowInComponent:1];
                NSInteger month = selectedMonthIndex+1;
                if (selectedYearIndex == 0) {
                    month = weakSelf.beginMonth + selectedMonthIndex;
                }
                NSInteger selectedDayIndex = [weakSelf.datePicker selectedRowInComponent:2];
                NSInteger day = selectedDayIndex+1;
                if (selectedYearIndex == 0 && selectedMonthIndex == 0) {
                    day = weakSelf.beginDay + selectedDayIndex;
                }
                weakSelf.selectedDateBlock(year, month, day);
                [weakSelf dismissContactView];
            }
        }];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           [weakSelf dismissContactView];
        }];
    }
    return _cancelButton;
}

- (UIView *)topBar {
    if (!_topBar) {
        _topBar = [UIView new];
        _topBar.backgroundColor = [UIColor colorWithHexString:@"#FFAB00"];
    }
    return _topBar;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

@end
