//
//  CheckListCell.h
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLZCheckItem;
typedef void(^TakePhotoBlock) ();
@interface NewCheckListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *listNumber;
@property (weak, nonatomic) IBOutlet UILabel *listContent;
@property (weak, nonatomic) IBOutlet UILabel *checkStatus;
@property (nonatomic, copy) TakePhotoBlock takePhotoBlock;
- (IBAction)takePhoto:(id)sender;

- (void)fillCellWithItem:(LLZCheckItem *)item andIndex:(NSInteger)index;

@end
