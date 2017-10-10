//
//  JYRouter.h
//  Job-Yang
//
//  Created by 杨权 on 16/9/22.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYRouter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (JYParams)

- (void)modelWithDictionary:(NSDictionary *)dic {
    if (!dic) {return;}
    for (NSString *keyName in [dic allKeys]) {
        NSString *setterMethodName = [NSString stringWithFormat:@"set%@:",[self firstUpperString:keyName]];
        SEL propertySelector = NSSelectorFromString(setterMethodName);
        if ([self respondsToSelector:propertySelector]) {
            id value = [dic objectForKey:keyName];
            unsigned int count;
            objc_property_t *properties = class_copyPropertyList([self class], &count);
            for (NSInteger i = 0; i < count; i++) {
                objc_property_t property = properties[i];
                const char *name = property_getName(property);
                NSString *proName = [[NSString alloc] initWithUTF8String:name];
                if ([proName isEqualToString:keyName]) {
                    const char *attributes = property_getAttributes(property);
                    char *type = [self typeOfPropertyFromAttributes:attributes];
                    if (1 == strlen(type)) {
                        [self encodeType:type[0] ofPropertySelector:propertySelector value:value];
                    }
                    else {
                        [self encodeStructureType:type ofPropertySelector:propertySelector value:value];
                    }
                    break;
                }
            }
        }
    }
}
                                      
- (NSString *)firstUpperString:(NSString *)str {
    if (str && str.length > 0) {
        NSString *firstChar = [str substringToIndex:1];
        return [str stringByReplacingOccurrencesOfString:firstChar withString:[firstChar uppercaseString]];
    }
    return @"";
}

- (char *)typeOfPropertyFromAttributes:(const char *)attributes {
    if (!attributes || strlen(attributes) <= 1) {
        return 0x00;
    }
    char *result = NULL;
    if (!(attributes[1] == '{')){
        result = malloc(sizeof(char) * 2);
        memset(result, 0, 2);
        strncpy(result, attributes + 1, 1);
        return result;
    }
    char *start = strstr(attributes, "{");
    char *end = start;
    while (true) {
        char *tmp = strstr(end + 1, "}");
        if (!tmp) break;
        end = tmp;
    }
    NSInteger len = end - start + 1;
    result = malloc(sizeof(char) * (len + 1));
    memset(result, 0, len + 1);
    strncpy(result, start, len);
    return result;
}

- (void)encodeType:(char)type ofPropertySelector:(SEL)selector value:(id)value {
    if (!type) return;
    switch (type) {
        case 'B': {
            BOOL boolValue = [(NSNumber *)value boolValue];
            ((void (*)(id, SEL, BOOL))(void *) objc_msgSend)((id)self, selector, boolValue);
            break;
        };
        case 'c': {
            char charValue = [(NSNumber *)value charValue];
            ((void (*)(id, SEL, char))(void *) objc_msgSend)((id)self, selector, charValue);
            break;
        }
        case 's': {
            short shortValue = [(NSNumber *)value shortValue];
            ((void (*)(id, SEL, short))(void *) objc_msgSend)((id)self, selector, shortValue);
            break;
        }
        case 'i': {
            int intValue = [(NSNumber *)value intValue];
            ((void (*)(id, SEL, int))(void *) objc_msgSend)((id)self, selector, intValue);
            break;
        }
        case 'C': {
            unsigned char unsignedCharValue = [(NSNumber *)value unsignedCharValue];
            ((void (*)(id, SEL, unsigned char))(void *) objc_msgSend)((id)self, selector, unsignedCharValue);
            break;
        }
        case 'S': {
            unsigned short unsignedShortValue = [(NSNumber *)value unsignedShortValue];
            ((void (*)(id, SEL, unsigned short))(void *) objc_msgSend)((id)self, selector, unsignedShortValue);
            break;
        }
        case 'I': {
            unsigned int unsignedIntValue = [(NSNumber *)value unsignedIntValue];
            ((void (*)(id, SEL, unsigned int))(void *) objc_msgSend)((id)self, selector, unsignedIntValue);
            break;
        }
        case 'l': {
            long longValue = [(NSNumber *)value longValue];
            ((void (*)(id, SEL, long))(void *) objc_msgSend)((id)self, selector, longValue);
            break;
        }
        case 'L': {
            unsigned long unsignedLongValue = [(NSNumber *)value unsignedLongValue];
            ((void (*)(id, SEL, unsigned long))(void *) objc_msgSend)((id)self, selector, unsignedLongValue);
            break;
        }
        case 'q': {
            long long longLongValue = [(NSNumber *)value longLongValue];
            ((void (*)(id, SEL, long long))(void *) objc_msgSend)((id)self, selector, longLongValue);
            break;
        }
        case 'Q': {
            unsigned long long unsignedLongLongValue = [(NSNumber *)value unsignedLongLongValue];
            ((void (*)(id, SEL, unsigned long long))(void *) objc_msgSend)((id)self, selector, unsignedLongLongValue);
            break;
        }
        case 'f': {
            float floatValue = [(NSNumber *)value floatValue];
            ((void (*)(id, SEL, float))(void *) objc_msgSend)((id)self, selector, floatValue);
            break;
        }
        case 'd': {
            double doubleValue = [(NSNumber *)value doubleValue];
            ((void (*)(id, SEL, double))(void *) objc_msgSend)((id)self, selector, doubleValue);
            break;
        }
        default: {
            ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, selector, value);
            break;
        }
    }
}

