//
//  AdaptiveHeightCellVC.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/12/17.
//  Copyright © 2018年 My. All rights reserved.
//

#import "AdaptiveHeightCellVC.h"
#import "AdaptiveTableViewCell1.h"

@interface AdaptiveHeightCellVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation AdaptiveHeightCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(k_NavBarMaxY);
        make.bottom.mas_equalTo(k_SafeAreaHeight);
    }];
}

#pragma mark - UITableView About

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"000000"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"000000"];
            cell.backgroundColor = [UIColor yellowColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [UILabel new];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor blackColor];
            label.text = @"之前的方法使用过程中能达到预想的效果，但是在开发过程中，发现会在控制台报Masonry的警告信息，类似[LayoutConstraints] Unable to simultaneously satisfy constraints.之类的";
            
            [cell.contentView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@30);
                make.right.equalTo(@-30);
                make.top.equalTo(@30);
                make.bottom.equalTo(@-30);
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111111"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111111"];
            cell.backgroundColor = [UIColor orangeColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [UILabel new];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor blackColor];
            label.text = @"cell0是黄色cell，没有报错信息，只有一个Label子控件。\ncell2是白色cell，其中包含四个黄色的子控件，也没有报错信息。\ncell3是黄色cell，包含一个白色子控件，没有报错信息。\ncell4是橘色cell，包含一个imageView控件，模仿的是项目中报错的cell，果不其然，也有报错信息了，但是和前几个cell用的代码都是基本一致的，不知道为什么会报错。现在再多模拟几个cell，找出到底是哪里出了问题。\ncell5是白色cell，包含一个黄色的imageView控件，没有填充图片，约束和cell3保持一致，没有报错。排除了imageView和view不一致的可能性。\ncell6是黄色cell，包含一个imageView控件，填充了图片，其他和cell5保持一致，没有报错。排除了是填充图片的可能性。\ncell7是橘色cell，包含了一个白色的imageView子控件，约束和cell4保持一致，又报错了，看来是约束的问题了。\ncell8是白色cell，包含一个黄色的imageView，左边右边顶部的约束都和cell7一致，高度不一致，没有报错，看来是高度这个约束的问题了。该cell的高度约束是写死的300，cell7高度是通过宽高比例计算出的高度，难道是这个问题？\ncell9是黄色cell，包含一个白色的imageView，除了高度的约束外，其他约束都和cell8保持一致，高度是写死的浮点数300.5，结果报错了，看来高度不能设置成浮点数。试着把之前的约束都换成整数，果真报错都已经不见了！！！好开心啊，哈哈哈哈啊哈哈";
            
            [cell.contentView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@30);
                make.right.equalTo(@-30);
                make.top.equalTo(@30);
            }];
            
            UIView *yellowView = [UIView new];
            yellowView.backgroundColor = [UIColor yellowColor];
            
            [cell.contentView addSubview:yellowView];
            
            [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@30);
                make.right.equalTo(@-30);
                make.top.equalTo(label.mas_bottom).offset(30);
                make.height.equalTo(@50);
                make.bottom.equalTo(@-30);
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"222222"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"222222"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            CGFloat gap = 30;
            CGFloat viewWidth = (YYScreenSize().width - gap*3)/2;
            CGFloat viewHeight = 50;
            for (NSInteger i = 0; i < 4; i++) {
                UIView *yellowView = [UIView new];
                yellowView.backgroundColor = [UIColor yellowColor];
                
                [cell.contentView addSubview:yellowView];
                
                [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(gap + (i%2)*(gap+viewWidth));
                    make.top.mas_equalTo(gap + (i/2)*(gap+viewHeight));
                    make.height.mas_equalTo(viewHeight);
                    make.width.mas_equalTo(viewWidth);
                    if (i == 3) {
                        make.bottom.mas_equalTo(-gap);
                    }
                }];
            }
        }
        return cell;
    }
    
    else if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"333333"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"333333"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor yellowColor];
            
            UIView *whiteView = [UIView new];
            whiteView.backgroundColor = [UIColor whiteColor];
            
            [cell.contentView addSubview:whiteView];
            
            [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(@30);
                make.right.equalTo(@-30);
                make.height.equalTo(@50);
                make.bottom.equalTo(@-30);;
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"444444"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"444444"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor orangeColor];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_home"]];
            
            [cell.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(@0);
//                make.height.mas_equalTo(YYScreenSize().width/750*527);
                make.height.mas_equalTo(ceilf(YYScreenSize().width/750*527));// 设置成整数高度就不会报错，设置成上面的浮点高度就会报错
                make.bottom.equalTo(@-10);
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"555555"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"555555"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = [UIColor yellowColor];
            
            [cell.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(@30);
                make.right.equalTo(@-30);
                make.height.equalTo(@50);
                make.bottom.equalTo(@-30);;
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"666666"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"666666"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor yellowColor];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_home"]];
            imageView.backgroundColor = [UIColor whiteColor];
            
            [cell.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(@30);
                make.right.equalTo(@-30);
                make.height.equalTo(@50);
                make.bottom.equalTo(@-30);;
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 7) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"7777777"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"7777777"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor orangeColor];
            
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = [UIColor whiteColor];
            
            [cell.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(@0);
//                make.height.mas_equalTo(YYScreenSize().width/750*527);
                make.height.mas_equalTo(ceil(YYScreenSize().width/750*527));
                make.bottom.equalTo(@-10);
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"888888"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"888888"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = [UIColor yellowColor];
            
            [cell.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(@0);
                make.height.mas_equalTo(300);
                make.bottom.equalTo(@-10);
            }];
        }
        return cell;
    }
    
    else if (indexPath.row == 9) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"999999"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"999999"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor yellowColor];
            
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(@10);
                make.right.equalTo(@-10);
                make.height.mas_equalTo(ceil(300.5));
                make.bottom.equalTo(@-10);
            }];
        }
        return cell;
    }
     
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了cell");
}

#pragma mark - Lazy load

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

@end
