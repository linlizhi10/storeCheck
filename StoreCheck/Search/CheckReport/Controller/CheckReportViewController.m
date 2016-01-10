//
//  CheckReportViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckReportViewController.h"

@interface CheckReportViewController ()
<UIScrollViewDelegate>

@end

@implementation CheckReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"巡店报告"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)currentDate:(id)sender {
    NSLog(@"contentview.height is %f,scrollView.content.height is %f",self.contentView.frame.size.height,self.scrollView.contentSize.height);
}

- (IBAction)searchAction:(id)sender {
    
}
- (IBAction)preStoreAction:(id)sender {
}

- (IBAction)nextStoreAction:(id)sender {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scroll enable is %d",self.scrollView.scrollEnabled);
    self.contentView.center = self.scrollView.contentOffset;
    NSLog(@"offset is %f",self.scrollView.contentSize.height);
    NSLog(@"center is %f",self.contentView.center.y);
}
@end
