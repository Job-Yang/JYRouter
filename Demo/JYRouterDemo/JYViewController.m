//
//  JYViewController.m
//  JYRouterDemo
//
//  Created by 杨权 on 2016/12/13.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYViewController.h"
#import "JYRouter.h"

#define kSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define kSCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

@interface JYViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation JYViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self showParameter];
    [self.view addSubview:self.tableView];
}

#pragma mark - setup methods
- (void)setNavigation {
    self.navigationItem.title = @"JYRouter";
    CGFloat red   = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    CGFloat bule  = arc4random() % 255;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:red/255 green:green/255 blue:bule/255 alpha:1];
}

- (void)showParameter {
    NSLog(@"-----------------------------------------------");
    NSLog(@"⭕️parameterString     = %@",self.parameterString);
    NSLog(@"⭕️parameterNumber     = %@",self.parameterNumber);
    NSLog(@"⭕️parameterDictionary = %@",self.parameterDictionary);
    NSLog(@"-----------------------------------------------\n\n");

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList[section][@"list"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataList[section][@"group"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    NSString *title = self.dataList[indexPath.section][@"list"][indexPath.row][@"title"];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *action = self.dataList[indexPath.section][@"list"][indexPath.row][@"action"];
    SEL sel = NSSelectorFromString(action);
    if (sel && [self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, sel, nil);
    }
}

#pragma mark - event & response

// ---------------------- Push ----------------------
/**
 Push跳转
 */
- (void)push1 {
    [[JYRouter router] push:@"JYViewController"];
}

/**
 Push跳转,附带参数
 */
- (void)push2 {
    NSDictionary *params = @{
                             @"parameterString" : @"我是一个字符串-Push",
                             @"parameterNumber" : @(123456789),
                             @"parameterDictionary" : @{
                                                         @"key1": @"Value1-Push",
                                                         @"key2": @"Value2-Push",
                                                         },
                             };
    [[JYRouter router] push:@"JYViewController" animated:YES params:params];
}

/**
 Push跳转,附带参数,完成回调
 */
- (void)push3 {
    NSDictionary *params = @{
                             @"parameterString" : @"我是一个字符串-Push",
                             @"parameterNumber" : @(123456789),
                             @"parameterDictionary" : @{
                                                         @"key1": @"Value1-Push",
                                                         @"key2": @"Value2-Push",
                                                         },
                             };
    [[JYRouter router] push:@"JYViewController" animated:YES params:params completion:^{
        NSLog(@"🔥🔥🔥Push完成回调🔥🔥🔥");
    }];
}

// ---------------------- Pop ----------------------
/**
 Pop到上级
 */
- (void)pop1 {
    [[JYRouter router] pop];
}

/**
 Pop到根控制器
 */
- (void)pop2 {
    [[JYRouter router] popToRoot];
}

/**
 Pop到根控制器,完成回调
 */
- (void)pop3 {
    [[JYRouter router] popToRoot:YES completion:^{
        NSLog(@"🔥🔥🔥Pop完成回调🔥🔥🔥");
    }];
}

/**
 Pop到指定控制器
 */
- (void)pop4 {
    [[JYRouter router] popTo:@"JYViewController"];
}

/**
 Pop到指定控制器,完成回调
 */
- (void)pop5 {
    [[JYRouter router] popTo:@"JYViewController" animated:YES completion:^{
        NSLog(@"🔥🔥🔥Pop完成回调🔥🔥🔥");
    }];
}

// ---------------------- Present ----------------------
/**
 present跳转
 */
- (void)present1 {
    [[JYRouter router] present:@"JYViewController"];
}

/**
 Present跳转,附带参数
 */
- (void)present2 {
    NSDictionary *params = @{
                             @"parameterString" : @"我是一个字符串-Present",
                             @"parameterNumber" : @(123456789),
                             @"parameterDictionary" : @{
                                                         @"key1": @"Value1-Present",
                                                         @"key2": @"Value2-Present",
                                                         },
                             };
    [[JYRouter router] present:@"JYViewController" animated:YES params:params];
}

/**
 Present跳转,附带参数,完成回调
 */
- (void)present3 {
    NSDictionary *params = @{
                             @"parameterString" : @"我是一个字符串-Present",
                             @"parameterNumber" : @(123456789),
                             @"parameterDictionary" : @{
                                                         @"key1": @"Value1-Present",
                                                         @"key2": @"Value2-Present",
                                                         },
                             };
    [[JYRouter router] present:@"JYViewController" animated:YES params:params completion:^{
        NSLog(@"🔥🔥🔥Pop完成回调🔥🔥🔥");
    }];
}

// ---------------------- Dismiss ----------------------
/**
 Dismiss
 */
- (void)dismiss1 {
    [[JYRouter router] dismiss];
}

/**
 Dismiss,完成回调
 */
- (void)dismiss2 {
    [[JYRouter router] dismiss:YES completion:^{
        NSLog(@"🔥🔥🔥Dismiss完成回调🔥🔥🔥");
    }];
}


#pragma mark - getter & setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)
                                                  style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataList {
    if (!_dataList) {
        //配置数据
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dataList" ofType:@"json"];
        NSData *data   = [[NSData alloc] initWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
        _dataList = array;
    }
    return _dataList;
}

@end
