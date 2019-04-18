//
//  LDDVC2.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDVC2.h"
#import "LQFAlertController.h"
#import "LDDTableViewCell1.h"
#import <IQKeyboardManager.h>
#import "LDDCustomCameraVC.h"
#import "UIView+CLoadingIndicatorView.h"

@interface LDDVC2 () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) NSArray *cellContentArray;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIImageView *imageView1;

@end

@implementation LDDVC2

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

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
    else if (self.index == 35) {
        [self adaptiveHeightOfUITableViewCell];
    }
    else if (self.index == 36) {
        [self aboutUIPageControl];
    }
    else if (self.index == 37) {
        [self backgroundSizeWithContentSize];
    }
    else if (self.index == 38) {
        [self useOfUICollection];
    }
    else if (self.index == 41) {
        [self changeKeyboardType];
    }
    else if (self.index == 42) {
        [self customCamera];
    }
    else if (self.index == 43) {
        [self testOfSystemControl];
    }
    else if (self.index == 45) {
        [self conflictOfMasonryConstraint];
    }
    else if (self.index == 47) {
        [self loadAnimation];
    }
    else if (self.index == 48) {
        [self aboutNSDate];
    }
    else if (self.index == 49) {
        [self presentedorting];
    }
    else if (self.index == 50) {
        [self showProgressWithSVProgressHUD];
    }
    else if (self.index == 51) {
        [self huggingPriorityAndCompressionResistance];
    }
    
    else if (self.index == 1001) {
        [self adaptiveTableCellWithMasonry];
    }
    else if (self.index == 1002) {
        [self presentedVC];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:false];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:false];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:true];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:true];
}

#pragma mark - 51.HuggingPriority和CompressionResistance

- (void)huggingPriorityAndCompressionResistance {
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    
    self.label1.backgroundColor = [UIColor yellowColor];
    self.label2.backgroundColor = [UIColor orangeColor];
    self.label1.text = @"label";
    self.label2.text = @"label2";
    
    [self.label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.label2 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.mas_equalTo(k_NavBarMaxY+10);
        make.right.equalTo(self.label2.mas_left).offset(-20);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1.mas_right).offset(20);
        make.top.equalTo(self.label1);
        make.right.equalTo(@-10);
    }];
    
    UILabel *tmpLabel = [self createLabel];
    [self.view addSubview:tmpLabel];
    [self.view addSubview:self.label3];
    
    tmpLabel.backgroundColor = [UIColor yellowColor];
    self.label3.backgroundColor = [UIColor orangeColor];
    tmpLabel.text = @"hello，我是第一个label，请多多！";
    self.label3.text = @"hello，我是第二个label，谢谢";
    
    [tmpLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.label3 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.label1.mas_bottom).offset(10);
        make.right.equalTo(self.label3.mas_left).offset(-20);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tmpLabel.mas_right).offset(20);
        make.top.equalTo(tmpLabel);
        make.right.equalTo(@-10);
    }];
}

#pragma mark - 50.SVProgressHUD 显示数值进度

- (void)showProgressWithSVProgressHUD {
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"点击显示进度" forState:UIControlStateNormal];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(k_NavBarMaxY);
    }];
    
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        __block float progress = 0.1;
        [NSTimer scheduledTimerWithTimeInterval:0.5 block:^(NSTimer * _Nonnull timer) {
            if (progress > 1) {
                [timer invalidate];
                [SVProgressHUD dismiss];
            }
            else {
                [SVProgressHUD showProgress:progress status:@"加载中..."];
                progress += 0.1;
            }
        } repeats:YES];
    }];
}

