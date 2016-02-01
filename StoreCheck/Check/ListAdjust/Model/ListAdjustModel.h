//
//  ListAdjustModel.h
//  StoreCheck
//
//  Created by 林立志 on 16/2/1.
//  Copyright © 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLZPhoto.h"
#import "LLZCheckItem.h"

@interface ListAdjustModel : NSObject

@property (nonatomic, strong) LLZCheckItem *item;
@property (nonatomic, strong) LLZPhoto *photo;
- (instancetype)initWithItem:(LLZCheckItem *)item
                       photo:(LLZPhoto *)photo;
+ (instancetype)adjustWithItem:(LLZCheckItem *)item
                         photo:(LLZPhoto *)photo;

@end
