//
//  Store.h
//  StoreCheck
//
//  Created by skunk  on 15/11/18.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject
<NSCoding>

@property (nonatomic, assign) NSInteger  serverId;
@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, copy) NSString * storeName;
@property (nonatomic, copy) NSString * storeName2;
@property (nonatomic, copy) NSString * storeAddress;
@property (nonatomic, copy) NSString * Telphone;
@property (nonatomic, strong) NSString * modifyTime;
@property (nonatomic, assign) double Latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) int useStatus;
@property (nonatomic, assign) int modifyUserId;

- (instancetype)initWithServerId:(NSInteger)serverId
                         storeId:(NSString *)storeId
                      storeName:(NSString *)storeName
                     storeName2:(NSString *)storeName2
                   storeAddress:(NSString *)storeAddress
                       telphone:(NSString *)telphone
                     modifyTime:(NSString *)modifyTime
                       latitude:(double)latitude
                      longitude:(double)longitude
                     useStatus:(int)useStatus
                   modifyUserId:(int)modifyUserId;

+ (instancetype)storeWithServerId:(NSInteger)serverId
                          storeId:(NSString *)storeId
                        storeName:(NSString *)storeName
                       storeName2:(NSString *)storeName2
                     storeAddress:(NSString *)storeAddress
                         telphone:(NSString *)telphone
                       modifyTime:(NSString *)modifyTime
                         latitude:(double)latitude
                        longitude:(double)longitude
                        useStatus:(int)useStatus
                     modifyUserId:(int)modifyUserId;

+ (instancetype)parseStoreDic:(NSDictionary *)dic;

@end
