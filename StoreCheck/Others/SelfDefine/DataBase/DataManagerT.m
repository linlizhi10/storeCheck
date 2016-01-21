//
//  DataManagerT.m
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "DataManagerT.h"
#import "Store.h"

@implementation DataManagerT

static DataManagerT *dataB = nil;
static NSString *dataBaseName = @"StoreCheckOriginal.db";

+ (instancetype)shareDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataB = [[DataManagerT alloc] init];
    });
    return dataB;
}

- (instancetype)init
{
    if (self = [super init]) {
        _dataBase = [FMDatabase databaseWithPath:DocumentPath(dataBaseName)];
        BOOL dataBaseOpen = [_dataBase open];
        if (!dataBaseOpen) {
            NSLog(@"error is %@",[_dataBase lastErrorMessage]);
        }
    }
    return self;
}

- (void)createStoreTable
{
    NSString *createSqlString = @"create table if not exists Store(id INTEGER,storeId varchar(20),storeName varchar(100),storeAddress varchar(200),Telphone varchar(20),Latitude double,Longitude double,useStatus int,modifyTime datetime,modifyUserId int,expandParam varchar(40));";
    [self createTable:createSqlString];
}

- (void)createTable:(NSString *)createSql
{
    BOOL createFlag = [_dataBase executeUpdate:createSql];
    if (!createFlag) {
        NSLog(@"create failed reason is %@",[_dataBase lastErrorMessage]);
    }
}

- (void)insertStore:(Store *)store
{
    NSString *insertSql = [NSString stringWithFormat:@"insert into StoreTable(id,storeId,storeName,storeAddress,Telphone,Latitude ,Longitude ,useStatus,modifyTime ,modifyUserId ,expandParam) values('%ld','%@','%@','%@','%@','%lf','%lf','%d','%@','%d');",store.serverId,store.storeId,store.storeName,store.storeAddress,store.Telphone,store.Latitude,store.longitude,store.useStatus,store.modifyTime,store.modifyUserId];
    [self insertData:insertSql];
}

- (void)insertData:(NSString *)insertSql
{
    BOOL insertFlag = [_dataBase executeUpdate:insertSql];
    if (!insertFlag) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (NSArray *)getStore
{
    NSString *fetchSql = [NSString stringWithFormat:@"select * from Store"];
    return [NSArray arrayWithArray:[self fetchStore:fetchSql]];
}

- (NSMutableArray *)fetchStore:(NSString *)fetchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:fetchSql];
    while ([set next]) {
        NSString *serverId = [set longForColumn:@"id"];
        NSString *storeId = [set stringForColumn:@"StoreId"];
        NSString *storeName = [set stringForColumn:@"StoreName"];
        NSString *storeName2 = [set stringForColumn:@"storeName2"];
        NSString *storeAddress = [set stringForColumn:@"storeAddress"];
        NSString *telphone = [set stringForColumn:@"Telphone"];
        double latitude = [set doubleForColumn:@"Latitude"];
        double longitude = [set doubleForColumn:@"Longitude"];
        int userStatus = [set intForColumn:@"UseStatus"];
        NSDate *modifyDate = [set dateForColumn:@"ModifyTime"];
        int modifyUserId = [set intForColumn:@"ModifyUserId"];
        
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
        
        Store *store = [Store storeWithStoreId:storeId
                                     storeName:storeName
                                    storeName2:storeName2
                                  storeAddress:storeAddress
                                      telphone:telphone
                                    modifyTime:modifyDate
                                      latitude:latitude
                                     longitude:longitude
                                     useStatus:userStatus
                                  modifyUserId:modifyUserId];
        [arrM addObject:store];
    }
    return arrM;
}

- (void)dropTable
{
    NSString *dropSql = @"drop table StoreTable";
    [_dataBase executeUpdate:dropSql];
}

@end
