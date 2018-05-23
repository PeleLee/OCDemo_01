//
//  LDDVM.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/23.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewModle.h"

@interface LDDVM : BaseViewModle

@property (nonatomic, strong) RACCommand *m1805231008Command;
@property (nonatomic, strong) RACCommand *m1805231726Command;
@property (nonatomic, strong) RACSubject *m1805231010Signal;
@property (nonatomic, strong) RACSubject *m1805231734Signal;

@property (nonatomic, copy) NSString *number1;
@property (nonatomic, copy) NSString *number2;
@property (nonatomic, copy) NSString *number3;

@end
