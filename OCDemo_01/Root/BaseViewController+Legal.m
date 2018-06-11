//
//  BaseViewController+Legal.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/6/11.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController+Legal.h"

static NSString *legalPropertyStrKey = @"legalPropertyStr";

@implementation BaseViewController (Legal)

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setLegalPropertyStr:(NSString *)legalPropertyStr {
    objc_setAssociatedObject(self, &legalPropertyStrKey, legalPropertyStr, OBJC_ASSOCIATION_COPY);
}

- (NSString *)legalPropertyStr {
    return objc_getAssociatedObject(self, &legalPropertyStrKey);
}

@end
