//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
//
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>

// 主题色：用于代替参数中的颜色
#define PYTHEME_THEME_COLOR @"PYTHEME_THEME_COLOR"

/** 在设置主题图片之前调用此block */
typedef void(^PYThemeImageSettingBlock)(const NSArray<id> *objects);

@interface NSObject (PYThemeExtension)

/**
 * 添加到主题色池
 * selector : 执行方法
 * objects : 方法参数数组
 * 注意：方法参数必须按顺序一一对应，如果涉及到的主题色设置使用 PYTHEME_THEME_COLOR 宏定义代替
 * 如果数组中某个参数为nil，需包装为 [NSNull null] 对象再添加到数组中
 */
- (void)py_addToThemeColorPoolWithSelector:(SEL)selector objects:(NSArray<id> *)objects;
/** 
 * 从主题色池移除
 * selector : 执行方法
 */
- (void)py_removeFromThemeColorPoolWithSelector:(SEL)selector;
/** 
 * 添加到主题色池
 * propertyName : 属性名
 */
- (void)py_addToThemeColorPool:(NSString *)propertyName;
/**
 * 从主题色池移除
 * propertyName : 属性名
 */
- (void)py_removeFromThemeColorPool:(NSString *)propertyName;
/** 
 * 设置主题色
 * color : 主题色
 */
- (void)py_setThemeColor:(UIColor *)color;


/** 添加到主题图片池 */
- (void)py_addToThemeImagePool;
/** 从主题图片池中移除 */
- (void)py_removeFromThemeImagePool;
/** 
 * 重新加载主题图片
 * themeColor : 主题色
 * block : 设置主题图片时调用的block
 */
- (void)py_reloadThemeImageWithThemeColor:(UIColor *)themeColor setting:(PYThemeImageSettingBlock)block;


@end
