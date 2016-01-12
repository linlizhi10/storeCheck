//
//  Plan.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZPlan.h"

@implementation LLZPlan

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
                    modifyUserId:(NSString *)modifyUserId
{
    if (self = [super init]) {
        self.planId = planId;
        self.planDate = planDate;
        self.userId = userId;
        self.storeId = storeId;
        self.checkType = checkType;
        self.durationTime = durationTime;
        self.memo = memo;
        self.createTime = createTime;
        self.createUserId = createUserId;
        self.checkTime = checkTime;
        self.checkTime = checkTime;
        self.checkUserId = checkUserId;
        self.modifyTime = modifyTime;
        self.modifyUserId = modifyUserId;
    }
    return self;
}
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
                    modifyUserId:(NSString *)modifyUserId
{
    return [[LLZPlan alloc] initWithPlanId:planId
                                  planDate:planDate
                                    userId:userId
                                   storeId:storeId
                                 checkType:checkType
                              durationTime:durationTime
                                      memo:memo
                                createTime:createTime
                              createUserId:createUserId
                                 checkTime:checkTime
                               checkUserId:checkUserId
                                modifyTime:modifyTime
                              modifyUserId:modifyUserId];

}

@end
