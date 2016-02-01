//
//  LLZRepair.m
//  StoreCheck
//
//  Created by 林立志 on 16/2/1.
//  Copyright © 2016年 linlizhi. All rights reserved.
//

#import "LLZRepair.h"

@implementation LLZRepair
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
                       tranStatus:(int)tranStatus
{
    if (self = [super init]) {
        _repaireId = repaireId;
        _deviceId = deviceId;
        _storeId = storeId;
        _repairDate = repairDate;
        _userId = userId;
        _itemId = itemId;
        _repairDesc = repairDesc;
        _imageFile1 = imageFile1;
        _imageFile2 = imageFile2;
        _isSolved = isSolved;
        _sortNo = sortNo;
        _modifyTime = modifyTime;
        _modifyUserId = modifyUserId;
        _tranStatus = tranStatus;
    }
    return  self;
}
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
                         tranStatus:(int)tranStatus
{
    return [[LLZRepair alloc] initWithrepaireId:repaireId
                                       deviceId:deviceId
                                        storeId:storeId
                                     repairDate:repairDate
                                         userId:userId
                                         itemId:itemId
                                     repairDesc:repairDesc
                                     imageFile1:imageFile1
                                     imageFile2:imageFile2
                                       isSolved:isSolved
                                         sortNo:sortNo
                                     modifyTime:modifyTime
                                   modifyUserId:modifyUserId
                                     tranStatus:tranStatus];
}

@end
