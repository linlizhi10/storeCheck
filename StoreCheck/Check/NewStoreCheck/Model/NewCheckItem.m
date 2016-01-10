//
//  NewCheckItem.m
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "NewCheckItem.h"

@implementation NewCheckItem

- (instancetype)initWithItemId:(NSString *)itemId content:(NSString *)content checkFlag:(BOOL)checkFlag
{
    if (self = [super init]) {
        self.itemId = itemId;
        self.content = content;
        self.checkFlag = checkFlag;
    }
    return self;
}
+ (instancetype)itemWithItemId:(NSString *)itemId content:(NSString *)content checkFlag:(BOOL)checkFlag
{
    return [[NewCheckItem alloc] initWithItemId:itemId
                                        content:content
                                      checkFlag:checkFlag];
}

@end
