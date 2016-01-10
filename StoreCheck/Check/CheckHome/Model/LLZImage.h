//
//  LLZImage.h
//  StoreCheck
//
//  Created by skunk  on 16/1/4.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZImage : NSObject

@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * imageDate;
@property (nonatomic, assign) int imageType;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, copy) NSString * imageDesc;
//后期改动
@property (nonatomic, strong) NSData * imageData;
//新改动 改为存储image的文件名，加document的绝对路径
@property (nonatomic, copy) NSString * imagePath;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, assign) int tranStatus;

- (instancetype)initWithStoreId:(NSString *)storeId
                         userId:(NSString *)userId
                      imageDate:(NSString *)imageDate
                      imageType:(int)imageType
                         itemId:(NSInteger)itemId
                      imageDesc:(NSString *)imageDesc
                      imageData:(NSData *)imageData
                       imagPath:(NSString *)imagePath
                     modifyTime:(NSString *)modifyTime
                     tranStatus:(int)tranStatus;

+ (instancetype)imageWithStoreId:(NSString *)storeId
                          userId:(NSString *)userId
                       imageDate:(NSString *)imageDate
                       imageType:(int)imageType
                          itemId:(NSInteger)itemId
                       imageDesc:(NSString *)imageDesc
                       imageData:(NSData *)imageData
                        imagPath:(NSString *)imagePath
                      modifyTime:(NSString *)modifyTime
                      tranStatus:(int)tranStatus;

@end
