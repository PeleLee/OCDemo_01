//
//  IQKeyboardVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/19.
//  Copyright © 2018年 My. All rights reserved.
//

#import "IQKeyboardVC.h"
#import "LDDVM.h"
#import "PGDatePickManager.h"

@interface IQKeyboardVC ()<UITextFieldDelegate,PGDatePickerDelegate>

@property (nonatomic, strong) LDDVM *viewModel;

@property (nonatomic, strong) RACCommand *command1;
@property (nonatomic, strong) RACCommand *command2;
@property (nonatomic, strong) RACCommand *command3;

@property (nonatomic, strong) RACSubject *subject4_1;
@property (nonatomic, strong) RACSubject *subject4_2;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UITextField *tf1;

@end

@implementation IQKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.index == 0) {
        [self createBottomTF];
    }
    else if (self.index == 5 ) {
        [self createButtons];
    }
    else if (self.index == 6) {
        [self orderOfMasonry];
    }
    else if (self.index == 7) {
        [self getWidthByGap];
    }
    else if (self.index == 8) {
        [self masonryOfLabel];
    }
    else if (self.index == 9) {
        [self macroOfRAC];
    }
    else if (self.index == 10) {
        [self subscribeOfRACSignal];
    }
    else if (self.index == 11) {
        [self useOfRACSubject];
    }
    else if (self.index == 12) {
        [self useOfRACCommand];
    }
    else if (self.index == 13) {
        [self useOfCommandAndSubjectWithRAC];
    }
    else if (self.index == 14) {
        [self useOfUIDatePicker];
    }
    else if (self.index == 15) {
        [self useOfPGDatePicker];
    }
}

- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *str = [NSString stringWithFormat:@"选择日期%ld-%ld-%ld",dateComponents.year,dateComponents.month,dateComponents.day];
    ((UILabel *)[self.view viewWithTag:150]).text = str;
    NSLog(@"%@",dateComponents);
}

- (void)useOfPGDatePicker {
    __weak typeof(self) weakSelf = self;
    [self.button1 setTitle:@"选择日历" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        PGDatePickManager *datePickManager = [[PGDatePickManager alloc] init];
        datePickManager.isShadeBackgroud = YES;
        datePickManager.headerViewBackgroundColor = [UIColor yellowColor];
        datePickManager.cancelButtonTextColor = [UIColor whiteColor];
        datePickManager.confirmButtonTextColor = [UIColor whiteColor];
        PGDatePicker *datePicker = datePickManager.datePicker;
        datePicker.delegate = self;
        datePicker.datePickerType = PGPickerViewType1;
        datePicker.isHiddenMiddleText = NO;
        datePicker.datePickerMode = PGDatePickerModeDate;
        datePicker.minimumDate = [[NSDate date] dateByAddingYears:-100];
        datePicker.maximumDate = [NSDate date];
        datePicker.lineBackgroundColor = [UIColor yellowColor];
        datePicker.textColorOfSelectedRow = [UIColor yellowColor];
        datePicker.textColorOfOtherRow = [UIColor lightGrayColor];
        [weakSelf presentViewController:datePickManager animated:NO completion:nil];
    }];
    [self.view addSubview:self.button1];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@100);
    }];
    
    [self.view addSubview:self.label1];
    self.label1.tag = 150;
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(weakSelf.button1.mas_bottom).offset(20);
    }];
}

- (void)useOfUIDatePicker {
    UIDatePicker *picker = [UIDatePicker new];
    picker.backgroundColor = [UIColor whiteColor];
    picker.datePickerMode = 1;
    [self.view addSubview:picker];
    
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@200);
    }];
}

- (LDDVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [LDDVM new];
    }
    return _viewModel;
}

