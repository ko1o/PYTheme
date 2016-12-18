//
//  代码地址: https://github.com/iphone5solo/PYTheme
//  代码作者: https://github.com/iphone5solo
//
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//


#import "PYTempCollectionViewController.h"
#import "NSObject+PYThemeExtension.h"
#import "UIView+PYExtension.h"

// 颜色
#define PYTHEME_COLOR(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define PYTHEME_RANDOM_COLOR  PYTHEME_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface PYTempCollectionViewController ()

@end

@implementation PYTempCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    // 设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 80) / 3;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = 20;
    
    if (self = [super initWithCollectionViewLayout:layout]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.py_x = 20;
    self.collectionView.py_y = 0;
    self.collectionView.py_width = [UIScreen mainScreen].bounds.size.width - 40;
    self.collectionView.py_height = [UIScreen mainScreen].bounds.size.height - 40;
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 51;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = PYTHEME_RANDOM_COLOR;
    cell.layer.cornerRadius = 5;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出cell
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    // 设置主题色
    [self py_setThemeColor:cell.backgroundColor];
}

@end
