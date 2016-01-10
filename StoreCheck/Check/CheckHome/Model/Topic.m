//
//  Topic.m
//  StoreCheck
//
//  Created by skunk  on 15/11/23.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "Topic.h"

@implementation Topic

- (instancetype)initWithImage:(NSString *)image title:(NSString *)title
{
    if (self = [super init]) {
        self.image = image;
        self.title = title;
    }
    return self;
}

+ (instancetype)topicWithImage:(NSString *)image title:(NSString *)title
{
    return [[Topic alloc] initWithImage:image title:title];
}

@end
