//
//  checkOut.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZAction.h"

@implementation LLZAction

- (instancetype)initWithTransStatus:(int)tranStatus
                           userName:(NSString *)userName
                             userId:(NSString *)userId
                          storeName:(NSString *)storeName
                          storeCode:(NSString *)storeCode
                             remark:(NSString *)remark
                           signTime:(NSString *)signTime
                           signName:(NSData *)signName
{
    if (self = [super init]) {
        self.tranStatus = tranStatus;
        self.userId = userId;
        self.userName = userName;
        self.storeCode = storeCode;
        self.storeName = storeName;
        self.remark = remark;
        self.signName = signName;
        self.signTime = signTime;
    }
    return self;
}

+ (instancetype)actionWithTransStatus:(int)tranStatus
                             userName:(NSString *)userName
                               userId:(NSString *)userId
                            storeName:(NSString *)storeName
                            storeCode:(NSString *)storeCode
                               remark:(NSString *)remark
                             signTime:(NSString *)signTime
                             signName:(NSData *)signName;
{
    return [[LLZAction alloc] initWithTransStatus:tranStatus
                                         userName:userName
                                           userId:userId
                                        storeName:storeName
                                        storeCode:storeCode
                                           remark:remark
                                         signTime:signTime
                                         signName:signName];
}

@end
