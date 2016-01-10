//
//  Store.m
//  StoreCheck
//
//  Created by skunk  on 15/11/18.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "Store.h"

@implementation Store

- (instancetype)initWithStoreId:(NSString *)storeId
                      storeName:(NSString *)storeName
                     storeName2:(NSString *)storeName2
                   storeAddress:(NSString *)storeAddress
                       telphone:(NSString *)telphone
                     modifyTime:(NSString *)modifyTime
                       latitude:(double)latitude
                      longitude:(double)longitude
                     useStatus:(int)userStatus
                   modifyUserId:(int)modifyUserId
{
    if (self = [super init]) {
        _storeId = storeId;
        _storeName = storeName;
        _storeAddress = storeAddress;
        _Telphone = telphone;
        _modifyTime = modifyTime;
        _Latitude = latitude;
        _longitude = longitude;
        _useStatus = userStatus;
        _modifyUserId = modifyUserId;
        _storeName2 = storeName2;
    }
    return self;
}

+ (instancetype)storeWithStoreId:(NSString *)storeId
                       storeName:(NSString *)storeName
                      storeName2:(NSString *)storeName2
                    storeAddress:(NSString *)storeAddress
                        telphone:(NSString *)telphone
                      modifyTime:(NSString *)modifyTime
                        latitude:(double)latitude
                       longitude:(double)longitude
                      useStatus:(int)useStatus
                    modifyUserId:(int)modifyUserId
{
    return [[Store alloc] initWithStoreId:storeId
                                storeName:storeName
                               storeName2:(NSString *)storeName2
                             storeAddress:storeAddress
                                 telphone:telphone
                               modifyTime:modifyTime
                                 latitude:latitude
                                longitude:longitude
                               useStatus:useStatus
                             modifyUserId:modifyUserId];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.storeId forKey:@"storeId"];
    [aCoder encodeObject:self.storeName forKey:@"storeName"];
    [aCoder encodeObject:self.storeName2 forKey:@"storeName2"];
    [aCoder encodeObject:self.storeAddress forKey:@"storeAddress"];
    [aCoder encodeObject:self.Telphone forKey:@"Telphone"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeObject:[NSNumber numberWithDouble:self.Latitude] forKey:@"Latitude"];
    [aCoder encodeObject:[NSNumber numberWithDouble:self.longitude] forKey:@"longitude"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.useStatus] forKey:@"useStatus"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.modifyUserId] forKey:@"modifyUserId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.storeId = [aDecoder decodeObjectForKey:@"storeId"];
        self.storeName = [aDecoder decodeObjectForKey:@"storeName"];
        self.storeName2 = [aDecoder decodeObjectForKey:@"storeName"];
        self.storeAddress = [aDecoder decodeObjectForKey:@"storeAddress"];
        self.Telphone = [aDecoder decodeObjectForKey:@"Telphone"];
        self.modifyTime = [aDecoder decodeObjectForKey:@"modifyTime"];
        self.Latitude = [[aDecoder decodeObjectForKey:@"Latitude"] doubleValue];
        self.longitude = [[aDecoder decodeObjectForKey:@"longitude"] doubleValue];
        self.useStatus = [[aDecoder decodeObjectForKey:@"useStatus"] intValue];
        self.modifyUserId = [[aDecoder decodeObjectForKey:@"modifyUserId"] intValue];
    }
    return self;
}

@end
