//
//  NotificationVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/21.
//  Copyright © 2018年 My. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC ()

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    NSLog(@"%s, %@调用了dealloc方法，表明该对象释放了",__FUNCTION__,self);
    if (_isRemoveNotification) {
        // Apple默认已经在iPhone中添加了
        [k_NotificationCenter removeObserver:self];
    }
}

- (void)addNormalObserver {
    [k_NotificationCenter addObserver:self selector:@selector(getNotification:) name:@"noticycle" object:nil];
}

- (void)addLeakObserver {
    
    // 1.正常使用 还是推荐使用这种
    // 添加该类型的通知观察者，即使不在dealloc中调用移除观察者的方法(官方已在iPhone默认添加了)，也不会产生内存泄漏
    // [self addNormalObserver];
    
    // 2.会产生内存泄漏的使用方法
    // 需要注意block造成的循环强引用问题
//    __weak typeof(self) weakSelf = self;
    
    [k_NotificationCenter addObserverForName:@"noticycle" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"注意观察 接收通知的 对象是否释放");
        NSLog(@"%s, %@一直都没有调用delloc方法，因为看不到打印日志",__FUNCTION__,self);/*不管使用self还是weakSelf都会有内存泄漏*/
        /*NSLog(@"%s 一直都没有调用delloc方法，因为看不到打印日志",__FUNCTION__);*//*改行代码，即使调用了dealloc方法，再次发通知还是会有一个无头对象收到通知*/
    }];
    
    
}

- (void)getNotification:(NSNotification *)notifi {
    NSLog(@"注意观察 接收通知的 对象是否释放");
    NSLog(@"%s, %@",__FUNCTION__,self);
}

- (void)postNotification {
    [k_NotificationCenter postNotificationName:@"noticycle" object:nil userInfo:nil];
    NSLog(@"注意观察 发送通知的 对象是否释放");
    NSLog(@"%s, %@",__FUNCTION__,self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
