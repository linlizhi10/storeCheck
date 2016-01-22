//
//  Store.m
//  StoreCheck
//
//  Created by skunk  on 15/11/18.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "Store.h"

@implementation Store

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
                    modifyUserId:(NSString *)modifyUserId
{
    if (self = [super init]) {
        _serverId = serverId;
        _storeId = storeId;
        _storeName = storeName;
        _storeAddress = storeAddress;
        _Telphone = telphone;
        _modifyTime = modifyTime;
        _Latitude = latitude;
        _longitude = longitude;
        _useStatus = useStatus;
        _modifyUserId = modifyUserId;
        _storeName2 = storeName2;
    }
    return self;
}

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
                     modifyUserId:(NSString *)modifyUserId;
{
    return [[Store alloc] initWithServerId:serverId
                                   storeId:storeId
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
    [aCoder encodeObject:self.modifyUserId forKey:@"modifyUserId"];
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
        self.modifyUserId = [aDecoder decodeObjectForKey:@"modifyUserId"];
    }
    return self;
}

+ (instancetype)parseStoreDic:(NSDictionary *)dic
{
    NSString *address = @"";
    if (![dic[@"CorpAddr"] isEqual:[NSNull null]]) {
        address = [NSString stringWithFormat:@"%@",dic[@"CorpAddr"]];
    }
    
    NSString *storeId = @"";
    if (![dic[@"CorpCode"] isEqual:[NSNull null]]) {
        storeId = [NSString stringWithFormat:@"%@",dic[@"CorpCode"]];
    }
    NSInteger serverId = 0;
    if (![dic[@"CorpId"] isEqual:[NSNull null]]) {
        serverId = [dic[@"CorpId"] integerValue];
    }
    NSString *storeName = @"";
    if (![dic[@"CorpName"] isEqual:[NSNull null]]) {
        storeName = [[NSString stringWithFormat:@"%@",dic[@"CorpName"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    NSString *telphone = @"";
    if (![dic[@"CorpPhone"] isEqual:[NSNull null]]) {
        telphone = [NSString stringWithFormat:@"%@",dic[@"CorpPhone"]];
    }
    double latitude = 0;
    if (![dic[@"Latitude"] isEqual:[NSNull null]]) {
        latitude = [dic[@"Latitude"] doubleValue];
    }
    double longitude = 0;
    if (![dic[@"Longitude"] isEqual:[NSNull null]]) {
      longitude = [dic[@"Longitude"] doubleValue];
    }
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
//        modifyDate = [modifyDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    NSString *optrId = @"";
    if (![dic[@"OptrId"] isEqual:[NSNull null]]) {
        optrId = [NSString stringWithFormat:@"%@",dic[@"OptrId"]];
    }
    int useStatus = 0;
    if (![dic[@"UseStatus"] isEqual:[NSNull null]]) {
        useStatus = [dic[@"UseStatus"] intValue];
    }
    NSString *vmEmpId = @"";
    if (![dic[@"VmEmpId"] isEqual:[NSNull null]]) {
        vmEmpId = [NSString stringWithFormat:@"%@",dic[@"VmEmpId"]];
    }
   
    
    return [Store storeWithServerId:serverId
                            storeId:storeId
                          storeName:storeName
                         storeName2:storeName
                       storeAddress:address
                           telphone:telphone
                         modifyTime:modifyDate
                           latitude:latitude
                          longitude:longitude
                          useStatus:useStatus
                       modifyUserId:optrId];
}

@end
