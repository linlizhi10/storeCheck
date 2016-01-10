//
//  LLZNavigationController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZNavigationController.h"

@interface LLZNavigationController ()

@end

@implementation LLZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
