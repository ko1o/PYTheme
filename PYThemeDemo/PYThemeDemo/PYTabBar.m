//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
//
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//


#import "PYTabBar.h"
#import "UIView+PYExtension.h"
#import "NSObject+PYThemeExtension.h"
#define  PYControllCount 4
@interface PYTabBar ()
@property (nonatomic, strong) UIView *plusBtn;
@end

@implementation PYTabBar


@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加加好按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setImage:[[UIImage imageNamed:@"tab_publish_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        // 设置监听事件
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        [self py_addToThemeColorPool:@"tintColor"];
    }
    return self;
}

- (void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusClick:)]) {
        [self.delegate tabBarDidPlusClick:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 计算宽度
    CGFloat childW = self.py_width / (PYControllCount + 1);
    self.plusBtn.py_width = childW;
    self.plusBtn.py_height = 49;
    
    // 添加plusBtn的位置
    self.plusBtn.py_x = ([UIScreen mainScreen].bounds.size.width - childW) * 0.5;
    self.plusBtn.py_y = 0;

    // 引出下标
    NSInteger index = 0;
    // 判断是否为控制器按钮
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child.class isSubclassOfClass:class]) {
            child.py_x = index * childW;
            child.py_width = childW;
            index++;
            if (index == 2) {
                index ++;
            }
        }
    }
}

+ (instancetype)tabBar
{
    return [[self alloc] init];
}
@end
