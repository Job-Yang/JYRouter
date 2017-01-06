//
//  JYRouter.h
//  Job-Yang
//
//  Created by 杨权 on 16/9/22.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYRouter.h"
#import "YYModel/YYModel.h"

@implementation UINavigationController (Extensions)

/**
 带完成回调的pushViewController

 @param viewController 控制器
 @param animated 是否开启动画
 @param completion 完成回调
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(void(^)())completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

/**
 带完成回调的popToRootViewController
 
 @param animated 是否开启动画
 @param completion 完成回调
 */
- (void)popToRootViewController:(BOOL)animated
                     completion:(void(^)())completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popToRootViewControllerAnimated:animated];
    [CATransaction commit];
}

/**
 带完成回调的popToViewController
 
 @param viewController 控制器
 @param animated 是否开启动画
 @param completion 完成回调
 */
- (void)popToViewController:(UIViewController *)viewController
                   animated:(BOOL)animated
                 completion:(void(^)())completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popToViewController:viewController animated:animated];
    [CATransaction commit];
}

@end


@interface JYRouter()
@property (strong, nonatomic) Class navClass;
@end

@implementation JYRouter

+ (instancetype)router {
    static JYRouter *_sharedRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRouter = [[JYRouter alloc] init];
    });
    return _sharedRouter;
}

+ (instancetype)newRouter {
    return [[self alloc] init];
}

- (void)setCustomNavigationClass:(Class)navClass {
    if (![navClass isSubclassOfClass:[UINavigationController class]]) {
        @throw [NSException exceptionWithName:@"NavClassTypeError"
                                       reason:@"navClass must be UINavigationController class or Subclass of UINavigationController"
                                     userInfo:nil];
    }
    self.navClass = navClass;
}

- (BOOL)hasRouter:(NSString *)url {
    return [self.routes.allKeys containsObject:url];
}

- (UIViewController *)currentVC {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }
    else {
        result = window.rootViewController.presentedViewController;
    }
    
    return result;
}

- (UIViewController *)controllerWithRouter:(NSString *)viewController {
    return [self controllerWithRouter:viewController
                               params:nil];
}

- (UIViewController *)controllerWithRouter:(NSString *)viewController
                                    params:(NSDictionary *)params {
    
    UPRouterOptions *options = [UPRouterOptions routerOptions];
    
    if (![self hasRouter:viewController]) {
        [self map:viewController toController:[self JYClassFromString:viewController] withOptions:options];
    }
    RouterParams *extraParams = [self routerParamsForUrl:viewController extraParams:params];
    
    options.openClass = [self JYClassFromString:viewController];
    extraParams.routerOptions = options;
    
    UIViewController *controller = [self controllerForRouterParams:extraParams];
    // 这里会按照params字典映射的方式给controller对应的属性赋值
    // 所以此处我使用了YYModel的yy_modelSetWithDictionary进行属性赋值
    // 如果你的项目中直接导入了YYModel，则可以删除YYmodel文件夹依赖
    // 如果你的项目中导入了YYKit，则可以删除YYmodel文件夹依赖，且使用 [controller modelSetWithDictionary:params];
    // 如果你的项目中单独导入了MJExtension，则可以删除YYmodel文件夹依赖，且使用 [controller mj_setKeyValues:params];
    [controller yy_modelSetWithDictionary:params];
    
    return controller;
}

- (void)push:(NSString *)viewController {
    [self push:viewController animated:YES];
}

- (void)push:(NSString *)viewController animated:(BOOL)animated {
    [self push:viewController animated:animated params:nil];
}

- (void)push:(NSString *)viewController animated:(BOOL)animated params:(NSDictionary *)params {
    [self push:viewController animated:animated params:params completion:nil];
}

- (void)push:(NSString *)viewController animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)())completion {
    [self open:viewController withOptions:nil animated:animated params:params completion:completion];
}

- (void)present:(NSString *)viewController {
    [self present:viewController animated:YES];
}

- (void)present:(NSString *)viewController animated:(BOOL)animated {
    [self present:viewController animated:animated params:nil];
}

- (void)present:(NSString *)viewController animated:(BOOL)animated params:(NSDictionary *)params {
    [self present:viewController animated:animated params:params completion:nil];
}

- (void)present:(NSString *)viewController animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)())completion {
    [self open:viewController withOptions:[[UPRouterOptions modal] withPresentationStyle:UIModalPresentationFormSheet] animated:animated params:params completion:completion];
}

- (void)present:(NSString *)viewController withOptions:(UPRouterOptions *)options animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)())completion {
    [self open:viewController withOptions:options animated:animated params:params completion:completion];
}

- (void)pop {
    [super pop];
}

