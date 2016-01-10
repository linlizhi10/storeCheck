//
//  ChangeInformationViewController.m
//  StoreCheck
//
//  Created by Yangxingyi on 15/12/27.
//  Copyright © 2015年 linlizhi. All rights reserved.
//

#import "ChangeInformationViewController.h"
#import "LLZUser.h"

@interface ChangeInformationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userCode;
@property (weak, nonatomic) IBOutlet UILabel *loginName;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UITextField *userNametf;
- (IBAction)confirmAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNUmbertf;
@end

@implementation ChangeInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"修改资料"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self setPersonalInformation];
}

- (void)setPersonalInformation
{
    if ([UserDefaults objectForKey:@"user"]) {
        LLZUser *user = [self getUserInfo];
        self.userCode.text = user.userCode;
        self.loginName.text = user.loginName;
        self.userNametf.placeholder = user.userName;
        self.phoneNUmbertf.placeholder = user.contactNumber;
    }else{
        self.userCode.text = @"";
        self.loginName.text = @"";
        self.userNametf.placeholder = @"";
        self.phoneNUmbertf.placeholder = @"";
        [self.confirmButton setHidden:YES];
        [self.cancleButton setHidden:YES];
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

- (IBAction)confirmAction:(id)sender {
    LLZUser *user = [self getUserInfo];
    user.userName = self.userNametf.text;
    user.contactNumber = self.phoneNUmbertf.text;
    [self.appD.dataM updateUserInformation:user];
    //send to server
}

- (IBAction)cancelAction:(id)sender {
    LLZUser *user = [self getUserInfo];
    self.userNametf.placeholder = user.userName;
    self.phoneNUmbertf.placeholder = user.contactNumber;
    
}
@end
