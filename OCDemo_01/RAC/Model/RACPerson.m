//
//  RACPerson.m
//  OCDemo_01
//
//  Created by liqunfei on 2018/4/27.
//  Copyright © 2018年 My. All rights reserved.
//

#import "RACPerson.h"

@implementation RACPerson

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"Keefe";
        self.age = @"18";
    }
    return self;
}

@end
