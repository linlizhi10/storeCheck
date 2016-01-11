//
//  LLZTddVersion.m
//  StoreCheck
//
//  Created by skunk  on 16/1/11.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import "LLZTddVersion.h"

@implementation LLZTddVersion
- (instancetype)initWithItemId:(NSString *)itemId
                     tableName:(NSString *)tableName
                    modifyDate:(NSString *)modifyDate
{
    if (self = [super init]) {
        self.itemId = itemId;
        self.tableName = tableName;
        self.modifyDate = modifyDate;
    }
    return self;
}
+ (instancetype)tddVersionWithItemId:(NSString *)itemId
                           tableName:(NSString *)tableName
                          modifyDate:(NSString *)modifyDate
{
    return [[LLZTddVersion alloc] initWithItemId:itemId
                                       tableName:tableName
                                      modifyDate:modifyDate];
}

+ (instancetype)parseDic:(NSDictionary *)dic
{
    NSString *itemId = dic[@"ItemId"];
    NSString *tableName = dic[@"TabName"];
    NSString *modifyDate = dic[@"ModifyDate"];
    return [LLZTddVersion tddVersionWithItemId:itemId
                                     tableName:tableName
                                    modifyDate:modifyDate];
}

@end
