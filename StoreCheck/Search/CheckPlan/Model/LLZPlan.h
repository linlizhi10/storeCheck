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
@property (nonatomic, assign) int durationTime;
@property (nonatomic, copy) NSString * memo;
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * createUserId;
@property (nonatomic, copy) NSString * checkTime;
@property (nonatomic, copy) NSString * checkUserId;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, copy) NSString * modifyUserId;
//object init
- (instancetype)initWithPlanId:(NSInteger)planId
                      planDate:(NSString *)planDate
                        userId:(NSString *)userId
                        storeId:(NSString *)storeId
                       checkType:(int)checkType
                    durationTime:(int)durationTime
                            memo:(NSString *)memo
                      createTime:(NSString *)createTime
                    createUserId:(NSString *)createUserId
                       checkTime:(NSString *)checkTime
                     checkUserId:(NSString *)checkUserId
                      modifyTime:(NSString *)modifyTime
                    modifyUserId:(NSString *)modifyUserId;
//class init
+ (instancetype)PlanWithPlanId:(NSInteger)planId
                      planDate:(NSString *)planDate
                          userId:(NSString *)userId
                         storeId:(NSString *)storeId
                       checkType:(int)checkType
                    durationTime:(int)durationTime
                            memo:(NSString *)memo
                      createTime:(NSString *)createTime
                    createUserId:(NSString *)createUserId
                       checkTime:(NSString *)checkTime
                     checkUserId:(NSString *)checkUserId
                      modifyTime:(NSString *)modifyTime
                    modifyUserId:(NSString *)modifyUserId;

@end
