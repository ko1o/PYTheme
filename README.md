# PYTheme
[![Build Status](https://travis-ci.org/iphone5solo/PYTheme.svg?branch=master)](https://travis-ci.org/iphone5solo/PYTheme)
[![Pod Version](http://img.shields.io/cocoapods/v/PYTheme.svg?style=flat)](http://cocoadocs.org/docsets/PYTheme/)
[![Pod Platform](http://img.shields.io/cocoapods/p/PYTheme.svg?style=flat)](http://cocoadocs.org/docsets/PYTheme/)
[![Pod License](http://img.shields.io/cocoapods/l/PYTheme.svg?style=flat)](https://opensource.org/licenses/MIT)

- An easy way to change theme through NSObject's category for iOS.
- 通过NSObject的分类实现使用简单的主题更换。

## Features
- [x] 轻量级
- [x] 低耦合
- [x] 自动管理内存
- [x] 支持动态更换主题颜色
- [x] 支持动态更换主题图片
- [x] 支持CocoaPods

## Requirements
* iOS 7.0 or later
* Xcode 7.0 or later

## Architecture
- `NSObject+PYThemeExtension`


## Renderings

<img src="https://github.com/iphone5solo/learngit/raw/master/imagesForPYTheme/PYThemeDemo.gif" width="375"> 

## Usage
* 使用CocoaPods:
  - `pod "PYTheme"`
  - 导入主头文件`#import <NSObject+PYThemeExtension.h>`
* 手动导入：
  - 将`PYTheme`文件夹中的所有文件拽入项目中
  - 导入主头文件`#import "NSObject+PYThemeExtension.h"`
  
  
## 具体使用
### 设置主题色
#### 1. 添加控件的属性/方法到主题色池中

- 直接通过属性

```objc
	
// 按钮的背景色添加到主题色池中
[button py_addToThemeColorPool:@"backgroundColor"];
	
```

- 通过设置方法并且传入方法对应参数数组，参数中直接含有颜色参数

```objc
// 设置按钮选中时字体颜色添加到主题色池中
[button py_addToThemeColorPoolWithSelector:@selector(setTitleColor:forState:) objects:@[PYTHEME_THEME_COLOR, @(UIControlStateSelected)]]; 
```

- 当方法参数中没有直接包含颜色参数，而是经过包装（如使用NSDictionary包装）

```objc

// 设置tabBar选中时字体颜色添加到主题色池中
NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = PYTHEME_THEME_COLOR;
    [childController.tabBarItem py_addToThemeColorPoolWithSelector:@selector(setTitleTextAttributes:forState:) objects:@[attrSel, @(UIControlStateSelected)]];
    
```

#### 2. 设置主题色 
```objc

// 设置主题色为红色
[self py_setThemeColor:[UIColor redColor]];

```

### 设置主题图片与配色
#### 1. 添加相关控件对象到主题图片池中
```objc

// 添加tabBarItem到主题图片池中
[tabBarItem py_addToThemeImagePool];

```

#### 2. 根据需求设置控件的相关属性
```objc

// 重新加载主题图片，并设置主题色为红色
[self py_reloadThemeImageWithThemeColor:[UIColor redColor] setting:^(const NSArray<id> *objects) {
     // 根据控件类型完成相关设置
}

```

### 使用注意
- 对象不能是`UIAppearance`，否则将无法添加到主题池中
如下：将导致navigationBar无法添加到主题色池中

```objc

// 获取全局navBar
UINavigationBar *navBar = [UINavigationBar appearance];
// 添加背景色到主题色池中        
[navBar py_addToThemeColorPool:@"barTintColor"];

```

- 使用`py_addToThemeColorPoolWithSelector:objects:`设置参数数组时注意：
	- 方法参数必须按顺序一一对应，如果涉及到的主题色设置使用 PYTHEME_THEME_COLOR 宏定义代替
	- 如果数组中某个参数为nil，需包装为 [NSNull null] 对象再添加到数组中
	
- 如果要使图片随着主题色变化而渲染成主题颜色，需要设置`RenderingMode`为：UIImageRenderingModeAlwaysTemplate

## 期待

- 如果您在使用过程中有任何问题，欢迎[issue me](https://github.com/iphone5solo/PYTheme/issues/new)! 很乐意为您解答任何相关问题!
- 与其给我点star，不如向我狠狠地抛来一个BUG！
- 如果想要参与这个项目的维护或者有好的功能，欢迎pull request！
- 如果您想要更多的接口来自定义或者建议/意见，欢迎[issue me](https://github.com/iphone5solo/PYTheme/issues/new)!我会根据大家的需求提供更多的接口！
- 如果您在使用中觉得略有不适，欢迎联系我QQ:499491531，希望一起完善此项目，让它变成更强大，能够满足大多数用户的需求！


## Licenses
All source code is licensed under the MIT License.
