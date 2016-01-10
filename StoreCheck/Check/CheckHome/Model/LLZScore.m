//
//  LLZScore.m
//  StoreCheck
//
//  Created by skunk  on 15/12/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZScore.h"

@implementation LLZScore

- (instancetype)initWithScoreId:(NSInteger)scoreId
                        storeId:(NSString *)storeId
                         userId:(NSString *)userId
                      checkDate:(NSString *)checkDate
                      checkType:(int)checkType
                         itemId:(int)itemId
                     reasonCode:(NSString *)reasonCode
                  reasonContent:(NSString *)reasonContent
                          score:(int)score
                     imageFile1:(NSString *)imageFile1
                     imageFile2:(NSString *)imageFile2
                     modifyTime:(NSString *)modifyTime
                     tranStatus:(int)tranStatus
{
    if (self = [super init]) {
        self.scoreId = scoreId;
        self.storeId = storeId;
        self.userId= userId;
        self.checkDate = checkDate;
        self.checkType = checkType;
        self.itemId = itemId;
        self.reasonCode= reasonCode;
        self.reasonContent = reasonContent;
        self.score = score;
        self.imageFile1 = imageFile1;
        self.imageFile2 = imageFile2;
        self.modifyTime = modifyTime;
        self.tranStatus = tranStatus;
    }
    return self;
}

+ (instancetype)scoreWithScoreId:(NSInteger)scoreId
                         storeId:(NSString *)storeId
                          userId:(NSString *)userId
                       checkDate:(NSString *)checkDate
                       checkType:(int)checkType
                          itemId:(int)itemId
                      reasonCode:(NSString *)reasonCode
                   reasonContent:(NSString *)reasonContent
                           score:(int)score
                      imageFile1:(NSString *)imageFile1
                      imageFile2:(NSString *)imageFile2
                      modifyTime:(NSString *)modifyTime
                      tranStatus:(int)tranStatus
{
    return [[LLZScore alloc] initWithScoreId:scoreId
                                     storeId:storeId
                                      userId:userId
                                   checkDate:checkDate
                                   checkType:checkType
                                      itemId:itemId
                                  reasonCode:reasonCode
                               reasonContent:reasonContent
                                       score:score
                                  imageFile1:imageFile1
                                  imageFile2:imageFile2
                                  modifyTime:modifyTime
                                  tranStatus:tranStatus];
}
@end
