//
//  PersonalInformationViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "LLZUser.h"

@interface PersonalInformationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *loginName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"个人信息"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self setPersonalInformation];
}

- (void)setPersonalInformation
{
    if ([UserDefaults objectForKey:@"user"]) {
        LLZUser *user = [self getUserInfo];
        self.userId.text = user.userCode;
        self.userName.text = user.userName;
        self.loginName.text = user.loginName;
        self.phoneNumber.text = user.contactNumber;
    }else{
        self.userId.text = @"";
        self.userName.text = @"";
        self.loginName.text = @"";
        self.phoneNumber.text = @"";
    }
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
