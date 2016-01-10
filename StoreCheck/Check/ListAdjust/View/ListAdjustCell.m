//
//  ListAdjustCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ListAdjustCell.h"
#import "LLZPhoto.h"

@implementation ListAdjustCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)compareAction:(id)sender {
    self.compareBlock(_beforeImage.image,_afterImage.image);
}

- (void)fillCellWithPhoto:(LLZPhoto *)photo
{
    self.listType.text = photo.itemTitle;
    self.beforeImage.image = [UIImage imageWithContentsOfFile:ImagePath(photo.imageFile1)];
    self.afterImage.image = [UIImage imageWithContentsOfFile:ImagePath(photo.imageFile2)];
}
@end
