//
//  IGLoadMoreViewController.m
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/16.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGLoadMoreViewController.h"
#import <IGListKit.h>
#import <IGListDiffable.h>
#import "IGSpinnerCell.h"
#import "IGLabelSectionController.h"

NSString *const spinToken = @"spinner";

@interface IGLoadMoreViewController ()

@property (nonatomic, strong) IGListAdapter *adapter;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) BOOL loading;

@end

@implementation IGLoadMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    self.adapter.scrollViewDelegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - IGList Adapter DataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    NSMutableArray *objects = [NSMutableArray arrayWithArray:[self.items copy]];
    if (self.loading) {
        [objects addObject:spinToken];
    }
    return objects;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        NSString *obj = (NSString *)object;
        if ([obj isEqualToString:spinToken]) {
            return [[IGSpinnerCell new] spinnerSectionController];
        }
        else {
            return [IGLabelSectionController new];
        }
    }
    else {
        
    }
    return [IGListSectionController new];
}

#pragma mark - Lazy load

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 20; i++) {
            [_items addObject:[NSNumber numberWithInteger:i]];
        }
    }
    return _items;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    }
    return _collectionView;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
    }
    return _adapter;
}

@end
