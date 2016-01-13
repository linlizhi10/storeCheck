//
//  AppDelegate.h
//  StoreCheck
//
//  Created by skunk  on 15/11/12.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//location information
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) DataManager * dataM;
@property (nonatomic, assign) BOOL locationSuccess;
@property (nonatomic, assign) NSInteger netStatus;

@end

