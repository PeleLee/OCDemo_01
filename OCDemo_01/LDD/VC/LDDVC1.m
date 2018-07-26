//
//  LDDVC1.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/24.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDVC1.h"
#import "LDDCustomDatePickerView.h"
#import "BaseViewController+UNLegal.h"
#import "BaseViewController+Legal.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import "ContentViewController.h"
#import "BezierPathView.h"

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

@interface LDDVC1 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UITextField *tf1;
@property (nonatomic, strong) UITextField *tf2;
@property (nonatomic, strong) UITextField *tf3;
@property (nonatomic, strong) UITextField *tf4;
@property (nonatomic, strong) UITextField *tf5;
@property (nonatomic, strong) UITextField *tf6;
@property (nonatomic, strong) UITextField *tf7;
@property (nonatomic, strong) UITextField *tf8;
@property (nonatomic, strong) UITextField *tf9;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UILabel *label6;
@property (nonatomic, strong) UILabel *label7;
@property (nonatomic, strong) UILabel *label8;
@property (nonatomic, strong) UILabel *label9;
@property (nonatomic, strong) UILabel *label10;
@property (nonatomic, strong) UILabel *label11;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;

@property (nonatomic, strong) NSTimer *YYKitTimer;
@property (nonatomic, strong) NSTimer *traditionTimer;
@property (nonatomic, strong) dispatch_source_t GCDTimer;

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) NSMutableArray *pageContentArray;

@end

@implementation LDDVC1

- (void)dealloc {
    [_YYKitTimer invalidate];
    [_traditionTimer invalidate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.index == 16) {
        [self useOfUICollectionView];
    }
    else if (self.index == 17) {
        [self customDatePickerView];
    }
    else if (self.index == 18) {
        [self strongReferenceOfBlock];
    }
    else if (self.index == 19) {
        [self aboutTimer];
    }
    else if (self.index == 20) {
        [self addPropertyInCategory];
    }
    else if (self.index == 23) {
        [self tableFootView];
    }
    else if (self.index == 25) {
        [self webViewUse];
    }
    else if (self.index == 26) {
        [self wkWebViewUse];
    }
    else if (self.index == 28) {
        [self pageViewController];
    }
    else if (self.index == 30) {
        [self bezierPathView];
    }
}

- (void)bezierPathView {
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGRect navRect = self.navigationController.navigationBar.frame;
//    CGRect tabRect = self.tabBarController.tabBar.frame.size.height;
    BezierPathView *view = [BezierPathView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(statusRect.size.height + navRect.size.height, 0, 0, 0));
    }];
}

- (void)pageViewController {
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMid),
                                  UIPageViewControllerOptionInterPageSpacingKey:@50};
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageVC.doubleSided = YES;
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        
        ContentViewController *initialViewController = [self viewControllerAtIndex:0];
        ContentViewController *initialViewController2 = [self viewControllerAtIndex:1];
        NSArray *viewControllers = [NSArray arrayWithObjects:initialViewController,initialViewController2, nil];
        [_pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
        _pageVC.view.frame = CGRectMake(0, 64, YYScreenSize().width, YYScreenSize().height - 64);
    }
    return _pageVC;
}

- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (self.pageContentArray.count == 0 || index >= self.pageContentArray.count) {
        return nil;
    }
    ContentViewController *vc = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    vc.content = self.pageContentArray[index];
    return vc;
}

- (NSUInteger)indexOfViewController:(ContentViewController *)viewController {
    return [self.pageContentArray indexOfObject:viewController.content];
}

- (NSMutableArray *)pageContentArray {
    if (!_pageContentArray) {
        _pageContentArray = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 10; i++) {
            NSString *contentStr = [[NSString alloc] initWithFormat:@"This is the page %ld of content displayed using UIPageViewController",i];
            [_pageContentArray addObject:contentStr];
        }
    }
    return _pageContentArray;
}

#pragma mark - UIPageViewController Delegate And Datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == self.pageContentArray.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (void)wkWebViewUse {
    [self.view addSubview:self.label1];
    self.label1.text = @"将UIWebView替换为WKWebView后,调用系统相册的时候还是会被MKLeaksFinder监测到内存泄漏...但是内存十分平缓,不会有内存飙升的情况。";
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    /*
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];*/
    WKWebView *webView = [WKWebView new];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(@0);
    }];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://m.baidu.com"]];
    [webView loadRequest:req];
}

