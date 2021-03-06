//
//  DataManager.h
//  StoreCheck
//
//  Created by skunk  on 15/11/18.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@class Store;
@class LLZUser;
@class LLZNotice;
@class LLZAction;
@class LLZCheckItem;
@class LLZReason;
@class LLZScore;
@class LLZImage;
@class LLZPhoto;
@class LLZTddVersion;
@class LLZPlan;
@class LLZQuestion;
@class LLZParam;
@class LLZRepair;

@interface DataManager : NSObject
{
    FMDatabase *_dataBase;
}

+ (instancetype)shareDataManager;

#pragma mark #################### store ####################
- (void)createStoreTable;
- (void)insertStore:(Store *)store;
- (NSArray *)searchStoreByKeyWord:(NSString *)keyWord;
- (NSArray *)getStore;
/**
 *  get store by position
 *
 *  @param latitude  latitude
 *  @param longitude longitude
 *
 *  @return store array
 */
- (NSArray *)getAroudStoreWithLatitude:(double)latitude
                             longitude:(double)longitude;

- (void)dropStoreTable;

#pragma mark ################ user #####################
- (void)createUserTable;
- (void)updateUserInformation:(LLZUser *)user;
- (void)insertUser:(LLZUser *)user;
- (NSArray *)getUserWithName:(NSString *)loginName
                    passWord:(NSString *)passWord;
- (void)dropUserTable;

#pragma mark ################ notice #####################
- (void)createMessageTable;
- (void)updateMessageTable;
- (void)insertMessage:(LLZNotice *)notice;
- (void)updateNoticeReadStatus:(LLZNotice *)notice;
- (NSArray *)getUnreadNotice;
- (NSArray *)getNotice;
- (void)dropMessageTable;

#pragma mark ################ action #####################
- (void)createSignStoreTable;
- (NSArray *)getActionByDate:(NSString *)dateString;
- (void)dropSignStoreTable;
- (void)insertAction:(LLZAction *)action;
- (void)deleteAction;

#pragma mark ################ checkitem #####################
- (void)createCheckItemTable;
- (NSArray *)getNewStoreCheckItemWithStoreId:(NSString *)storeId
                                      userId:(NSString *)userId;
- (NSArray *)getDailyCheckItem;
- (NSArray *)getProblemItem;
- (void)dropCheckItemTable;
- (void)insertCheckItem:(LLZCheckItem *)item;
- (void)updateCheckItem:(LLZCheckItem *)item;
- (int)totalItemCount;
- (int)checkedItemCountWithStore:(Store *)store
                            user:(LLZUser *)user
                            date:(NSString *)date;
- (int)scoreAmountWithStore:(Store *)store
                       user:(LLZUser *)user
                       date:(NSString *)date;
- (NSArray *)getListAdjustItem;

#pragma mark ################ reason #####################
- (void)createReasonTable;
- (LLZReason *)getResaonByReasonCode:(NSString *)reasonCode;
- (NSArray *)getResaonByReasonCodeArray:(NSArray *)reasonCodeArray;
- (void)updateReason:(LLZReason *)reason;
- (void)dropReasonTable;
- (void)insertReason:(LLZReason *)reason;

#pragma mark ################ score #####################
- (void)createScoreTable;
- (BOOL)insertScore:(LLZScore *)score;

#pragma mark ################ Image #####################
- (void)createImageTable;
- (void)insertImageItem:(LLZImage *)image;
- (NSArray *)getImageInfo;

#pragma mark ################ photo #####################
- (void)createPhotoTable;
- (void)insertPhoto:(LLZPhoto *)photo;
- (LLZPhoto *)getPhotoWithStoreId:(NSString *)storeId
                          userId:(NSString *)userId
                          itemId:(NSInteger)itemId;

#pragma mark ################ Question #####################
- (void)createQuestionTable;
- (void)insertQuestion:(LLZQuestion *)question;
- (NSArray *)getQuestionWithUserId:(NSString *)userId
                           storeId:(NSString *)storeId
                              date:(NSString *)date;
- (NSInteger)numberOfProblemWithUserId:(NSString *)userId
                         storeId:(NSString *)storeId
                            date:(NSString *)date;
- (NSInteger)numberOfProblemUnsolvedWithUserId:(NSString *)userId
                                       storeId:(NSString *)storeId
                                          date:(NSString *)date;

#pragma mark ################ TddVersion #####################
- (void)createTddVersionTable;
- (LLZTddVersion *)getMaxTddVersion;
- (void)insertTddVersion:(LLZTddVersion *)tddVersion;
- (void)deleteTddVersion;

#pragma mark ################ checkPlan #####################
- (void)createShopPlanTable;
- (void)insertShopPlan:(LLZPlan *)plan;
- (NSArray *)getCheckPlanOrderByDateByUserId:(NSString *)userId;
- (NSArray *)getCheckPlanOrderByStoreIdByUserId:(NSString *)userId;
- (void)dropShopPlanTable;

#pragma mark ################ param #####################
- (void)createParamTable;
- (LLZParam *)getParamWithId:(int)paramId;
- (void)insertParam:(LLZParam *)param;
- (void)deleteParamTable;
#pragma mark ################ repair #####################
- (void)createRepaireTable;
- (void)insertRepair:(LLZRepair *)repair;
- (NSArray *)getRepairByUserId:(NSString *)userId;

@end
