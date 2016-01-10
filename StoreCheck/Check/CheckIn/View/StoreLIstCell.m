//
//  StoreLIstCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "StoreListCell.h"
#import "Store.h"

@implementation StoreListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithStore:(Store *)store
{
    self.storeId.text = store.storeId;
    self.storeName.text = store.storeName;
}

@end