- (void)webViewUse {
    [self.view addSubview:self.label1];
    /*https://blog.csdn.net/yeshennet/article/details/52541421*/
    self.label1.text = @"发现的问题是使用UIWebView控件的页面调用系统相册时都会被检测到内存泄漏。同时也能看到内存飙升。查阅了相关方法,在打理方法中设置了相关方法,基本没什么效果...";
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    UIWebView *webView = [UIWebView new];
    webView.delegate = self;
    webView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(@0);
    }];
    /*https://m.baidu.com*/
    //NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"neighbour_shot_rule" ofType:@"html"]]];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://m.baidu.com"]];
    [webView loadRequest:req];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)tableFootView {
    [self.view addSubview:self.label1];
    self.label1.text = @"UITableView的HeaderView(FooterView)在滑动的时候会固定在上方(下方)";
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    UITableView *tableView = [UITableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom);
        make.right.left.bottom.equalTo(@0);
    }];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-->%ld",indexPath.section,indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerOrHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerOrHeaderID"];
    if (!footerOrHeader) {
        footerOrHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerOrHeaderID"];
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 101;
        [footerOrHeader addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(footerOrHeader);
        }];
    }
    UILabel *label = (UILabel *)[footerOrHeader viewWithTag:101];
    label.text = [NSString stringWithFormat:@"header %ld",section];
    return footerOrHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerOrHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerOrHeaderID"];
    if (!footerOrHeader) {
        footerOrHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerOrHeaderID"];
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 101;
        [footerOrHeader addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(footerOrHeader);
        }];
    }
    UILabel *label = (UILabel *)[footerOrHeader viewWithTag:101];
    label.text = [NSString stringWithFormat:@"footer %ld",section];
    return footerOrHeader;
}

#pragma mark -
- (void)addPropertyInCategory {
    // 参考文章 https://www.jianshu.com/p/9e827a1708c6
    
    [self.view addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@85);
        make.right.equalTo(@-20);
    }];
    
    self.label1.text = @"在分类中添加的成员变量只能在导入分类的头文件的情况下使用。所以如果不导入BaseViewController+UNLegal头文件，BaseViewController对象是读取不到BaseViewController+UNLegal分类中定义的成员变量的。";
    
    [self.view addSubview:self.label2];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.label1);
        make.top.equalTo(self.label1.mas_bottom).offset(10);
    }];
    
    self.label2.text = @"BaseViewController+UNLegal分类中只声名了成员变量，直接使用的话是会Crash掉的，代码已注释，可以打开注释试一下。";
    /*
    BaseViewController *vc0 = [BaseViewController new];
    vc0.unLegalPropertyStr = @"不能直接使用";
    */
    
    [self.view addSubview:self.label3];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.label2);
        make.top.equalTo(self.label2.mas_bottom).offset(10);
    }];
    
    self.label3.text = @"使用runtime给分类的成员属性添加get和set方法后就可以正常使用了。";
    
    BaseViewController *vc1 = [BaseViewController new];
    vc1.legalPropertyStr = @"可以使用。";
    NSLog(@"get方法:%@",vc1.legalPropertyStr);
}

/**
 定时器相关
 */
