//
//  NewCheckItem.h
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLZCheckItem;
@interface NewCheckItem : NSObject

@property (nonatomic, strong) LLZCheckItem * checkItem;
@property (nonatomic, copy) NSString *imageFile;

- (instancetype)initWithCheckItem:(LLZCheckItem *)checkItem
                     imageFile:(NSString *)imageFile;

+ (instancetype)itemWithCheckItem:(LLZCheckItem *)checkItem
                        imageFile:(NSString *)imageFile;
@end