- (void)useOfCommandAndSubjectWithRAC {
    __weak typeof(self) weakSelf = self;
    
    UITextField *tf1 = [UITextField new];
    tf1.font = [UIFont systemFontOfSize:13];
    tf1.borderStyle = UITextBorderStyleRoundedRect;
    tf1.placeholder = @"输入数字";
    tf1.delegate = self;
    tf1.tag = 130;
    tf1.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tf1];
    
    UITextField *tf2 = [UITextField new];
    tf2.font = [UIFont systemFontOfSize:13];
    tf2.borderStyle = UITextBorderStyleRoundedRect;
    tf2.placeholder = @"输入数字";
    tf2.delegate = self;
    tf2.tag = 131;
    tf2.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tf2];
    
    UITextField *tf3 = [UITextField new];
    tf3.font = [UIFont systemFontOfSize:13];
    tf3.borderStyle = UITextBorderStyleRoundedRect;
    tf3.placeholder = @"输入数字";
    tf3.delegate = self;
    tf3.tag = 132;
    tf3.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tf3];
    
    [tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@100);
    }];
    
    [tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tf1);
        make.top.equalTo(tf1.mas_bottom).offset(20);
    }];
    
    [tf3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tf2);
        make.top.equalTo(tf2.mas_bottom).offset(20);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"使用switchToLatest计算相加结果" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.viewModel.m1805231008Command execute:nil];
    }];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(tf3.mas_bottom).offset(20);
    }];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(btn.mas_bottom).offset(20);
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"不使用switchToLatest计算相乘结果" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.viewModel.m1805231726Command execute:nil];
    }];
    [self.view addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(label.mas_bottom).offset(20);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(btn2.mas_bottom).offset(20);
    }];
    
    RAC(self.viewModel,number1) = tf1.rac_textSignal;
    RAC(self.viewModel,number2) = tf2.rac_textSignal;
    RAC(self.viewModel,number3) = tf3.rac_textSignal;
    
    [self.viewModel.m1805231010Signal subscribeNext:^(id  _Nullable x) {
        label.text = [NSString stringWithFormat:@"计算结果:%@",x];
    }];
    [self.viewModel.m1805231734Signal subscribeNext:^(id  _Nullable x) {
        label2.text = [NSString stringWithFormat:@"计算结果:%@",x];
    }];
}

- (RACCommand *)command {
    if (_command) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"执行命令出现的数据。"];
                return nil;
            }];
        }];
    }
    return _command;
}

- (void)useOfRACCommand {
    // https://blog.csdn.net/y_csdnblog_xx/article/details/51480342
    
    __weak typeof(self) weakSelf = self;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"普通--->看打印" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf commandTest1];
    }];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(@100);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"一般,引入了executionSignals--->看打印" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf commandTest2];
    }];
    [self.view addSubview:button1];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(button.mas_bottom).offset(20);
    }];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"高级,引入了switchToLatest--->看打印" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf commandTest3];
    }];
    [self.view addSubview:button2];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(button1.mas_bottom).offset(20);
    }];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"信号中信号--->看打印" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button3.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.subject4_1.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self.subject4_1 sendNext:self.subject4_2];
    [[button3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf commandTest4];
    }];
    [self.view addSubview:button3];
    
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.top.equalTo(button2.mas_bottom).offset(20);
    }];
}

- (RACSubject *)subject4_1 {
    if (!_subject4_1) {
        _subject4_1 = [RACSubject subject];
    }
    return _subject4_1;
}

- (RACSubject *)subject4_2 {
    if (!_subject4_2) {
        _subject4_2 = [RACSubject subject];
    }
    return _subject4_2;
}

- (void)commandTest4 {
    /*
    RACSubject *signalofsignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    
    // switchToLatest: 获取信号中信号发送的最新信号
    [signalofsignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [signalofsignals sendNext:signalA];
    [signalA sendNext:@4];*/
    [self.subject4_2 sendNext:@"4"];
}

- (RACCommand *)command3 {
    if (!_command3) {
        _command3 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"执行高级命令出现的数据。"];
                return nil;
            }];
        }];
    }
    return _command3;
}