- (void)aboutTimer {
    __weak typeof(self) weakSelf = self;
    
    // YYKit
    [self.view addSubview:self.button1];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(85);
    }];
    [self.button1 setTitle:@"☞☞☞YYKit分类 NSTimer" forState:UIControlStateNormal];
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.button1 setTitle:@"2.5s(执行两次)后返回上个界面" forState:UIControlStateNormal];
        [weakSelf.button1 setEnabled:NO];
        weakSelf.YYKitTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            NSLog(@"YYKit Timer执行");
        } repeats:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }];
    
    [self.view addSubview:self.label1];
    self.label1.text = @"在dealloc中调用invalidate方法就不会产生内存泄漏";
    self.label1.numberOfLines = 0;
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.equalTo(self.button1.mas_bottom).offset(5);
    }];
    
    //Tradition
    [self.view addSubview:self.button2];
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(self.label1.mas_bottom).offset(10);
    }];
    [self.button2 setTitle:@"☞☞☞传统Timer" forState:UIControlStateNormal];
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        /*
        weakSelf.traditionTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(traditionTimerSelector) userInfo:nil repeats:YES];
        [weakSelf.navigationController popViewControllerAnimated:YES];*/
    }];
    
    [self.view addSubview:self.label2];
    self.label2.text = @"即使target使用weakSelf，也会产生内存泄漏，不会调用dealloc方法。错误代码已注释，查看可打开注释。";
    self.label2.numberOfLines = 0;
    self.label2.textColor = [UIColor redColor];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.equalTo(self.button2.mas_bottom).offset(5);
    }];
    
    // GCD
    [self.view addSubview:self.button3];
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(self.label2.mas_bottom).offset(10);
    }];
    [self.button3 setTitle:@"☞☞☞GCD Timer" forState:UIControlStateNormal];
    [[self.button3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.button3 setTitle:@"2.5s(执行几次)后返回上一界面" forState:UIControlStateNormal];
        [weakSelf.button3 setEnabled:NO];
        //几秒后退出页面
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
        // 创建Timer
        NSTimeInterval period = 1.0;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        weakSelf.GCDTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(weakSelf.GCDTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(weakSelf.GCDTimer, ^{
            NSLog(@"GCD Timer 执行");
        });
        dispatch_resume(weakSelf.GCDTimer);
    }];
    
    [self.view addSubview:self.label3];
    self.label3.text = @"精度更高且不存在内存泄漏的问题";
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.equalTo(self.button3.mas_bottom).offset(5);
    }];
}

- (void)traditionTimerSelector {
    NSLog(@"传统Timer执行");
}

- (void)strongReferenceOfBlock {
    
    [self.view addSubview:self.label1];
    self.label1.text = @"YES代表会强引用，NO代表不会强引用，现在的代码全都是正确的代码，不会造成内存泄漏，可打开对应代码看效果。";
    self.label1.numberOfLines = 0;
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@84);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.button1];
    [self.button1 setTitle:@"成员变量使用RAC Block --> YES" forState:UIControlStateNormal];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom);
        make.left.equalTo(@40);
    }];
    
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 会强引用 运行回报内存泄漏，
        // 需要看其他代码的运行效果需要重新编译，要不其他不会引起内存泄漏的代码也会报错
