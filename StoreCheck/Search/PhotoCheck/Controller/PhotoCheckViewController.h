//
//  PhotoCheckViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoCheckViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *dateTf;
- (IBAction)searchAction:(id)sender;
- (IBAction)currentDate:(id)sender;
- (IBAction)prePhoto:(id)sender;
- (IBAction)nextPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *currentImage;

@end
