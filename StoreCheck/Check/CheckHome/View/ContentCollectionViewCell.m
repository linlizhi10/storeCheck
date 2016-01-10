//
//  ContentCollectionViewCell.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ContentCollectionViewCell.h"
#import "Topic.h"

@implementation ContentCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)fillCellWithTopic:(Topic *)topic
{
    if (![topic.image isEqualToString:@""]) {
        self.contentImage.image = [UIImage imageNamed:topic.image];
    }
    self.contentText.text = topic.title;
}

@end
