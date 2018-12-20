//
//  LDDCustomCameraVC.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/11/21.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDDCustomCameraVC : BaseViewController

@property (nonatomic, copy) void(^photoBlock)(UIImage *photo);

@end

NS_ASSUME_NONNULL_END
