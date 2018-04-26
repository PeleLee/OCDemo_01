//
//  RACVC.m
//  OCDemo_01
//
//  Created by liqunfei on 2018/4/25.
//  Copyright © 2018年 My. All rights reserved.
//

#import "RACVC.h"
#import "NotificationTestVC.h"

@interface RACVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *showAlertButton2;
@property (weak, nonatomic) IBOutlet UIButton *traditionNotificationBtn;
@property (weak, nonatomic) IBOutlet UIButton *RACNotificationBtn;
@property (weak, nonatomic) IBOutlet UILabel *showNotification1Label;
@property (weak, nonatomic) IBOutlet UILabel *showNotification2Label;

@end

@implementation RACVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ReactiveCocoa";
    
    // RAC监听textFild的UIControlEventEditingChanged事件
    [[self.textField1 rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"Textfield1 changed in RAC.");
    }];
    
    // RAC对于textFild的文字监听
    [[self.textField1 rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"Show textField1 text in RAC: %@",x);
    }];
    
    // RAC给某个label添加手势动作
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [[tap1 rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        NSLog(@"Tap label1 by RAC.");
    }];
    [self.label1 addGestureRecognizer:tap1];
    
    // 常规方法给某个label添加手势动作
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Selector)];
    [self.label2 addGestureRecognizer:tap2];
    
    __weak typeof(self) weakSelf = self;
    // RAC给button添加事件
    [[self.showAlertButton2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tradition" message:@"RAC方法触发" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"action1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Tradition action1.");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        // 不使用weakSelf而直接使用self的话会发生内存泄露
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    
    // 通知：传统方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(traditionNotificationSelector:) name:@"traditionNotification" object:nil];
    
    // 通知：RAC
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"RACNotification" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSString *message = x.userInfo[@"message"];
        weakSelf.showNotification2Label.text = message;
        NSLog(@"----接收到RAC定义的通知----");
    }];
    
    [[self.traditionNotificationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NotificationTestVC *vc = [[NotificationTestVC alloc] initWithNibName:@"NotificationTestVC" bundle:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.RACNotificationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NotificationTestVC *vc = [[NotificationTestVC alloc] initWithNibName:@"NotificationTestVC" bundle:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"traditionNotification" object:nil];
}

#pragma mark notification selector
- (void)traditionNotificationSelector:(NSNotification *)notification {
    NSString *message = notification.userInfo[@"message"];
    self.showNotification1Label.text = message;
    NSLog(@"----接收到传统方法定义的通知----");
}

#pragma mark button action

- (IBAction)button1Action:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tradition" message:@"传统方法触发" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"action1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Tradition action1.");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"action2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Tradition action2.");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark tap action
- (void)tap2Selector {
    NSLog(@"Tap label2 by tap action.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.textField2) {
        NSLog(@"TextField2 changed in delegate method.");
        NSLog(@"Show textField2 text in delegate method: %@%@",textField.text,string);
    }
    
    return YES;
}



@end