- (void)commandTest3 {
    // switchToLatest获取最新发送的信号，只能用于信号中信号
    [self.command3.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self.command3 execute:@3];
}

- (RACCommand *)command2 {
    if (!_command2) {
        _command2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"执行一般命令出现的数据。"];
                return nil;
            }];
        }];
    }
    return _command2;
}

- (void)commandTest2 {
    // 注意：这里必须是先订阅才能发送命令
    // executionSignals:信号源
    [self.command2.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    [self.command2 execute:@2];
}

- (RACCommand *)command1 {
    if (!_command1) {
        _command1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"执行普通命令出现的数据。"];
                return nil;
            }];
        }];
    }
    return _command1;
}

- (void)commandTest1 {
    // 这里其实用到的是replaySubject 可以先发送命令再订阅
    RACSignal *signal = [self.command1 execute:@2];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (RACSubject *)subject {
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

- (void)useOfRACSubject {
    __weak typeof(self) weakSelf = self;
    UITextField *tf = [UITextField new];
    tf.font = [UIFont systemFontOfSize:13];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"输入5位数字";
    tf.delegate = self;
    tf.tag = 110;
    [self.view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"RACSubject sendMessage" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // RACSubject既可以发送信号，也可以订阅信号
        // 此处为发送信号
        [weakSelf.subject sendNext:tf.text];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tf.mas_left);
        make.top.equalTo(tf.mas_bottom).offset(20);
    }];
    
    UITextField *tf2 = [UITextField new];
    tf2.font = [UIFont systemFontOfSize:13];
    tf2.borderStyle = UITextBorderStyleRoundedRect;
    tf2.placeholder = @"输入5位数字";
    tf2.delegate = self;
    tf2.tag = 111;
    [self.view addSubview:tf2];
    
    [tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(20);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"Block sendMessage" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (weakSelf.sendMessageBlock) {
            weakSelf.sendMessageBlock(tf2.text);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:button2];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tf2.mas_left);
        make.top.equalTo(tf2.mas_bottom).offset(20);
    }];
}

- (void)subscribeOfRACSignal {
    UITextField *tf = [UITextField new];
    tf.font = [UIFont systemFontOfSize:13];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"Input Message";
    [self.view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blueColor];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.top.equalTo(tf.mas_bottom).offset(40);
    }];
    
    // 冷信号-->热信号
    [tf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        label.text = x;
    }];
}

- (void)macroOfRAC {
    UITextField *tf = [UITextField new];
    tf.font = [UIFont systemFontOfSize:13];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.placeholder = @"Input Message";
    [self.view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blueColor];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.top.equalTo(tf.mas_bottom).offset(40);
    }];
    
    // 把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
    RAC(label,text) = tf.rac_textSignal;
}

- (void)masonryOfLabel {
    UILabel *label1 = [UILabel new];
    label1.backgroundColor = [UIColor yellowColor];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:12];
    label1.text = @"字数较少的情况";
    
    [self.view addSubview:label1];
    
    // label宽高会自适应
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.offset(100);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.backgroundColor = [UIColor orangeColor];
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:12];
    label2.numberOfLines = 0;
    label2.text = @"字数较多的情况,且宽度高不固定，包含换行符。\n倚风挽雨入弦，一人独唱离伤 \n万千心绪，欲寄无从\n一声幽叹\n叹情深缘浅，叹岁月成殇，叹执念一场";
    
    [self.view addSubview:label2];
    
    // lable高度自适应
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.equalTo(label1.mas_bottom).offset(40);
    }];
    
    UILabel *label3 = [UILabel new];
    label3.backgroundColor = [UIColor yellowColor];
    label3.textColor = [UIColor blackColor];
    label3.font = [UIFont systemFontOfSize:12];
    label3.numberOfLines = 0;
    label3.text = @"字数较多的情况,且宽度高不固定，不包含换行符。倚风挽雨入弦，一人独唱离伤 万千心绪，欲寄无从 一声幽叹 叹情深缘浅，叹岁月成殇，叹执念一场";
    
    [self.view addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.top.equalTo(label2.mas_bottom).offset(40);
    }];
    
    UILabel *label4 = [UILabel new];
    label4.backgroundColor = [UIColor orangeColor];
    label4.textColor = [UIColor blackColor];
    label4.font = [UIFont systemFontOfSize:12];
    label4.numberOfLines = 0;
    label4.text = @"字数较多的情况,且宽度固定。倚风挽雨入弦，一人独唱离伤 万千心绪，欲寄无从 一声幽叹 叹情深缘浅，叹岁月成殇，叹执念一场";
    
    [self.view addSubview:label4];
    
    // lable高度自适应
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.equalTo(label3.mas_bottom).offset(40);
    }];
}

