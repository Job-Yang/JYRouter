//
//  JYNavigationController.m
//  JYRouterDemo
//
//  Created by 杨权 on 2016/12/13.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYNavigationController.h"

@interface JYNavigationController ()

@end

@implementation JYNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
}

- (void)setNavigationBar {
    //设置NavigationBar背景颜色
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

@end
