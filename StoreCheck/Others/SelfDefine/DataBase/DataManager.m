//
//  DataManager.m
//  StoreCheck
//
//  Created by skunk  on 15/11/18.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "DataManager.h"
#import "Store.h"
#import "LLZUser.h"
#import "LLZNotice.h"
#import "LLZAction.h"
#import "LLZCheckItem.h"
#import "LLZReason.h"
#import "LLZScore.h"
#import "LLZNotice.h"
#import "LLZImage.h"
#import "LLZPhoto.h"
#import "LLZTddVersion.h"
#import "LLZPlan.h"
#import "LLZQuestion.h"
#import "NewCheckItem.h"
#import "LLZParam.h"
#import "LLZRepair.h"

@implementation DataManager

static NSString *dataBaseName = @"StoreCheck.db";

+ (instancetype)shareDataManager
{
    static dispatch_once_t onceToken;
    static DataManager *dataM = nil;
    dispatch_once(&onceToken, ^{
        dataM = [[DataManager alloc] init];
    });
    return dataM;
}

- (instancetype)init
{
    if (self = [super init]) {
        _dataBase = [FMDatabase databaseWithPath:DocumentPath(dataBaseName)];
        NSLog(@"path is %@",DocumentPath(dataBaseName));
        BOOL openFlag = [_dataBase open];
        if (!openFlag) {
            NSLog(@"error is %@",[_dataBase lastErrorMessage]);
        }
    }
    return self;
}

- (void)createStoreTable
{
    NSString *createSqlString = @"create table if not exists Store(id INTEGER,StoreId varchar(20),storeName varchar(100),storeName2 varchar(100),storeAddress varchar(200),Telphone varchar(20),Latitude double,Longitude double,UseStatus int,ModifyTime varchar(30),ModifyUserId varchar(30),VmEmpld varchar(40));";
    [self createTable:createSqlString];
}

- (void)insertStore:(Store *)store
{
    NSString *storeSearchSql = [NSString stringWithFormat:@"select * from Store where storeId='%@';",store.storeId];
    NSArray *storeSearchArr  = [self fetchStore:storeSearchSql];
    NSLog(@"count is %lu",(unsigned long)storeSearchArr.count);
    if (storeSearchArr.count > 0) {
        [self updateStore:store];
    }else{
        NSString *insertSql = [NSString stringWithFormat:@"insert into Store(id,StoreId,storeName,storeName2,storeAddress,Telphone,Latitude ,Longitude ,UseStatus,ModifyTime ,ModifyUserId) values('%ld','%@','%@','%@','%@','%@','%lf','%lf','%d','%@','%@');",store.serverId,store.storeId,store.storeName,store.storeName2,store.storeAddress,store.Telphone,store.Latitude,store.longitude,store.useStatus,store.modifyTime,store.modifyUserId];
        [self insertData:insertSql];
    }
}

