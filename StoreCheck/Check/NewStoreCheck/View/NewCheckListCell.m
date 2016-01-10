//
//  CheckListCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "NewCheckListCell.h"
#import "LLZCheckItem.h"

@implementation NewCheckListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)takePhoto:(id)sender {
    self.takePhotoBlock();
}

- (void)fillCellWithItem:(LLZCheckItem *)item andIndex:(NSInteger)index
{
    self.listNumber.text = [NSString stringWithFormat:@"%ld",index];
    self.listContent.text = item.title;
    self.checkStatus.text = (item.checkFlag == YES) ? @"已检查" : @"未检查";
}

@end
