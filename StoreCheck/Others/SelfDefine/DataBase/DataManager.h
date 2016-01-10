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

@interface DataManager : NSObject
{
    FMDatabase *_dataBase;
}

+ (instancetype)shareDataManager;
#pragma mark #################### store ####################
- (void)createStoreTable;
- (void)updateStoreTable;
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
- (void)updateUserTable;
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
- (NSArray *)getAction;
- (void)dropSignStoreTable;
- (void)insertAction:(LLZAction *)action;
- (void)deleteAction;
#pragma mark ################ checkitem #####################
- (void)createCheckItemTable;
- (NSArray *)getNewStoreCheckItem;
- (NSArray *)getDailyCheckItem;
- (void)updateCheckItemTable;
- (void)dropCheckItemTable;
- (void)insertCheckItem:(LLZCheckItem *)item;
- (void)updateCheckItem:(LLZCheckItem *)item;
- (int)totalItemCount;
- (int)checkedItemCountWithStore:(Store *)store
                            user:(LLZUser *)user
                            date:(NSString *)date;
- (int)scoreAmountWithStore:(Store *)store
                       user:(LLZUser *)user
                       date:(NSString *)date
;
#pragma mark ################ reason #####################
- (void)createReasonTable;
- (LLZReason *)getResaonByReasonCode:(NSString *)reasonCode;
- (NSArray *)getResaonByReasonCodeArray:(NSArray *)reasonCodeArray;
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
- (NSArray *)getPhotoWithStoreId:(NSString *)storeId
                          userId:(NSString *)userId;
#pragma mark ################ Question #####################
- (void)createQuestionTable;
//- (void)insertQuestion:

@end
