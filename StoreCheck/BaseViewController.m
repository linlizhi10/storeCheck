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
#import "AppDelegate.h"
#import "Tools.h"
#import "LogInViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton * leftNavigaitonButton;
@property (nonatomic, strong) UILabel * leftNavigationLabel;
@property (nonatomic, strong) UIButton * rightNavigationButton;
@property (nonatomic, strong) UILabel * centerLabel;
@property (nonatomic, strong) UIView * backView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(outOfStore)
                                                 name:@"outOfStore"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"outOfStore"
                                                  object:nil];
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
        if (!self.rightNavigationLabel) {
            self.rightNavigationLabel = [UILabel new];
            [self.rightNavigationLabel setFrame:CGRectMake(iPhoneWidth - 90, 20, 80, 40)];
            self.rightNavigationLabel.center = CGPointMake(self.rightNavigationLabel.center.x, 44);
            [self.rightNavigationLabel setTextColor:[UIColor yellowColor]];
            self.rightNavigationLabel.tag = 1990;
            self.rightNavigationLabel.textAlignment = NSTextAlignmentCenter;
            [self.rightNavigationLabel setFont:[UIFont systemFontOfSize:14]];
            AppDelegate *appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appD.window addSubview:self.rightNavigationLabel];
        }else{
            NSLog(@"self.rightlabel is %@",self.rightNavigationLabel);
            NSLog(@"super view is %@",self.rightNavigationLabel.superview);
        }
        if ([self isKindOfClass:[LogInViewController class]]) {
            [self.rightNavigationLabel setHidden:YES];
        }else{
            [self.rightNavigationLabel setHidden:NO];
        }
        self.rightNavigationLabel.text = obj;
       
        
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
    return [Store storeWithServerId:0
                            storeId:@""
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
        [_dateFormatterTwo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeZone *timeZoneTwo = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [_dateFormatterTwo setTimeZone:timeZoneTwo];
    }
    return _dateFormatterTwo;
}

- (void)startTimeCountWithTimeString:(NSString *)timeString
{
    NSString *startTime = [self.dateFormatterTwo stringFromDate:[NSDate date]];
    NSLog(@"startTime is %@",startTime);
    
    if (!self.timeCount) {
        __block  int timeCountInt = 0;
        if (!timeString) {
            timeCountInt = 0;
        }else{
            NSDate *startDate = [self.dateFormatterTwo dateFromString:timeString];
            timeCountInt = [Tools calculateTimeAmountWithStartDate:startDate andEndDate:[NSDate date]];
        }
        self.timeCount = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(self.timeCount,dispatch_walltime(NULL, 0), 60.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(self.timeCount, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (timeCountInt < 60) {
                    [self setRightButton:[NSString stringWithFormat:@"入店%d分钟",timeCountInt]];
                }else if(timeCountInt < 60 * 24){
                    [self setRightButton:[NSString stringWithFormat:@"入店%d小时",(timeCountInt / 60)]];
                }else{
                    NSLog(@"too long");
                }
                timeCountInt ++;
            });
        });
        
    }else{
        NSLog(@"exists");
    }
    @try {
        dispatch_resume(self.timeCount);

    }
    @catch (NSException *exception) {
        NSLog(@"time is crash");
    }
   

}

- (void)outOfStore
{
    NSString *leaveTime = [self.dateFormatterTwo stringFromDate:[NSDate date]];
    NSLog(@"leaveTime is %@",leaveTime);
    if (self.timeCount) {
        dispatch_cancel(self.timeCount);
    }else{
        NSLog(@"no timer");
    }
    if (self.rightNavigationLabel) {
        self.rightNavigationLabel.text = @"";
        [self.rightNavigationLabel removeFromSuperview];
 
    }else{
        NSLog(@"no right label");
    }
}

@end
