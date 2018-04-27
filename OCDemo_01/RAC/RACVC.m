//
//  RACVC.m
//  OCDemo_01
//
//  Created by liqunfei on 2018/4/25.
//  Copyright © 2018年 My. All rights reserved.
//

#import "RACVC.h"
#import "NotificationTestVC.h"
#import "RACPerson.h"

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

@property (nonatomic, strong) RACSignal *flatterMapSignal;

@end

@implementation RACVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ReactiveCocoa";
    
    NSLog(@"-----在代码中打开对应方法-----");
    NSLog(@"\n");
//    [self viewWithRAC];
//    [self notificationWithRAC];
//    [self basisOfRACSignal];
//    [self observableOfHot];
//    [self observableOfCold];
//    [self coldSignalTurnsIntoHotSignal];
//    [self multipleSubscriptions];
    [self resolveMultipleSubscriptions];
}

/**
 解决多次订阅
 */
- (void)resolveMultipleSubscriptions {
    RACPerson *model = [RACPerson new];
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"只希望输出一次");
        [subscriber sendNext:model];
        return nil;
    }] replayLazily/*转换为热信号*/];
    RACSignal *name = [signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal return:model.name];
    }];
    RACSignal *age = [signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal return:model.age];
    }];
    RAC(self.textField1,text) = [[name catchTo:[RACSignal return:@"error"]] startWith:@"name:"];
    RAC(self.textField2,text) = [[age catchTo:[RACSignal return:@"error"]] startWith:@"age:"];
}

/**
 不当使用:会产生多次订阅
 */
- (void)multipleSubscriptions {
    RACPerson *model = [RACPerson new];
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"只希望输出一次");
        [subscriber sendNext:model];
        return nil;
    }];
    RACSignal *name = [signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal return:model.name];
    }];
    RACSignal *age = [signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return [RACSignal return:model.age];
    }];
    RAC(self.textField1,text) = [[name catchTo:[RACSignal return:@"error"]] startWith:@"name:"];
    RAC(self.textField2,text) = [[age catchTo:[RACSignal return:@"error"]] startWith:@"age:"];
}

/**
 将冷信号转变为热信号
 */
- (void)coldSignalTurnsIntoHotSignal {
    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [[RACScheduler mainThreadScheduler] afterDelay:0.5 schedule:^{
            [subscriber sendNext:@2];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@3];
        }];
        return nil;
    }] publish];
    [connection connect];
    RACSignal *signal = connection.signal;
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"这里是 冷-->热 信号1，接收到了%@", x);
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"这里是 冷-->热 信号2，接收到了%@", x);
        }];
    }];
}

/**
 冷信号
 */
- (void)observableOfCold {
    //创建冷信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [[RACScheduler mainThreadScheduler] afterDelay:0.5 schedule:^{
            [subscriber sendNext:@2];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@3];
        }];
        return nil;
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"signal1接收到了%@", x);
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"signal2接收到了%@", x);
        }];
    }];
    /*
     2018-04-27 10:38:48.417331+0800 OCDemo_01[44741:5398654] signal1接收到了1
     2018-04-27 10:38:48.967265+0800 OCDemo_01[44741:5398654] signal1接收到了2
     2018-04-27 10:38:49.382421+0800 OCDemo_01[44741:5398654] signal2接收到了1
     2018-04-27 10:38:49.933196+0800 OCDemo_01[44741:5398654] signal2接收到了2
     2018-04-27 10:38:50.595367+0800 OCDemo_01[44741:5398654] signal1接收到了3
     2018-04-27 10:38:51.581481+0800 OCDemo_01[44741:5398654] signal2接收到了3
     */
}

/**
 热信号
 参考:https://www.jianshu.com/p/870a740ea6ba
 */
- (void)observableOfHot {
    // 创建热信号 RACStream --> RACSignal --> RACSubject
    RACSubject *subject = [RACSubject subject];
    [subject sendNext:@1]; // 立即发送1
    [[RACScheduler mainThreadScheduler] afterDelay:0.5 schedule:^{
        [subject sendNext:@2]; // 0.5秒后发送2
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
        [subject sendNext:@3]; // 2秒后发送3
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"subject1接收到了%@",x); // 0.1秒后subject1订阅了
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [subject subscribeNext:^(id  _Nullable x) {
            NSLog(@"subject2接收到了%@",x); // 1秒后subject2订阅了
        }];
    }];
    /*
     2018-04-27 10:28:46.843322+0800 OCDemo_01[44699:5394460] subject1接收到了2
     2018-04-27 10:28:48.531071+0800 OCDemo_01[44699:5394460] subject1接收到了3
     2018-04-27 10:28:48.531245+0800 OCDemo_01[44699:5394460] subject2接收到了3
     */
}

/**
 RACSignal基本用法
 */
- (void)basisOfRACSignal {
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号
        [subscriber sendNext:@"RACSignal基本用法"];
        [subscriber sendCompleted];
        return nil;
    }];
    // 接收信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"这里是接收到的数据：%@",x);
    }];
}

- (void)notificationWithRAC {
    __weak typeof(self) weakSelf = self;
    
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

#pragma mark notification selector
- (void)traditionNotificationSelector:(NSNotification *)notification {
    NSString *message = notification.userInfo[@"message"];
    self.showNotification1Label.text = message;
    NSLog(@"----接收到传统方法定义的通知----");
}

- (void)viewWithRAC {
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"traditionNotification" object:nil];
}

@end
