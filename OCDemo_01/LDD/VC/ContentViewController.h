//
//  ContentViewController.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/7/20.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController.h"

@interface ContentViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (copy, nonatomic) NSString *content;

@end
