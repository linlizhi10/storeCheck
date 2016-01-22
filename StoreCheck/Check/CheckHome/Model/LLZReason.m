//
//  LLZReason.m
//  StoreCheck
//
//  Created by skunk  on 15/12/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZReason.h"

@implementation LLZReason
- (instancetype)initWithReasonId:(NSInteger)reasonId
                      reasonCode:(NSString *)reasonCode
                      reasonDesc:(NSString *)reasonDesc
                    createUserId:(NSString *)createUserId
                      modifyTime:(NSString *)modifyTime
                       useStatus:(int)useStatus
{
    if (self = [super init]) {
        //default to no
//        self.selectStatus = NO;
        self.reasonId = reasonId;
        self.reasonCode = reasonCode;
        self.reasonDesc = reasonDesc;
        self.createUserId = createUserId;
        self.modifyTime = modifyTime;
        self.useStatus = useStatus;
    }
    return self;
}

+ (instancetype)reasonWithReasonId:(NSInteger)reasonId
                        reasonCode:(NSString *)reasonCode
                        reasonDesc:(NSString *)reasonDesc
                      createUserId:(NSString *)createUserId
                        modifyTime:(NSString *)modifyTime
                         useStatus:(int)useStatus
{
    return [[LLZReason alloc] initWithReasonId:reasonId
                                    reasonCode:reasonCode
                                    reasonDesc:reasonDesc
                                  createUserId:createUserId
                                    modifyTime:modifyTime
                                     useStatus:useStatus];

}

+ (instancetype)parseResonDic:(NSDictionary *)dic
{
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
    }
    NSString *modifyUseId = @"";
    if (![dic[@"ModifyEmpId"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyEmpId"]];
    }
    NSString *reasonCode = @"";
    if (![dic[@"ReasonCode"] isEqual:[NSNull null]]) {
        reasonCode = [NSString stringWithFormat:@"%@",dic[@"ReasonCode"]];
    }
    NSString *reasonContent = @"";
    if (![dic[@"ReasonContent"] isEqual:[NSNull null]]) {
        reasonContent = [NSString stringWithFormat:@"%@",dic[@"ReasonContent"]];
    }
    NSInteger reasonId = 0;
    if (![dic[@"ReasonId"] isEqual:[NSNull null]]) {
        reasonId = [dic[@"ReasonId"] integerValue];
    }
    int sortNo = 0;
    if (![dic[@"SortNo"] isEqual:[NSNull null]]) {
        sortNo = [dic[@"SortNo"] intValue];
    }
    int status = 0;
    if (![dic[@"Status"] isEqual:[NSNull null]]) {
        status = [dic[@"Status"] intValue];
    }
    return [[LLZReason alloc] initWithReasonId:reasonId
                                    reasonCode:reasonCode
                                    reasonDesc:reasonContent
                                  createUserId:modifyUseId
                                    modifyTime:modifyDate
                                     useStatus:status];
}

@end
