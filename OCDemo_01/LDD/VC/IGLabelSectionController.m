//
//  IGLabelSectionController.m
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/25.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGLabelSectionController.h"
#import "IGLabelCell.h"

@interface IGLabelSectionController ()

@property (nonatomic, copy) NSString *object;

@end

@implementation IGLabelSectionController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    IGLabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:IGLabelCell.class forSectionController:self atIndex:index];
    cell.text = self.object;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.object = ((NSString *)object).description;
}

@end
