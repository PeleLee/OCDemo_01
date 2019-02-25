//
//  IGLoadMoreViewController.h
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/16.
//  Copyright © 2019年 My. All rights reserved.
//

#import "BaseViewController.h"
#import <IGListAdapter.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGLoadMoreViewController : BaseViewController<IGListAdapterDataSource,UIScrollViewDelegate>

@end

NS_ASSUME_NONNULL_END
