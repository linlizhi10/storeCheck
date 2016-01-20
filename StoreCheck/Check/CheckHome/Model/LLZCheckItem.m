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

@end
