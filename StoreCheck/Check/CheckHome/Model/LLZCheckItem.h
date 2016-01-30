//
//  LLZCheckItem.h
//  StoreCheck
//
//  Created by skunk  on 15/12/29.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZCheckItem : NSObject
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) int checkType;
@property (nonatomic, assign) int score;
@property (nonatomic, copy) NSString * reasonCode;
@property (nonatomic, assign) int isNeed;
@property (nonatomic, assign) int sortNo;
@property (nonatomic, strong) NSString * modifyTime;
@property (nonatomic, assign) NSString * modifyUserId;
@property (nonatomic, assign) int useStatus;
//用于新店检查，是否拍照，默认是为NO
@property (nonatomic, assign) BOOL checkFlag;

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
                     useStatus:(int)useStatus;

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
                     useStatus:(int)useStatus;

+ (instancetype)parseItemDic:(NSDictionary *)dic;

@end