#pragma mark - 1002.Present VC
- (void)presentedVC {
    __weak typeof(self) weakSelf = self;
    
    UIButton *backBtn = [self createButton];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.mas_equalTo(k_NavBarMaxY);
    }];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIButton *button1 = [self createButton];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(backBtn.mas_bottom).offset(20);
    }];
    [button1 setTitle:@"查看presentingViewController" forState:UIControlStateNormal];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"presentingViewController:%@",weakSelf.presentingViewController);
        weakSelf.label1.text = @"适用于present跳转的情况，push跳转的话该属性为空";
    }];
    
    UIButton *button2 = [self createButton];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button1);
        make.top.equalTo(button1.mas_bottom).offset(20);
    }];
    [button2 setTitle:@"查看parentViewController" forState:UIControlStateNormal];
    [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"parentViewController:%@",weakSelf.parentViewController);
        weakSelf.label1.text = @"当前页面的父试图控制器";
    }];
    
    [self.view addSubview:self.label1];
    self.label1.backgroundColor = [UIColor yellowColor];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(button2.mas_bottom).offset(20);
    }];
}

#pragma mark - 49.UIViewController presentedVC or persentingVC
- (void)presentedorting {
    __weak typeof(self)weakSelf = self;
    
    [self.view addSubview:self.button1];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.mas_equalTo(k_NavBarMaxY + 20);
    }];
    [self.button1 setTitle:@"present跳转" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LDDVC2 *vc2 = [LDDVC2 new];
        vc2.index = 1002;
        [weakSelf presentViewController:vc2 animated:YES completion:^{
            NSLog(@"presentedViewController:%@",weakSelf.presentedViewController);
        }];
    }];
    
    UIButton *button3 = [self createButton];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(self.button1.mas_bottom).offset(20);
    }];
    [button3 setTitle:@"查看presentedViewController" forState:UIControlStateNormal];
    [[button3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"presentedViewController:%@",weakSelf.presentedViewController);
        weakSelf.label1.text = @"适用于present跳转的情况，push跳转的话该属性为空";
    }];
    
    UIButton *button4 = [self createButton];
    [self.view addSubview:button4];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(button3.mas_bottom).offset(20);
    }];
    [button4 setTitle:@"查看presentationController" forState:UIControlStateNormal];
    [[button4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"presentationController:%@",weakSelf.presentationController);
        weakSelf.label1.text = @"还未理解";
    }];
    
    UIButton *button5 = [self createButton];
    [self.view addSubview:button5];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(button4.mas_bottom).offset(20);
    }];
    [button5 setTitle:@"查看presentingViewController" forState:UIControlStateNormal];
    [[button5 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"presentingViewController:%@",weakSelf.presentingViewController);
        weakSelf.label1.text = @"适用于present跳转的情况，push跳转的话该属性为空";
    }];
    
    UIButton *button6 = [self createButton];
    [self.view addSubview:button6];
    [button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(button5.mas_bottom).offset(20);
    }];
    [button6 setTitle:@"查看parentViewController" forState:UIControlStateNormal];
    [[button6 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"parentViewController:%@",weakSelf.parentViewController);
        weakSelf.label1.text = @"当前页面的父试图控制器";
    }];
    
    [self.view addSubview:self.label1];
    self.label1.backgroundColor = [UIColor yellowColor];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(button6.mas_bottom).offset(20);
    }];
}

#pragma mark - 48.NSDate

