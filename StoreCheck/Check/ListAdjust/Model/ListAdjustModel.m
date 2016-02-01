//
//  ListAdjustModel.m
//  StoreCheck
//
//  Created by 林立志 on 16/2/1.
//  Copyright © 2016年 linlizhi. All rights reserved.
//

#import "ListAdjustModel.h"

@implementation ListAdjustModel
- (instancetype)initWithItem:(LLZCheckItem *)item
                       photo:(LLZPhoto *)photo
{
    self = [super init];
    if (self) {
        _item = item;
        _photo = photo;
    }
    return self;
}
+ (instancetype)adjustWithItem:(LLZCheckItem *)item
                         photo:(LLZPhoto *)photo
{
    return [[ListAdjustModel alloc] initWithItem:item
                                           photo:photo];
}

@end
