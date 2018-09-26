//
//  LDDVC2.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/8/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDVC2.h"
#import "LQFAlertController.h"
#import "LDDTableViewCell1.h"

@interface LDDVC2 () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) NSArray *cellContentArray;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation LDDVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if (self.index == 32) {
        [self customAlertController];
    }
    else if (self.index == 33) {
        [self overlappingOfSystemAlertControll];
    }
    else if (self.index == 34) {
        [self layoutSubViewsBeforeLayoutSuperViewWithMasonry];
    }
    else if (self.index == 35) {
        [self adaptiveHeightOfUITableViewCell];
    }
    else if (self.index == 36) {
        [self aboutUIPageControl];
    }
    else if (self.index == 37) {
        [self backgroundSizeWithContentSize];
    }
    
    else if (self.index == 1001) {
        [self adaptiveTableCellWithMasonry];
    }
}

#pragma mark - 37.Xib-根据内容尺寸确定背景大小
- (void)backgroundSizeWithContentSize {
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    
    [self.label1 setText:@"纠"];
    [self.label2 setText:@"结"];
    [self.label3 setText:@"伦"];
    [self.label1 setBackgroundColor:[UIColor yellowColor]];
    [self.label2 setBackgroundColor:[UIColor yellowColor]];
    [self.label3 setBackgroundColor:[UIColor yellowColor]];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0.3];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY).offset(-5);
        make.right.equalTo(self.view.mas_centerX).offset(-5);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.label1);
        make.left.equalTo(self.view.mas_centerX).offset(5);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).offset(5);
        make.centerX.equalTo(self.view);
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1).offset(-10);
        make.top.equalTo(self.label1).offset(-10);
        make.right.equalTo(self.label2).offset(10);
        make.bottom.equalTo(self.label3).offset(10);
    }];
}

#pragma mark - 36.UIPageControl相关
- (void)aboutUIPageControl {
    [self addContentScrollView];
    [self.contentScrollView addSubview:self.label1];
    [self.contentScrollView addSubview:self.button1];
    
    self.label1.text = @"基础用法，之前写过几次，不过还是容易忘记，所以整理一下，方便查阅。\n\n初始化参数\n\nTransitionStyle(过渡方式):\n";
    [self.button1 setTitle:@"UIPageViewControllerTransitionStyleScroll" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(YYScreenSize().width-40);
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label1.mas_bottom).offset(10);
        make.left.mas_equalTo(self.label1);
    }];
}

#pragma mark - UITableView About
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellContentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDDTableViewCell1 *cell = (LDDTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"LDDTableViewCell1"];
    if (!cell) {
        cell = [[LDDTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LDDTableViewCell1"];
    }
    [cell setContent:self.cellContentArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"TableView frame.origin :%f",tableView.frame.origin.y);
}

#pragma mark - 1001.使用Masonry来自适应cell高度
- (void)adaptiveTableCellWithMasonry {
    UITableView *table = [UITableView new];
    table.delegate = self;
    table.dataSource = self;
    table.estimatedRowHeight = 44;//必须要设置
    [self.view addSubview:table];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CellContentText" ofType:@"plist"];
    self.cellContentArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - 35.UITableViewCell高度自适应的几种方法
- (void)adaptiveHeightOfUITableViewCell {
    [self.view addSubview:self.label1];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.label2];
    
    __weak typeof(self) weakSelf = self;
    
    self.label1.text = @"参考地址:https://www.aliyun.com/jiaocheng/352213.html";
    
    [self.button1 setTitle:@"1.通过Maaonry获取cell的自适应高度" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LDDVC2 *vc = [LDDVC2 new];
        vc.index = 1001;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    self.label2.text = @"table.estimatedRowHeight = 44;必须设置该属性,否则在低版本iOS版本上会不起效(目前已知的有iOS9.0)\n这样是真的便捷...";
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY + 20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button1.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
}

#pragma mark - 34:Masonry-先布局子视图后布局父视图

- (void)layoutSubViewsBeforeLayoutSuperViewWithMasonry {
    UIView *superView = [UIView new];
    [superView setBackgroundColor:[UIColor yellowColor]];
    UIView *subView1 = [UIView new];
    [subView1 setBackgroundColor:[UIColor lightGrayColor]];
    UIView *subView2 = [UIView new];
    [subView2 setBackgroundColor:[UIColor orangeColor]];
    UIView *subView3 = [UIView new];
    [subView3 setBackgroundColor:[UIColor purpleColor]];
    
    [self.view addSubview:superView];
    [superView addSubview:subView1];
    [superView addSubview:subView2];
    [superView addSubview:subView3];
    
    [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@50);
    }];
    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subView1.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(superView.mas_centerX).offset(-10);
        make.height.equalTo(@50);
    }];
    [subView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_centerX).offset(10);
        make.top.equalTo(subView2);
        make.right.equalTo(@-20);
        make.height.equalTo(@50);
    }];
    [superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subView1.mas_top).offset(-20);
        make.bottom.equalTo(subView3.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(YYScreenSize().width-60);
    }];
}