- (void)encodeStructureType:(char *)type ofPropertySelector:(SEL)selector value:(id)value {
    if (!strcmp(type, @encode(CGPoint))) {
        CGPoint pointValue = [(NSValue *)value CGPointValue];
        ((void (*)(id, SEL, CGPoint))(void *) objc_msgSend)((id)self, selector, pointValue);
    }
    else if (!strcmp(type, @encode(CGSize))) {
        CGSize sizeValue = [(NSValue *)value CGSizeValue];
        ((void (*)(id, SEL, CGSize))(void *) objc_msgSend)((id)self, selector, sizeValue);
    }
    else if (!strcmp(type, @encode(CGRect))){
        CGRect rectValue = [(NSValue *)value CGRectValue];
        ((void (*)(id, SEL, CGRect))(void *) objc_msgSend)((id)self, selector, rectValue);
    }
    else if (!strcmp(type, @encode(CGAffineTransform))){
        CGAffineTransform affineValue = [(NSValue*)value CGAffineTransformValue];
        ((void (*)(id, SEL, CGAffineTransform))(void *) objc_msgSend)((id)self, selector, affineValue);
    }
    else if (!strcmp(type, @encode(UIEdgeInsets))){
        UIEdgeInsets edgeInsetsValue = [(NSValue*)value UIEdgeInsetsValue];
        ((void (*)(id, SEL, UIEdgeInsets))(void *) objc_msgSend)((id)self, selector, edgeInsetsValue);
    }
    else if (!strcmp(type, @encode(UIOffset))){
        UIOffset offset = [(NSValue*)value UIOffsetValue];
        ((void (*)(id, SEL, UIOffset))(void *) objc_msgSend)((id)self, selector, offset);
    }
    else {
        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, selector, value);
    }
}

@end


@implementation UINavigationController (JYCallBack)
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(void(^)(void))completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

- (void)popToRootViewController:(BOOL)animated
                     completion:(void(^)(void))completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popToRootViewControllerAnimated:animated];
    [CATransaction commit];
}

- (void)popToViewController:(UIViewController *)viewController
                   animated:(BOOL)animated
                 completion:(void(^)(void))completion {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self popToViewController:viewController animated:animated];
    [CATransaction commit];
}

@end


@interface JYRouterOptions()
@property (nonatomic, assign) BOOL isModal;
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@property (nonatomic, assign) UIModalTransitionStyle transitionStyle;
@property (nonatomic, strong) NSDictionary *defaultParams;
@property (nonatomic, strong) Class openClass;
@property (nonatomic, copy  ) JYRouterOpenCallback callback;
@end

@implementation JYRouterOptions
+ (instancetype)routerOptionsWithModal:(BOOL)isModal {
    JYRouterOptions *options = [[JYRouterOptions alloc] init];
    options.presentationStyle = UIModalPresentationNone;
    options.transitionStyle = UIModalTransitionStyleCoverVertical;
    options.isModal = isModal;
    return options;
}

+ (instancetype)routerOptions {
    return [self routerOptionsWithModal:NO];
}

+ (instancetype)routerOptionsAsModal {
    return [self routerOptionsWithModal:YES];
}

- (JYRouterOptions *)withPresentationStyle:(UIModalPresentationStyle)style {
    [self setPresentationStyle:style];
    return self;
}

@end

@interface JYRouterParams()
@property (nonatomic, strong) JYRouterOptions *routerOptions;
@property (nonatomic, strong) NSDictionary *openParams;
@property (nonatomic, strong) NSDictionary *extraParams;
@property (nonatomic, strong) NSDictionary *controllerParams;
@end

@implementation JYRouterParams
- (instancetype)initWithRouterOptions:(JYRouterOptions *)routerOptions
                           openParams:(NSDictionary *)openParams
                          extraParams:(NSDictionary *)extraParams {
    [self setRouterOptions:routerOptions];
    [self setExtraParams:extraParams];
    [self setOpenParams:openParams];
    return self;
}

@end


