//
//  CheckListCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckListCell.h"
#import "LLZCheckItem.h"

@implementation CheckListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)fillCellWithItem:(LLZCheckItem *)item index:(NSInteger)index
{
    self.listNumber.text = [NSString stringWithFormat:@"%d",index];
    self.listContent.text = item.title;
    self.score.text = [NSString stringWithFormat:@"%d",item.score];
    
}

@end
