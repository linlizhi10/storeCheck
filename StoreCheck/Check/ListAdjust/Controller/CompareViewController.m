//
//  CompareViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CompareViewController.h"

@interface CompareViewController ()
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *beforeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *afterImageView;

@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beforeImageView.image = self.beforeImage;
    self.afterImageView.image = self.afterImage;
//
//    NSLog(@"frame is %f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //强制横屏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  // New Autorotation support.
 - (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0);
 - (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0);
 // Returns interface orientation masks.
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0);

 */

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}



- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    //    if(UIDeviceOrientationIsLandscape(self.interfaceOrientation)) {
//        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//            objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait);
//        }
//    }
}

@end