- (void)aboutNSDate {
    // https://mp.weixin.qq.com/s/EHdV7XkUafF465YpfGL6Uw
    
    // create
    UIButton *btn3 = [self createButton];
    UIButton *btn4 = [self createButton];
    UIButton *btn5 = [self createButton];
    
    // add
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
    
    // backgroundColor
    self.button1.backgroundColor = self.button2.backgroundColor = [UIColor orangeColor];
    btn3.backgroundColor = [UIColor yellowColor];
    btn4.backgroundColor = [UIColor yellowColor];
    btn5.backgroundColor = [UIColor orangeColor];
    
    // title
    [self.button1 setTitle:@"[NSDate date] -> 不一定是零时区的时间，与语言有关" forState:UIControlStateNormal];
    [self.button2 setTitle:@"NSDateFormatter默认是当前时区" forState:UIControlStateNormal];
    [btn3 setTitle:@"设置NSDateFormatter的时区" forState:UIControlStateNormal];
    [btn4 setTitle:@"字符串转NSDate" forState:UIControlStateNormal];
    [btn5 setTitle:@"当前时间转时间戳" forState:UIControlStateNormal];
    
    // masonry
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.mas_equalTo(k_NavBarMaxY + 10);
    }];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(self.button1.mas_bottom).offset(10);
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(self.button2.mas_bottom).offset(10);
    }];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(btn3.mas_bottom).offset(10);
    }];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(btn4.mas_bottom).offset(10);
    }];
    
    // other
    NSDate *date = [NSDate date];
    
    // ControlEvents
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 通过[NSDate date]返回的不一定是零时区的时间
        // 如果打印时有非英文的字符，就打印零时区的时间
        NSLog(@"零时区 date = %@",date);
        // 如果打印时全都是英文字符，就打印当前时区的时间
        NSLog(@"Zero time zone date = %@",date);
    }];
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 如果没有规定formatter的时区，那么formatter默认的就是当前时区
        NSDateFormatter *fm = [NSDateFormatter new];
        // 最结尾的Z表示的是时区，零时区表示+0000，东八区表示+0800
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        // 当前时区
        NSString *dateStr = [fm stringFromDate:date];
        NSLog(@"当前时区 date时间 = %@",dateStr);
    }];
    [[btn3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDateFormatter *fm2 = [NSDateFormatter new];
        [fm2 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        fm2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        NSString *dateStr2 = [fm2 stringFromDate:date];
        NSLog(@"东八区 date时间 = %@",dateStr2);
        
        NSDateFormatter *fm3 = [NSDateFormatter new];
        [fm3 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        fm3.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
        NSString *dateStr3 = [fm3 stringFromDate:date];
        NSLog(@"东九区 date时间 = %@",dateStr3);
    }];
    [[btn4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDateFormatter *fm = [[NSDateFormatter alloc] init];
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        NSDate *date = [fm dateFromString:@"2016-12-07 14:06:24 +0800"];
        NSLog(@"date = %@",date);
        
        [fm setDateFormat:@"yyyy年MM-dd HH:mm:ss Z"];
        NSDate *date2 = [fm dateFromString:@"2016年12-07 14:06:24 +0800"];
        NSLog(@"date2 = %@",date2);
    }];
    [[btn5 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSTimeInterval timeIn = [date timeIntervalSince1970];
        NSLog(@"当前时间戳 = %.0f",timeIn);
        
        NSDateFormatter *fm = [[NSDateFormatter alloc] init];
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        NSString *dateStr = @"2016-12-07 14:06:24 +0800";
//        NSLog(@"date2 string = %@",dateStr);
        NSDate *date2 = [fm dateFromString:dateStr];
//        NSLog(@"date2 = %@",date2);
        NSTimeInterval timeIn2 = [date2 timeIntervalSince1970];
        NSLog(@"过去某个时间戳 = %.0f",timeIn2);
    }];
}

#pragma mark - 47.加载动画

- (void)loadAnimation {
    
    UITableView *testTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    testTV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testTV];
    
    [self.button1 setTitle:@"开始动画" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [testTV showLoadingIndicatorlView];
//        [weakSelf.view showLoadingIndicatorlView];
    }];
    [self.button2 setTitle:@"结束动画" forState:UIControlStateNormal];
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [testTV completeIndicatorLoading];
//        [weakSelf.view completeIndicatorLoading];
    }];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY + 50);
        make.left.equalTo(@50);
    }];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button1.mas_bottom).offset(50);
        make.left.equalTo(self.button1);
    }];
    [testTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button2);
        make.right.equalTo(@-50);
        make.top.equalTo(self.button2.mas_bottom).offset(50);
        make.bottom.equalTo(@-50);
    }];
}

#pragma mark - 45.Masonry约束冲突

- (void)conflictOfMasonryConstraint {
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:centerView];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@200);
    }];
    
    UIView *subView = [UIView new];
    subView.backgroundColor = [UIColor orangeColor];
    
    [centerView addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@30);
        make.right.equalTo(@-30);
        make.height.equalTo(@30);
        make.bottom.equalTo(@-30);
    }];
}

#pragma mark - 43.系统控件内边距测试

