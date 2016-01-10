//
//  checkOut.h
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZAction : NSObject

@property (nonatomic, assign) int tranStatus;

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * storeName;
@property (nonatomic, copy) NSString * storeCode;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, strong) NSString * signTime;
@property (nonatomic, strong) NSData * signName;

- (instancetype)initWithTransStatus:(int)tranStatus
                           userName:(NSString *)userName
                             userId:(NSString *)userId
                          storeName:(NSString *)storeName
                          storeCode:(NSString *)storeCode
                             remark:(NSString *)remark
                           signTime:(NSString *)signTime
                           signName:(NSData *)signName;

+ (instancetype)actionWithTransStatus:(int)tranStatus
                             userName:(NSString *)userName
                               userId:(NSString *)userId
                            storeName:(NSString *)storeName
                            storeCode:(NSString *)storeCode
                               remark:(NSString *)remark
                             signTime:(NSString *)signTime
                             signName:(NSData *)signName;
@end
