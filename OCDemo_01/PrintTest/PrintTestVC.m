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
    [self addCell:@"调用方法:SEL、NSInvocation" method:@"severalWaysToCallMethods"];
    [self addCell:@"test" method:@"test"];
    
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

- (void)test {
    NSMutableArray *listA = [NSMutableArray arrayWithObjects:@"a", @"b", @"c", @"d",nil];
    NSMutableArray *listB = [listA mutableCopy];
    NSLog(@"listB:%@",listB);
    
    for (NSInteger i = listA.count - 1; i >= 0; i--) {
        [listB addObject:listA[i]];
    }
    NSLog(@"listB:%@",listB);
}

/**
 调用方法的几种方式
 https://www.jianshu.com/p/e24b3420f1b4
 */
- (void)severalWaysToCallMethods {
    NSString *str1 = @"My heart";
    NSString *str2 = @"will";
    NSString *str3 = @"go on.";
    
    // 传统方法无法满足通过字符串来调用函数
    NSLog(@"传统方法:%@",[self appendString:str1 withStr2:str2 andStr3:str3]);
    
    // performSelector
    /*方法1、2不能满足多个参数的要求*/
    // 方法1 只能传两个参数
    NSLog(@"performSelector直接调用:%@",[self performSelector:@selector(appendString:withStr2:andStr3:) withObject:str1 withObject:str2]);
    
    NSString *methodStr = @"appendString:withStr2:andStr3:";
    SEL selector = NSSelectorFromString(methodStr);
    
    // 方法2 只能传两个参数 会产生警告
    id str = [self performSelector:selector withObject:str1 withObject:str2];
    if (str) {
        NSLog(@"performSelector通过字符串调用(有warning):%@",(NSString *)str);
    }
    
    // 方法3 可传多个参数 不会产生警告
    // 来源: https://www.jianshu.com/p/6517ab655be7
    IMP imp = [self methodForSelector:selector];
    NSString *(*func)(id, SEL, NSString *, NSString *, NSString *) = (void *)imp;
    NSString *result = func(self, selector, str1, str2, str3);
    NSLog(@"performSelector通过字符串调用(无warning):%@",result);
    
    //NSInvocation使用
    //1.创建方法签名 signature:签名
    // 签名--对象方法
    NSMethodSignature *signature1 = [self methodSignatureForSelector:selector];
    // 签名--类方法
    //NSMethodSignature *signature2 = [[self class] instanceMethodSignatureForSelector:selector];
    
    //2.创建NSInvocation对象 invocation:调用
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature1];
    
    //3.给NSInvocation对象赋值
    invocation.target = self;
    invocation.selector = selector;
    
    //4.设置参数 下标从2开始,0、1已经被target与selector占用
    [invocation setArgument:&str1 atIndex:2];
    [invocation setArgument:&str2 atIndex:3];
    [invocation setArgument:&str3 atIndex:4];
    
    if (signature1.methodReturnLength > 0) {
        id result = nil;
        [invocation getReturnValue:&result];
        if (result) {
            // 不会调用
            NSLog(@"NSInvocation调用:%@",result);
        }
    }
    
    [invocation invoke];
    
    if (signature1.methodReturnLength > 0) {
        // 需要添加__weak，不然对象类型的返回值会崩溃，原理未知
        __weak id result = nil;
        [invocation getReturnValue:&result];
        if (result) {
            NSLog(@"NSInvocation调用:%@",result);
        }
    }
}

- (NSString *)appendString:(NSString *)str1
                  withStr2:(NSString *)str2
                   andStr3:(NSString *)str3 {
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
    return str;
}

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