- (void)testOfSystemControl {
    UILabel *label1 = [UILabel new];
    label1.text = @"label有文字,下面是没文字的";
    label1.backgroundColor = [UIColor yellowColor];
    label1.textColor = [UIColor blackColor];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@100);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"";
    label2.backgroundColor = [UIColor yellowColor];
    label2.textColor = [UIColor blackColor];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(label1.mas_bottom).offset(20);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundColor:[UIColor orangeColor]];
    [button1 setTitle:@"button有标题,下面是没标题的button" forState:UIControlStateNormal];
    [button1.titleLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(label2.mas_bottom).offset(20);
    }];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundColor:[UIColor orangeColor]];
    [button2 setTitle:@"" forState:UIControlStateNormal];
    [button2.titleLabel setTextColor:[UIColor blackColor]];
//    button2.hidden = YES;
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(button1.mas_bottom).offset(20);
    }];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setBackgroundColor:[UIColor blueColor]];
    [button3 setTitle:@"上面有一个没标题的按钮,被隐藏了" forState:UIControlStateNormal];
    [button3.titleLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(button2.mas_bottom);
    }];
}

#pragma mark - 42.自定义相机
- (void)customCamera {
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"点击拍照" forState:UIControlStateNormal];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.mas_equalTo(k_NavBarMaxY + 20);
    }];
    
    [self.view addSubview:self.imageView1];
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@(200*YYScreenSize().height/YYScreenSize().width));
    }];
    
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LDDCustomCameraVC *vc = [LDDCustomCameraVC new];
        vc.photoBlock = ^(UIImage * _Nonnull photo) {
            [weakSelf.imageView1 setImage:photo];
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
}

#pragma mark - 41.键盘类型切换
- (void)changeKeyboardType {
    UITextField *tf = [UITextField new];
    [tf setPlaceholder:@"点击输入框弹出键盘,然后点击切换按钮"];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.mas_equalTo(k_NavBarMaxY+20);
    }];
    
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"切换" forState:UIControlStateNormal];
    self.button1.selected = NO;
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tf);
        make.top.equalTo(tf.mas_bottom).offset(20);
    }];
    
    __weak typeof(self) weakSelf = self;
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        weakSelf.button1.selected = !weakSelf.button1.selected;
        UIKeyboardType type = weakSelf.button1.selected ? UIKeyboardTypeDefault : UIKeyboardTypeNumberPad;
        [tf setKeyboardType:type];
        weakSelf.label1.hidden = NO;
    }];
    
    [self.view addSubview:self.label1];
    self.label1.text = @"这种操作键盘类型是不会变的，除非将键盘先收起再弹出才会变换键盘类型。";
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tf);
        make.top.equalTo(self.button1.mas_bottom).offset(20);
    }];
}

#pragma mark - 38.UICollection
- (void)useOfUICollection {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, k_NavBarMaxY + 5, YYScreenSize().width, YYScreenSize().height - k_NavBarMaxY - k_SafeAreaHeight) collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
}

#pragma mark - 37.Xib-根据内容尺寸确定背景大小
- (void)backgroundSizeWithContentSize {
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    
    [self.label1 setText:@"纠"];
    [self.label2 setText:@"结"];
    [self.label3 setText:@"伦"];
    [self.label1 setBackgroundColor:[UIColor yellowColor]];
    [self.label2 setBackgroundColor:[UIColor yellowColor]];
    [self.label3 setBackgroundColor:[UIColor yellowColor]];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0.3];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY).offset(-5);
        make.right.equalTo(self.view.mas_centerX).offset(-5);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.label1);
        make.left.equalTo(self.view.mas_centerX).offset(5);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(5);
        make.centerX.equalTo(self.view);
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1).offset(-10);
        make.top.equalTo(self.label1).offset(-10);
        make.right.equalTo(self.label2).offset(10);
        make.bottom.equalTo(self.label3).offset(10);
    }];
}

#pragma mark - 36.UIPageControl相关
- (void)aboutUIPageControl {
    [self addContentScrollView];
    [self.contentScrollView addSubview:self.label1];
    [self.contentScrollView addSubview:self.button1];
    
    self.label1.text = @"基础用法，之前写过几次，不过还是容易忘记，所以整理一下，方便查阅。\n\n初始化参数\n\nTransitionStyle(过渡方式):\n";
    [self.button1 setTitle:@"UIPageViewControllerTransitionStyleScroll" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(YYScreenSize().width-40);
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label1.mas_bottom).offset(10);
        make.left.mas_equalTo(self.label1);
    }];
}

