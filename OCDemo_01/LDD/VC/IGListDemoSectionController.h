//
//  IGListDemoSectionController.h
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/16.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGListSectionController.h"
#import <IGListDiff.h>

@interface DemoItem : NSObject<IGListDiffable>

- (instancetype)initWithName:(NSString *)name
             controllerClass:(Class)controllerClass
        controllerIdentifier:(NSString *)controllerIdentifier;

@end

NS_ASSUME_NONNULL_BEGIN

@interface IGListDemoSectionController : IGListSectionController

@property (nonatomic, strong) DemoItem *object;

@end

NS_ASSUME_NONNULL_END