//        [self.navigationController popViewControllerAnimated:YES];
        // 要使用weakSelf
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.view addSubview:self.button2];
    [self.button2 setTitle:@"Masonry Block --> NO" forState:UIControlStateNormal];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button1.mas_bottom);
        make.left.equalTo(self.button1);
    }];
    
    [self.view addSubview:self.label2];
    self.label2.text = @"test";
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        // 这两行不会强引用 不需要使用weakSelf
        make.left.equalTo(self.button2);
        make.top.equalTo(self.button2.mas_bottom);
    }];
    
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.view addSubview:self.button3];
    [self.button3 setTitle:@"UIView动画 Block 涉及Masonry --> NO" forState:UIControlStateNormal];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button2);
        make.top.equalTo(self.label2.mas_bottom);
    }];
    
    [self.button3 addTarget:self action:@selector(animationBlock) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.label3];
    self.label3.text = @"例子中写到的动画是用Masonry的remake方法来改变位置,起初是用的update方法来改变位置,发现达不到想要的效果,并且还会报内存泄漏。";
    self.label3.numberOfLines = 0;
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.top.equalTo(self.button3.mas_bottom);
    }];
    
    [self.view addSubview:self.button4];
    [self.button4 setTitle:@"RAC中执行动画 Block --> YES" forState:UIControlStateNormal];

    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button3);
        make.top.equalTo(self.label3.mas_bottom);
    }];
    [[self.button4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //会报错 需要使用weakSelf
         /*
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.button4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.label3);
                make.top.equalTo(self.view.mas_bottom).offset(-50);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:YES];
        }];*/
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [weakSelf.button4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.label3);
                make.top.equalTo(weakSelf.view.mas_bottom).offset(-50);
            }];
            [weakSelf.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"非成员变量使用RAC --> YES" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button4);
        make.top.equalTo(self.button4.mas_bottom);
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 会产生强引用，需要使用weakSelf
        /*
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.button4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom).offset(-100);
                make.left.equalTo(@40);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:YES];
        }];*/
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [weakSelf.button4 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.view.mas_bottom).offset(-100);
                make.left.equalTo(@40);
            }];
            [weakSelf.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)animationBlock {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3f initialSpringVelocity:3.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 涉及masonry的动画要使用remake 而不能使用update
        /*
        [self.button3 mas_updateConstraints:^(MASConstraintMaker *make) {
            // 这里使用self会报错,需要使用weakSelf
            make.top.equalTo(weakSelf.view.mas_bottom).offset(-50);
        }];
        */
        [self.button3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-50);
            make.left.equalTo(@40);
        }];
        // 需要self.view 调用layoutIfNeeded方法才会有动画效果
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)customDatePickerView {
    [self.view addSubview:self.label7];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label4];
    [self.view addSubview:self.label5];
    [self.view addSubview:self.label6];
    [self.view addSubview:self.label8];
    [self.view addSubview:self.label9];
    [self.view addSubview:self.label10];
    
    [self.view addSubview:self.tf1];
    [self.view addSubview:self.tf2];
    [self.view addSubview:self.tf3];
    [self.view addSubview:self.tf4];
    [self.view addSubview:self.tf5];
    [self.view addSubview:self.tf6];
    [self.view addSubview:self.tf7];
    [self.view addSubview:self.tf8];
    [self.view addSubview:self.tf9];
    
    __weak typeof(self) weakSelf = self;
    
    _label7.numberOfLines = 0;
    _label7.text = @"输入日期必须合法，否则不能正常计算。\n默认日期需介于开始日期和结束日期之间。\n不输入则显示当前日期往前100年的日期。";
    [_label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(@100);
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.label7.mas_bottom).offset(35);
    }];
    _label1.text = @"开始   年:";
    
    [_tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label1.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.label1);
        make.width.equalTo(@70);
    }];
    _tf1.keyboardType = UIKeyboardTypeNumberPad;
    _tf1.tag = 171;
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tf1.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.tf1);
    }];
    _label2.text = @"月:";
    
    [_tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label2.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.label2);
        make.width.equalTo(@35);
    }];
    _tf2.keyboardType = UIKeyboardTypeNumberPad;
    _tf2.tag = 172;
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tf2.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.tf2);
    }];
    _label3.text = @"日";
    
    [_tf3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label3.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.label3);
        make.width.equalTo(@35);
    }];
    _tf3.keyboardType = UIKeyboardTypeNumberPad;
    _tf3.tag = 173;
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(weakSelf.label1.mas_bottom).offset(35);
    }];
    _label4.text = @"结束   年:";
    
    [_tf4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label4.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.label4);
        make.width.equalTo(@70);
    }];
    _tf4.keyboardType = UIKeyboardTypeNumberPad;
    _tf4.tag = 174;
    
    [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tf4.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.tf4);
    }];
    _label5.text = @"月:";
    
    [_tf5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label5.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.label5);
        make.width.equalTo(@35);
    }];
    _tf5.keyboardType = UIKeyboardTypeNumberPad;
    _tf5.tag = 175;
    
    [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tf5.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.tf5);
    }];
    _label6.text = @"日";
    
    [_tf6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.label6.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.label6);
        make.width.equalTo(@35);
    }];
    _tf6.keyboardType = UIKeyboardTypeNumberPad;
    _tf6.tag = 176;
    
    [_label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label4);
        make.top.equalTo(self.label4.mas_bottom).offset(35);
    }];
    _label8.text = @"默认   年:";
    
    [_tf7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label8.mas_right).offset(10);
        make.centerY.equalTo(self.label8);
        make.width.equalTo(@70);
    }];
    _tf7.keyboardType = UIKeyboardTypeNumberPad;
    _tf7.tag = 177;
    
    [_label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label5);
        make.top.equalTo(self.label5.mas_bottom).offset(35);
    }];
    _label9.text = @"月:";
    
    [_tf8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label9.mas_right).offset(10);
        make.centerY.equalTo(self.label9);
        make.width.equalTo(@35);
    }];
    _tf8.keyboardType = UIKeyboardTypeNumberPad;
    _tf8.tag = 178;
    
    [_label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tf8.mas_right).offset(20);
        make.top.equalTo(self.label6.mas_bottom).offset(35);
    }];
    _label10.text = @"日";
    
    [_tf9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label10.mas_right).offset(10);
        make.centerY.equalTo(self.label10);
        make.width.equalTo(@35);
    }];
    _tf9.keyboardType = UIKeyboardTypeNumberPad;
    _tf9.tag = 179;
    
    [self.view addSubview:self.button1];
    
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tf7.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
    }];
    [_button1 setTitle:@"确定" forState:UIControlStateNormal];
    [[_button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.view resignFirstResponder];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        
        NSString *beginDateStr = [NSString stringWithFormat:@"%04ld%02ld%02ld",weakSelf.tf1.text.integerValue,weakSelf.tf2.text.integerValue,weakSelf.tf3.text.integerValue];
        NSDate *beginDate =  [formatter dateFromString:beginDateStr];
        NSString *endDateStr = [NSString stringWithFormat:@"%04ld%02ld%02ld",weakSelf.tf4.text.integerValue,weakSelf.tf5.text.integerValue,weakSelf.tf6.text.integerValue];
        NSDate *endDate = [formatter dateFromString:endDateStr];
        NSString *defaultDateStr = [NSString stringWithFormat:@"%04ld%02ld%02ld",weakSelf.tf7.text.integerValue,weakSelf.tf8.text.integerValue,weakSelf.tf9.text.integerValue];
        NSDate *defaultDate = [formatter dateFromString:defaultDateStr];
        
        LDDCustomDatePickerView *datePicker = [[LDDCustomDatePickerView alloc] initWithBeginDate:beginDate endDate:endDate defaultDate:defaultDate];
        datePicker.selectedDateBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
            weakSelf.label11.text = [NSString stringWithFormat:@"选择的日期:%ld年%ld月%ld日",year,month,day];
        };
        [datePicker showView];
    }];
    
    [self.view addSubview:self.label11];
    self.label11.textColor = [UIColor redColor];
    [self.label11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1);
        make.top.equalTo(self.button1.mas_bottom).offset(35);
    }];
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

