//
//  RepairListCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repairType;
@property (weak, nonatomic) IBOutlet UILabel *repairTips;
@property (weak, nonatomic) IBOutlet UILabel *repairTime;

@end
