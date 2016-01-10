//
//  LLZTabar.m
//  StoreCheck
//
//  Created by skunk  on 15/11/12.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZTabBar.h"
#import "LLZTabBarButton.h"

@interface LLZTabBar ()

@property (nonatomic, weak) LLZTabBarButton * selectedButton;

@end

@implementation LLZTabBar

- (NSMutableArray *)tabBarButtonArray
{
    if (_tabBarButtonArray == nil) {
        _tabBarButtonArray = [[NSMutableArray alloc] init];
    }
    return _tabBarButtonArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xe1e1d7);
    }
    return self;
}


- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    LLZTabBarButton *button = [[LLZTabBarButton alloc] init];
    [self addSubview:button];
    [self.tabBarButtonArray addObject:button];
    
    button.item = item;
}

- (void)buttonClick:(LLZTabbarButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:1 to:2];
    }

}

@end