- (void)updateStore:(Store *)store
{
    NSLog(@"storename is %@",store.storeName);
    NSString *updateSql = [NSString stringWithFormat:@"update Store set StoreId='%@',storeName='%@',storeName2='%@',storeAddress='%@',Telphone='%@',Latitude='%lf',Longitude='%lf',UseStatus='%d',ModifyTime='%@',ModifyUserId='%@'where storeId='%@';",store.storeId,store.storeName,store.storeName2,store.storeAddress,store.Telphone,store.Latitude,store.longitude,store.useStatus,store.modifyTime,store.modifyUserId,store.storeId];
    BOOL rec = [_dataBase executeUpdate:updateSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (NSArray *)getStore
{
    NSString *fetchSql = [NSString stringWithFormat:@"select * from Store where UseStatus=0"];
    return [NSArray arrayWithArray:[self fetchStore:fetchSql]];
}

- (NSArray *)getAroudStoreWithLatitude:(double)latitude longitude:(double)longitude
{
    NSString *fetchSql = [NSString stringWithFormat:@"select * from Store where (Latitude-%lf)<0.02 and (Latitude-%lf)>(-0.02) and (Longitude-%lf)<0.02 and (Longitude-%lf)>(-0.02) and UseStatus=0;",latitude,latitude,longitude,longitude];
    return [self fetchStore:fetchSql];
}

- (NSArray *)searchStoreByKeyWord:(NSString *)keyWord
{
    NSString *keyWordSearchSql = [NSString stringWithFormat:@"select * from Store where storeName like '%%%@%%'or StoreId like '%@%%' or storeAddress like '%%%@%%' and UseStatus=0;",keyWord,keyWord,keyWord];
    return [self fetchStore:keyWordSearchSql];
}

- (NSMutableArray *)fetchStore:(NSString *)fetchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:fetchSql];
    while ([set next]) {
        NSInteger serverId = [set longForColumn:@"id"];
        NSString *storeId = [set stringForColumn:@"storeId"];
        NSString *storeName = [set stringForColumn:@"storeName"];
        NSString *storeName2 = [set stringForColumn:@"storeName2"];
        NSString *storeAddress = [set stringForColumn:@"storeAddress"];
        NSString *telphone = [set stringForColumn:@"Telphone"];
        double latitude = [set doubleForColumn:@"Latitude"];
        double longitude = [set doubleForColumn:@"Longitude"];
        int userStatus = [set intForColumn:@"useStatus"];
        NSString *modifyDate = [set stringForColumn:@"modifyTime"];
        NSString *modifyUserId = [set stringForColumn:@"modifyUserId"];
        Store *store = [Store storeWithServerId:serverId
                                        storeId:storeId
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

- (void)dropStoreTable
{
    [self dropTable:@"Store"];
}

- (void)createUserTable{
    NSString *createSqlString = @"create table if not exists Users(userId varchar(20),userCode varchar(20),userName varchar(20),LoginName varchar(20),userPwd varchar(20),duty varchar(20),contactPhone varchar(20),OrgId int,UseStatus int,ModifyTime varchar(30),ModifyUserId varchar(20),remark varchar(200));";
    [self createTable:createSqlString];
}

- (void)insertUser:(LLZUser *)user
{
    NSString *searchUserSql = [NSString stringWithFormat:@"select * from Users where userId='%@';",user.userId];
    NSArray *userArr = [self fetchUser:searchUserSql];
    if (userArr.count > 0) {
        [self updateUser:user];
    }else{
        NSString *insertSqlString = [NSString stringWithFormat:@"insert into Users (userId ,userCode ,userName ,LoginName ,userPwd ,duty ,contactPhone ,OrgId ,UseStatus ,ModifyTime ,ModifyUserId ,remark ) values('%@','%@','%@','%@','%@','%@','%@','%d','%d','%@','%@','%@');",user.userId,user.userCode,user.userName,user.loginName,user.loginPwd,user.duty,user.contactNumber,user.orgId,user.useStatus,user.modifyTime,user.modifyUserId,user.remark];
        [self insertData:insertSqlString];
        }
}

- (void)updateUser:(LLZUser *)user
{
    NSString *updateSql = [NSString stringWithFormat:@"update Users set userCode='%@',userName='%@',LoginName='%@',userPwd='%@',duty='%@',contactPhone='%@',OrgId='%d',UseStatus='%d',ModifyTime='%@',ModifyUserId='%@',remark='%@' where userId='%@';",user.userCode,user.userName,user.loginName,user.loginPwd,user.duty,user.contactNumber,user.orgId,user.useStatus,user.modifyTime,user.modifyUserId,user.remark,user.userId];
    BOOL rec = [_dataBase executeUpdate:updateSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (void)updateUserInformation:(LLZUser *)user
{
    NSString *updateSql = [NSString stringWithFormat:@"update Users set userName='%@', contactPhone='%@', userPwd='%@' where userId ='%@';",user.userName,user.contactNumber,user.loginPwd,user.userId];
    BOOL rec = [_dataBase executeUpdate:updateSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }else{
        NSLog(@"update sucess");
    }
}

- (NSArray *)getUserWithName:(NSString *)loginName passWord:(NSString *)passWord
{
    NSString *searchSql = [NSString stringWithFormat:@"select * from Users where LoginName = '%@' and userPwd = '%@';",loginName,passWord];
    return [self fetchUser:searchSql];
}

- (NSArray *)fetchUser:(NSString *)sql
{
    FMResultSet *set = [_dataBase executeQuery:sql];
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    while ([set next]) {
        NSString *userId = [set stringForColumn:@"userId"];
        NSString *userCode = [set stringForColumn:@"userCode"];
        NSString *userName = [set stringForColumn:@"userName"];
        NSString *loginName = [set stringForColumn:@"LoginName"];
        NSString *userPwd = [set stringForColumn:@"userPwd"];
        NSString *duty = [set stringForColumn:@"duty"];
        NSString *contactNumber = [set stringForColumn:@"contactPhone"];
        NSString *remark = [set stringForColumn:@"remark"];
        int orgId = [set intForColumn:@"OrgId"];
        int useStatus = [set intForColumn:@"UseStatus"];
        NSString *modifyUserId = [set stringForColumn:@"ModifyUserId"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        LLZUser *user = [LLZUser userWithuserId:userId
                                       userCode:userCode
                                       userName:userName
                                      loginName:loginName
                                       loginPwd:userPwd
                                           duty:duty
                                  contactNumber:contactNumber
                                         remark:remark
                                          orgId:orgId
                                      useStatus:useStatus
                                   modifyUserId:modifyUserId
                                     modifyTime:modifyTime];
        [arrm addObject:user];
    }
    return arrm;
}

- (void)dropUserTable
{
    [self dropTable:@"Users"];
}
#pragma mark ################ message #####################
- (void)createMessageTable
{
    //INTEGER primary key autoIncrement
    NSString *createSql = @"create table if not exists Message(id integer,title varchar(20),message varchar(200),dateTime varchar(30),isRead bool);";
    [self createTable:createSql];
}

- (NSArray *)getNotice
{
    NSString *searchSql = @"select * from Message";
   return [self fetchNotice:searchSql];
}

- (NSArray *)getUnreadNotice
{
    NSString *searchSql = @"select * from Message where isRead = '0'";
    return [self fetchNotice:searchSql];
}

- (void)insertMessage:(LLZNotice *)notice
{
    NSString *messageSearchSql = [NSString stringWithFormat:@"select * from Message where id='%ld';",notice.noticeId];
    NSArray *arrM = [self fetchNotice:messageSearchSql];
    if (arrM.count > 0) {
        [self updateNotice:notice];
    }
    NSString *messageInsertSql = [NSString stringWithFormat:@"insert into Message(id,title,message,dateTime,isRead) values('%ld','%@','%@','%@','%d');",(long)notice.noticeId,notice.noticeTitle,notice.noticeContent,notice.noticeDate,notice.readFlag];
    [self insertData:messageInsertSql];
    //完善 效率
//    NSString *messageSearchSql = [NSString stringWithFormat:@"select * from Message where id='%d';",notice.noticeId];
//    NSArray *messageSearchArr = [self fetchNotice:messageSearchSql];
//    if (messageSearchArr.count > 0) {
//        [self updateNotice:notice];
//    }else{
//        NSString *messageInsertSql = [NSString stringWithFormat:@"insert into Message(id,title,message,dateTime,isRead) values('%d','%@','%@','%@','%d');",notice.noticeId,notice.noticeTitle,notice.noticeContent,notice.noticeDate,notice.readFlag];
//        [self insertData:messageInsertSql];
//    }
}

- (void)updateNotice:(LLZNotice *)notice
{
    NSString *noticeUpdateSql = [NSString stringWithFormat:@"update Message set title='%@',message='%@',dateTime='%@' where id='%ld';",notice.noticeTitle,notice.noticeContent,notice.noticeDate,notice.noticeId];
    BOOL rec = [_dataBase executeUpdate:noticeUpdateSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (void)updateNoticeReadStatus:(LLZNotice *)notice
{
    NSString *updateSql = [NSString stringWithFormat:@"update Message set isRead='%d' where id='%ld';",notice.readFlag,(long)notice.noticeId];
    [_dataBase executeUpdate:updateSql];
}

- (NSArray *)fetchNotice:(NSString *)sql
{
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:sql];
    
    while ([set next]) {
        NSInteger noticeId = [set longForColumn:@"id"];
        NSString *noticeTitle = [set stringForColumn:@"title"];
        NSString *noticeDate = [set stringForColumn:@"dateTime"];
        NSString *noticeContent = [set stringForColumn:@"message"];
        BOOL readFlag = [set boolForColumn:@"isRead"];
        
        LLZNotice *notice = [LLZNotice noticeWithNoticeTitle:noticeTitle
                                                  noticeDate:noticeDate
                                               noticeContent:noticeContent
                                                    readFlag:readFlag
                                                    noticeId:noticeId];
        
        [arrm addObject:notice];
    }
    return arrm;
}

- (void)dropMessageTable
{
    [self dropTable:@"Message"];
}
#pragma mark ################ action #####################
- (void)createSignStoreTable
{
    NSString *createSql = @"create table if not exists SignStore(id integer primary key autoincrement, UserId varchar(20), SignTime varchar(30), storeCode varchar(20), signName blob, Remark varchar(20), TranStatus int);";
    [self createTable:createSql];
}

- (NSArray *)getActionByDate:(NSString *)dateString
{
    //关联查找
    NSString *actionSearchSql = [NSString stringWithFormat:@"select users.LoginName,store.storeName,SignStore.UserId,SignStore.SignTime,SignStore.storeCode,SignStore.signName,SignStore.Remark,SignStore.TranStatus from SignStore LEFT join Users on SignStore.UserId = users.userId left join Store on SignStore.storeCode = Store.StoreId  where (julianday(date(signtime)) - julianday(date('%@')) = 0) order by SignStore.SignTime desc;",dateString];
    return [self fetchAction:actionSearchSql];
}

- (NSArray *)fetchAction:(NSString *)sql
{
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:sql];
    while ([set next]) {
        NSString *userId = [set stringForColumn:@"UserId"];
        NSString *userName = [set stringForColumn:@"LoginName"];
        NSString *signTime = [set stringForColumn:@"SignTime"];
        NSString *storeCode = [set stringForColumn:@"storeCode"];
        NSString *storeName = [set stringForColumn:@"storeName"];
        NSData *signName = [set dataForColumn:@"signName"];
        NSString *remark = [set stringForColumn:@"Remark"];
        int tranStatus = [set intForColumn:@"TranStatus"];
        LLZAction *action = [LLZAction actionWithTransStatus:tranStatus
                                                    userName:userName
                                                      userId:userId
                                                   storeName:storeName
                                                   storeCode:storeCode
                                                      remark:remark
                                                    signTime:signTime
                                                    signName:signName];
        [arrm addObject:action];
    }
    return arrm;
}

- (void)insertAction:(LLZAction *)action
{
    NSString *inserSql = [NSString stringWithFormat:@"insert into SignStore(UserId,SignTime,storeCode,signName,Remark,TranStatus) values('%@','%@','%@','%@','%@','%d');",action.userId,action.signTime,action.storeCode,action.signName,action.remark,action.tranStatus];
    [self insertData:inserSql];
}

- (void)deleteAction
{
    BOOL rec = [_dataBase executeUpdate:@"delete from SignStore Where id = 14;"];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }else
    {
        NSLog(@"delete success");
    }
}

- (void)dropSignStoreTable
{
    [self dropTable:@"SignStore"];
}
#pragma mark ################ checkItem #####################
- (void)createCheckItemTable
{
    NSString *createSql = @"create table if not exists CheckItem(itemId integer primary key autoincrement,Title varchar(40),Content varchar(100),CheckType int,Score int,reasonCode varchar(40),isNeed int,SortNo int,ModifyTime varchar(30),ModifyUserId varchar(30),UseStatus int);";
    [self createTable:createSql];
}

- (NSArray *)getNewStoreCheckItemWithStoreId:(NSString *)storeId
                                      userId:(NSString *)userId

{
    //通过type=40和usestatus来判断？
    NSString *newStoreItemSearchSql = @"select * from CheckItem where CheckType=40 and UseStatus=0 order by sortNo,itemId;";
    NSArray *arrT = [self fetchItem:newStoreItemSearchSql];
    NSMutableArray *newItemArr = [[NSMutableArray alloc] init];
    for (LLZCheckItem *item in arrT) {
        NewCheckItem *newItem = [[NewCheckItem alloc] initWithCheckItem:item imageFile:@""];
        NSString *newStoreItemImageSql = [NSString stringWithFormat:@"select ImageFile from Image where storeId='%@' and UserId='%@' and itemId='%d';",storeId,userId,item.itemId];
        FMResultSet *set = [_dataBase executeQuery:newStoreItemImageSql];
        while ([set next]) {
            NSString *imageFile = [set stringForColumn:@"ImageFile"];
            newItem.imageFile = imageFile;
        }
        [newItemArr addObject:newItem];
    }
    return newItemArr;
}

- (NSArray *)getDailyCheckItem
{
    //select * from CheckItem where CheckType=10 and UseStatus=0 order by sortNo,itemId
    NSString *dailyCheckItemSearchSql = @"select * from CheckItem where CheckType=10 and UseStatus=0 order by sortNo,itemId";
    return [self fetchItem:dailyCheckItemSearchSql];
}

- (NSArray *)getProblemItem
{
    NSString *problemListItemSearchSql = @"select * from CheckItem where CheckType=30 and UseStatus=0 order by sortNo,itemId";
    return [self fetchItem:problemListItemSearchSql];
}

- (NSArray *)getListAdjustItem
{
    NSString *listAdjustItemSearchSql = @"select * from CheckItem where CheckType = 20 order by sortNo,itemId;";
    return [self fetchItem:listAdjustItemSearchSql];
}

- (NSArray *)fetchItem:(NSString *)sql
{
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:sql];
    while ([set next]) {
        NSInteger itemId = [set longForColumn:@"itemId"];
        NSString *title = [set stringForColumn:@"Title"];
        NSString *content = [set stringForColumn:@"Content"];
        int checkType = [set intForColumn:@"CheckType"];
        int score = [set intForColumn:@"Score"];
        NSString *reasonCode = [set stringForColumn:@"reasonCode"];
        int isNeed = [set intForColumn:@"IsNeed"];
        int sortNo = [set intForColumn:@"SortNo"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        NSString *modifyUserId = [set stringForColumn:@"modifyUserId"];
        int useStatus = [set intForColumn:@"UseStatus"];
        LLZCheckItem *item = [LLZCheckItem itemWithItemId:itemId
                                                    title:title
                                                  content:content
                                                checkType:checkType
                                                    score:score
                                               reasonCode:reasonCode
                                                   isNeed:isNeed
                                                   sortNo:sortNo
                                               modifyTime:modifyTime
                                             modifyUserId:modifyUserId
                                                useStatus:useStatus];
        [arrm addObject:item];
    }
    return arrm;
}

- (void)updateCheckItem:(LLZCheckItem *)item
{

}

- (void)insertCheckItem:(LLZCheckItem *)item
{
    NSString *searchItemSql = [NSString stringWithFormat:@"select * from CheckItem where itemId='%ld';",(long)item.itemId];
    NSArray *itemArr = [self fetchItem:searchItemSql];
    if (itemArr.count > 0) {
        [self updateItem:item];
    }else{
        NSString *itemInsertSql = [NSString stringWithFormat:@"insert into CheckItem(itemId ,Title ,Content ,CheckType ,Score ,reasonCode ,isNeed ,SortNo ,ModifyTime ,ModifyUserId ,UseStatus) values('%ld','%@','%@','%d','%d','%@','%d','%d','%@','%@','%d');",(long)item.itemId,item.title,item.content,item.checkType,item.score,item.reasonCode,item.isNeed,item.sortNo,item.modifyTime,item.modifyUserId,item.useStatus];
        [self insertData:itemInsertSql];
    }
    //    [_dataBase executeUpdate:@"insert into CheckItem(itemId ,Title ,Content ,CheckType ,Score ,reasonCode ,isNeed ,SortNo ,ModifyTime ,ModifyUserId ,UseStatus) values(?,?,?,?);",item.itemId,item.title];
}

- (void)updateItem:(LLZCheckItem *)item
{
    NSString *updateItemSql = [NSString stringWithFormat:@"update CheckItem set itemId='%ld',Title='%@',Content='%@',CheckType='%d',Score='%d',reasonCode='%@',IsNeed='%d',SortNo='%d',ModifyTime='%@',ModifyUserId='%@',UseStatus='%d' where itemId='%ld';",(long)item.itemId,item.title,item.content,item.checkType,item.score,item.reasonCode,item.isNeed,item.sortNo,item.modifyTime,item.modifyUserId,item.useStatus,(long)item.itemId];
    [_dataBase executeUpdate:updateItemSql];
}

- (void)updateCheckItemTable
{

}

- (void)dropCheckItemTable
{
    [self dropTable:@"CheckItem"];
}

- (int)totalItemCount
{
    NSString *getCountSql = @"select count(*) from CheckItem where UseStatus=0 and CheckType=10;";
    FMResultSet *set = [_dataBase executeQuery:getCountSql];
    while ([set next]) {
        int totalCount = [set intForColumn:@"count(*)"];
        return totalCount;
    }
    return 0;
}

- (int)checkedItemCountWithStore:(Store *)store user:(LLZUser *)user date:(NSString *)date
{
    NSString *checkSql = [NSString stringWithFormat:@"select count(*) from Score where  storeId='%@' and UserId='%@' and  CheckDate='%@';",store.storeId,user.userId,date];
    FMResultSet *set = [_dataBase executeQuery:checkSql];
    while ([set next]) {
        int totalCount = [set intForColumn:@"count(*)"];
        NSLog(@"checkedCount is %d",totalCount);
        return totalCount;
    }
    return 0;
}

- (int)scoreAmountWithStore:(Store *)store user:(LLZUser *)user date:(NSString *)date

{
    NSString *searchSql = [NSString stringWithFormat:@"select SUM(Score)  from Score where storeId='%@' and UserId='%@' and  checkDate='%@';",store.storeId,user.userId,date];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        int totalCount = [set intForColumn:@"SUM(Score)"];
        return totalCount;
    }
    return 0;
}

#pragma mark ################ reason #####################
- (void)createReasonTable
{
    NSString *reasonTableCreateSql = @"create table if not exists Reason(reasonId integer primary key autoincrement,reasonCode varchar(5),reasonDesc varchar(40),createUserId varchar(20), modifyTime varchar(30),UseStatus int);";
    [self createTable:reasonTableCreateSql];
}

- (void)insertReason:(LLZReason *)reason
{
    NSString *searchReasonSql = [NSString stringWithFormat:@"select * from Reason where reasonId='%ld';",(long)reason.reasonId];
    NSArray *arrReason = [self fetchReason:searchReasonSql];
    if (arrReason.count > 0) {
        [self updateReason:reason];
    }else{
        NSString *reasonInsertSql = [NSString stringWithFormat:@"insert into Reason(reasonCode,reasonDesc,createUserId,modifyTime,UseStatus) values('%@','%@','%@','%@','%d');",reason.reasonCode,reason.reasonDesc,reason.createUserId,reason.modifyTime,reason.useStatus];
        [self insertData:reasonInsertSql];
    }
}

- (LLZReason *)getResaonByReasonCode:(NSString *)reasonId
{
    if ([reasonId isEqualToString:@""]) {
        return nil;
    }
    NSString *searchReasonSql = [NSString stringWithFormat:@"select * from Reason where reasonCode='%@' and UseStatus=0;",reasonId];
    NSArray *reasonA = [self fetchReason:searchReasonSql];
    if (reasonA.count > 0) {
        return reasonA[0];
    }else{
        return nil;
    }
}

- (NSArray *)getResaonByReasonCodeArray:(NSArray *)reasonCodeArray
{
    NSMutableArray *arrRM =[[NSMutableArray alloc] init];
    for (NSString *reasonCode in reasonCodeArray) {
        LLZReason *reason = [self getResaonByReasonCode:reasonCode];
        if (reason != nil) {
            [arrRM addObject:reason];
        }
    }
    return arrRM;
}

- (NSArray *)fetchReason:(NSString *)searchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        NSInteger reasonId = [set longForColumn:@"reasonId"];
        NSString *reasonCode = [set stringForColumn:@"reasonCode"];
        NSString *reasonDesc = [set stringForColumn:@"reasonDesc"];
        NSString *createUserId = [set stringForColumn:@"createUserId"];
        NSString *modifyTime = [set stringForColumn:@"modifyTime"];
        int userStatus = [set intForColumn:@"UseStatus"];
        LLZReason *reason = [LLZReason reasonWithReasonId:reasonId
                                               reasonCode:reasonCode
                                               reasonDesc:reasonDesc
                                             createUserId:createUserId
                                               modifyTime:modifyTime
                                                useStatus:userStatus];
        [arrM addObject:reason];
    }
    return arrM;
}

- (void)updateReason:(LLZReason *)reason
{
    NSString *updateReasonSql = [NSString stringWithFormat:@"update Reason set reasonCode='%@',reasonDesc='%@',createUserId='%@',modifyTime='%@',UseStatus='%d' where reasonId='%ld';",reason.reasonCode,reason.reasonDesc,reason.createUserId,reason.modifyTime,reason.useStatus,reason.reasonId];
    [_dataBase executeUpdate:updateReasonSql];
}

- (void)dropReasonTable
{
    [self dropTable:@"Reason"];
}
#pragma mark ################ score #####################
- (void)createScoreTable
{
    NSString *createScoreSql = @"create table if not exists Score(scoreId integer primary key autoincrement,storeId varchar(20),UserId varchar(20),CheckDate varchar(20),CheckType int,itemId int,reasonCode varchar(40),reasonContent varchar(250),Score int,ImageFile1 varchar(60),ImageFile2 varchar(60),ModifyTime varchar(30),TranStatus int);";
    [self createTable:createScoreSql];
}

- (BOOL)insertScore:(LLZScore *)score
{
    NSString *scoreId = @"";
    NSString *scoreSearchSql = [NSString stringWithFormat:@"select scoreId from Score where storeId='%@' and UserId='%@' and itemId='%d';",score.storeId,score.userId,score.itemId];
    FMResultSet *set = [_dataBase executeQuery:scoreSearchSql];
    while ([set next]) {
        scoreId = [set stringForColumn:@"scoreId"];
    }
    if ([scoreId isEqualToString:@""]) {
        NSString *scoreInserSql = [NSString stringWithFormat:@"insert into Score(storeId,UserId,CheckDate,CheckType,itemId,reasonCode,reasonContent,Score,ImageFile1,ImageFile2,ModifyTime,TranStatus) values('%@','%@','%@','%d','%d','%@','%@','%d','%@','%@','%@','%d');",score.storeId,score.userId,score.checkDate,score.checkType,score.itemId,score.reasonCode,score.reasonContent,score.score,score.imageFile1,score.imageFile2,score.modifyTime,score.tranStatus];
        [self insertData:scoreInserSql];
        return YES;
    }else{
        NSLog(@"exists already");
        NSString *updateScoreSql = [NSString stringWithFormat:@"update Score set CheckDate='%@',reasonCode='%@',reasonContent='%@',Score='%d',ImageFile1='%@',ImageFile2='%@',ModifyTime='%@',TranStatus='%d' where scoreId='%@';",score.checkDate,score.reasonCode,score.reasonContent,score.score,score.imageFile1,score.imageFile2,score.modifyTime,score.tranStatus,scoreId];
        [_dataBase executeUpdate:updateScoreSql];
        return NO;
    }
}
#pragma mark ################ image #####################
- (void)createImageTable
{
    NSString *imageCreateSql = @"create table if not exists Image(imageId integer primary key autoincrement,storeId varchar(20),UserId varchar(20),ImageDate varchar(30),ImageType int,itemId integer,ImageDesc varchar(200),ImageFile varchar(100),ModifyTime varchar(30),TranStatus int);";
    [self createTable:imageCreateSql];
}

- (void)insertImageItem:(LLZImage *)image
{
    //old for test
    NSString *insertImageSql = [NSString stringWithFormat:@"insert into Image(storeId,UserId,ImageDate,ImageType,itemId,ImageFile,ImageDesc,ModifyTime,TranStatus) values('%@','%@','%@','%d','%ld','%@','%@','%@','%d');",image.storeId,image.userId,image.imageDate,image.imageType,(long)image.itemId,image.imagePath,image.imageDesc,image.modifyTime,image.tranStatus];
    //new
//    NSString *insertImageSql = [NSString stringWithFormat:@"insert into Image(storeId,UserId,ImageDate,ImageType,itemId,ImageDesc,ImageData,ImagePath,ModifyTime,TranStatus) values('%@','%@','%@','%d','%ld','%@','%@','%@','%@','%d');",image.storeId,image.userId,image.imageDate,image.imageType,image.itemId,image.imageDesc,image.imageData,image.imagePath,image.modifyTime,image.tranStatus];
    [self insertData:insertImageSql];
}

- (NSArray *)getImageInfo
{
    NSString *imageSearchSql = @"select * from Image";
    return [self fetchImage:imageSearchSql];
}

- (NSArray *)fetchImage:(NSString *)searchSql
{
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
//        NSInteger imageId = [set longForColumn:@"imageId"];
        NSString *storeId = [set stringForColumn:@"storeId"];
        NSString *userId = [set stringForColumn:@"UserId"];
        NSString *imageDate = [set stringForColumn:@"ImageDate"];
        int imageType = [set intForColumn:@"ImageType"];
        NSInteger itemId = [set longForColumn:@"itemId"];
        NSString *imageDesc = [set stringForColumn:@"ImageDesc"];
        NSData *imageData = [set dataForColumn:@"ImageData"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        int tranStatus = [set intForColumn:@"TranStatus"];
        LLZImage *image = [LLZImage imageWithStoreId:storeId
                                              userId:userId
                                           imageDate:imageDate
                                           imageType:imageType
                                              itemId:itemId
                                           imageDesc:imageDesc
                                           imageData:imageData
                                            imagPath:nil
                                          modifyTime:modifyTime
                                          tranStatus:tranStatus];
        [arrm addObject:image];
    }
    return arrm;
}
#pragma mark ################ photo #####################
- (void)createPhotoTable
{
    NSString *photoCreateSql = @"create table if not exists Photo(photoId integer primary key autoincrement,storeId varchar(20),UserId varchar(20),PhotoDate varchar(30),CheckType int,itemId integer,ImageFile1 varchar(100),ImageFile2 varchar(100),ModifyTime varchar(30),TranStatus int);";
    [self createTable:photoCreateSql];
}

- (void)insertPhoto:(LLZPhoto *)photo
{
    NSString *photoSearchSql = [NSString stringWithFormat:@"select * from where storeId='%@' and UserId='%@' and itemId='%ld';",photo.storeId,photo.userId,photo.itemId];
    NSArray *arrM = [self fetchPhoto:photoSearchSql];
    if (arrM.count > 0) {
        [self updatePhoto:photo];
    }else{
        NSString *photoInsertSql = [NSString stringWithFormat:@"insert into Photo(storeId,UserId,PhotoDate,CheckType,itemId,ImageFile1,ImageFile2,ModifyTime,TranStatus) values('%@','%@','%@','%d','%ld','%@','%@','%@','%d');",photo.storeId,photo.userId,photo.photoDate,photo.checkType,(long)photo.itemId,photo.imageFile1,photo.imageFile2,photo.modifyTime,photo.tranStatus];
        [self insertData:photoInsertSql];
       
    }
}

- (void)updatePhoto:(LLZPhoto *)photo
{
    NSString *photoUpdateSql = [NSString stringWithFormat:@"update Photo set ImageFile1='%@',ImageFile2='%@',TranStatus='%d' where storeId='%@' and UserId='%@' and itemId='%ld';",photo.imageFile1,photo.imageFile2,photo.tranStatus,photo.storeId,photo.userId,photo.itemId];
    BOOL rec = [_dataBase executeUpdate:photoUpdateSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (LLZPhoto *)getPhotoWithStoreId:(NSString *)storeId userId:(NSString *)userId itemId:(NSInteger)itemId
{
    NSString *photoSearch = [NSString stringWithFormat:@"select CheckItem.Title,Photo.storeId,Photo.UserId,Photo.PhotoDate,Photo.CheckType,Photo.itemId,Photo.ImageFile1,Photo.ImageFile2,Photo.ModifyTime,Photo.TranStatus from Photo LEFT join CheckItem on Photo.itemId = CheckItem.itemId where storeId='%@' and userId='%@' and itemId='%ld';",storeId,userId,(long)itemId];
    NSArray *arrD = [self fetchPhoto:photoSearch];
    if (arrD.count > 0) {
        return arrD[0];
    }else{
        return nil;
    }
}

- (NSArray *)fetchPhoto:(NSString *)searchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        NSString *storeId = [set stringForColumn:@"storeId"];
        NSString *userId = [set stringForColumn:@"userId"];
        NSString *photoDate = [set stringForColumn:@"PhotoDate"];
        int checkType = [set intForColumn:@"CheckType"];
        NSInteger itemId = [set longForColumn:@"itemId"];
        NSString *imageFile1 = [set stringForColumn:@"ImageFile1"];
        NSString *imageFile2 = [set stringForColumn:@"ImageFile2"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        int tranStatus = [set intForColumn:@"TranStatus"];
        NSString *itemTitle = [set stringForColumn:@"Title"];
        LLZPhoto *photo = [LLZPhoto photoWithStoreId:storeId
                                              userId:userId
                                           photoDate:photoDate
                                           checkType:checkType
                                              itemId:itemId
                                           itemTitle:itemTitle
                                          imageFile1:imageFile1
                                          imageFile2:imageFile2
                                          modifyTime:modifyTime
                                          tranStatus:tranStatus];
        [arrM addObject:photo];
    }
    return arrM;
}

- (void)dropPhotoTable
{
    [self dropTable:@"Photo"];
}

#pragma mark ################ Question #####################
- (void)createQuestionTable
{
    NSString *questionTableCreateSql = @"create table if not exists Question(QuestionId integer primary key autoincrement,storeId varchar(20),Date varchar(30),UserId varchar(20),itemId integer,QuestionDesc varchar(200),ImageFile1 varchar(60),ImageFile2 varchar(60),IsSolved bool,SortNo int,ModifyTime varchar(30),ModifyUserId varchar(20),TranStatus int);";
    [self createTable:questionTableCreateSql];
}
- (void)insertQuestion:(LLZQuestion *)question
{
    NSString *questionInsertSql = [NSString stringWithFormat:@"insert into Question(storeId,Date,UserId,itemId,QuestionDesc,ImageFile1,ImageFile2,IsSolved ,SortNo ,ModifyTime ,ModifyUserId ,TranStatus) values('%@','%@','%@','%ld','%@','%@','%@','%d','%d','%@','%@','%d');",question.storeId,question.photoDate,question.userId,question.itemId,question.questionDesc,question.imageFile1,question.imageFile2,question.isSolved,question.sortNo,question.modifyTime,question.modifyUserId,question.tranStatus];
    [self insertData:questionInsertSql];
}
- (NSArray *)getQuestionWithUserId:(NSString *)userId
                           storeId:(NSString *)storeId
                              date:(NSString *)date
{
    NSString *questionSearchSql = [NSString stringWithFormat:@"select Question.QuestionId,Question.storeId,Question.UserId,Question.itemId,CheckItem.Title,Question.QuestionDesc,Question.ImageFile1,Question.ImageFile2,Question.SortNo,Question.ModifyTime,Question.ModifyUserId,Question.TranStatus,Question.Date ,Question.IsSolved from Question left join Checkitem on Question.itemId = Checkitem.itemid where Question.storeId='%@' and Question.[UserId]='%@' and Question.Date>='%@';",storeId,userId,date];
    return [self fetchQuestion:questionSearchSql withType:2];
}

- (NSInteger)numberOfProblemWithUserId:(NSString *)userId
                         storeId:(NSString *)storeId
                            date:(NSString *)date;
{
    return [self getQuestionWithUserId:userId
                               storeId:storeId
                                  date:date].count;
}

- (NSInteger)numberOfProblemUnsolvedWithUserId:(NSString *)userId
                                       storeId:(NSString *)storeId
                                          date:(NSString *)date
{
    NSString *unsolvedSql = [NSString stringWithFormat:@"select * from Question where IsSolved=0 and storeId='%@' and UserId = '%@' and Date>'%@'",storeId,userId,date];
    return [self fetchQuestion:unsolvedSql withType:1].count;
}

- (NSArray *)fetchQuestion:(NSString *)searchSql withType:(int)type
{
    NSMutableArray *questionArrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        NSInteger qustionId = [set longForColumn:@"QuestionId"];
        NSString *storeId = [set stringForColumn:@"storeId"];
        NSString *questionDate = [set stringForColumn:@"Date"];
        NSString *userId = [set stringForColumn:@"UserId"];
        NSInteger itemId = [set longForColumn:@"itemId"];
        NSString *questionDesc = [set stringForColumn:@"QuestionDesc"];
        NSString *imageFile1 = [set stringForColumn:@"ImageFile1"];
        NSString *imageFile02 = [set stringForColumn:@"ImageFile2"];
        BOOL isSolved = [set boolForColumn:@"IsSolved"];
        int sortNo = [set intForColumn:@"SortNo"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        NSString *modifyUserId = [set stringForColumn:@"ModifyUserId"];
        int tranStatus = [set intForColumn:@"TranStatus"];
        LLZQuestion *question = [LLZQuestion questionWithStoreId:storeId
                                                       photoDate:questionDate
                                                          userId:userId
                                                          itemId:itemId
                                                    questionDesc:questionDesc
                                                      imageFile1:imageFile1
                                                      imageFile2:imageFile02
                                                        isSolved:isSolved
                                                          sortNo:sortNo
                                                      modifyTime:modifyTime
                                                    modifyUserId:modifyUserId
                                                      tranStatus:tranStatus];
        if (type == 2) {
            NSString *itemTitle = [set stringForColumn:@"Title"];
            question.questionType = itemTitle;
        }else{
            NSLog(@"no title");
        }
        [questionArrM addObject:question];
        
       
    }
    return questionArrM;
}

#pragma mark ################ tdd_version #####################
- (void)createTddVersionTable
{
    NSString *tddVersionCreateSql = @"create table if not exists Tdd_Version(ItemId varchar(30),TabName varchar(80),ModifyDate varchar(30));";
    [self createTable:tddVersionCreateSql];
}

- (void)insertTddVersion:(LLZTddVersion *)tddVersion
{
    NSString *tddVersionSearchSql = [NSString stringWithFormat:@"select * from Tdd_Version where ItemId='%@';",tddVersion.itemId];
    NSArray *arr = [self searchTddVersion:tddVersionSearchSql];
    if (arr.count > 0) {
        [self updateTddVersion:tddVersion];
    }else{
    NSString *insertVersionSql = [NSString stringWithFormat:@"insert into Tdd_Version(ItemId,TabName,ModifyDate) values('%@','%@','%@');",tddVersion.itemId,tddVersion.tableName,tddVersion.modifyDate];
    [self insertData:insertVersionSql];
    }
}

- (LLZTddVersion *)getMaxTddVersion
{
    NSString *searchMaxSql = @"select * from Tdd_Version  where ItemId=(select max(ItemId) from Tdd_Version);";
    if ([self searchTddVersion:searchMaxSql].count > 0) {
        return [self searchTddVersion:searchMaxSql][0];
    }
    return nil;
}

- (void)updateTddVersion:(LLZTddVersion *)tddVersion
{
    NSString *updateTddVersionSql = [NSString stringWithFormat:@"update Tdd_Version set TabName='%@',ModifyDate='%@' where ItemId='%@';",tddVersion.tableName,tddVersion.modifyDate,tddVersion.itemId];
    BOOL rec = [_dataBase executeUpdate:updateTddVersionSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (NSArray *)searchTddVersion:(NSString *)searchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        NSString *itemId = [set stringForColumn:@"ItemId"];
        NSString *tabName = [set stringForColumn:@"TabName"];
        NSString *modifyDate = [set stringForColumn:@"ModifyDate"];
        LLZTddVersion *tddVerison = [LLZTddVersion tddVersionWithItemId:itemId
                                                              tableName:tabName
                                                             modifyDate:modifyDate];
        [arrM addObject:tddVerison];
    }
    return arrM;
}

- (void)deleteTddVersion
{
    [self dropTable:@"Tdd_Version"];
}

#pragma mark ################ shopPlan #####################
- (void)createShopPlanTable
{
    NSString *shopPlanTableCreateSql = @"create table if not exists ShopPlan(planId integer primary key autoincrement,planDate varchar(30),userId varchar(20),storeId varchar(20),CheckType int,DurationTime int, Memo varchar(200),CreateTime varchar(30),CreateUserId varchar(30),CheckTime varchar(30),CheckUserId varchar(30),ModifyTime varchar(30),ModifyUserId varchar(30));";
    [self createTable:shopPlanTableCreateSql];
}

- (void)insertShopPlan:(LLZPlan *)plan
{
    NSString *planSearchSql = [NSString stringWithFormat:@"select * from ShopPlan where planId='%ld';",plan.planId];
    NSArray *planArr = [self fetchShopPlan:planSearchSql type:1];
    if (planArr.count > 0) {
        [self updatePlan:plan];
    }else{
        NSString *planInsertSql = [NSString stringWithFormat:@"insert into ShopPlan(planDate,UserId,storeId,CheckType,DurationTime,Memo,CreateTime,CreateUserId,CheckTime,CheckUserId,ModifyTime,ModifyUserId) values('%@','%@','%@','%d','%d','%@','%@','%@','%@','%@','%@','%@');",plan.planDate,plan.userId,plan.storeId,plan.checkType,plan.durationTime,plan.memo,plan.createTime,plan.createUserId,plan.checkTime,plan.checkUserId,plan.modifyTime,plan.modifyUserId];
        [self insertData:planInsertSql];
    }
}

- (void)updatePlan:(LLZPlan *)plan
{
    NSString *planUpdateSql = [NSString stringWithFormat:@"update ShopPlan set planDate='%@',UserId='%@',storeId='%@',CheckType='%d',DurationTime='%d',Memo='%@',CreateTime='%@',CreateUserId='%@',CheckTime='%@',CheckUserId='%@',ModifyTime='%@',ModifyUserId='%@' where planId='%ld';",plan.planDate,plan.userId,plan.storeId,plan.checkType,plan.durationTime,plan.memo,plan.createTime,plan.createUserId,plan.checkTime,plan.checkUserId,plan.modifyTime,plan.modifyUserId,plan.planId];
    BOOL rec = [_dataBase executeUpdate:planUpdateSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

//- (NSArray *)getCheckPlanOrderByDateByUserId:(NSString *)userId
//{
//    NSString *planSearch = [NSString stringWithFormat:@"select * from ShopPlan where userId='%@' order by planDate;",userId];
//    return [self fetchShopPlan:planSearch type:1];
//}

- (NSArray *)getCheckPlanOrderByDateByUserId:(NSString *)userId
{
    NSString *planSearchN = [NSString stringWithFormat:@"select ShopPlan.planId,ShopPlan.planDate,ShopPlan.UserId,ShopPlan.storeId,ShopPlan.CheckType,ShopPlan.DurationTime,ShopPlan.Memo,ShopPlan.CreateTime,ShopPlan.CreateUserId,ShopPlan.CheckTime,ShopPlan.CheckUserId,ShopPlan.ModifyTime,ShopPlan.ModifyUserId,Store.storeName from ShopPlan left join Store on Store.id = ShopPlan.storeId  where userId='%@' order by planDate;",userId];
    return [self fetchShopPlan:planSearchN type:2];
}

- (NSArray *)getCheckPlanOrderByStoreIdByUserId:(NSString *)userId
{
    NSString *planSearch = [NSString stringWithFormat:@"select ShopPlan.planId,ShopPlan.planDate,ShopPlan.UserId,ShopPlan.storeId,ShopPlan.CheckType,ShopPlan.DurationTime,ShopPlan.Memo,ShopPlan.CreateTime,ShopPlan.CreateUserId,ShopPlan.CheckTime,ShopPlan.CheckUserId,ShopPlan.ModifyTime,ShopPlan.ModifyUserId,Store.storeName from ShopPlan left join Store on Store.id = ShopPlan.storeId where userId='%@' order by ShopPlan.storeId;",userId];
    return [self fetchShopPlan:planSearch type:2];
}

- (NSArray *)fetchShopPlan:(NSString *)searchSql type:(int)type
{
    NSMutableArray *planArrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        NSInteger planId = [set longForColumn:@"planId"];
        NSString *planDate = [set stringForColumn:@"planDate"];
        NSString *userId = [set stringForColumn:@"userId"];
        NSString *storeId = [set stringForColumn:@"storeId"];
        int checkType = [set intForColumn:@"CheckType"];
        int durationTime = [set intForColumn:@"DurationTime"];
        NSString *memo = [set stringForColumn:@"Memo"];
        NSString *createTime = [set stringForColumn:@"CreateTime"];
        NSString *createUserId = [set stringForColumn:@"CreateUserId"];
        NSString *checkTime = [set stringForColumn:@"CheckTime"];
        NSString *checkUserId = [set stringForColumn:@"CheckUserId"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        NSString *modifyUserId = [set stringForColumn:@"ModifyUserId"];
        LLZPlan *plan = [LLZPlan PlanWithPlanId:planId
                                       planDate:planDate
                                         userId:userId
                                        storeId:storeId
                                      checkType:checkType
                                   durationTime:durationTime
                                           memo:memo
                                     createTime:createTime
                                   createUserId:createUserId
                                      checkTime:checkTime
                                    checkUserId:checkUserId
                                     modifyTime:modifyTime
                                   modifyUserId:modifyUserId];
        if (type == 2) {
            NSString *storeName = [set stringForColumn:@"storeName"];
            plan.storeName = storeName;
        }else{
            NSLog(@"none");
        }
        [planArrM addObject:plan];
    }
    return planArrM;
}

- (void)dropShopPlanTable
{
    [self dropTable:@"ShopPlan"];
}
#pragma mark ################ param #####################
- (void)createParamTable
{
    NSString *paramTableCreateSql = [NSString stringWithFormat:@"create table if not exists Params(id int,param varchar(40),description varchar(200));"];
    [self createTable:paramTableCreateSql];
}

- (LLZParam *)getParamWithId:(int)paramId
{
    NSString *paramSearchSql = [NSString stringWithFormat:@"select * from Params where id='%d';",paramId];
    if ([self fetchParams:paramSearchSql].count > 0) {
        return [self fetchParams:paramSearchSql][0];

    }else{
        return nil;
    }
}

- (NSArray *)fetchParams:(NSString *)fetchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:fetchSql];
    while ([set next]) {
        int paramId = [set intForColumn:@"id"];
        NSString *paramContent = [set stringForColumn:@"param"];
        NSString *paramDescription = [set stringForColumn:@"description"];
        LLZParam *param = [LLZParam paramWithParamId:paramId
                                        paramContent:paramContent
                                    paramDescription:paramDescription];
        [arrM addObject:param];
    }
    return arrM;
}

- (void)insertParam:(LLZParam *)param
{
    NSString *paramSearchSql = [NSString stringWithFormat:@"select * from Params where id='%d';",param.paramId];
    NSArray *arrM = [self fetchParams:paramSearchSql];
    if (arrM.count > 0) {
        [self updateParam:param];
    }
    //test
    NSString *paramInsertSql = [NSString stringWithFormat:@"insert into Params(id,param,description) values('%d','%@','%@');",param.paramId,param.paramContent,param.paramDescription];
    [self insertData:paramInsertSql];
    
    //完善 效率问题
//    NSString *searchParamSql = [NSString stringWithFormat:@"select * from Params where id='%d';",param.paramId];
//    NSArray *searchArr = [self fetchParams:searchParamSql];
//    if (searchArr.count > 0) {
//        [self updateParam:param];
//    }else{
//        NSString *paramInsertSql = [NSString stringWithFormat:@"insert into Params(id,param,description) values('%d','%@','%@');",param.paramId,param.paramContent,param.paramDescription];
//        [self insertData:paramInsertSql];
//    }
}
- (void)updateParam:(LLZParam *)param
{
    NSString *updateParamSql = [NSString stringWithFormat:@"update Params set param='%@',description='%@' where id='%d';",param.paramContent,param.paramDescription,param.paramId];
    BOOL rec = [_dataBase executeUpdate:updateParamSql];
    if (!rec) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (void)deleteParamTable
{
    [self dropTable:@"Params"];
}

#pragma mark ################ repair #####################
- (void)createRepaireTable
{
    NSString *repaireTableCreate = @"create table if not exists Repairs(RepaireId integer primary key autoincrement,DeviceId varchar(64),storeId varchar(20),RepairDate varchar(16),UserId varchar(20),itemId integer,RepairDesc varchar(200),ImageFile1 varchar(100),ImageFile2 varchar(100),isSolved bool,SortNo int,ModifyTime varchar(30),ModifyUserId varchar(20),TranStatus int);";
    [self createTable:repaireTableCreate];
}
- (void)insertRepair:(LLZRepair *)repair
{
    NSString *repairInserSql = [NSString stringWithFormat:@"insert into Repairs(DeviceId,storeId,RepairDate,UserId,itemId,RepairDesc,ImageFile1,ImageFile2,isSolved,SortNo,ModifyTime,ModifyUserId,TranStatus) values('%@','%@','%@','%@','%ld','%@','%@','%@','%d','%d','%@','%@','%d');",repair.deviceId,repair.storeId,repair.repairDate,repair.userId,repair.itemId,repair.repairDesc,repair.imageFile1,repair.imageFile2,repair.isSolved,repair.sortNo,repair.modifyTime,repair.modifyUserId,repair.tranStatus];
    [self insertData:repairInserSql];
}

- (NSArray *)getRepairByUserId:(NSString *)userId
{
    NSString *repairSearchSql = [NSString stringWithFormat:@"select * from Repairs where UserId='%@';",userId];
    return [self fetchRepairBySql:repairSearchSql];
}

- (NSArray *)fetchRepairBySql:(NSString *)searchSql
{
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [_dataBase executeQuery:searchSql];
    while ([set next]) {
        NSInteger repairId = [set longForColumn:@"RepaireId"];
        NSString *deviceId = [set stringForColumn:@"DeviceId"];
        NSString *storeId = [set stringForColumn:@"storeId"];
        NSString *repairDate = [set stringForColumn:@"RepairDate"];
        NSString *userId = [set stringForColumn:@"UserId"];
        NSInteger itemId = [set longForColumn:@"itemId"];
        NSString *repairDesc = [set stringForColumn:@"RepairDesc"];
        NSString *imageFile1 = [set stringForColumn:@"ImageFile1"];
        NSString *imageFile2 = [set stringForColumn:@"ImageFile2"];
        int isSolved = [set intForColumn:@"isSolved"];
        int sortNO = [set intForColumn:@"SortNo"];
        NSString *modifyTime = [set stringForColumn:@"ModifyTime"];
        NSString *modifyUserId = [set stringForColumn:@"ModifyUserId"];
        int tranStatus = [set intForColumn:@"TranStatus"];
        LLZRepair *repair = [LLZRepair repairWithrepaireId:repairId
                                                  deviceId:deviceId
                                                   storeId:storeId
                                                repairDate:repairDate
                                                    userId:userId
                                                    itemId:itemId
                                                repairDesc:repairDesc
                                                imageFile1:imageFile1
                                                imageFile2:imageFile2
                                                  isSolved:isSolved
                                                    sortNo:sortNO
                                                modifyTime:modifyTime
                                              modifyUserId:modifyUserId
                                                tranStatus:tranStatus];
        [arrM addObject:repair];

    }
    return arrM;
}

#pragma mark ################ public #####################
- (void)dropTable:(NSString *)tableName
{
    NSString *dropSql = [NSString stringWithFormat:@"drop table %@",tableName];
    [_dataBase executeUpdate:dropSql];

}

- (void)insertData:(NSString *)insertSql
{
    BOOL insertFlag = [_dataBase executeUpdate:insertSql];
    if (!insertFlag) {
        NSLog(@"error is %@",[_dataBase lastErrorMessage]);
    }
}

- (void)createTable:(NSString *)createSql
{
    BOOL createFlag = [_dataBase executeUpdate:createSql];
    if (!createFlag) {
        NSLog(@"create failed reason is %@",[_dataBase lastErrorMessage]);
    }
}

@end
