//
//  ReasonChooseCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/23.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ReasonChooseCell.h"
#import "LLZReason.h"

@implementation ReasonChooseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fillCellWithReason:(LLZReason *)reason
{
    self.reason.text = reason.reasonDesc;
    self.selectFlagImage.image = [UIImage imageNamed:@"select_no"];
}

@end
