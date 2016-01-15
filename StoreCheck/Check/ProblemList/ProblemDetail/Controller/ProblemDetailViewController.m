//
//  ProblemDetailViewController.m
//  StoreCheck
//
//  Created by skunk  on 16/1/14.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import "ProblemDetailViewController.h"

@interface ProblemDetailViewController ()

@end

@implementation ProblemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"问题详情"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