#pragma mark - collectionView代理方法

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
    
    UILabel *label = (UILabel *)[headerView viewWithTag:1600];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:headerView.bounds];
        label.text = @"头部";
        label.font = [UIFont systemFontOfSize:15];
        label.tag = 1600;
        [headerView addSubview:label];
    }
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击");
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tobeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (tobeString.length == 0) {
        return YES;
    }
    
    if (textField.tag == 171 || textField.tag == 174 || textField.tag == 177) {
        if (tobeString.integerValue < 1 || tobeString.integerValue > 3000) {
            return NO;
        }
    }
    if (textField.tag == 172 || textField.tag == 175 || textField.tag == 178) {
        if (tobeString.integerValue < 1 || tobeString.integerValue > 12) {
            return NO;
        }
    }
    if (textField.tag == 173 || textField.tag == 176 || textField.tag == 179) {
        if (tobeString.integerValue < 1 || tobeString.integerValue > 31) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - lazy
- (UITextField *)tf1 {
    if (!_tf1) {
        _tf1 = [UITextField new];
        _tf1.borderStyle = UITextBorderStyleRoundedRect;
        _tf1.font = [UIFont systemFontOfSize:13];
        _tf1.delegate = self;
    }
    return _tf1;
}

- (UITextField *)tf2 {
    if (!_tf2) {
        _tf2 = [UITextField new];
        _tf2.borderStyle = UITextBorderStyleRoundedRect;
        _tf2.font = [UIFont systemFontOfSize:13];
        _tf2.delegate = self;
    }
    return _tf2;
}

- (UITextField *)tf3 {
    if (!_tf3) {
        _tf3 = [UITextField new];
        _tf3.borderStyle = UITextBorderStyleRoundedRect;
        _tf3.font = [UIFont systemFontOfSize:13];
        _tf3.delegate = self;
    }
    return _tf3;
}

- (UITextField *)tf4 {
    if (!_tf4) {
        _tf4 = [UITextField new];
        _tf4.borderStyle = UITextBorderStyleRoundedRect;
        _tf4.font = [UIFont systemFontOfSize:13];
        _tf4.delegate = self;
    }
    return _tf4;
}

- (UITextField *)tf5 {
    if (!_tf5) {
        _tf5 = [UITextField new];
        _tf5.borderStyle = UITextBorderStyleRoundedRect;
        _tf5.font = [UIFont systemFontOfSize:13];
        _tf5.delegate = self;
    }
    return _tf5;
}

- (UITextField *)tf6 {
    if (!_tf6) {
        _tf6 = [UITextField new];
        _tf6.borderStyle = UITextBorderStyleRoundedRect;
        _tf6.font = [UIFont systemFontOfSize:13];
        _tf6.delegate = self;
    }
    return _tf6;
}

- (UITextField *)tf7 {
    if (!_tf7) {
        _tf7 = [UITextField new];
        _tf7.borderStyle = UITextBorderStyleRoundedRect;
        _tf7.font = [UIFont systemFontOfSize:13];
        _tf7.delegate = self;
    }
    return _tf7;
}

- (UITextField *)tf8 {
    if (!_tf8) {
        _tf8 = [UITextField new];
        _tf8.borderStyle = UITextBorderStyleRoundedRect;
        _tf8.font = [UIFont systemFontOfSize:13];
        _tf8.delegate = self;
    }
    return _tf8;
}

- (UITextField *)tf9 {
    if (!_tf9) {
        _tf9 = [UITextField new];
        _tf9.borderStyle = UITextBorderStyleRoundedRect;
        _tf9.font = [UIFont systemFontOfSize:13];
        _tf9.delegate = self;
    }
    return _tf9;
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

- (UILabel *)label4 {
    if (!_label4) {
        _label4 = [UILabel new];
        _label4.font = [UIFont systemFontOfSize:13];
        _label4.textColor = [UIColor blackColor];
        _label4.numberOfLines = 0;
    }
    return _label4;
}

- (UILabel *)label5 {
    if (!_label5) {
        _label5 = [UILabel new];
        _label5.font = [UIFont systemFontOfSize:13];
        _label5.textColor = [UIColor blackColor];
        _label5.numberOfLines = 0;
    }
    return _label5;
}

- (UILabel *)label6 {
    if (!_label6) {
        _label6 = [UILabel new];
        _label6.font = [UIFont systemFontOfSize:13];
        _label6.textColor = [UIColor blackColor];
        _label6.numberOfLines = 0;
    }
    return _label6;
}

- (UILabel *)label7 {
    if (!_label7) {
        _label7 = [UILabel new];
        _label7.font = [UIFont systemFontOfSize:13];
        _label7.textColor = [UIColor blackColor];
        _label7.numberOfLines = 0;
    }
    return _label7;
}

- (UILabel *)label8 {
    if (!_label8) {
        _label8 = [UILabel new];
        _label8.font = [UIFont systemFontOfSize:13];
        _label8.textColor = [UIColor blackColor];
        _label8.numberOfLines = 0;
    }
    return _label8;
}

- (UILabel *)label9 {
    if (!_label9) {
        _label9 = [UILabel new];
        _label9.font = [UIFont systemFontOfSize:13];
        _label9.textColor = [UIColor blackColor];
        _label9.numberOfLines = 0;
    }
    return _label9;
}

- (UILabel *)label10 {
    if (!_label10) {
        _label10 = [UILabel new];
        _label10.font = [UIFont systemFontOfSize:13];
        _label10.textColor = [UIColor blackColor];
        _label10.numberOfLines = 0;
    }
    return _label10;
}

- (UILabel *)label11 {
    if (!_label11) {
        _label11 = [UILabel new];
        _label11.font = [UIFont systemFontOfSize:13];
        _label11.textColor = [UIColor blackColor];
        _label11.numberOfLines = 0;
    }
    return _label11;
}

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

- (UIButton *)button3 {
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button3.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _button3;
}

- (UIButton *)button4 {
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button4.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _button4;
}

@end
