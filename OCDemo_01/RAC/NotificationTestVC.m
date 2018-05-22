//
//  NotificationTestVC.m
//  OCDemo_01
//
//  Created by liqunfei on 2018/4/25.
//  Copyright © 2018年 My. All rights reserved.
//

#import "NotificationTestVC.h"

@interface NotificationTestVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UIButton *sendButton1;
@property (weak, nonatomic) IBOutlet UIButton *sendButton2;

@end

@implementation NotificationTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [[self.sendButton1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDictionary *dic = @{@"message":weakSelf.tf1.text};
        NSNotification *notification = [NSNotification notificationWithName:@"traditionNotification" object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.sendButton2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSDictionary *dic = @{@"message":weakSelf.tf2.text};
        NSNotification *notification = [NSNotification notificationWithName:@"RACNotification" object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)dealloc {
    [k_NotificationCenter removeObserver:self];
}

@end
