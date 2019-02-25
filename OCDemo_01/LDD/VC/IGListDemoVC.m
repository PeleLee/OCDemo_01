//
//  IGListDemoVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2019/1/10.
//  Copyright © 2019年 My. All rights reserved.
//

#import "IGListDemoVC.h"
#import <IGListAdapter.h>
#import <IGListAdapterUpdater.h>

#import "IGListDemoSectionController.h"
#import "IGLoadMoreViewController.h"

@interface IGListDemoVC ()<IGListAdapterDataSource>

@property (nonatomic, strong) IGListAdapter *adapter;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray <DemoItem *>* demos;

@end

@implementation IGListDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
    
    self.navigationItem.title = @"IGList Demos";
    
    [self.view addSubview:self.collectionView];
    
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (void)config {
    self.demos = @[[[DemoItem alloc] initWithName:@"Tail Loading" controllerClass:IGLoadMoreViewController.class controllerIdentifier:nil]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.demos;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [IGListDemoSectionController new];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark - Lazy load

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
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
