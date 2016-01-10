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
                    createUserId:(int)createUserId
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
                      createUserId:(int)createUserId
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
@end
