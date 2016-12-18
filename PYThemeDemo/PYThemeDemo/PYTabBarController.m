//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
//
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "PYTabBarController.h"
#import "PYNavigationController.h"
#import "PYTempCollectionViewController.h"
#import "NSObject+PYThemeExtension.h"
#import "PYTabBar.h"

@interface PYTabBarController ()


@end

@implementation PYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PYTabBar *tabBar = [PYTabBar tabBar];
    // 设置自定义tabBar(使用kvc)
    [self setValue:tabBar forKeyPath:@"tabBar"];
   
    // 首页
    [self addChildViewController:[[PYTempCollectionViewController alloc] init] image:@"tab_home_nor" seletedImage:@"tab_home_press" title:@"Home"];
    [self addChildViewController:[[PYTempCollectionViewController alloc] init] image:@"tab_classify_nor"  seletedImage:@"tab_classify_press"  title:@"Classify"];
    [self addChildViewController:[[PYTempCollectionViewController alloc] init] image:@"tab_community_nor"  seletedImage:@"tab_community_press"  title:@"Community"];
    [self addChildViewController:[[PYTempCollectionViewController alloc] init] image:@"tab_me_nor"  seletedImage:@"tab_me_press"  title:@"Me"];
}

- (UIViewController *)addChildViewController:(UIViewController *)childController image:(NSString *)image seletedImage:(NSString *)selectedImage title:(NSString *)title
{
    // 设置标题
    childController.title = title;
    // 设置字体颜色
    NSMutableDictionary *attrNol = [NSMutableDictionary dictionary];
    attrNol[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [childController.tabBarItem setTitleTextAttributes:attrNol forState:UIControlStateNormal];
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = PYTHEME_THEME_COLOR;
    [childController.tabBarItem py_addToThemeColorPoolWithSelector:@selector(setTitleTextAttributes:forState:) objects:@[attrSel, @(UIControlStateSelected)]];
    // 设置图片
    [childController.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [childController.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

    // 包装导航条
    PYNavigationController *nav = [[PYNavigationController alloc] initWithRootViewController:childController];
    // 添加子控制器
    [self addChildViewController:nav];
    return childController;
}

@end
