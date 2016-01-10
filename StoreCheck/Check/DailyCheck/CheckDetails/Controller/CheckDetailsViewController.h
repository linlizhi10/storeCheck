//
//  CheckDetailsViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/20.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface CheckDetailsViewController : BaseViewController
@property (nonatomic, assign) int totalCount                                                                                                    ;
@property (nonatomic, assign) int checkedCount;
@property (nonatomic, assign) int uncheckedCount;
@property (nonatomic, assign) int scoreString;
@property (nonatomic, strong) NSMutableArray *listArary;
@property (nonatomic, assign) NSInteger dealIndex;
@property (nonatomic, copy) NSString * titleName;
@property (weak, nonatomic) IBOutlet UITextView *itemContentT;
@property (weak, nonatomic) IBOutlet UILabel *amountCheckItems;
@property (weak, nonatomic) IBOutlet UILabel *checkedItems;
@property (weak, nonatomic) IBOutlet UILabel *uncheckedItems;
@property (weak, nonatomic) IBOutlet UILabel *score;
- (IBAction)zeroButtonAction:(id)sender;
- (IBAction)addAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *itemScore;
- (IBAction)fullScoreAction:(id)sender;
- (IBAction)decreaceAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
- (IBAction)takePhotos:(id)sender;
- (IBAction)reasonChooseAction:(id)sender;
- (IBAction)prePageAction:(id)sender;
- (IBAction)nextPageAction:(id)sender;
- (IBAction)gotoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pageTextFiled;


@end
