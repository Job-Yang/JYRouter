//
//  JYRouter.h
//  Job-Yang
//
//  Created by 杨权 on 16/9/22.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^JYRouterOpenCallback)(NSDictionary *params);

/**
 跳转时属性自动复制的工具分类
 */
@interface NSObject (JYParams)
@end

/**
 跳转时回调的分类
 */
@interface UINavigationController (JYCallBack)
@end

/**
 跳转选项相关类
 */
@interface JYRouterOptions : NSObject
@end

/**
 跳转参数相关类
 */
@interface JYRouterParams : NSObject
@end


@interface JYRouter : NSObject

/**
 是否忽略异常
 */
@property (nonatomic, assign) BOOL ignoresExceptions;

/**
 单例

 @return JYRouter单例对象
 */
+ (instancetype)router;

/**
 获取一个新的Router对象

 @return JYRouter对象
 */
+ (instancetype)newRouter;

/**
 获取当前显示的VC
 
 @return 当前显示的VC
 */
+ (UIViewController *)currentVC;

/**
 设置自定义的Navigation,用于present时显示
 如果您想全局设置，请在AppDelegate 的didFinishLaunchingWithOptions方法中设置
 [[JYRouter router] setCustomNavigationClass:[YourCustomNavigation class]];
 
 @param navClass Navigation Class
 */
- (void)setCustomNavigationClass:(Class)navClass;

/**
 判断该URL是否可以路由跳转

 @param url url
 @return 是否可以跳转
 */
- (BOOL)hasRouter:(NSString *)url;

/**
 通过VC名称初始化VC

 @param viewController VC名称
 @return VC对象
 */
- (UIViewController *)controllerWithRouter:(NSString *)viewController;

/**
 通过VC名称初始化VC，并params映射将指定的属性赋值

 @param viewController VC名称
 @param params 属性映射
 @return VC对象
 */
- (UIViewController *)controllerWithRouter:(NSString *)viewController
                                    params:(NSDictionary *)params;


#pragma mark - Push

/**
 通过VC名Push到指定的VC（默认显示push动画）

 @param viewController VC名称
 */
- (void)push:(NSString *)viewController;

/**
 通过VC名Push到指定的VC（是否显示push动画）

 @param viewController VC名称
 @param animated 是否显示动画
 */
- (void)push:(NSString *)viewController
    animated:(BOOL)animated;

/**
 通过VC名Push到指定的VC，并params映射将指定的属性赋值

 @param viewController VC名称
 @param animated 是否显示push动画
 @param params 属性映射
 */
- (void)push:(NSString *)viewController
    animated:(BOOL)animated
      params:(NSDictionary *)params;


/**
 通过VC名Push到指定的VC，并params映射将指定的属性赋值
 
 @param viewController VC名称
 @param animated 是否显示push动画
 @param params 属性映射
 @param completion 完成回调
 */
- (void)push:(NSString *)viewController
    animated:(BOOL)animated
      params:(NSDictionary *)params
  completion:(void(^)(void))completion;

#pragma mark - Present

/**
 通过VC名Present到指定的VC（默认显示Present动画）

 @param viewController VC名称
 */
- (void)present:(NSString *)viewController;

/**
 通过VC名Present到指定的VC（是否显示Present动画）

 @param viewController VC名称
 @param animated 是否显示Present动画
 */
- (void)present:(NSString *)viewController
       animated:(BOOL)animated;

/**
 通过VC名Present指定的VC，并params映射将指定的属性赋值

 @param viewController VC名称
 @param animated 是否显示Present动画
 @param params 属性映射
 */
- (void)present:(NSString *)viewController
       animated:(BOOL)animated
         params:(NSDictionary *)params;


/**
 通过VC名Present指定的VC，并params映射将指定的属性赋值
 
 @param viewController VC名称
 @param animated 是否显示Present动画
 @param params 属性映射
 @param completion 完成回调
 */
- (void)present:(NSString *)viewController
       animated:(BOOL)animated
         params:(NSDictionary *)params
     completion:(void(^)(void))completion;

#pragma mark - Pop

/**
 Pop到上级VC（默认显示Pop动画）
 */
- (void)pop;

/**
 Pop到上级VC（是否显示Pop动画）
 
 @param animated 是否显示Pop动画
 */
- (void)pop:(BOOL)animated;

/**
 Pop到根控制器（默认显示Pop动画）
 */
- (void)popToRoot;

/**
 Pop到根控制器（是否显示Pop动画）

 @param animated 是否显示Pop动画
 */
- (void)popToRoot:(BOOL)animated;

/**
 Pop到根控制器（是否显示Pop动画）
 
 @param animated 是否显示Pop动画
 @param completion 完成回调
 */
- (void)popToRoot:(BOOL)animated
       completion:(void(^)(void))completion;

/**
 通过VC名Pop到指定的VC（默认显示Pop动画）

 @param viewController VC名称
 */
- (void)popTo:(NSString *)viewController;

/**
 通过VC名Pop到指定的VC（是否显示Pop动画)

 @param viewController VC名称
 @param animated 是否显示Pop动画
 */
- (void)popTo:(NSString *)viewController
     animated:(BOOL)animated;

/**
 通过VC名Pop到指定的VC（是否显示Pop动画)
 
 @param viewController VC名称
 @param animated 是否显示Pop动画
 @param completion 完成回调
 */
- (void)popTo:(NSString *)viewController
     animated:(BOOL)animated
   completion:(void(^)(void))completion;

#pragma mark - Dismiss

/**
 dismiss（默认显示Dismiss动画）
 */
- (void)dismiss;
/**
 dismiss（是否显示Dismiss动画）
 
 @param animated 是否显示Dismiss动画
 */
- (void)dismiss:(BOOL)animated;

/**
 dismiss（是否显示Dismiss动画）
 
 @param animated 是否显示Dismiss动画
 @param completion 完成回调
 */
- (void)dismiss:(BOOL)animated
     completion:(void(^)(void))completion;

@end


