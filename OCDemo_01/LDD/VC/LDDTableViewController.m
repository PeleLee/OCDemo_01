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
#import "IQKeyboardVC.h"
#import "LDDVC1.h"
#import "LDDHJTableViewController.h"
#import "LDDTabBarViewController.h"
#import "ScrollViewInXibVC.h"
#import "LDDPageViewController.h"
#import "LDDVC2.h"
#import "AdaptiveHeightCellVC.h"
#import "IGListDemoVC.h"
#import "NLPageViewController.h"
#import "LDDVC3.h"

@interface LDDTableViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
    //0
    [self addCell:@"IQKeyboardManager" class:@"IQKeyboardVC"];
    //1
    [self addCell:@"通知:点击使Appdelegate发通知" class:@"1"];
    //2
    [self addCell:@"通知:模拟通知造成的内存泄漏" class:@"2"];
    //3
    [self addCell:@"通知:再次发送通知" class:@"3"];
    //4
    [self addCell:@"全屏侧滑返回" class:@"4"];
    //5
    [self addCell:@"几种按钮" class:@"IQKeyboardVC"];
    //6
    [self addCell:@"Masonary:约束条件先后顺序影响" class:@"IQKeyboardVC"];
    //7
    [self addCell:@"Masonary:并列的view通过间隔计算宽度" class:@"IQKeyboardVC"];
    //8
    [self addCell:@"Masonary:Label的一些自适应" class:@"IQKeyboardVC"];
    //9
    [self addCell:@"RAC:RAC宏" class:@"IQKeyboardVC"];
    //10
    [self addCell:@"RAC:RACSignal对象调subscribeNext方法" class:@"IQKeyboardVC"];
    //11
    [self addCell:@"RAC:RACSubject" class:@"11"];
    //12
    [self addCell:@"RAC:RACCommand" class:@"12"];
    //13
    [self addCell:@"RAC:RACCommand与RACSubject套用" class:@"IQKeyboardVC"];
    //14
    [self addCell:@"UIDatePicker" class:@"IQKeyboardVC"];
    //15
    [self addCell:@"PGDatePicker" class:@"IQKeyboardVC"];
    //16
    [self addCell:@"UICollectionView" class:@"LDDVC1"];
    //17
    [self addCell:@"自定义日期选择器" class:@"LDDVC1"];
    //18
    [self addCell:@"Block强引用(使用MLeaksFinder判断)" class:@"LDDVC1"];
    //19
    [self addCell:@"定时器相关Timer" class:@"LDDVC1"];
    //20
    [self addCell:@"分类(Category):添加成员变量" class:@"LDDVC1"];
    //21
    [self addCell:@"HJTabViewController:基本使用" class:@"21"];
    //22
    [self addCell:@"HJTabViewController:配合TabBarController" class:@"22"];
    //23
    [self addCell:@"UITableView: tableFooterView" class:@"LDDVC1"];
    //24
    [self addCell:@"TabBarController对TableView的影响" class:@"24"];
    //25
    [self addCell:@"UIWebView:调用相册内存泄漏" class:@"LDDVC1"];
    //26
    [self addCell:@"WKWebView" class:@"LDDVC1"];
    //27
    [self addCell:@"Xib-UIScrollView" class:@"27"];
    //28
    [self addCell:@"UIPageViewController" class:@"LDDVC1"];
    //29
    [self addCell:@"WKPageController" class:@"29"];
    //30
    [self addCell:@"UIBezierPath" class:@"LDDVC1"];
    //31
    [self addCell:@"IDFV+keychain" class:@"LDDVC1"];
    //32
    [self addCell:@"自定义AlertController" class:@"LDDVC2"];
    //33
    [self addCell:@"UIAlertControll是否重叠" class:@"LDDVC2"];
    //34
    [self addCell:@"Masonry:先布局子视图后布局父视图" class:@"LDDVC2"];
    //35
    [self addCell:@"UITableView Cell高度自适应" class:@"LDDVC2"];
    //36
    [self addCell:@"UIPageControll" class:@"LDDVC2"];
    //37
    [self addCell:@"Xib-根据内容视图确定背景图大小" class:@"LDDVC2"];
    //38
    [self addCell:@"UICollectionView" class:@"LDDVC2"];
    //39
    [self addCell:@"相机:UIImagePickerController" class:@"39"];
    //40
    [self addCell:@"相册:UIImagePickerController" class:@"40"];
    //41
    [self addCell:@"键盘类型切换" class:@"LDDVC2"];
    //42
    [self addCell:@"自定义相机" class:@"LDDVC2"];
    //43
    [self addCell:@"系统控件内边距测试" class:@"LDDVC2"];
    //44
    [self addCell:@"cell自适应高度" class:@"AdaptiveHeightCellVC"];
    //45
    [self addCell:@"Masonry约束冲突" class:@"LDDVC2"];
    //46
    [self addCell:@"IGListKitDemo" class:@"IGListDemoVC"];
    //47
    [self addCell:@"加载动画_向辉" class:@"LDDVC2"];
    //48
    [self addCell:@"NSDate" class:@"LDDVC2"];
    //49
    [self addCell:@"UIViewController present ed/ting ViewController" class:@"LDDVC2"];
    //50
    [self addCell:@"SVProgressHUD 显示进度" class:@"LDDVC2"];
    //51
    [self addCell:@"HuggingPriority和CompressionResistance" class:@"LDDVC2"];
    //52
    [self addCell:@"纯自定义PageVC" class:@"LDDVC3"];
    //53
    [self addCell:@"GCD面试相关" class:@"LDDVC3"];
    // 54
    [self addCell:@"超出父视图的Button响应" class:@"LDDVC3"];
    // 55
    [self addCell:@"Masonry:按比例布局" class:@"LDDVC3"];
    // 56
    [self addCell:@"masonry--简单demo" class:@"LDDVC3"];
    // 57
    [self addCell:@"nil条件" class:@"LDDVC3"];
    // 58
    [self addCell:@"Button Image" class:@"LDDVC3"];
    // 59
    [self addCell:@"直接使用masonry remake" class:@"LDDVC3"];
    // 60
    [self addCell:@"多层@strongify" class:@"LDDVC3"];
    
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
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld> %@",indexPath.row,self.titles[indexPath.row]];
//    NSLog(@"cell tag:%ld",cell.tag);
    
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
    else {
        if ([className isEqualToString:@"1"]) {
            [k_Appdelegate postNotification];
        }
        else if ([className isEqualToString:@"2"]) {
            NotificationVC *vc1 = [[NotificationVC alloc] init];
            vc1.isRemoveNotification = YES;
            [vc1 addLeakObserver];
            
            NotificationVC *vc2 = [[NotificationVC alloc] init];
            [vc2 postNotification];
        }
        else if ([className isEqualToString:@"3"]) {
            NotificationVC *vc2 = [[NotificationVC alloc] init];
            [vc2 postNotification];
        }
        else if ([className isEqualToString:@"11"]) {
            IQKeyboardVC *vc = [IQKeyboardVC new];
            vc.index = indexPath.row;
            
            // RACSubject既可以发送信号，也可以订阅信号
            // 此处为订阅信号
            [vc.subject subscribeNext:^(id  _Nullable x) {
                weakSelf.titles[indexPath.row] = [NSString stringWithFormat:@"RACSubject接收到----->%@",x];
                [weakSelf.tableView reloadData];
            }];
            
            vc.sendMessageBlock = ^(NSString *message) {
                weakSelf.titles[indexPath.row] = [NSString stringWithFormat:@"Block接收到----->%@",message];
                [weakSelf.tableView reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"12"]) {
            IQKeyboardVC *vc = [IQKeyboardVC new];
            vc.index = indexPath.row;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"21"]) {
            LDDHJTableViewController *vc = [LDDHJTableViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"22"]) {
            LDDTabBarViewController *vc = [LDDTabBarViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"24"]) {
            LDDTabBarViewController *vc = [LDDTabBarViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"27"]) {
            ScrollViewInXibVC *vc = [[ScrollViewInXibVC alloc] initWithNibName:@"ScrollViewInXibVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"29"]) {
            LDDPageViewController *vc = [[LDDPageViewController alloc] init];
            vc.menuViewStyle = WMMenuViewStyleLine;
//            vc.showOnNavigationBar = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"39"]) {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:NO];
            [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
        }
        else if ([className isEqualToString:@"40"]) {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:NO];
            [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
        }
        else if ([className isEqualToString:@"52"]) {
            NLPageViewController *vc = [NLPageViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
