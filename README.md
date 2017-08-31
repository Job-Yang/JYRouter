JYRouter
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/Job-Yang/JYRouter/master/LICENSE) 
[![CocoaPods](http://img.shields.io/cocoapods/v/JYRouter.svg?style=flat)](http://cocoapods.org/?q=JYRouter) 
[![CocoaPods](http://img.shields.io/cocoapods/p/JYRouter.svg?style=flat)](http://cocoapods.org/?q=JYRouter) 
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) 


Router framework  is based on runtime to push/present/pop/dismiss for iOS



Features
==============

- **Compatibility:** Support for Objective-C and Swift

- **Ease of use:**   Support property auto assignment and completion callback

- **Low coupling:**  No need to inherit the base class or follow the protocol, plug and play

- **Applicability:** Supports jumps other than UIViewController




Usage
==============

### Jump 
**Objective-C**
```Objective-C
// Push
[[JYRouter router] push:@"JYViewController"];
	
// Push, Params
NSDictionary *params1 = @{ @"title" : @"JYRouter"};
[[JYRouter router] push:@"JYViewController" animated:YES params:params1];
	
// Push, Params, Callback
NSDictionary *params2 = @{@"type" : @(0)};
[[JYRouter router] push:@"JYViewController" animated:YES params:params2 completion:^{
	NSLog(@"🔥🔥🔥Push completion callback🔥🔥🔥");
}];
```

**Swift** 
```Swift
// Push
JYRouter().push("JYViewController")

// Push, Params
let params1 = ["title" : "JYRouter"]
JYRouter().push("JYViewController", animated: true, params: params1)

// Push, Params, Callback
let params2 = ["title" : "JYRouter"]
JYRouter().push("JYViewController", animated: true, params: params2, completion: {
	print("🔥🔥🔥Push completion callback🔥🔥🔥")
})
```

###  Custom NavigationController
**Objective-C**
```Objective-C
// Set in AppDelegate
[[JYRouter router] setCustomNavigationClass:[JYNavigationController class]];
```

**Swift** 
```Swift
// Set in AppDelegate
JYRouter().setCustomNavigationClass(JYNavigationController.self)
```



Installation
==============

### CocoaPods
1. Add `pod 'JYRouter'` to your Podfile.
2. Run `pod install` or `pod update`.
3. **Objective-C**：
	1. `#import "JYRouter.h"`

   **Swift**：
	1. Create `"YourProjectName-Bridging-Header.h"` bridging header file
	2. `#import "JYRouter.h"` in the bridging header file

### Manually
1. Download all the files in the `JYRouter` subdirectory.
2. Add the source files to your Xcode project.
3. **Objective-C**：
	1. `#import "JYRouter.h"`

   **Swift**：
	1. Create `"YourProjectName-Bridging-Header.h"` bridging header file
	2. `#import "JYRouter.h"` in the bridging header file


### License
JYRouter is released under the MIT license. See LICENSE file for details.

---



中文介绍
==============

基于runtime实现的iOS路由框架



特性
==============

- **兼容性：** 支持Objective-C和Swift
- **易用性：** 支持属性自动赋值和完成回调
- **低耦合：** 无需继承基类或遵循协议，即插即用
- **适用性：** 支持UIViewController之外其他类的跳转




使用方法
==============

### Jump 
**Objective-C**
```Objective-C
// Push跳转
[[JYRouter router] push:@"JYViewController"];
	
// Push跳转,附带参数
NSDictionary *params1 = @{@"title" : @"JYRouter"};
[[JYRouter router] push:@"JYViewController" animated:YES params:params1];
	
// Push跳转,附带参数,完成回调
NSDictionary *params2 = @{@"type" : @(0)};
[[JYRouter router] push:@"JYViewController" animated:YES params:params2 completion:^{
	NSLog(@"🔥🔥🔥Push完成回调🔥🔥🔥");
}];
```

**Swift** 
```Swift
// Push跳转
JYRouter().push("JYViewController")

// Push跳转,附带参数
let params1 = ["title" : "JYRouter"]
JYRouter().push("JYViewController", animated: true, params: params1)

// Push跳转,附带参数,完成回调
let params2 = ["title" : "JYRouter"]
JYRouter().push("JYViewController", animated: true, params: params2, completion: {
	print("🔥🔥🔥Push完成回调🔥🔥🔥")
})
```

###  自定义NavigationController
**Objective-C**
```Objective-C
// 在AppDelegate设置
[[JYRouter router] setCustomNavigationClass:[JYNavigationController class]];
```

**Swift** 
```Swift
// 在AppDelegate设置
JYRouter().setCustomNavigationClass(JYNavigationController.self)
```



安装
==============

### CocoaPods
1. 在 Podfile 中添加 pod 'JYRouter'。
2. 执行 pod install 或 pod update。
3. **Objective-C**：
	1. `#import "JYRouter.h"`

   **Swift**：
	1. 建立 `"你的工程名-Bridging-Header.h"`桥接文件
	2. 在该桥接文件中 `#import "JYRouter.h"`

### 手动安装
1. 下载 JYRouter 文件夹内的所有内容。
2. 将 JYRouter 内的源文件添加(拖放)到你的工程。
3. **Objective-C**：
	1. `#import "JYRouter.h"`

   **Swift**：
	1. 建立 `"你的工程名-Bridging-Header.h"`桥接文件
	2. 在该桥接文件中 `#import "JYRouter.h"`

许可证
==============
JYRouter 使用 MIT 许可证，详情见 LICENSE 文件。
