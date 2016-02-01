//
//  LLZRepair.h
//  StoreCheck
//
//  Created by 林立志 on 16/2/1.
//  Copyright © 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZRepair : NSObject
@property (nonatomic, assign) NSInteger repaireId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *repairDate;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, copy) NSString *repairDesc;
@property (nonatomic, copy) NSString *imageFile1;
@property (nonatomic, copy) NSString *imageFile2;
@property (nonatomic, assign) BOOL isSolved;
@property (nonatomic, assign) int sortNo;
@property (nonatomic, copy) NSString *modifyTime;
@property (nonatomic, copy) NSString *modifyUserId;
@property (nonatomic, assign) int tranStatus;
- (instancetype)initWithrepaireId:(NSInteger)repaireId
                        deviceId:(NSString *)deviceId
                          storeId:(NSString *)storeId
                       repairDate:(NSString *)repairDate
                           userId:(NSString *)userId
                           itemId:(NSInteger)itemId
                       repairDesc:(NSString *)repairDesc
                       imageFile1:(NSString *)imageFile1
                       imageFile2:(NSString *)imageFile2
                         isSolved:(BOOL)isSolved
                           sortNo:(int)sortNo
                       modifyTime:(NSString *)modifyTime
                     modifyUserId:(NSString *)modifyUserId
                       tranStatus:(int)tranStatus;
+ (instancetype)repairWithrepaireId:(NSInteger)repaireId
                           deviceId:(NSString *)deviceId
                            storeId:(NSString *)storeId
                         repairDate:(NSString *)repairDate
                             userId:(NSString *)userId
                             itemId:(NSInteger)itemId
                         repairDesc:(NSString *)repairDesc
                         imageFile1:(NSString *)imageFile1
                         imageFile2:(NSString *)imageFile2
                           isSolved:(BOOL)isSolved
                             sortNo:(int)sortNo
                         modifyTime:(NSString *)modifyTime
                       modifyUserId:(NSString *)modifyUserId
                         tranStatus:(int)tranStatus;
@end
