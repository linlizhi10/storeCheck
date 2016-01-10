//
//  DailyCheckViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface DailyCheckViewController : BaseViewController

@property (nonatomic, assign) int totalCount                                                                                                    ;
@property (nonatomic, assign) int checkedCount;
@property (nonatomic, assign) int uncheckedCount;
@property (nonatomic, assign) int score;

- (void)prepareData;

@end
