//
//  CheckOutCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckOutCell.h"
#import "LLZAction.h"

@implementation CheckOutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithAction:(LLZAction *)action
{
    self.name.text = action.userName;
    self.storeName.text = action.storeName;
    self.actionRemark.text = action.remark;
    self.actionDate.text = action.signTime;
}

@end
