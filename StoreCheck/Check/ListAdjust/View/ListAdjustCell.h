//
//  ListAdjustCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLZPhoto;

typedef void(^ CompareBlock)(UIImage *beforeImage,UIImage *afterImage);
@interface ListAdjustCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *listType;
@property (weak, nonatomic) IBOutlet UIImageView *beforeImage;
@property (weak, nonatomic) IBOutlet UIImageView *afterImage;
@property (nonatomic, copy) CompareBlock compareBlock;

- (IBAction)compareAction:(id)sender;

- (void)fillCellWithPhoto:(LLZPhoto *)photo;

@end
