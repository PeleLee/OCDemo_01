//
//  MasonryVC1.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/3/27.
//  Copyright © 2019 My. All rights reserved.
//

#import "MasonryVC1.h"
#import "AutoLayoutTableViewCell.h"

@interface MasonryVC1 () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTV;

@end

@implementation MasonryVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.index == 0) {
        [self differentOrderOfAddSubView];
    }
    else if (self.index == 1) {
        [self.view addSubview:self.myTV];
        [self.myTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(k_NavBarMaxY);
            make.bottom.offset(k_SafeAreaHeight);
        }];
    }
    
}

#pragma mark - 1.AutoLayout与Masonry


#pragma mark - 0.addSubView顺序不同
- (void)differentOrderOfAddSubView {
    UILabel *label1 = [UILabel new];
    label1.backgroundColor = [UIColor yellowColor];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"label 1";
    
    UILabel *label2 = [UILabel new];
    label2.backgroundColor = [UIColor orangeColor];
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:14];
    label2.numberOfLines = 0;
    label2.text = @"label2label2label2label2label2label2label2label2label2label2label2label2label2label2label2label2";
    
    UILabel *label3 = [UILabel new];
    label3.backgroundColor = [UIColor yellowColor];
    label3.textColor = [UIColor blackColor];
    label3.font = [UIFont systemFontOfSize:14];
    label3.text = @"label 1";
    
    UILabel *label4 = [UILabel new];
    label4.backgroundColor = [UIColor orangeColor];
    label4.textColor = [UIColor blackColor];
    label4.font = [UIFont systemFontOfSize:14];
    label4.numberOfLines = 0;
    label4.text = @"label2label2label2label2label2label2label2label2label2label2label2label2label2label2label2label2";
    // 正确顺序
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    // 错误顺序
    [self.view addSubview:label4];
    [self.view addSubview:label3];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(100);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(10);
        make.right.offset(-20);
        make.top.equalTo(label1);
    }];
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(label2.mas_bottom).offset(20);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right).offset(10);
        make.right.offset(-20);
        make.top.equalTo(label3);
    }];
    [label3 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

#pragma mark - UITableView About

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.index == 1) {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.index == 1) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.index == 1) {
        NSString *content = @"开始\n开发过程中，修改某份之前的代码，用xib布局的cell，发现内部的label总是不能显示完全的内容，以此来验证是不是布局错误。\n验证结果：不是约束条件的问题。\n结束";
        AutoLayoutTableViewCell *cell = (AutoLayoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AutoLayoutTableViewCellID"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AutoLayoutTableViewCell" owner:nil options:nil] lastObject];
            cell.contentLabel.text = content;
        }
        return cell;
//        if (indexPath.row == 0) {
//            AutoLayoutTableViewCell *cell = (AutoLayoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AutoLayoutTableViewCellID"];
//            if (!cell) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:@"AutoLayoutTableViewCell" owner:nil options:nil] lastObject];
//
//            }
//            return cell;
//        }
    }
    return [UITableViewCell new];
}

#pragma mark - Lazy Load

- (UITableView *)myTV {
    if (!_myTV) {
        _myTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTV.delegate = self;
        _myTV.dataSource = self;
        _myTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTV;
}

@end
