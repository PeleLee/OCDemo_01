//
//  LDDVC3.m
//  OCDemo_01
//
//  Created by LiQunFei on 2019/4/18.
//  Copyright © 2019 My. All rights reserved.
//

#import "LDDVC3.h"
#import "EDTabView.h"
#import "TATabView.h"
#import "NLPageViewController.h"
#import "OutView.h"

@interface LDDVC3 ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *myLabel;

@end

@implementation LDDVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    switch (self.index) {
        case 52:
        {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
            [self.view addGestureRecognizer:pan];
            [self customPageVC];
        }
            break;
        case 53:
        {
            [self gcd_53];
        }
            break;
        case 54:
        {
            [self buttonOutSupview];
        }
            break;
        case 55:
        {
            [self masonryLayout];
        }
            break;
        case 56:
        {
            [self masonryDemo];
        }
            break;
        case 57:
        {
            [self ifWithNil];
        }
            break;
        case 58:
        {
            [self imageWithButton];
        }
            break;
        case 59:
        {
            [self useRemakeInMasonry];
        }
            break;
        case 60:
        {
            [self multiStoreyStrongify];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 多层@strongify
- (void)multiStoreyStrongify {
    self.btn = [self createButton];
    [self.btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.btn];
    
    self.myLabel = [self createLabel];
    [self.view addSubview:self.myLabel];
    
    @weakify(self);
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.view.backgroundColor = [UIColor yellowColor];
        [UIView animateWithDuration:0.3 animations:^{
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                self.btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }];
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

#pragma mark - 59.直接使用 masonry remake
- (void)useRemakeInMasonry {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

#pragma mark - 58.button image
- (void)imageWithButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"mine_select"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(54, 60));
    }];
    [btn addTarget:self action:@selector(btnAction_58) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction_58 {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 57.nil条件
- (void)ifWithNil {
    NSString *tmpStr = nil;
    if (tmpStr) {
        NSLog(@"非空判断");
    }
}

#pragma mark - 56

- (void)masonryDemo {
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor yellowColor];
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:13.f];
    label1.text = @"参考";
    
    UILabel *label2 = [UILabel new];
    label2.font = [UIFont systemFontOfSize:13.f];
    label2.numberOfLines = 0;
    label2.text = @"111111112222222333333333335555555555666666666666888888888888899999999999999990000000000000";
    
    [self.view addSubview:view1];
    [view1 addSubview:label1];
    [view1 addSubview:label2];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@100);
        make.right.equalTo(@-20);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(label2);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(20);
        make.top.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@-20);
    }];
}

#pragma mark - 55.Masonry 按比例布局

- (void)masonryLayout {
    /*UIView *view = [UIView new];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_height).multipliedBy(0.5);
        make.left.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];*/
}

#pragma mark - 54.超出父视图的button响应

- (void)buttonOutSupview {
    OutView *supView = [OutView new];
    supView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:supView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"button2" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击2");
    }];
    [supView addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitle:@"button1" forState:UIControlStateNormal];
    [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击1");
    }];
    [supView addSubview:button2];
    
    [supView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@200);
        make.width.height.equalTo(@100);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(supView);
        make.top.equalTo(supView.mas_bottom).offset(30);
    }];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(supView);
        make.top.equalTo(supView);
    }];
}

#pragma mark - 53.GCD

- (void)gcd_53 {
    /*dispatch_async_on_main_queue(^{
        dispatch_async_on_main_queue(^{
            sleep(2);
            NSLog(@"1");
        });
        NSLog(@"2");
        dispatch_async_on_main_queue(^{
            NSLog(@"3");
        });
    });
    sleep(1);*/
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        dispatch_async(queue, ^{
            sleep(2);
            NSLog(@"1");
        });
        NSLog(@"2");
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
    });
    sleep(1);
}

#pragma mark - 52.CustomPageVC

- (void)customPageVC {
    EDTabModel *model = [EDTabModel new];
    model.dataList = @[@"便利",@"雪亮",@"贵虎",@"冰袋",@"爱国者"];
    
    UILabel *label_1 = [self createLabel];
    label_1.text = model.dataList[0];
    [self.view addSubview:label_1];
    
    EDTabView *tabView = [[EDTabView alloc] initWithTabModel:model];
    tabView.selectedBlock = ^(NSInteger index) {
        label_1.text = model.dataList[index];
    };
    [self.view addSubview:tabView];
    
    UIButton *button_1 = [self createButton];
    [button_1 setTitle:@"该类型pageVC->" forState:UIControlStateNormal];
    [button_1 addTarget:self action:@selector(gotoPageVC:) forControlEvents:UIControlEventTouchUpInside];
    button_1.tag = 1001;
    [self.view addSubview:button_1];
    
    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(k_NavBarMaxY);
        make.height.equalTo(@50);
    }];
    
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.equalTo(tabView.mas_bottom).offset(20);
    }];
    
    [button_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label_1);
        make.right.offset(-5);
    }];
    
    TATabModel *taModel = [TATabModel new];
    taModel.dataList = @[@"福",@"百草味",@"草莓夹心",@"白巧克力",@"香砂养胃丸",@"顺丰速运",@"MacBook Pro",@"大派送",@"U便利",@"弹跳杯"];
    
    UILabel *label_2 = [self createLabel];
    label_2.text = taModel.dataList[0];
    [self.view addSubview:label_2];
    
    TATabView *taTabView = [[TATabView alloc] initWithTabModel:taModel];
    taTabView.selectedBlock = ^(NSInteger index) {
        label_2.text = taModel.dataList[index];
    };
    [self.view addSubview:taTabView];
    
    UIButton *button_2 = [self createButton];
    [button_2 setTitle:@"该类型pageVC->" forState:UIControlStateNormal];
    [button_2 addTarget:self action:@selector(gotoPageVC:) forControlEvents:UIControlEventTouchUpInside];
    button_2.tag = 1002;
    [self.view addSubview:button_2];
    
    [taTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(label_1.mas_bottom).offset(20);
        make.height.equalTo(@50);
    }];
    
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.equalTo(taTabView.mas_bottom).offset(20);
    }];
    
    [button_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label_2);
        make.right.offset(-5);
    }];
}

- (void)gotoPageVC:(UIButton *)btn {
    id model;
    if (btn.tag == 1001) {
        EDTabModel *edModel = [EDTabModel new];
        edModel.dataList = @[@"便利",@"雪亮",@"贵虎",@"冰袋",@"爱国者"];
        model = edModel;
    }
    else if (btn.tag == 1002) {
        TATabModel *taModel = [TATabModel new];
        taModel.dataList = @[@"福",@"百草味",@"草莓夹心",@"白巧克力",@"香砂养胃丸",@"顺丰速运",@"MacBook Pro",@"大派送",@"U便利",@"弹跳杯"];
        model = taModel;
    }
    NLPageViewController *pageVC = [[NLPageViewController alloc] initWithTabModel:model];
    [self.navigationController pushViewController:pageVC animated:YES];
}

#pragma mark - Factory

- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    return btn;
}

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    return label;
}

#pragma mark - Other

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

@end
