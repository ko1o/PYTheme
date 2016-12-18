//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
//
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//


#import "PYNavigationController.h"
#import "NSObject+PYThemeExtension.h"

@implementation PYNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        // 设置主题颜色
        UINavigationBar *navBar = [[UINavigationBar alloc] init];
        // 设置背景颜色
        [navBar py_addToThemeColorPool:@"barTintColor"];
        navBar.tintColor = [UIColor whiteColor];
        // 设置字体颜色
        NSDictionary *attr = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                                };
        navBar.titleTextAttributes = attr;
        [self setValue:navBar forKey:@"navigationBar"];
    }
   
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
