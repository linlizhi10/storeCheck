//
//  Plan.h
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZPlan : NSObject

@property (nonatomic, assign) NSInteger planId;
@property (nonatomic, copy) NSString * planDate;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, assign) int checkType;
@property (nonatomic, copy) NSString * durationTime;
@property (nonatomic, copy) NSString * memo;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * createUserId;
@property (nonatomic, copy) NSString * checkTime;
@property (nonatomic, copy) NSString * checkUserId;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, copy) NSString * modifyUserId;
//object init
- (instancetype)initWithDate:(NSDate *)date
                       store:(NSString *)store
                        time:(NSString *)time
                        tips:(NSString *)tips;
//class init
+ (instancetype)PlanWithDate:(NSDate *)date
                       store:(NSString *)store
                        time:(NSString *)time
                        tips:(NSString *)tips;

@end