- (void)pop:(BOOL)animated {
    [super pop:animated];
}

- (void)popToRoot {
    [self popToRoot:YES];
}

- (void)popToRoot:(BOOL)animated {
    [self popToRoot:animated completion:nil];
}

- (void)popToRoot:(BOOL)animated completion:(void(^)())completion {
    [self.navigationController popToRootViewController:animated completion:completion];
}

- (void)popTo:(NSString *)viewController {
    [self popTo:viewController animated:YES];
}

- (void)popTo:(NSString *)viewController animated:(BOOL)animated  {
    [self popTo:viewController animated:YES completion:nil];
}

- (void)popTo:(NSString *)viewController animated:(BOOL)animated completion:(void(^)())completion {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([NSStringFromClass([temp class]) isEqualToString:viewController]) {
            [self.navigationController popToViewController:temp animated:animated completion:completion];
        }
    }
}

- (void)dismiss {
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animated {
    [self dismiss:animated completion:nil];
}

- (void)dismiss:(BOOL)animated completion:(void(^)())completion {
    [self.navigationController dismissViewControllerAnimated:animated completion:completion];
}

- (void)open:(NSString *)url withOptions:(UPRouterOptions *)options animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)())completion {
    if (![self hasRouter:url]) {
        [self map:url toController:[self JYClassFromString:url] withOptions:options];
    }
    RouterParams *extraParams = [self routerParamsForUrl:url extraParams:params];
    if (!options) {
        options = [UPRouterOptions routerOptions];
    }
    options.openClass = [self JYClassFromString:url];
    extraParams.routerOptions = options;
    
    if (options.callback) {
        RouterOpenCallback callback = options.callback;
        callback([extraParams controllerParams]);
        return;
    }
    
    if (!self.navigationController) {
        @throw [NSException exceptionWithName:@"NavigationControllerNotProvided"
                                       reason:@"Router#navigationController has not been set to a UINavigationController instance"
                                     userInfo:nil];
    }
    
    UIViewController *controller = [self controllerForRouterParams:extraParams];
    // 这里会按照params字典映射的方式给controller对应的属性赋值
    // 所以此处我使用了YYModel的yy_modelSetWithDictionary进行属性赋值
    // 如果你的项目中直接导入了YYModel，则可以删除YYmodel文件夹依赖
    // 如果你的项目中导入了YYKit，则可以删除YYmodel文件夹依赖，且使用 [controller modelSetWithDictionary:params];
    // 如果你的项目中单独导入了MJExtension，则可以删除YYmodel文件夹依赖，且使用 [controller mj_setKeyValues:params];
    [controller yy_modelSetWithDictionary:params];
    
    
    if ([options isModal]) {
        if ([controller.class isSubclassOfClass:UINavigationController.class]) {
            [self.navigationController presentViewController:controller
                                                    animated:animated
                                                  completion:completion];
        }
        else {
            if (!self.navClass) {
                self.navClass = [UINavigationController class];
            }
            UINavigationController *navigationController = [[self.navClass alloc] initWithRootViewController:controller];
            navigationController.modalPresentationStyle = controller.modalPresentationStyle;
            navigationController.modalTransitionStyle = controller.modalTransitionStyle;
            
            [self.navigationController presentViewController:navigationController
                                                    animated:animated
                                                  completion:completion];
        }
    }
    else if (options.shouldOpenAsRootViewController) {
        [self.navigationController setViewControllers:@[controller] animated:animated];
    }
    else {
        self.navigationController.navigationBar.hidden = NO;
        if (completion) {
            [self.navigationController pushViewController:controller animated:animated completion:completion];
        }else {
            [self.navigationController pushViewController:controller animated:animated];
        }
    }
}

- (Class)JYClassFromString:(NSString *)className {
    Class class = NSClassFromString(className);
    if (!class) {
        class = [self swiftClassFromString:className];
    }
    NSLog(@"class = %@",class);
    return class;
}

- (Class)swiftClassFromString:(NSString *)className {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"];
    //http://www.skyfox.org/swift-nsclassfromstring-crash.html
    appName = [appName stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    NSString *classStringName = [NSString stringWithFormat:@"%@.%@", appName, className];
    return NSClassFromString(classStringName);
}

- (UINavigationController *)navigationController {
    return [self navigationControllerWithController:[UIApplication sharedApplication].delegate.window.rootViewController];
}

- (UINavigationController *)navigationControllerWithController:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        return [self navigationControllerWithController:viewController.presentedViewController];
    }
    else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *vc = (UITabBarController *)viewController;
        return vc.selectedViewController;
    }
    else {
        return (UINavigationController *)viewController;
    }
}

@end
