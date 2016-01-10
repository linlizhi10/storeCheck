//
//  PhotoCheckViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "PhotoCheckViewController.h"

@interface PhotoCheckViewController ()

@end

@implementation PhotoCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"拍照查询"];
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

- (IBAction)searchAction:(id)sender {
}

- (IBAction)currentDate:(id)sender {
}

- (IBAction)prePhoto:(id)sender {
}

- (IBAction)nextPhoto:(id)sender {
}
@end
