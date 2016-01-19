//
//  LogInViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LogInViewController.h"
#import "CheckHomeViewController.h"
#import "SystemHomeViewController.h"
#import "AssistantHomeViewController.h"
#import "SearchHomeViewController.h"
#import "LLZFTabBarController.h"
#import "LLZNavigationController.h"
#import "LLZUser.h"
#import "NSString+MD5String.h"
#import "LLZParam.h"

@interface LogInViewController ()<UIAlertViewDelegate>

@property (nonatomic, assign) BOOL rememberFlag;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *rememberStatus;
@property (strong, nonatomic) LLZParam *contactParam;

- (IBAction)rememberAction:(id)sender;
- (IBAction)logIn:(id)sender;
- (IBAction)forget:(id)sender;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"登录"];
    [self dataPrepared];
    self.rememberFlag = [UserDefaults boolForKey:@"rememberFlag"];
    self.userName.text = [UserDefaults stringForKey:@"userName"];
    if (self.rememberFlag) {
        self.rememberStatus.image = [UIImage imageNamed:@"select_yes"];
        self.password.text = [UserDefaults stringForKey:@"password"];
    }else
    {
        self.rememberStatus.image = [UIImage imageNamed:@"select_no"];
        self.password.text = @"";
    }
}

- (void)dataPrepared
{
    self.contactParam = [self.appD.dataM getParamWithId:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)rememberAction:(id)sender {
    
    if (self.rememberFlag == NO) {
        self.rememberStatus.image = [UIImage imageNamed:@"select_yes"];
        self.rememberFlag = YES;
    }
    else
    {
        self.rememberStatus.image = [UIImage imageNamed:@"select_no"];
        self.rememberFlag = NO;
    }
    [UserDefaults setBool:self.rememberFlag forKey:@"rememberFlag"];
}

- (IBAction)logIn:(id)sender {
    if (![self checkLoginInformation]) {
        return;
    }else{
        NSArray *arrUser = [self.appD.dataM getUserWithName:self.userName.text passWord:[self.password.text getMd5String]];
        
        if (arrUser.count > 0) {
            NSLog(@"login sucess");
            LLZUser *user = arrUser[0];
            //user for whole operation
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
            ;
            [UserDefaults setObject:userData forKey:@"user"];
            [UserDefaults setValue:self.userName.text forKey:@"userName"];
            [UserDefaults setValue:self.password.text forKey:@"password"];
            
            //init viewcontrollers
            CheckHomeViewController *checkHome = [[CheckHomeViewController alloc] init];
            AssistantHomeViewController *assitantHome = [[AssistantHomeViewController alloc] init];
            SearchHomeViewController *searchHome = [[SearchHomeViewController alloc] init];
            SystemHomeViewController *systemHome = [[SystemHomeViewController alloc] init];
            //init navigation controller
            LLZNavigationController *navCheck = [[LLZNavigationController alloc] initWithRootViewController:checkHome];
            LLZNavigationController *navSearch = [[LLZNavigationController alloc] initWithRootViewController:searchHome];
            LLZNavigationController *navAssitant = [[LLZNavigationController alloc] initWithRootViewController:assitantHome];
            LLZNavigationController *navSystem = [[LLZNavigationController alloc] initWithRootViewController:systemHome];
            //viewcontrollers array
            NSArray *controllers = [NSArray arrayWithObjects:navCheck,
                                    navSearch,
                                    navAssitant,
                                    navSystem, nil];
            //items
            UITabBarItem *item01 = [[UITabBarItem alloc] initWithTitle:@"巡店" image:[UIImage imageNamed:@"tab-home"] selectedImage:[UIImage imageNamed:@"tab-home-s"]];
            UITabBarItem *item02 = [[UITabBarItem alloc] initWithTitle:@"查询" image:[UIImage imageNamed:@"tab-cart"] selectedImage:[UIImage imageNamed:@"tab-cart-s"]];
            UITabBarItem *item03 = [[UITabBarItem alloc] initWithTitle:@"辅助" image:[UIImage imageNamed:@"tab-new"] selectedImage:[UIImage imageNamed:@"tab-new-s"]];
            UITabBarItem *item04 = [[UITabBarItem alloc] initWithTitle:@"系统" image:[UIImage imageNamed:@"tab-pro"] selectedImage:[UIImage imageNamed:@"tab-pro-s"]];
            navCheck.tabBarItem = item01;
            navSearch.tabBarItem = item02;
            navAssitant.tabBarItem = item03;
            navSystem.tabBarItem = item04;
            
            LLZFTabBarController *tabBarController = [[LLZFTabBarController alloc] init];
            tabBarController.viewControllers = controllers;
            tabBarController.selectedIndex = 0;
            tabBarController.tabBar.tintColor = [UIColor whiteColor];
            NSLog(@"height is %f",tabBarController.tabBar.frame.size.height);
            [self presentViewController:tabBarController animated:YES completion:nil];

        }else{
            Alert(@"账号或者密码不正确", self,10001);
        }
        }
   
}

- (BOOL)checkLoginInformation
{
    if ([self.userName.text isEqualToString:@""]) {
        [WToast showWithText:@"请填写用户名" forToastType:2];
        return NO;
    }else{
        if ([self.password.text isEqualToString:@""]) {
            [WToast showWithText:@"请输入密码" forToastType:2];
            return NO;
        }else{
            return YES;
        }
    }
}

- (IBAction)forget:(id)sender {
    NSString *contactMessage = [NSString stringWithFormat:@"请联系管理员:%@",self.contactParam.paramContent];
    Alert(contactMessage, self,10002);
}

- (BOOL)isChinese:(NSString *)string{
    NSString *str = @"i'm a 苹果。...";
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return YES;
    }
    return NO;
}


@end
