//
//  ProblemListCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  LLZQuestion;
@interface ProblemListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *problemType;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *problemDescrible;
- (void)fillCellWithQuestion:(LLZQuestion *)question;
@end
