//
//  StoreLIstCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Store;
@interface StoreListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *storeId;
@property (weak, nonatomic) IBOutlet UILabel *storeName;

- (void)fillCellWithStore:(Store *)store;

@end