- (void)getWidthByGap {
    // 两个并列的view，宽度高度相等，间隔知道，用masonry来布局
    // 左右及中间的间隔都是50
    
    // 自己会使用的旧方法
    UIView *oldView1 = [UIView new];
    UIView *oldView2 = [UIView new];
    [self.view addSubview:oldView1];
    [self.view addSubview:oldView2];
    
    oldView1.backgroundColor = [UIColor orangeColor];
    oldView2.backgroundColor = [UIColor yellowColor];
    
    [oldView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.offset(100);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo((YYScreenSize().width-150)/2);
    }];
    
    [oldView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-50);
        make.top.equalTo(oldView1.mas_top);
        make.height.equalTo(oldView1);
        make.width.equalTo(oldView1);
    }];
    
    // 学到的新方法
    UIView *newView1 = [UIView new];
    UIView *newView2 = [UIView new];
    [self.view addSubview:newView1];
    [self.view addSubview:newView2];
    
    newView1.backgroundColor = [UIColor orangeColor];
    newView2.backgroundColor = [UIColor yellowColor];
    
    [newView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oldView1);
        make.top.equalTo(oldView1.mas_bottom).offset(50);
        make.height.equalTo(@40);
    }];
    
    [newView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newView1);
        make.height.equalTo(newView1);
        make.right.offset(-50);
        make.width.equalTo(newView1);
        make.left.equalTo(newView1.mas_right).offset(50);
    }];
}

- (void)orderOfMasonry {
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    
    // view2的约束需要view1的约束
    // 可神奇的是能够先不定义view1的约束，到后面再定义，不影响显示效果
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(20);
        make.centerX.equalTo(view1);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@100);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
//    [self.view layoutIfNeeded];
//    NSLog(@"%@",view1);
}

- (void)createButtons {
    // 默认button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:k_ImageNamed(@"group_activity_location") forState:UIControlStateNormal];
    [btn setTitle:@"定位中" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(k_StatusBarHeight+64);
        make.height.equalTo(@15);
    }];
    
}

- (void)createBottomTF {
    UITextField *tf1 = [UITextField new];
    UITextField *tf2 = [UITextField new];
    
    tf1.placeholder = @"IQKeyboardManager tf one.";
    tf2.placeholder = @"IQKeyboardManager tf two.";
    
    [self.view addSubview:tf1];
    [self.view addSubview:tf2];
    
    [tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.offset(10);
    }];
    
    [tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tf1.mas_top).offset(-20);
        make.centerX.equalTo(tf1.mas_centerX);
        make.left.equalTo(tf1.mas_left);
    }];
}

#pragma mark - UITextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tobeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 110 || textField.tag == 111) {
        if (tobeString.length > 5) {
            return NO;
        }
    }
    else if (textField.tag == 130 || textField.tag == 131 || textField.tag == 132) {
        if (tobeString.length > 2) {
            return NO;
        }
    }
    return YES;
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _button1;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.textColor = [UIColor blackColor];
        _label1.font = [UIFont systemFontOfSize:14];
    }
    return _label1;
}

@end
