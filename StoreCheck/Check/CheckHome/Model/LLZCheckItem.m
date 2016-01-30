//
//  LLZCheckItem.m
//  StoreCheck
//
//  Created by skunk  on 15/12/29.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZCheckItem.h"

@implementation LLZCheckItem

- (instancetype)initWithItemId:(NSInteger)itemId
                         title:(NSString *)title
                       content:(NSString *)content
                     checkType:(int)checkType
                         score:(int)score
                    reasonCode:(NSString *)reasonCode
                        isNeed:(int)isNeed
                        sortNo:(int)sortNo
                    modifyTime:(NSString *)modifyTime
                  modifyUserId:(NSString *)modifyUserId
                     useStatus:(int)useStatus
{
    if (self = [super init]) {
        //默认为no
        self.checkFlag = NO;
        self.itemId = itemId;
        self.title = title;
        self.content = content;
        self.checkType = checkType;
        self.score = score;
        self.reasonCode = reasonCode;
        self.isNeed = isNeed;
        self.sortNo = sortNo;
        self.modifyTime = modifyTime;
        self.modifyUserId = modifyUserId;
        self.useStatus = useStatus;
    }
    return self;
}

+ (instancetype)itemWithItemId:(NSInteger)itemId
                         title:(NSString *)title
                       content:(NSString *)content
                     checkType:(int)checkType
                         score:(int)score
                    reasonCode:(NSString *)reasonCode
                        isNeed:(int)isNeed
                        sortNo:(int)sortNo
                    modifyTime:(NSString *)modifyTime
                  modifyUserId:(NSString *)modifyUserId
                     useStatus:(int)useStatus
{
    return [[LLZCheckItem alloc] initWithItemId:itemId
                                          title:title
                                        content:content
                                      checkType:checkType
                                          score:score
                                     reasonCode:reasonCode
                                         isNeed:isNeed
                                         sortNo:sortNo
                                     modifyTime:modifyTime
                                   modifyUserId:modifyUserId
                                      useStatus:useStatus];
}
/*
 CheckTypeId = 10;
 IsNeed = 0;
 ItemCode = 1; //检查项目编号
 ItemContent = "\U62db\U724c\Uff082\Uff09\U3001\U5927\U95e8\Uff082\Uff09\U3001\U6a71\U7a97\Uff082\Uff09\U3001\U5916\U5899\U9762\Uff081\Uff09\U3001\U95e8\U524d\U6e05\U6d01\Uff081\Uff09\Uff0c\U5404\U7c7b\U6807\U8bc6\U724c\Uff082\Uff09\U3002";
 ItemId = 1;
 ItemNo = 1; //排序号
 ItemScore = 10;
 ItemTitle = "\U95e8\U524d\U6e05\U6d01";
 ModifyDate = "2015-08-26T11:16:49";
 ModifyEmpId = "";
 PhoMax = 0;
 PhoMin = 0;
 ReasonCode = "10,11,12,13,14,15,16";
 Status = 0;
 */
+ (instancetype)parseItemDic:(NSDictionary *)dic
{
    NSInteger itemId = 0;
    if (![dic[@"ItemId"] isEqual:[NSNull null]]) {
        itemId = [dic[@"ItemId"] integerValue];
    }
    int checkType = 0;
    if (![dic[@"CheckTypeId"] isEqual:[NSNull null]]) {
        checkType = [dic[@"CheckTypeId"] intValue];
    }
    int isNeed = 0;
    if (![dic[@"IsNeed"] isEqual:[NSNull null]]) {
        isNeed = [dic[@"IsNeed"] intValue];
    }
    NSInteger itemCode = 0;
    if (![dic[@"ItemCode"] isEqual:[NSNull null]]) {
        itemCode = [dic[@"ItemCode"] integerValue];
    }
    NSString *itemContent = @"";
    if (![dic[@"ItemContent"] isEqual:[NSNull null]]) {
        itemContent = [NSString stringWithFormat:@"%@",dic[@"ItemContent"]];
    }
    int sortNum = 0;
    if (![dic[@"ItemNo"] isEqual:[NSNull null]]) {
        sortNum = [dic[@"ItemNo"] intValue];
    }
    int score = 0;
    if (![dic [@"ItemScore"] isEqual:[NSNull null]]) {
        score = [dic[@"ItemScore"] intValue];
    }
    NSString *itemTitle = @"";
    if (![dic[@"ItemTitle"] isEqual:[NSNull null]]) {
        itemTitle = [NSString stringWithFormat:@"%@",dic[@"ItemTitle"]];
    }
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
    }
    NSString *modifyEmpId = @"";
    if (![dic[@"ModifyEmpId"] isEqual:[NSNull null]]) {
        modifyEmpId = [NSString stringWithFormat:@"%@",dic[@"ModifyEmpId"]];
    }
    int photoMax = 0;
    if (![dic[@"PhoMax"] isEqual:[NSNull null]]) {
        photoMax = [dic[@"PhoMax"] intValue];
    }
    int photoMin = 0;
    if (![dic[@"PhoMin"] isEqual:[NSNull null]]) {
        photoMin = [dic[@"PhoMin"] intValue];
    }
    NSString *reasonCode = @"";
    if (![dic[@"ReasonCode"] isEqual:[NSNull null]]) {
        reasonCode = [NSString stringWithFormat:@"%@",dic[@"ReasonCode"]];
    }
    int status = 0;
    if (![dic[@"Status"] isEqual:[NSNull null]]) {
        status = [dic[@"Status"] intValue];
    }
    return [LLZCheckItem itemWithItemId:itemId
                                  title:itemTitle
                                content:itemContent
                              checkType:checkType
                                  score:score
                             reasonCode:reasonCode
                                 isNeed:isNeed
                                 sortNo:sortNum
                             modifyTime:modifyDate
                           modifyUserId:modifyEmpId
                              useStatus:status];
}

@end