#pragma mark - UITableView About
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellContentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDDTableViewCell1 *cell = (LDDTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"LDDTableViewCell1"];
    if (!cell) {
        cell = [[LDDTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LDDTableViewCell1"];
    }
    [cell setContent:self.cellContentArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"TableView frame.origin :%f",tableView.frame.origin.y);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - 1001.使用Masonry来自适应cell高度
- (void)adaptiveTableCellWithMasonry {
    UITableView *table = [UITableView new];
    table.delegate = self;
    table.dataSource = self;
    table.estimatedRowHeight = 44;//必须要设置
    [self.view addSubview:table];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CellContentText" ofType:@"plist"];
    self.cellContentArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - 35.UITableViewCell高度自适应的几种方法
- (void)adaptiveHeightOfUITableViewCell {
    [self.view addSubview:self.label1];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.label2];
    
    __weak typeof(self) weakSelf = self;
    
    self.label1.text = @"参考地址:https://www.aliyun.com/jiaocheng/352213.html";
    
    [self.button1 setTitle:@"1.通过Masonry获取cell的自适应高度" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LDDVC2 *vc = [LDDVC2 new];
        vc.index = 1001;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    self.label2.text = @"table.estimatedRowHeight = 44;必须设置该属性,否则在低版本iOS版本上会不起效(目前已知的有iOS9.0)\n最重要的是，必须要设置最下面一个控件和contentView的bottom之间的约束，要不然不会起效\n这样是真的便捷...";
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY + 20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button1.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
}

#pragma mark - 34:Masonry-先布局子视图后布局父视图

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

#pragma mark - 33.UIAlertController是否重叠

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

#pragma mark - 32.自定义AlertController

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

#pragma mark - AddContentScrollView
- (void)addContentScrollView {
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-k_SafeAreaHeight);
    }];
}

#pragma mark - Lazy load

#pragma mark Button

- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    return btn;
}

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

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [UILabel new];
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.textColor = [UIColor blackColor];
        _label2.numberOfLines = 0;
    }
    return _label2;
}

- (UILabel *)label3 {
    if (!_label3) {
        _label3 = [UILabel new];
        _label3.font = [UIFont systemFontOfSize:13];
        _label3.textColor = [UIColor blackColor];
        _label3.numberOfLines = 0;
    }
    return _label3;
}

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    return label;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [UIScrollView new];
//        _contentScrollView.backgroundColor = [UIColor yellowColor];
    }
    return _contentScrollView;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [UIImageView new];
    }
    return _imageView1;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if (headerView == nil) {
            headerView = [[UICollectionReusableView alloc] init];
        }
        [headerView removeAllSubviews];
        if (indexPath.section == 0) {
            headerView.backgroundColor = [UIColor blueColor];
            
            UILabel *label0 = [UILabel new];
            label0.textColor = [UIColor whiteColor];
            label0.font = [UIFont systemFontOfSize:13];
            label0.text = @"子视图1";
            [headerView addSubview:label0];
            [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.left.mas_equalTo(20);
            }];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [button setTitle:@"子视图2" forState:UIControlStateNormal];
            [headerView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(label0.mas_bottom).offset(10);
                make.left.equalTo(label0);
            }];
            
            UILabel *label1 = [UILabel new];
            label1.textColor = [UIColor whiteColor];
            label1.font = [UIFont systemFontOfSize:13];
            label1.text = @"子视图3";
            [headerView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.mas_bottom).offset(10);
                make.left.equalTo(label0);
            }];
        }
        else {
            headerView.backgroundColor = [UIColor grayColor];
        }
        
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if (footView == nil) {
            footView = [UICollectionReusableView new];
        }
        footView.backgroundColor = [UIColor yellowColor];
        return footView;
    }
    return nil;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(YYScreenSize().width, 100);
    }
    else {
        return CGSizeMake(YYScreenSize().width, 44);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(YYScreenSize().width, 22);
}

@end
