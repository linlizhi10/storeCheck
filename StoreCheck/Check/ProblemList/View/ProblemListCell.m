//
//  ProblemListCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ProblemListCell.h"
#import "LLZQuestion.h"

@implementation ProblemListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithQuestion:(LLZQuestion *)question
{
    self.problemType.text = question.questionType;
    NSLog(@"questiondesc is %@",question.questionDesc);
    self.problemDescrible.text = question.questionDesc;
    self.dateLabel.text = question.photoDate;
}
@end
