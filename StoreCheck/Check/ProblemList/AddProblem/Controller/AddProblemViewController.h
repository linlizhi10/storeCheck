//
//  AddProblemViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface AddProblemViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *problemType;
- (IBAction)chooseType:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *problemDescribe;
- (IBAction)takePhoto:(id)sender;
- (IBAction)save:(id)sender;


@end