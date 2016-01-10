//
//  LLZQuestion.m
//  StoreCheck
//
//  Created by skunk  on 16/1/8.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import "LLZQuestion.h"

@implementation LLZQuestion

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
{
    if (self = [super init]) {
        self.storeId = storeId;
        self.userId = userId;
        self.photoDate = photoDate;
        self.itemId = itemId;
        self.questionDesc = questionDesc;
        self.imageFile1 = imageFile1;
        self.imageFile2 = imageFile2;
        self.isSolved = isSolved;
        self.sortNo = sortNo;
        self.modifyTime = modifyTime;
        self.modifyUserId = modifyUserId;
    }
    return self;
}
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
{
    return [[LLZQuestion alloc] initWithStoreId:storeId
                                      photoDate:photoDate
                                         userId:userId
                                         itemId:itemId
                                   questionDesc:questionDesc
                                     imageFile1:imageFile1
                                     imageFile2:imageFile2
                                       isSolved:isSolved
                                         sortNo:sortNo
                                     modifyTime:modifyTime
                                   modifyUserId:modifyUserId];
}

@end
