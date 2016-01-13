//
//  ViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/12.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"
#import "LLZUser.h"
#import "Store.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton * leftNavigaitonButton;
@property (nonatomic, strong) UILabel * leftNavigationLabel;
@property (nonatomic, strong) UIButton * rightNavigationButton;
@property (nonatomic, strong) UILabel * rightNavigationLabel;
@property (nonatomic, strong) UILabel * centerLabel;
@property (nonatomic, strong) UIView * backView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBar:(UIColor *)color
{
    if (!self.backView) {
        self.backView = [UIView new];
        [_backView setUserInteractionEnabled:YES];
        [_backView setFrame:CGRectMake(0, 0, iPhoneWidth, 64)];
        [_backView setBackgroundColor:color];
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor whiteColor];
        line.frame = CGRectMake(0, 63, iPhoneWidth, 1);
        [_backView addSubview:line];
        [self.view addSubview:_backView];
    }else{
        NSLog(@"view is alloc");
    }
    
}

- (void)setCenterButton:(id)obj
{
    [self setNavigationBar:RGB(0, 0, 0)];
    if ([obj isKindOfClass:[NSString class]]) {
        if (!self.centerLabel) {
            self.centerLabel = [UILabel new];
            self.centerLabel.frame = CGRectMake(0, 0, 120, 44);
            self.centerLabel.center = CGPointMake(iPhoneWidth / 2, 44);
            self.centerLabel.textAlignment = NSTextAlignmentCenter;
            self.centerLabel.font = [UIFont systemFontOfSize:16];
            self.centerLabel.textColor = [UIColor whiteColor];
            [self.backView addSubview:self.centerLabel];

        }
        self.centerLabel.text = obj;
//        [self.backView addSubview:self.centerLabel];

    }
}

- (void)setLeftButton:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        self.leftNavigaitonButton = nil;
        if (!self.leftNavigationLabel) {
            self.leftNavigationLabel = [UILabel new];
            self.leftNavigationLabel.frame = CGRectMake(10, 10, 90, 40);
            self.leftNavigationLabel.center = CGPointMake(self.leftNavigationLabel.center.x, 44);
            self.leftNavigationLabel.textColor = [UIColor yellowColor];
            self.leftNavigationLabel.font = [UIFont systemFontOfSize:14];
            [self.backView addSubview:self.leftNavigationLabel];

        }
        self.leftNavigationLabel.text = obj;
    }else if ([obj isKindOfClass:[UIImage class]])
    {
        self.leftNavigationLabel = nil;
        if (!self.leftNavigaitonButton) {
            self.leftNavigaitonButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftNavigaitonButton.frame = CGRectMake(0, 20, 44, 44);
            [self.backView addSubview:self.leftNavigaitonButton];
        }
        [self.leftNavigaitonButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftNavigaitonButton setImage:obj forState:UIControlStateNormal];
    }
}

- (void)setRightButton:(id)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        
    }else if ([obj isKindOfClass:[UIImage class]])
    {
    
    }
}

- (void)pushToViewContrller:(Class)className
{
    //question
    UIViewController *vc = [[className alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)leftButtonAction:(UIButton *)sender
{
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
//        self.hidesBottomBarWhenPushed = NO;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (Store *)getStoreInfo
{
    if ([UserDefaults objectForKey:@"selectStore"]) {
        NSData *storeData = [UserDefaults objectForKey:@"selectStore"];
        Store *store = [NSKeyedUnarchiver unarchiveObjectWithData:storeData];
        return store;
    }
    return [Store storeWithStoreId:@""
                         storeName:@""
                        storeName2:@""
                      storeAddress:@""
                          telphone:@""
                        modifyTime:nil
                          latitude:0
                         longitude:0
                         useStatus:0
                      modifyUserId:0];
}

- (LLZUser *)getUserInfo
{
    if ([UserDefaults objectForKey:@"user"]) {
        NSData *userData = [UserDefaults objectForKey:@"user"];
        LLZUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        return user;
    }
    return [LLZUser userWithuserId:@""
                          userCode:@""
                          userName:@""
                         loginName:@""
                          loginPwd:@""
                              duty:@""
                     contactNumber:@""
                            remark:@""
                             orgId:0
                         useStatus:0
                      modifyUserId:0
                        modifyTime:nil];
}

- (NSDateFormatter *)dateFormatterOne {
    if (_dateFormatterOne == nil) {
        _dateFormatterOne = [[NSDateFormatter alloc] init];
        [_dateFormatterOne setDateFormat:@"yyyy-MM-dd"];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [_dateFormatterOne setTimeZone:timeZone];
    }
    return _dateFormatterOne;
}

- (NSDateFormatter *)dateFormatterTwo
{
    if (_dateFormatterTwo == nil) {
        _dateFormatterTwo = [[NSDateFormatter alloc] init];
        [_dateFormatterTwo setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSTimeZone *timeZoneTwo = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [_dateFormatterTwo setTimeZone:timeZoneTwo];
    }
    return _dateFormatterTwo;
}

@end
