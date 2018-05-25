//
//  LDDVC1.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDVC1.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
        self.topImage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.topImage];
        
        self.botLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 70, 30)];
        self.botLabel.textAlignment = NSTextAlignmentCenter;
        self.botLabel.textColor = [UIColor blueColor];
        self.botLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.botLabel];
    }
    return self;
}

@end

@interface LDDVC1 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation LDDVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.index == 16) {
        [self useOfUICollectionView];
    }
}

- (void)useOfUICollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(YYScreenSize().width, 40);
    layout.itemSize = CGSizeMake(110, 150);
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, k_NavBarMaxY, YYScreenSize().width, YYScreenSize().height-k_NavBarMaxY) collectionViewLayout:layout];
    [self.view addSubview:_mainCollectionView];
    
    [_mainCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.botLabel.text = [NSString stringWithFormat:@"{%ld,%ld}",indexPath.section,indexPath.row];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 40;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    label.text = @"头部";
    label.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:label];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击");
}

@end
