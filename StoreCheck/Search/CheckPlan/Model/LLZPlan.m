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

/*
 CheckBegTime = "<null>"; //计划开始时间 预留
 CheckEmpId = "<null>";  //计划人员id 预留
 CheckEndTime = "<null>";  //计划结束时间  预留
 CheckTypeId = 10;
 IsTran = 0;
 Memo = "\U591a\U5927";
 ModifyDate = "2015-07-21T19:25:26";
 ModifyEmpId = 20150721183531;
 PlanCorpId = 1; //实施计划店
 PlanDate = "2015-07-22T00:00:00";
 PlanEmpId = 20150721183531;
 PlanGuid = 20150721192422150;
 PlanHours = 4;
 RealHours = 0;
 StaTime = "<null>";
 Status = 10;
 TranTime = "<null>";
 */
+ (instancetype)parsePlanDic:(NSDictionary *)dic
{
    NSString *checkBeginTime = @"";
    if (![dic[@"CheckBeginTime"] isEqual:[NSNull null]]) {
        checkBeginTime = [NSString stringWithFormat:@"%@",dic[@"CheckBegTime"]];
    }
    NSString *checkEmpId = @"";
    if (![dic[@"CheckEmpId"] isEqual:[NSNull null]]) {
        checkEmpId = [NSString stringWithFormat:@"%@",dic[@"CheckEmpId"]];
    }
    NSString *checkEndTime = @"";
    if (![dic[@"CheckEndTime"] isEqual:[NSNull null]]) {
        checkEndTime = [NSString stringWithFormat:@"%@",dic[@"CheckEndTime"]];
    }
    int checkType = 0;
    if (![dic[@"CheckTypeId"] isEqual:[NSNull null]]) {
        checkType = [dic[@"CheckTypeId"] intValue];
    }
    int isTrans = 0;
    if (![dic[@"IsTran"] isEqual:[NSNull null]]) {
        isTrans = [dic[@"IsTran"] intValue];
    }
    NSString *memo = @"";
    if (![dic[@"Memo"] isEqual:[NSNull null]]) {
        memo = [NSString stringWithFormat:@"%@",dic[@"Memo"]];
    }
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
    }
    NSString *modifyEmpId = @"";
    if (![dic[@"ModifyEmpId"] isEqual:[NSNull null]]) {
        modifyEmpId = [NSString stringWithFormat:@"%@",dic[@"ModifyEmpId"]];
    }
    NSString *planStoreId = @"";
    if (![dic[@"PlanCorpId"] isEqual:[NSNull null]]) {
        planStoreId = [NSString stringWithFormat:@"%@",dic[@"PlanCorpId"]];
    }
    NSString *planDate = @"";
    if (![dic[@"PlanDate"] isEqual:[NSNull null]]) {
        planDate = [NSString stringWithFormat:@"%@",dic[@"PlanDate"]];
    }
    NSString *planEmpId = @"";
    if (![dic[@"PlanEmpId"] isEqual:[NSNull null]]) {
        planEmpId = [NSString stringWithFormat:@"%@",dic[@"PlanEmpId"]];
    }
    NSString *planGuid = @"";
    if (![dic[@"PlanGuid"] isEqual:[NSNull null]]) {
        planGuid = [NSString stringWithFormat:@"%@",dic[@"PlanGuid"]];
    }
    int planHours = 0;
    if (![dic[@"PlanHours"] isEqual:[NSNull null]]) {
        planHours = [dic[@"PlanHours"] intValue];
    }
    int realHours = 0;
    if (![dic[@"RealHours"] isEqual:[NSNull null]]) {
        realHours = [dic[@"RealHours"] intValue];
    }
    NSString *startTime = @"";
    if (![dic[@"StaTime"] isEqual:[NSNull null]]) {
        startTime = [NSString stringWithFormat:@"%@",dic[@"StaTime"]];
    }
    int status = 0;
    if (![dic[@"Status"] isEqual:[NSNull null]]) {
        status = [dic[@"Status"] intValue];
    }
    NSString *tranTime = @"";
    if (![dic[@"TranTime"] isEqual:[NSNull null]]) {
        tranTime = [NSString stringWithFormat:@"%@",dic[@"TranTime"]];
    }
    
    return [LLZPlan PlanWithPlanId:0
                          planDate:planDate
                            userId:planEmpId
                           storeId:planStoreId
                         checkType:checkType
                      durationTime:planHours
                              memo:memo
                        createTime:modifyDate
                      createUserId:modifyEmpId
                         checkTime:planDate
                       checkUserId:planEmpId
                        modifyTime:modifyDate
                      modifyUserId:modifyEmpId];
}
@end
