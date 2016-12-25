//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
// 
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "NSObject+PYThemeExtension.h"

#define PYTHEME_COLOR_ARGS_KEY @"PYTHEME_COLOR_ARGS_KEY"
#define PYTHEME_IMAGE_ARGS_KEY @"PYTHEME_IMAGE_ARGS_KEY"

@implementation NSObject (PYThemeExtension)

/** 主题颜色池 */
static NSMutableArray<NSMapTable *> *_themeColorPool;
/** 当前主题色 */
static UIColor *_currentThemeColor;

/** 主题图片池 */
static NSMutableArray<id> *_themeImagePool;

#pragma mark - 懒加载
- (NSMutableArray *)themeColorPool
{
    if (!_themeColorPool) {
        _themeColorPool = [NSMutableArray array];
    }
    return _themeColorPool;
}

- (NSMutableArray *)themeImagePool
{
    if (!_themeImagePool) {
        _themeImagePool = [NSMutableArray array];
    }
    return _themeImagePool;
}

#pragma mark - performSelector 多参调用
- (id)py_performSelector:(SEL)selector withObjects:(const NSArray<id> *)objects
{
    // 1. 创建方法签名
    // 根据方法来初始化NSMethodSignature
    NSMethodSignature *methodSignate = [[self class] instanceMethodSignatureForSelector:selector];
    if (!methodSignate) { // 没有该方法
        return self;
    }
    // 2. 创建invocation对象（包装方法）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignate];
    // 3. 设置相关属性
    // 调用者
    invocation.target = self;
    // 调用方法
    invocation.selector = selector;
    // 获取除self、_cmd的参数个数
    NSInteger paramsCount = methodSignate.numberOfArguments - 2;
    // 取最少的，防止越界
    NSInteger count = MIN(paramsCount, objects.count);
    // 用于dictionary的拷贝(用于保住objCopy，避免非法内存访问)
    NSMutableDictionary *objCopy = nil;
    // 设置参数
    for (int i = 0; i < count; i++) {
        // 取出参数对象
        id obj = objects[i];
        // 如果是主题颜色参数颜色，则设置
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:PYTHEME_THEME_COLOR]) {
            obj = _currentThemeColor;
        }
        // 判断需要设置的参数是否是NSNull, 如果是就设置为nil
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        // 获取参数类型
        const char *argumentType = [methodSignate getArgumentTypeAtIndex:i + 2];
        // 判断参数类型 根据类型转化数据类型（如果有必要）
        NSString *argumentTypeString = [NSString stringWithUTF8String:argumentType];
        if ([argumentTypeString isEqualToString:@"@"]) { // id
            // 如果是dictionary，可能存在 PYTHEME_THEME_COLOR
            if ([obj isKindOfClass:[NSDictionary class]]) { // NSDictionary
                objCopy = [obj mutableCopy];
                // 取出所有键
                NSArray *keys = [objCopy allKeys];
                for (NSString *key in keys) {
                    // 取出值
                    id value = objCopy[key];
                    if ([value isKindOfClass:[NSString class]] && [value isEqualToString:PYTHEME_THEME_COLOR]) {
                        // 替换成颜色
                        [objCopy setValue:_currentThemeColor forKey:key];
                    }
                }
                [invocation setArgument:&objCopy atIndex:i + 2];
            } else { // 其他
                [invocation setArgument:&obj atIndex:i + 2];
            }
        }  else if ([argumentTypeString isEqualToString:@"B"]) { // bool
            bool objVaule = [obj boolValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"f"]) { // float
            float objVaule = [obj floatValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"d"]) { // double
            double objVaule = [obj doubleValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"c"]) { // char
            char objVaule = [obj charValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"i"]) { // int
            int objVaule = [obj intValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"I"]) { // unsigned int
            unsigned int objVaule = [obj unsignedIntValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"S"]) { // unsigned short
            unsigned short objVaule = [obj unsignedShortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"L"]) { // unsigned long
            unsigned long objVaule = [obj unsignedLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"s"]) { // shrot
            short objVaule = [obj shortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"l"]) { // long
            long objVaule = [obj longValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"q"]) { // long long
            long long objVaule = [obj longLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"C"]) { // unsigned char
            unsigned char objVaule = [obj unsignedCharValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"Q"]) { // unsigned long long
            unsigned long long objVaule = [obj unsignedLongLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"{CGRect={CGPoint=dd}{CGSize=dd}}"]) { // CGRect
            CGRect objVaule = [obj CGRectValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"{UIEdgeInsets=dddd}"]) { // UIEdgeInsets
            UIEdgeInsets objVaule = [obj UIEdgeInsetsValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
    }
    // 4.调用方法
    [invocation invoke];
    // 5. 设置返回值
    id returnValue = nil;
    if (methodSignate.methodReturnLength != 0) { // 有返回值
        // 将返回值赋值给returnValue
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

#pragma mark - Theme Color
/**
 * 添加到主题色池
 * selector : 执行方法
 * objects : 方法参数数组
 * 注意：方法参数必须按顺序一一对应，如果涉及到的主题色设置使用 PYTHEME_THEME_COLOR 宏定义代替
 * 如果数组中某个参数为nil，需包装为 [NSNull null] 对象再添加到数组中
 */
- (void)py_addToThemeColorPoolWithSelector:(SEL)selector objects:(NSArray *)objects
{
    // 判断参数是否为空
    if (!objects) return;
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    // 如果对象为_UIAppearance，直接返回
    if ([self isMemberOfClass:appearanceClass]) return;
    // 键：对象地址+方法名 值：对象
    NSString *pointSelectorString = [NSString stringWithFormat:@"%p%@", self, NSStringFromSelector(selector)];
    // 采用NSMapTable存储对象，使用弱引用
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:self forKey:pointSelectorString];
    [mapTable setObject:objects forKey:PYTHEME_COLOR_ARGS_KEY];
    // 判断是否已经在主题色池中
    for (NSMapTable *subMapTable in [[self themeColorPool] copy]) {
        if ([[subMapTable description] isEqualToString:[mapTable description]]) { // 存在，直接返回
            return;
        }
    }
    // 不存在，添加主题色池中
    [[self themeColorPool] addObject:mapTable];
    if (_currentThemeColor) { // 已经设置主题色，直接设置
        [self py_performSelector:selector withObjects:objects];
    }
}

/**
 * 从主题色池移除
 * selector : 执行方法
 */
- (void)py_removeFromThemeColorPoolWithSelector:(SEL)selector
{
    // 如果对象为_UIAppearance，直接返回
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) return;
    
    // 键：对象地址+方法名 值：对象
    NSString *pointSelectorString = [NSString stringWithFormat:@"%p%@", self, NSStringFromSelector(selector)];
    // 判断是否已经在主题色池中
    for (NSMapTable *subMapTable in [[self themeColorPool] copy]) {
        // 取出key
        NSString *objectKey = nil;
        // 获取mapTable中所有key
        NSEnumerator *enumerator = [subMapTable keyEnumerator];
        NSString *key;
        while (key = [enumerator nextObject]) {
            if (![key isEqualToString:PYTHEME_COLOR_ARGS_KEY]) {
                objectKey = key;
                break;
            }
        }
        if([objectKey isEqualToString:pointSelectorString]) { // 存在，移除
            [[self themeColorPool] removeObject:subMapTable];
            return;
        }
    }
}

