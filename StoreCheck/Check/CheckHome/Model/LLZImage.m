//
//  LLZImage.m
//  StoreCheck
//
//  Created by skunk  on 16/1/4.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import "LLZImage.h"

@implementation LLZImage

- (instancetype)initWithStoreId:(NSString *)storeId
                         userId:(NSString *)userId
                      imageDate:(NSString *)imageDate
                      imageType:(int)imageType
                         itemId:(NSInteger)itemId
                      imageDesc:(NSString *)imageDesc
                      imageData:(NSData *)imageData
                       imagPath:(NSString *)imagePath
                     modifyTime:(NSString *)modifyTime
                     tranStatus:(int)tranStatus
{
    if (self = [super init]) {
        self.storeId = storeId;
        self.userId = userId;
        self.imageDate = imageDate;
        self.imageType = imageType;
        self.itemId = itemId;
        self.imageDesc = imageDesc;
        self.imageData = imageData;
        self.imagePath = imagePath;
        self.modifyTime = modifyTime;
        self.tranStatus = tranStatus;
    }
    return self;
}

+ (instancetype)imageWithStoreId:(NSString *)storeId
                          userId:(NSString *)userId
                       imageDate:(NSString *)imageDate
                       imageType:(int)imageType
                          itemId:(NSInteger)itemId
                       imageDesc:(NSString *)imageDesc
                       imageData:(NSData *)imageData
                        imagPath:(NSString *)imagePath
                      modifyTime:(NSString *)modifyTime
                      tranStatus:(int)tranStatus
{
    return [[LLZImage alloc] initWithStoreId:storeId
                                      userId:userId
                                   imageDate:imageDate
                                   imageType:imageType
                                      itemId:itemId
                                   imageDesc:imageDesc
                                   imageData:imageData
                                    imagPath:imagePath
                                  modifyTime:modifyTime
                                  tranStatus:tranStatus];
}

@end
