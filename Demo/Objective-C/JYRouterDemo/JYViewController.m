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
    NSString *title = self.dataList[indexPath.section][@"list"][indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self routerAtIndexPath:indexPath];
}

#pragma mark - event & response
- (void)routerAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *group = self.dataList[indexPath.section][@"group"];
    NSDictionary *params = @{
                             @"parameterString" : [NSString stringWithFormat:@"%@-%@",@"我是一个字符串", group],
                             @"parameterNumber" : @(123456789),
                             @"parameterDictionary" : @{
                                     @"key1": [NSString stringWithFormat:@"%@-%@",@"Value1", group],
                                     @"key2": [NSString stringWithFormat:@"%@-%@",@"Value2", group],
                                     },
                             };
    
    
    switch (indexPath.section) {
        // ---------------------- Push ----------------------
        case 0: {
            switch (indexPath.row) {
                /**
                 Push跳转
                 */
                case 0: {
                    [[JYRouter router] push:@"JYViewController"];
                    break;
                }
                /**
                 Push跳转,附带参数
                 */
                case 1: {
                    [[JYRouter router] push:@"JYViewController" animated:YES params:params];
                    break;
                }
                /**
                 Push跳转,附带参数,完成回调
                 */
                case 2: {
                    [[JYRouter router] push:@"JYViewController" animated:YES params:params completion:^{
                        NSLog(@"🔥🔥🔥Push完成回调🔥🔥🔥");
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
            
        // ---------------------- Pop ----------------------
        case 1: {
            switch (indexPath.row) {
                /**
                 Pop到上级
                 */
                case 0: {
                    [[JYRouter router] pop];
                    break;
                }
                /**
                 Pop到根控制器
                 */
                case 1: {
                    [[JYRouter router] popToRoot];
                    break;
                }
                /**
                 Pop到根控制器,完成回调
                 */
                case 2: {
                    [[JYRouter router] popToRootAnimated:YES completion:^{
                        NSLog(@"💧💧💧Pop完成回调💧💧💧");
                    }];
                    break;
                }
                /**
                 Pop到指定控制器
                 */
                case 3: {
                    [[JYRouter router] popTo:@"JYViewController"];
                    break;
                }
                /**
                 Pop到指定控制器,完成回调
                 */
                case 4: {
                    [[JYRouter router] popTo:@"JYViewController" animated:YES completion:^{
                        NSLog(@"💧💧💧Pop完成回调💧💧💧");
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
            
        // ---------------------- Present ----------------------
        case 2: {
            switch (indexPath.row) {
                /**
                 present跳转
                 */
                case 0: {
                    [[JYRouter router] present:@"JYViewController"];
                    break;
                }
                /**
                 Present跳转,附带参数
                 */
                case 1: {
                    [[JYRouter router] present:@"JYViewController" animated:YES params:params];
                    break;
                }
                /**
                 Present跳转,附带参数,完成回调
                 */
                case 2: {
                    [[JYRouter router] present:@"JYViewController" animated:YES params:params completion:^{
                        NSLog(@"🌧🌧🌧Pop完成回调🌧🌧🌧");
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
            
        // ---------------------- Dismiss ----------------------
        case 3: {
            switch (indexPath.row) {
                /**
                 Dismiss
                 */
                case 0: {
                    [[JYRouter router] dismiss];
                    break;
                }
                /**
                 Dismiss,完成回调
                 */
                case 1: {
                    [[JYRouter router] dismiss:YES completion:^{
                        NSLog(@"⚡️⚡️⚡️Dismiss完成回调⚡️⚡️⚡️");
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
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
