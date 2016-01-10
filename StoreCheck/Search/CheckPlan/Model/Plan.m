//
//  Plan.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "Plan.h"

@implementation Plan

- (instancetype)initWithDate:(NSDate *)date store:(NSString *)store time:(NSString *)time tips:(NSString *)tips
{
    if (self = [super init]) {
        self.date = date;
        self.store = store;
        self.time = time;
        self.tips = tips;
    }
    return self;
}
+ (instancetype)PlanWithDate:(NSDate *)date store:(NSString *)store time:(NSString *)time tips:(NSString *)tips
{
    return  [[Plan alloc] initWithDate:date
                                 store:store
                                  time:time
                                  tips:tips];
}

@end
