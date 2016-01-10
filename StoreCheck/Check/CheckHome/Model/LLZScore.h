//
//  LLZScore.h
//  StoreCheck
//
//  Created by skunk  on 15/12/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZScore : NSObject
@property (nonatomic, assign) NSInteger scoreId;
@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, strong) NSString * checkDate;
@property (nonatomic, assign) int checkType;
@property (nonatomic, assign) int itemId;
@property (nonatomic, copy) NSString * reasonCode;
@property (nonatomic, copy) NSString * reasonContent;
@property (nonatomic, assign) int score;
@property (nonatomic, copy) NSString * imageFile1;
@property (nonatomic, copy) NSString * imageFile2;
@property (nonatomic, strong) NSString * modifyTime;
@property (nonatomic, assign) int tranStatus;

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
                     tranStatus:(int)tranStatus;

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
                      tranStatus:(int)tranStatus;
@end
