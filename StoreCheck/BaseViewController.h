//
//  ViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/12.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Store;
@class LLZUser;
@interface BaseViewController : UIViewController
@property (nonatomic, strong) AppDelegate * appD;
@property (nonatomic, strong) NSDateFormatter * dateFormatterOne;
@property (nonatomic, strong) NSDateFormatter * dateFormatterTwo;
@property (nonatomic, strong) dispatch_source_t timeCount;

//set left button
- (void)setLeftButton:(id)obj;
//set roght button
- (void)setRightButton:(id)obj;
//center title
- (void)setCenterButton:(id)obj;
//push action
- (void)pushToViewContrller:(Class)className;
- (void)startTimeCount;
- (void)leftButtonAction:(UIButton *)sender;
- (void)setNavigationBar:(UIColor *)color;

- (Store *)getStoreInfo;
- (LLZUser *)getUserInfo;

@end

