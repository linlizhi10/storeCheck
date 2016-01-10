//
//  CheckPlanViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckPlanViewController : BaseViewController
- (IBAction)dateOrder:(id)sender;
- (IBAction)storeOrder:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *planTable;

@end
