//
//  LDDTableViewController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/18.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDTableViewController.h"
#import "BaseViewController.h"
#import "MyMacro.h"
#import "AppDelegate.h"
#import "NotificationVC.h"

@interface LDDTableViewController ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation LDDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    
    self.title = @"LDD";
    self.titles = [NSMutableArray arrayWithCapacity:0];
    self.classNames = [NSMutableArray arrayWithCapacity:0];
    [self addCell:@"IQKeyboardManager" class:@"IQKeyboardVC"];
    [self addCell:@"通知:点击使Appdelegate发通知" class:@"1"];
    [self addCell:@"通知:模拟通知造成的内存泄漏" class:@"2"];
    [self addCell:@"通知:再次发送通知" class:@"3"];
    [self addCell:@"全屏侧滑返回" class:@"4"];
    [self addCell:@"几种按钮" class:@"IQKeyboardVC"];
    [self addCell:@"Masonary:约束条件先后顺序影响" class:@"IQKeyboardVC"];
    [self addCell:@"Masonary:并列的view通过间隔计算宽度" class:@"IQKeyboardVC"];
    [self addCell:@"Masonary:Label的一些自适应" class:@"IQKeyboardVC"];
    
    [k_NotificationCenter addObserver:self selector:@selector(changeCellText:) name:@"changeCellText" object:nil];
    
    [self.tableView reloadData];
}

- (void)changeCellText:(NSNotification *)noti {
    for (NSInteger i = 0; i < self.classNames.count; i++) {
        NSString *className = self.classNames[i];
        if ([className isEqualToString:@"1"]) {
            self.titles[i] = noti.object;
            [self.tableView reloadData];
            return;
        }
    }
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.tag = indexPath.row;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,self.titles[indexPath.row]];
//    NSLog(@"cell tag:%ld",cell.tag);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        BaseViewController *vc = [class new];
        vc.index = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        if ([className isEqualToString:@"1"]) {
            [k_Appdelegate postNotification];
        }
        else if ([className isEqualToString:@"2"]) {
            NotificationVC *vc1 = [[NotificationVC alloc] init];
            [vc1 addLeakObserver];
            
            NotificationVC *vc2 = [[NotificationVC alloc] init];
            [vc2 postNotification];
        }
        else if ([className isEqualToString:@"3"]) {
            NotificationVC *vc2 = [[NotificationVC alloc] init];
            [vc2 postNotification];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
