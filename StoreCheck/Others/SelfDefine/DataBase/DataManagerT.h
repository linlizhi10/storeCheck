//
//  DataManagerT.h
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@class Store;

@interface DataManagerT : NSObject
{
    FMDatabase *_dataBase;
}

+ (instancetype)shareDataManager;
- (void)createUserTable;
#pragma mark #################### store ####################
- (void)createStoreTable;
- (void)insertStore:(Store *)store;
- (NSArray *)getStore;
- (void)dropTable;

@end
