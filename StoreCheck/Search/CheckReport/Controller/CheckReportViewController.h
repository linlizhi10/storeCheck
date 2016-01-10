//
//  CheckReportViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckReportViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *dateTf;
- (IBAction)currentDate:(id)sender;
- (IBAction)searchAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *store;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *planningTime;
@property (weak, nonatomic) IBOutlet UILabel *actualTime;
@property (weak, nonatomic) IBOutlet UILabel *scoreAmount;
@property (weak, nonatomic) IBOutlet UILabel *excellentItem;
@property (weak, nonatomic) IBOutlet UILabel *unexcellentItem;
@property (weak, nonatomic) IBOutlet UILabel *photoNumber;
@property (weak, nonatomic) IBOutlet UILabel *problemNumber;
@property (weak, nonatomic) IBOutlet UILabel *solvedNumber;
@property (weak, nonatomic) IBOutlet UILabel *problemPhotoNumber;
@property (weak, nonatomic) IBOutlet UILabel *photoNumberAgain;
- (IBAction)preStoreAction:(id)sender;
- (IBAction)nextStoreAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
