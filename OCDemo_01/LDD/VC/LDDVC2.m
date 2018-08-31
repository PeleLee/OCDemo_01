//
//  LDDVC2.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDVC2.h"
#import "LQFAlertController.h"

@interface LDDVC2 ()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UILabel *label1;

@end

@implementation LDDVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (self.index == 32) {
        [self customAlertController];
    }
    else if (self.index == 33) {
        [self overlappingOfSystemAlertControll];
    }
    else if (self.index == 34) {
        [self layoutSubViewsBeforeLayoutSuperViewWithMasonry];
    }
}

#pragma mark - Masonry:先布局子视图后布局父视图

- (void)layoutSubViewsBeforeLayoutSuperViewWithMasonry {
    UIView *superView = [UIView new];
    [superView setBackgroundColor:[UIColor yellowColor]];
    UIView *subView1 = [UIView new];
    [subView1 setBackgroundColor:[UIColor lightGrayColor]];
    UIView *subView2 = [UIView new];
    [subView2 setBackgroundColor:[UIColor orangeColor]];
    UIView *subView3 = [UIView new];
    [subView3 setBackgroundColor:[UIColor purpleColor]];
    
    [self.view addSubview:superView];
    [superView addSubview:subView1];
    [superView addSubview:subView2];
    [superView addSubview:subView3];
    
    [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@50);
    }];
    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subView1.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(superView.mas_centerX).offset(-10);
        make.height.equalTo(@50);
    }];
    [subView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_centerX).offset(10);
        make.top.equalTo(subView2);
        make.right.equalTo(@-20);
        make.height.equalTo(@50);
    }];
    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subView1.mas_top).offset(-20);
        make.bottom.equalTo(subView3.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(YYScreenSize().width-60);
    }];
}

#pragma mark - UIAlertController是否重叠

- (void)overlappingOfSystemAlertControll {
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"显示第一个Alert" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"第一层" message:@"第二个alert出现后,是覆盖第一层还是移除第一层?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *tipsAction = [UIAlertAction actionWithTitle:@"5s后显示第二个Alert" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.label1.text = @"不能同时在一个ViewController中present两个AlertController,会报错(Warning: Attempt to present <UIAlertController: 0x7ff37580fc00>  on <UINavigationController: 0x7ff37702ba00> which is already presenting <UIAlertController: 0x7ff37509f000>),所以实验是失败的...";
        }];
        [alert addAction:tipsAction];
        [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY+20);
        make.left.mas_equalTo(20);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *secondAlert = [UIAlertController alertControllerWithTitle:@"第二层" message:@"这时第一个alert是否消失?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [secondAlert addAction:cancelAction];
        [weakSelf.navigationController presentViewController:secondAlert animated:YES completion:nil];
    });
    
    [self.view addSubview:self.label1];
    self.label1.text = @"";
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.right.equalTo(@-20);
        make.top.equalTo(self.button1.mas_bottom).offset(20);
    }];
}

#pragma mark - 自定义AlertController

- (void)customAlertController {
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"☞☞☞ Show Custom AlertController" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LQFAlertController *alert = [[LQFAlertController alloc] init];
        [weakSelf.navigationController presentViewController:alert animated:NO completion:nil];
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(k_NavBarMaxY+20);
    }];
    
    [self.view addSubview:self.button2];
    [self.button2 setTitle:@"☞☞☞ Show System AlertController" forState:UIControlStateNormal];
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"系统AlertController" message:@"对比显示和消失动画等" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"消失" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [weakSelf.navigationController presentViewController:alert animated:NO completion:nil];
    }];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(self.button1.mas_bottom).offset(20);
    }];
}

#pragma mark - Lazy load

#pragma mark Button
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button2.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _button2;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.textColor = [UIColor blackColor];
        _label1.numberOfLines = 0;
    }
    return _label1;
}

@end
