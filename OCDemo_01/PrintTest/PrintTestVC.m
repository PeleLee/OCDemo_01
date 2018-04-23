//
//  PrintTestVC.m
//  OCDemo_01
//
//  Created by liqunfei on 2018/4/23.
//  Copyright © 2018年 My. All rights reserved.
//

#import "PrintTestVC.h"

@interface PrintTestVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTV;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *methodsNames;

@end

@implementation PrintTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Print Test";
    self.titles = [NSMutableArray arrayWithCapacity:0];
    self.methodsNames = [NSMutableArray arrayWithCapacity:0];
    [self addCell:@"定义宏时不加括号的影响" method:@"effectOfParenthesesOnMacros"];
    
    self.myTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 - 10) style:UITableViewStylePlain];
    _myTV.delegate = self;
    _myTV.dataSource = self;
    [self.view addSubview:_myTV];
}

- (void)addCell:(NSString *)title method:(NSString *)methodName {
    [self.titles addObject:title];
    [self.methodsNames addObject:methodName];
}

#pragma mark - Methods
/**
 敲代码过程中发现定义宏不加括号,然后在另一个宏里调用这个宏的话,获得
 的结果和自己的预期不一样,所以做这个测试。
 */
- (void)effectOfParenthesesOnMacros {
#define macro1 1 > 2 ? 5 : 10    //10
#define macro2 (1 > 2 ? 5 : 10)  //10
    
    /*宏里实现值的相加,之前的想法:macro1的值已经确定,这个值'10'分别和
     '1'与'2'相加,结果应该是'11'和'12',然而打印结果并非如此。
     推测macro3、macro4借用的是macro1的整体而不是值:
     macro3 = 1 + 1 > 2 ? 5 : 10
     macro4 = 2 + 1 > 2 ? 5 : 10
     */
    
#define macro3 1 + macro1
#define macro4 2 + macro1
    
    /*macro2加上括号之后符合预期结果*/
#define macro5 1 + macro2
#define macro6 2 + macro2
    
    NSLog(@"macro1:%d",macro1);
    NSLog(@"macro2:%d",macro2);
    NSLog(@"macro3:%d",macro3);
    NSLog(@"macro4:%d",macro4);
    NSLog(@"macro5:%d",macro5);
    NSLog(@"macro6:%d",macro6);
}


#pragma mark - UITableView About
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *methodName = _methodsNames[indexPath.row];
    SEL selector = NSSelectorFromString(methodName);
    if (selector) {
        [self performSelector:selector withObject:nil afterDelay:0];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
