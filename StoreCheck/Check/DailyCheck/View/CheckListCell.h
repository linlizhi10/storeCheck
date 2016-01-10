//
//  CheckListCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLZCheckItem;
@interface CheckListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *listNumber;
@property (weak, nonatomic) IBOutlet UILabel *listContent;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (nonatomic, copy) NSString *reasonCode;

- (void)fillCellWithItem:(LLZCheckItem *)item index:(NSInteger)index; 

@end
