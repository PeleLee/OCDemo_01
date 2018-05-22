//
//  NotificationLearnTVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/21.
//  Copyright © 2018年 My. All rights reserved.
//

#import "NotificationLearnTVC.h"
#import "BaseViewController.h"
#import "NotificationVC.h"

@interface NotificationLearnTVC ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation NotificationLearnTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通知相关";
    
    [self addCell:@"野指针" class:@"1"];
    
    [self.tableView reloadData];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,_titles[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        BaseViewController *tv = [class new];
        [self.navigationController pushViewController:tv animated:YES];
    }
    else {
        if ([className isEqualToString:@"1"]) {
            
            if (YES) {
                NotificationVC *vc1 = [[NotificationVC alloc] init];
                vc1.isRemoveNotification = NO;
                [vc1 addNormalObserver];
                
                NotificationVC *vc2 = [[NotificationVC alloc] init];
                [vc2 postNotification];
            }
            
            [self postNotificationAgain];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)postNotificationAgain {
    NotificationVC *vc2 = [[NotificationVC alloc] init];
    [vc2 postNotification];
    NSLog(@"结论:现在即使不在dealloc中移除通知观察者也不会有野指针，因为Apple已经帮我们自动加上了移除的代码，不过建议还是写上，听说在iPad上还是会出现野指针的问题，产生闪退");
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray arrayWithCapacity:0];
    }
    return _titles;
}

- (NSMutableArray *)classNames {
    if (!_classNames) {
        _classNames = [NSMutableArray arrayWithCapacity:0];
    }
    return _classNames;
}
@end
