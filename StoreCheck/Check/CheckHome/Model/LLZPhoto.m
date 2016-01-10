//
//  LLZPhoto.m
//  StoreCheck
//
//  Created by skunk  on 16/1/5.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import "LLZPhoto.h"

@implementation LLZPhoto
- (instancetype)initWithStoreId:(NSString *)storeId
                         userId:(NSString *)userId
                      photoDate:(NSString *)photoDate
                      checkType:(int)checkType
                         itemId:(NSInteger)itemId
                      itemTitle:(NSString *)itemTitle
                     imageFile1:(NSString *)imageFile1
                     imageFile2:(NSString *)imageFile2
                     modifyTime:(NSString *)modifyTime
                     tranStatus:(int)tranStatus
{
    if (self = [super init]) {
        self.storeId = storeId;
        self.userId = userId;
        self.photoDate = photoDate;
        self.checkType = checkType;
        self.itemId = itemId;
        self.itemTitle = itemTitle;
        self.imageFile1 = imageFile1;
        self.imageFile2 = imageFile2;
        self.modifyTime = modifyTime;
        self.tranStatus = tranStatus;
    }
    return self;
}

+ (instancetype)photoWithStoreId:(NSString *)storeId
                          userId:(NSString *)userId
                       photoDate:(NSString *)photoDate
                       checkType:(int)checkType
                          itemId:(NSInteger)itemId
                       itemTitle:(NSString *)itemTitle
                      imageFile1:(NSString *)imageFile1
                      imageFile2:(NSString *)imageFile2
                      modifyTime:(NSString *)modifyTime
                      tranStatus:(int)tranStatus
{
    return [[LLZPhoto alloc] initWithStoreId:storeId
                                      userId:userId
                                   photoDate:photoDate
                                   checkType:checkType
                                      itemId:itemId
                                   itemTitle:itemTitle
                                  imageFile1:imageFile1
                                  imageFile2:imageFile2
                                  modifyTime:modifyTime
                                  tranStatus:tranStatus];
}

@end