#define ROUTE_NOT_FOUND_FORMAT @"No route found for URL %@"
#define INVALID_CONTROLLER_FORMAT @"Your controller class %@ needs to implement either the static method %@ or the instance method %@"

@interface JYRouter()
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSMutableDictionary *routes;
@property (nonatomic, strong) NSMutableDictionary *cachedRoutes;
@property (nonatomic, strong) Class navClass;
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

- (instancetype)init {
    if (self = [super init]) {
        self.routes = [NSMutableDictionary dictionary];
        self.cachedRoutes = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (UIViewController *)currentVC {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
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

- (UIViewController *)controllerWithRouter:(NSString *)viewController {
    return [self controllerWithRouter:viewController
                               params:nil];
}

- (UIViewController *)controllerWithRouter:(NSString *)viewController
                                    params:(NSDictionary *)params {
    
    JYRouterOptions *options = [JYRouterOptions routerOptions];
    
    if (![self hasRouter:viewController]) {
        [self map:viewController toController:[self classFromString:viewController] withOptions:options];
    }
    JYRouterParams *extraParams = [self routerParamsForUrl:viewController extraParams:params];
    
    options.openClass = [self classFromString:viewController];
    extraParams.routerOptions = options;
    
    UIViewController *controller = [self controllerForRouterParams:extraParams];
    [controller modelWithDictionary:params];
    
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

- (void)push:(NSString *)viewController animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)(void))completion {
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

- (void)present:(NSString *)viewController animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)(void))completion {
    [self open:viewController withOptions:[[JYRouterOptions routerOptionsAsModal] withPresentationStyle:UIModalPresentationFormSheet] animated:animated params:params completion:completion];
}

- (void)present:(NSString *)viewController withOptions:(JYRouterOptions *)options animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)(void))completion {
    [self open:viewController withOptions:options animated:animated params:params completion:completion];
}

- (void)pop {
    [self popViewControllerFromRouterAnimated:YES];
}

- (void)pop:(BOOL)animated {
    [self popViewControllerFromRouterAnimated:animated];
}

- (void)popToRoot {
    [self popToRoot:YES];
}

- (void)popToRoot:(BOOL)animated {
    [self popToRoot:animated completion:nil];
}

- (void)popToRoot:(BOOL)animated completion:(void(^)(void))completion {
    [self.navigationController popToRootViewController:animated completion:completion];
}

- (void)popTo:(NSString *)viewController {
    [self popTo:viewController animated:YES];
}

- (void)popTo:(NSString *)viewController animated:(BOOL)animated  {
    [self popTo:viewController animated:YES completion:nil];
}

- (void)popTo:(NSString *)viewController animated:(BOOL)animated completion:(void(^)(void))completion {
    for (UIViewController *tempVC in self.navigationController.viewControllers) {
        if ([NSStringFromClass([tempVC class]) isEqualToString:viewController]) {
            [self.navigationController popToViewController:tempVC animated:animated completion:completion];
            break;
        }
    }
}