/**
 * 添加到主题色池
 * propertyName : 属性名
 */
- (void)py_addToThemeColorPool:(NSString *)propertyName
{
    // 如果对象为_UIAppearance，直接返回
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) return;
    // 键：对象地址+属性名 值：对象
    NSString *pointString = [NSString stringWithFormat:@"%p%@", self, propertyName];
    // 采用NSMapTable存储对象，使用弱引用
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:self forKey:pointString];
    // 判断是否已经在主题色池中
    for (NSMapTable *subMapTable in [[self themeColorPool] copy]) {
        if ([[subMapTable description] isEqualToString:[mapTable description]]) { // 存在，直接返回
            return;
        }
    }
    // 不存在，添加主题色池中
    [[self themeColorPool] addObject:mapTable];
    if (_currentThemeColor) { // 已经设置主题色，直接设置
        [self setValue:_currentThemeColor forKey:propertyName];
    }
}

/**
 * 从主题色池移除
 * propertyName : 属性名
 */
- (void)py_removeFromThemeColorPool:(NSString *)propertyName
{
    // 如果对象为_UIAppearance，直接返回
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) return;
    
    // 键：对象地址+属性名 值：对象
    NSString *pointString = [NSString stringWithFormat:@"%p%@", self, propertyName];
    // 判断是否已经在主题色池中
    for (NSMapTable *subMapTable in [[self themeColorPool] copy]) {
        // 获取mapTable中所有key
        NSEnumerator *enumerator = [subMapTable keyEnumerator];
        if([[enumerator nextObject] isEqualToString:pointString]) { // 存在，移除
            [[self themeColorPool] removeObject:subMapTable];
            return;
        }
    }
}

