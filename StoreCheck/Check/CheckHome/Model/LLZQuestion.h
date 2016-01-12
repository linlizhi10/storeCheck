//
//  LLZQuestion.h
//  StoreCheck
//
//  Created by skunk  on 16/1/8.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZQuestion : NSObject

@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, copy) NSString * photoDate;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, copy) NSString * questionDesc;
@property (nonatomic, copy) NSString * imageFile1;
@property (nonatomic, copy) NSString * imageFile2;
@property (nonatomic, assign) BOOL isSolved;
@property (nonatomic, assign) int sortNo;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, copy) NSString * modifyUserId;
@property (nonatomic, assign) int tranStatus;

- (instancetype)initWithStoreId:(NSString *)storeId
                      photoDate:(NSString *)photoDate
                         userId:(NSString *)userId
                         itemId:(NSInteger)itemId
                   questionDesc:(NSString *)questionDesc
                     imageFile1:(NSString *)imageFile1
                     imageFile2:(NSString *)imageFile2
                       isSolved:(BOOL)isSolved
                         sortNo:(int)sortNo
                     modifyTime:(NSString *)modifyTime
                   modifyUserId:(NSString *)modifyUserId
                     tranStatus:(int)tranStatus;

+ (instancetype)questionWithStoreId:(NSString *)storeId
                          photoDate:(NSString *)photoDate
                             userId:(NSString *)userId
                             itemId:(NSInteger)itemId
                       questionDesc:(NSString *)questionDesc
                         imageFile1:(NSString *)imageFile1
                         imageFile2:(NSString *)imageFile2
                           isSolved:(BOOL)isSolved
                             sortNo:(int)sortNo
                         modifyTime:(NSString *)modifyTime
                       modifyUserId:(NSString *)modifyUserId
                         tranStatus:(int)tranStatus;
;
@end
