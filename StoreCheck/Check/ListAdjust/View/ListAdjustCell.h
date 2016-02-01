//
//  ListAdjustCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListAdjustModel;

typedef void(^ CompareBlock)(UIImage *beforeImage,UIImage *afterImage);
typedef void(^ BeforeBlock) ();
typedef void(^ AfterBlock) ();

@interface ListAdjustCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *listType;
@property (weak, nonatomic) IBOutlet UIImageView *beforeImage;
@property (weak, nonatomic) IBOutlet UIImageView *afterImage;
@property (nonatomic, copy) CompareBlock compareBlock;
@property (nonatomic, copy) BeforeBlock beforeBlock;
@property (nonatomic, copy) AfterBlock afterBlock;

- (IBAction)beforeButtonAction:(id)sender;
- (IBAction)afterButtonAction:(id)sender;
- (IBAction)compareAction:(id)sender;
- (void)fillCellWithPhoto:(ListAdjustModel *)adjust;

@end
