//
//  LLZButtonCell.h
//  StoreCheck
//
//  Created by skunk  on 15/12/28.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock) ();
@interface LLZButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;
@property (weak, nonatomic) IBOutlet UIButton *cellButtonAction;
@property (nonatomic, copy) ButtonBlock buttonBlock;

@end
