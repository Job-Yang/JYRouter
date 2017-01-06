# JYRouter

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/Job-Yang/JYRouter/master/LICENSE) 
[![CocoaPods](http://img.shields.io/cocoapods/v/JYRouter.svg?style=flat)](http://cocoapods.org/?q=JYRouter) 
[![CocoaPods](http://img.shields.io/cocoapods/p/JYRouter.svg?style=flat)](http://cocoapods.org/?q=JYRouter) 
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) 


## 总述
JYRouter是一个基于[Routable](https://github.com/clayallsopp/routable-ios)封装的路由跳转库，封装了常见的**Push**, **Pop**, **Present**, **Dismiss**等跳转方法。


## 特性
- **兼容性:**支持Objective-C和Swift

- **易用性:**支持传递参数属性赋值和完成回调

- **无侵入性:**无需继承自其他基类


## 使用方法

### 简单使用
**Objective-C**
	//Push跳转
	[[JYRouter router] push:@"JYViewController"];
	
	//Push跳转,附带参数
	NSDictionary *params1 = @{
	  						@"title" : @"JYRouter"
							};
	[[JYRouter router] push:@"JYViewController" animated:YES params:params1];
	
	//Push跳转,附带参数,完成回调
	NSDictionary *params2 = @{
	  						@"type" : @(0)
							};
	[[JYRouter router] push:@"JYViewController" animated:YES params:params2 completion:^{
		NSLog(@"🔥🔥🔥Push完成回调🔥🔥🔥");
	}];

**Swift** 

	//Push跳转
	JYRouter().push("JYViewController")
	
	//Push跳转,附带参数
	let params1 = [
				  "title" : "JYRouter"
				  ]
	JYRouter().push("JYViewController", animated: true, params: params1)
	
	//Push跳转,附带参数,完成回调
	let params2 = [
				  "title" : "JYRouter"
				  ]
	JYRouter().push("JYViewController", animated: true, params: params2, completion: {
		print("🔥🔥🔥Push完成回调🔥🔥🔥")
	})

### 自定义NavigationController
	在AppDelegate设置

**Objective-C**
	[[JYRouter router] setCustomNavigationClass:[JYNavigationController class]];
	
**Swift**
	JYRouter().setCustomNavigationClass(JYNavigationController.self)

## 安装

### 手动安装

1. 下载 JYRouter 文件夹内的所有内容。
2. 将 JYRouter 内的源文件添加(拖放)到你的工程。
3. 导入 `JYRouter.h`.

## 许可证

JYRouter 使用 MIT 许可证，详情见 LICENSE 文件。
