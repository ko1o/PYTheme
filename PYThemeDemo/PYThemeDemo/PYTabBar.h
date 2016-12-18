//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
//
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//


#import <UIKit/UIKit.h>
@class PYTabBar;

@protocol PYTarBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidPlusClick:(PYTabBar *)tarbar;
@end


@interface PYTabBar : UITabBar

@property (nonatomic, weak) id<PYTarBarDelegate> delegate;

+ (instancetype)tabBar;

@end
