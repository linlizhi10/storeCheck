//
//  LLZTabar.h
//  StoreCheck
//
//  Created by skunk  on 15/11/12.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLZTabBar;
@class LLZTabbarButton;
//delegate
@protocol LLZTabBarDeldgate <NSObject>

- (void)tabBar:(LLZTabBar *)tabBar didSelectButtonFrom:(NSInteger)index to:(NSInteger)index;

@end
//tabBar
@interface LLZTabBar : UIView
@property (nonatomic, weak) id<LLZTabBarDeldgate> delegate;
@property (nonatomic, strong) NSMutableArray * tabBarButtonArray;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
- (void)buttonClick:(LLZTabbarButton *)button;

@end
