//
//  NewCheckItem.h
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewCheckItem : NSObject

@property (nonatomic, copy) NSString * itemId;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) BOOL checkFlag;

- (instancetype)initWithItemId:(NSString *)itemId
                       content:(NSString *)content
                     checkFlag:(BOOL)checkFlag;
+ (instancetype)itemWithItemId:(NSString *)itemId
                       content:(NSString *)content
                     checkFlag:(BOOL)checkFlag;
@end
