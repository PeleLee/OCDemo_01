//
//  NLKeychainManager.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/20.
//  Copyright © 2018年 My. All rights reserved.
//

#import "NLKeychainManager.h"

@implementation NLKeychainManager

- (BOOL)insertAndUpdate:(NSString *)UUID {
    //先查查是否已经存在
    //构造一个操作字典用于查询
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *UUIDKey = [NSString stringWithFormat:@"%@-UUID",[[NSBundle mainBundle] bundleIdentifier]];
    [queryDic setObject:UUID forKey:UUIDKey];
    
    OSStatus status = -1;
    CFTypeRef result = NULL;
    
    status = SecItemCopyMatching((__bridge CFDictionaryRef)queryDic, &result);
    
    if (status == errSecItemNotFound) {
        //没有找到则添加
        status = SecItemAdd((__bridge CFDictionaryRef)queryDic, NULL);
    }
    else if (status == errSecSuccess) {
        //成功找到，说明钥匙已经存在则进行更新
        status = SecItemUpdate((__bridge CFDictionaryRef)queryDic, (__bridge CFDictionaryRef)queryDic);
    }
    
    return (status == errSecSuccess);
}

@end
