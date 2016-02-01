//
//  CheckPlanCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckPlanCell.h"
#import "LLZPlan.h"
@implementation CheckPlanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithPlan:(LLZPlan *)plan
{
    self.date.text = [plan.checkTime substringToIndex:10];
    self.store.text = plan.s
}

@end