- (void)dismiss {
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animated {
    [self dismiss:animated completion:nil];
}

- (void)dismiss:(BOOL)animated completion:(void(^)(void))completion {
    [self.navigationController dismissViewControllerAnimated:animated completion:completion];
}

- (void)open:(NSString *)url withOptions:(JYRouterOptions *)options animated:(BOOL)animated params:(NSDictionary *)params completion:(void(^)(void))completion {
    
    if (![self hasRouter:url]) {
        [self map:url toController:[self classFromString:url] withOptions:options];
    }
    
    JYRouterParams *extraParams = [self routerParamsForUrl:url extraParams:params];
    if (!options) {
        options = [JYRouterOptions routerOptions];
    }
    options.openClass = [self classFromString:url];
    extraParams.routerOptions = options;
    
    if (options.callback) {
        JYRouterOpenCallback callback = options.callback;
        callback([extraParams controllerParams]);
        return;
    }
    
    if (!self.navigationController) {
        @throw [NSException exceptionWithName:@"NavigationControllerNotProvided"
                                       reason:@"Router#navigationController has not been set to a UINavigationController instance"
                                     userInfo:nil];
    }
    
    UIViewController *controller = [self controllerForRouterParams:extraParams];
    [controller modelWithDictionary:params];
    
    
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
    else {
        [self.navigationController pushViewController:controller animated:animated completion:completion];
    }
}

- (Class)classFromString:(NSString *)className {
    Class class = NSClassFromString(className);
    if (!class) {
        class = [self swiftClassFromString:className];
    }
//    NSLog(@"class = %@",class);
    return class;
}

- (Class)swiftClassFromString:(NSString *)className {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"];
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

- (void)map:(NSString *)format toController:(Class)controllerClass withOptions:(JYRouterOptions *)options {
    if (!format) {
        @throw [NSException exceptionWithName:@"RouteNotProvided"
                                       reason:@"Route #format is not initialized"
                                     userInfo:nil];
        return;
    }
    if (!options) {
        options = [JYRouterOptions routerOptions];
    }
    options.openClass = controllerClass;
    [self.routes setObject:options forKey:format];
}


- (void)popViewControllerFromRouterAnimated:(BOOL)animated {
    if (self.navigationController.presentedViewController) {
        [self.navigationController dismissViewControllerAnimated:animated completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:animated];
    }
}


- (JYRouterParams *)routerParamsForUrl:(NSString *)url extraParams: (NSDictionary *)extraParams {
    if (!url) {
        if (_ignoresExceptions) {
            return nil;
        }
        @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                       reason:[NSString stringWithFormat:ROUTE_NOT_FOUND_FORMAT, url]
                                     userInfo:nil];
    }
    
    if ([self.cachedRoutes objectForKey:url] && !extraParams) {
        return [self.cachedRoutes objectForKey:url];
    }
    
    NSArray *givenParts = url.pathComponents;
    NSArray *legacyParts = [url componentsSeparatedByString:@"/"];
    if ([legacyParts count] != [givenParts count]) {
        NSLog(@"Routable Warning - your URL %@ has empty path components - this will throw an error in an upcoming release", url);
        givenParts = legacyParts;
    }
    
    __block JYRouterParams *openParams = nil;
    [self.routes enumerateKeysAndObjectsUsingBlock:
     ^(NSString *routerUrl, JYRouterOptions *routerOptions, BOOL *stop) {
         
         NSArray *routerParts = [routerUrl pathComponents];
         if ([routerParts count] == [givenParts count]) {
             
             NSDictionary *givenParams = [self paramsForUrlComponents:givenParts routerUrlComponents:routerParts];
             if (givenParams) {
                 openParams = [[JYRouterParams alloc] initWithRouterOptions:routerOptions
                                                                 openParams:givenParams
                                                                extraParams:extraParams];
                 *stop = YES;
             }
         }
     }];
    
    if (!openParams) {
        if (_ignoresExceptions) {
            return nil;
        }
        @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                       reason:[NSString stringWithFormat:ROUTE_NOT_FOUND_FORMAT, url]
                                     userInfo:nil];
    }
    [self.cachedRoutes setObject:openParams forKey:url];
    return openParams;
}

- (NSDictionary *)paramsForUrlComponents:(NSArray *)givenUrlComponents
                     routerUrlComponents:(NSArray *)routerUrlComponents {
    
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [routerUrlComponents enumerateObjectsUsingBlock:
     ^(NSString *routerComponent, NSUInteger idx, BOOL *stop) {
         
         NSString *givenComponent = givenUrlComponents[idx];
         if ([routerComponent hasPrefix:@":"]) {
             NSString *key = [routerComponent substringFromIndex:1];
             [params setObject:givenComponent forKey:key];
         }
         else if (![routerComponent isEqualToString:givenComponent]) {
             params = nil;
             *stop = YES;
         }
     }];
    return params;
}

- (UIViewController *)controllerForRouterParams:(JYRouterParams *)params {
    SEL CONTROLLER_CLASS_SELECTOR = sel_registerName("allocWithRouterParams:");
    SEL CONTROLLER_SELECTOR = sel_registerName("initWithRouterParams:");
    SEL CONTROLLER_INIT = sel_registerName("init");
    UIViewController *controller = nil;
    Class controllerClass = params.routerOptions.openClass;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([controllerClass respondsToSelector:CONTROLLER_CLASS_SELECTOR]) {
        controller = [controllerClass performSelector:CONTROLLER_CLASS_SELECTOR withObject:[params controllerParams]];
    }
    else if ([params.routerOptions.openClass instancesRespondToSelector:CONTROLLER_SELECTOR]) {
        controller = [[params.routerOptions.openClass alloc] performSelector:CONTROLLER_SELECTOR withObject:[params controllerParams]];
    }
    else {
        controller = [[params.routerOptions.openClass alloc] performSelector:CONTROLLER_INIT];
    }
    #pragma clang diagnostic pop
    if (!controller) {
        if (_ignoresExceptions) {
            return controller;
        }
        @throw [NSException exceptionWithName:@"RoutableInitializerNotFound"
                                       reason:[NSString stringWithFormat:INVALID_CONTROLLER_FORMAT, NSStringFromClass(controllerClass), NSStringFromSelector(CONTROLLER_CLASS_SELECTOR),  NSStringFromSelector(CONTROLLER_SELECTOR)]
                                     userInfo:nil];
    }
    
    controller.modalTransitionStyle = params.routerOptions.transitionStyle;
    controller.modalPresentationStyle = params.routerOptions.presentationStyle;
    return controller;
}


@end