#pragma mark - 33.UIAlertController是否重叠

- (void)overlappingOfSystemAlertControll {
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"显示第一个Alert" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"第一层" message:@"第二个alert出现后,是覆盖第一层还是移除第一层?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *tipsAction = [UIAlertAction actionWithTitle:@"5s后显示第二个Alert" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.label1.text = @"不能同时在一个ViewController中present两个AlertController,会报错(Warning: Attempt to present <UIAlertController: 0x7ff37580fc00>  on <UINavigationController: 0x7ff37702ba00> which is already presenting <UIAlertController: 0x7ff37509f000>),所以实验是失败的...";
        }];
        [alert addAction:tipsAction];
        [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY+20);
        make.left.mas_equalTo(20);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *secondAlert = [UIAlertController alertControllerWithTitle:@"第二层" message:@"这时第一个alert是否消失?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [secondAlert addAction:cancelAction];
        [weakSelf.navigationController presentViewController:secondAlert animated:YES completion:nil];
    });
    
    [self.view addSubview:self.label1];
    self.label1.text = @"";
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.right.equalTo(@-20);
        make.top.equalTo(self.button1.mas_bottom).offset(20);
    }];
}

#pragma mark - 32.自定义AlertController

- (void)customAlertController {
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"☞☞☞ Show Custom AlertController" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        LQFAlertController *alert = [[LQFAlertController alloc] init];
        [weakSelf.navigationController presentViewController:alert animated:NO completion:nil];
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(k_NavBarMaxY+20);
    }];
    
    [self.view addSubview:self.button2];
    [self.button2 setTitle:@"☞☞☞ Show System AlertController" forState:UIControlStateNormal];
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"系统AlertController" message:@"对比显示和消失动画等" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"消失" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [weakSelf.navigationController presentViewController:alert animated:NO completion:nil];
    }];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button1);
        make.top.equalTo(self.button1.mas_bottom).offset(20);
    }];
}

#pragma mark - AddContentScrollView
- (void)addContentScrollView {
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_NavBarMaxY);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-k_SafeAreaHeight);
    }];
}

#pragma mark - Lazy load

#pragma mark Button
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button2.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _button2;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.textColor = [UIColor blackColor];
        _label1.numberOfLines = 0;
    }
    return _label1;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [UILabel new];
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.textColor = [UIColor blackColor];
        _label2.numberOfLines = 0;
    }
    return _label2;
}

- (UILabel *)label3 {
    if (!_label3) {
        _label3 = [UILabel new];
        _label3.font = [UIFont systemFontOfSize:13];
        _label3.textColor = [UIColor blackColor];
        _label3.numberOfLines = 0;
    }
    return _label3;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [UIScrollView new];
//        _contentScrollView.backgroundColor = [UIColor yellowColor];
    }
    return _contentScrollView;
}
@end
