//
//  CheckPlanCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckPlanCell.h"
#import "Plan.h"
@implementation CheckPlanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithPlan:(Plan *)plan
{
    self.date.text = [Tools dateToString:plan.date];
}

@end
