//
//  NewCheckItem.m
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "NewCheckItem.h"

@implementation NewCheckItem

- (instancetype)initWithCheckItem:(LLZCheckItem *)checkItem
                        imageFile:(NSString *)imageFile
{
    if (self = [super init]) {
        self.checkItem = checkItem;
        self.imageFile = imageFile;
    }
    return self;
}
+ (instancetype)itemWithCheckItem:(LLZCheckItem *)checkItem
                        imageFile:(NSString *)imageFile
{
    return [[NewCheckItem alloc] initWithCheckItem:checkItem
                                         imageFile:imageFile];
}

@end
