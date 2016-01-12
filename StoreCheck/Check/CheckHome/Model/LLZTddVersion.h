//
//  LLZTddVersion.h
//  StoreCheck
//
//  Created by skunk  on 16/1/11.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZTddVersion : NSObject

@property (nonatomic, assign) NSString * itemId;
@property (nonatomic, copy) NSString * tableName;
@property (nonatomic, copy) NSString * modifyDate;

- (instancetype)initWithItemId:(NSString *)itemId
                     tableName:(NSString *)tableName
                    modifyDate:(NSString *)modifyDate;
+ (instancetype)tddVersionWithItemId:(NSString *)itemId
                           tableName:(NSString *)tableName
                          modifyDate:(NSString *)modifyDate;
+ (instancetype)parseDic:(NSDictionary *)dic;
@end
