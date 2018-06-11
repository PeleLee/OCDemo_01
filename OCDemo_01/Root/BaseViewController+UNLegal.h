//
//  BaseViewController+UNLegal.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/6/11.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (UNLegal)

/**
 只在分类中声名成员变量，是不能直接使用的
 */
@property (nonatomic, copy) NSString *unLegalPropertyStr;

@end
