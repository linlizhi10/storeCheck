//
//  LLZSwitchCell.h
//  StoreCheck
//
//  Created by skunk  on 15/12/28.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchBlock) ();
@interface LLZSwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (nonatomic, copy) SwitchBlock switchBlock;
- (IBAction)switchAction:(id)sender;

@end
