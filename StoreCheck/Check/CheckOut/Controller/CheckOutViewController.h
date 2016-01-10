//
//  CheckOutViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckOutViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *checkOutTable;
@property (weak, nonatomic) IBOutlet UILabel *storeId;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeAddress;
- (IBAction)checkOutAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkOutButton;

@end
