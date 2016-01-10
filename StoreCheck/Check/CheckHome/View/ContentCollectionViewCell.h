//
//  ContentCollectionViewCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;
@interface ContentCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *contentText;

- (void)fillCellWithTopic:(Topic *)topic;

@end
