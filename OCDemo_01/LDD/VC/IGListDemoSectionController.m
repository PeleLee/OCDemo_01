//
//  IGListDemoSectionController.m
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/16.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGListDemoSectionController.h"
#import "IGLabelCell.h"
#import <SVProgressHUD.h>

@interface DemoItem ()

@property (nonatomic, copy)     NSString *name;
@property (nonatomic, strong)   Class controllerClass;
@property (nonatomic, copy)     NSString *controllerIdentifier;

@end

@implementation DemoItem

- (instancetype)initWithName:(NSString *)name controllerClass:(Class)controllerClass controllerIdentifier:(NSString *)controllerIdentifier {
    self = [super init];
    if (self) {
        self.name = name;
        self.controllerClass = controllerClass;
        self.controllerIdentifier = controllerIdentifier;
    }
    return self;
}

- (id<NSObject>)diffIdentifier {
    return self.name;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return YES;
}

@end

@implementation IGListDemoSectionController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    IGLabelCell *cell = (IGLabelCell *)[self.collectionContext dequeueReusableCellOfClass:[IGLabelCell class] forSectionController:self atIndex:index];
    if (!cell) {
        [SVProgressHUD showErrorWithStatus:@"cell 初始化出错"];
    }
    cell.text = self.object.name;
    NSLog(@"mmmmmmmmmm");
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.object = (DemoItem *)object;
    NSLog(@"nnnnnnnnnn");
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了cell");
    NSString *identifier = self.object.controllerIdentifier;
    if (identifier) {
    }
    else {
        [self.viewController.navigationController pushViewController:[self.object.controllerClass new] animated:YES];
    }
}

@end
