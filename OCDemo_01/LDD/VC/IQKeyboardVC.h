//
//  IQKeyboardVC.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/19.
//  Copyright © 2018年 My. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface IQKeyboardVC : BaseViewController

@property (nonatomic, strong) RACSubject *subject;

@property (nonatomic, copy) void (^sendMessageBlock)(NSString *message);

@property (nonatomic, strong) RACCommand *command;

@end
