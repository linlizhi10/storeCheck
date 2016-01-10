//
//  CheckOutViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckOutViewController.h"
#import "CheckOutCell.h"
#import "LLZAction.h"
#import "LLZUser.h"
#import "Store.h"
#import "DrawSignView.h"

@interface CheckOutViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray * actionArr;

@end

@implementation CheckOutViewController

static NSString *cellI = @"CheckOutCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"离店"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self dataPrepared];
    RegisterNib(cellI, self.checkOutTable);
    BOOL checkIn = [UserDefaults boolForKey:@"checkIn"];
    if (checkIn) {
        self.checkOutButton.enabled = YES;
    }else{
        self.checkOutButton.enabled = NO;
    }
}

- (void)dataPrepared
{
    Store *store = [self getStoreInfo];
    self.storeId.text = store.storeId;
    self.storeName.text = [store.storeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.storeAddress.text = [store.storeAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.actionArr = [self.appD.dataM getAction];
    for (LLZAction *action in self.actionArr) {
        NSLog(@"action is %@",action);
    }
    if (self.actionArr.count == 0) {
        [self.checkOutTable setHidden:YES];
    }else{
        [self.checkOutTable setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckOutCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    
    ;
    LLZAction *action = self.actionArr[indexPath.row];
    [cell fillCellWithAction:action];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark ############ check out ###########
- (IBAction)checkOutAction:(id)sender {
    [self signViewPop];
}

- (void)signViewPop
{
    DrawSignView *signView = [[DrawSignView alloc] init];
    signView.signCallBackBlock = ^(UIImage *image){
        if ([UserDefaults objectForKey:@"user"]) {
            LLZUser *user = [self getUserInfo];
            if ([UserDefaults objectForKey:@"selectStore"]) {
                Store *store = [self getStoreInfo];
                NSString *signTime = [self.dateFormatterTwo stringFromDate:[NSDate date]];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                LLZAction *action = [LLZAction actionWithTransStatus:0
                                                            userName:user.userName
                                                              userId:user.userId
                                                           storeName:store.storeName
                                                           storeCode:store.storeId
                                                              remark:@"离店"
                                                            signTime:signTime
                                                            signName:imageData];

                //test
                [self.appD.dataM insertAction:action];
            }else{
                NSLog(@"not checkin");
            }
            
        }else{
            NSLog(@"not login");
        }
        [UserDefaults setObject:nil forKey:@"selectStore"];
        [UserDefaults setBool:NO forKey:@"checkIn"];
    
    };
    [self.view addSubview:signView];
    
}

@end
