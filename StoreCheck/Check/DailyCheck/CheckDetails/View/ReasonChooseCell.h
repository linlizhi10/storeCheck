//
//  ReasonChooseCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/23.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLZReason;
@interface ReasonChooseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlagImage;
@property (nonatomic, assign) BOOL imageStatus;

- (void)fillCellWithReason:(LLZReason *)reason;

@end
