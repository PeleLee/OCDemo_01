//
//  LDDVM.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/23.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDVM.h"

@implementation LDDVM

- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        [self.m1805231008Command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            [weakSelf.m1805231010Signal sendNext:x];
        }];
    }
    return self;
}

- (RACCommand *)m1805231008Command {
    if (!_m1805231008Command) {
        __weak typeof(self) weakSelf = self;
        _m1805231008Command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                // 使用switchToLatest的时候必须在初始化时绑定command和signal
                [subscriber sendNext:[NSString stringWithFormat:@"%ld",(weakSelf.number1.integerValue + weakSelf.number2.integerValue + weakSelf.number3.integerValue)]];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _m1805231008Command;
}

- (RACCommand *)m1805231726Command {
    __weak typeof(self) weakSelf = self;
    if (!_m1805231726Command) {
        _m1805231726Command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [weakSelf.m1805231734Signal sendNext:[NSString stringWithFormat:@"%ld",weakSelf.number1.integerValue * weakSelf.number2.integerValue * weakSelf.number3.integerValue]];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _m1805231726Command;
}

- (RACSubject *)m1805231010Signal {
    if (!_m1805231010Signal) {
        _m1805231010Signal = [RACSubject subject];
    }
    return _m1805231010Signal;
}

- (RACSubject *)m1805231734Signal {
    if (!_m1805231734Signal) {
        _m1805231734Signal = [RACSubject subject];
    }
    return _m1805231734Signal;
}

@end
