//
//  NoticeViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface NoticeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *noticeContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *readFlag;
- (IBAction)preMessage:(id)sender;
- (IBAction)nextMessage:(id)sender;
- (IBAction)readFlagChanged:(id)sender;


@end
