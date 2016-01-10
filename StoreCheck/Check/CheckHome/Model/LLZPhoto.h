//
//  LLZPhoto.h
//  StoreCheck
//
//  Created by skunk  on 16/1/5.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZPhoto : NSObject

@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * photoDate;
@property (nonatomic, assign) int checkType;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, copy) NSString * itemTitle;
@property (nonatomic, copy) NSString * imageFile1;
@property (nonatomic, copy) NSString * imageFile2;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, assign) int tranStatus;

- (instancetype)initWithStoreId:(NSString *)storeId
                         userId:(NSString *)userId
                      photoDate:(NSString *)photoDate
                      checkType:(int)checkType
                         itemId:(NSInteger)itemId
                      itemTitle:(NSString *)itemTitle
                     imageFile1:(NSString *)imageFile1
                     imageFile2:(NSString *)imageFile2
                     modifyTime:(NSString *)modifyTime
                     tranStatus:(int)tranStatus;

+ (instancetype)photoWithStoreId:(NSString *)storeId
                          userId:(NSString *)userId
                       photoDate:(NSString *)photoDate
                       checkType:(int)checkType
                          itemId:(NSInteger)itemId
                       itemTitle:(NSString *)itemTitle
                      imageFile1:(NSString *)imageFile1
                      imageFile2:(NSString *)imageFile2
                      modifyTime:(NSString *)modifyTime
                      tranStatus:(int)tranStatus;

@end
