//
//  ChangePasswordViewController.m
//  StoreCheck
//
//  Created by Yangxingyi on 15/12/27.
//  Copyright © 2015年 linlizhi. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LogInViewController.h"
#import "NSString+MD5String.h"
#import "LLZUser.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTf;
@property (weak, nonatomic) IBOutlet UITextField *changedPasswordTf;
@property (weak, nonatomic) IBOutlet UITextField *reWritePasswordTf;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confirmAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
- (IBAction)cancleAction:(id)sender;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"修改密码"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancleAction:(id)sender {
    self.oldPasswordTf.text = @"";
    self.changedPasswordTf.text = @"";
    self.reWritePasswordTf.text = @"";
    
}
- (IBAction)confirmAction:(id)sender {
    if ([self.oldPasswordTf.text isEqualToString:@""]) {
        [WToast showWithText:@"请填写旧密码" forToastType:2];
    }else {
        NSString *passwordString = [self.oldPasswordTf.text getMd5String];
        LLZUser *user = [self getUserInfo];
        if ([passwordString isEqualToString:user.loginPwd]) {
            if ([self.changedPasswordTf.text isEqualToString:@""]) {
                [WToast showWithText:@"请输入新密码" forToastType:2];
            }else{
                if ([self.reWritePasswordTf.text isEqualToString:self.changedPasswordTf.text]) {
                    [WToast showWithText:@"修改成功" forToastType:0];
                    user.loginPwd = [self.changedPasswordTf.text getMd5String];
                    [self.appD.dataM updateUserInformation:user];
                    [UserDefaults setValue:@"" forKey:@"password"];
                    [self pushToViewContrller:[LogInViewController class]];
                }else{
                    [WToast showWithText:@"请检查两次输入密码是否相同" forToastType:2];
                }
            
            }
            
        }else{
            [WToast showWithText:@"原密码不正确" forToastType:2];
        }
    }
}
@end
