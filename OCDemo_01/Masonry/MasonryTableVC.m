//
//  MasonryTableVC.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/3/27.
//  Copyright © 2019 My. All rights reserved.
//

#import "MasonryTableVC.h"
#import "BaseViewController.h"

@interface MasonryTableVC ()

@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation MasonryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = [NSMutableArray arrayWithCapacity:0];
    self.classNames = [NSMutableArray arrayWithCapacity:0];
    
    // 0
    [self addCell:@"addSubView顺序不同" class:@"MasonryVC1"];
    // 1
    [self addCell:@"AutoLayout布局变高cell" class:@"MasonryVC1"];
    // 2
    [self addCell:@"UIImageView:top、left" class:@"MasonryVC1"];
    // 3
    [self addCell:@"UIImageView" class:@"MasonryVC1"];
    
    [self.tableView reloadData];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titlesArray addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld> %@",indexPath.row+1,self.titlesArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        BaseViewController *vc = [class new];
        vc.index = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