/**
 * 设置主题色
 * color : 主题色
 */
- (void)py_setThemeColor:(UIColor *)color
{
    _currentThemeColor = color;
    // 遍历缓主题池，设置统一主题色
    for (NSMapTable *mapTable in [_themeColorPool copy]) {
        // 取出key
        NSString *objectKey = nil;
        // 获取mapTable中所有key
        NSEnumerator *enumerator = [mapTable keyEnumerator];
        NSString *key;
        while (key = [enumerator nextObject]) {
            if (![key isEqualToString:PYTHEME_COLOR_ARGS_KEY]) {
                objectKey = key;
                break;
            }
        }
        if (!key) { // 如果key为空，则mapTable 为空，移除mapTable
            [_themeColorPool removeObject:mapTable];
        }
        // 取出对象
        id object = [mapTable objectForKey:objectKey];
        if ([objectKey containsString:@":"]) { // 方法
            // 取出参数
            NSArray *args = [mapTable objectForKey:PYTHEME_COLOR_ARGS_KEY];
            // 取出方法
            NSString *selectorName = [objectKey substringFromIndex:[[NSString stringWithFormat:@"%p", object] length]];
            SEL selector = NSSelectorFromString(selectorName);
            // 调用方法，设置属性
            [object py_performSelector:selector withObjects:args];
        } else { // 成员属性
            // 取出属性值
            NSString *propertyName = [objectKey substringFromIndex:[[NSString stringWithFormat:@"%p", object] length]];
            // 给对象的对应属性赋值（使用KVC）
            [object setValue:color forKeyPath:propertyName];
        }
    }
}

#pragma mark - Theme Image
/** 添加到主题图片池 */
- (void)py_addToThemeImagePool
{
    // 如果对象为_UIAppearance，直接返回
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) return;
    
    if ([self isKindOfClass:[UITabBarItem class]]) { // 如果是UITabBarItem，判断是否有设置图片
        UITabBarItem *item = (UITabBarItem *)self;
        if (!item.image) { // 没有设置图片
            item.image = [[UIImage alloc] init];
        }
        if (!item.selectedImage) { // 没有设置图片
            item.selectedImage = [[UIImage alloc] init];
        }
    }
    // 判断是否已经在主题图片池中
    if (![[self themeImagePool] containsObject:self]) { // 不在主题图片池中
        [[self themeImagePool] addObject:self];
    }
}

/** 从主题图片池中移除 */
- (void)py_removeFromThemeImagePool
{
    // 如果对象为_UIAppearance，直接返回
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) return;
    // 判断是否已经在图片池中
    if ([[self themeImagePool] containsObject:self]) { // 在主题图片池中
        [[self themeImagePool] removeObject:self];
    }
}

/** 重新加载主题图片 */
- (void)py_reloadThemeImageWithThemeColor:(UIColor *)themeColor setting:(PYThemeImageSettingBlock)block
{
    if (themeColor) { // 有主题色，设置主题色
        [self py_setThemeColor:themeColor];
    }
    if (block) { // 存在block，直接调用
        block([self themeImagePool]);
    }
}

@end
