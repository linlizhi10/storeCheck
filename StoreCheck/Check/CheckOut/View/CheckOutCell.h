//
//  CheckOutCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLZAction;
@interface CheckOutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *actionRemark;
@property (weak, nonatomic) IBOutlet UILabel *actionDate;

- (void)fillCellWithAction:(LLZAction *)action;

@end
