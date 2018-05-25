//
//  LDDVC1.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "BaseViewController.h"

@interface MyCollectionViewCell: UICollectionViewCell

@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, strong) UILabel *botLabel;

@end

@interface LDDVC1 : BaseViewController

@property (nonatomic, assign) NSInteger index;

@end
