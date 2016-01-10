//
//  UINavigationController+CustomAnimation.m
//  StoreCheck
//
//  Created by skunk  on 15/12/2.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "UINavigationController+CustomAnimation.h"

@implementation UINavigationController (CustomAnimation)

- (void)customPushViewController:(UIViewController *)viewController
{
    viewController.view.frame = (CGRect){0,-viewController.view.frame.size.height,viewController.view.frame.size};
    
    viewController.hidesBottomBarWhenPushed = YES;

    [self pushViewController:viewController animated:NO];
    
    [UIView animateWithDuration:.3f animations:^{
        viewController.view.frame = (CGRect){0, 0, self.view.bounds.size};
        
    }];
}

@end
