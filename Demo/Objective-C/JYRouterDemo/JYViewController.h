//
//  JYViewController.h
//  JYRouterDemo
//
//  Created by 杨权 on 2016/12/13.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYViewController : UIViewController

//待传值的参数列表，这边参数既可以写在.h中，也可以写在.m中

/**
 *  参数1 -- 字符串
 */
@property (copy, nonatomic) NSString *parameterString;
/**
 *  参数2 -- 数值
 */
@property (strong, nonatomic) NSNumber *parameterNumber;
/**
 *  参数3 -- 字典
 */
@property (strong, nonatomic) NSDictionary *parameterDictionary;
/**
 *  参数4 -- 基本类型
 */
@property (assign, nonatomic) BOOL parameterBool;
/**
 *  参数5 -- 结构体
 */
@property (assign, nonatomic) CGSize parameterSize;

@end
