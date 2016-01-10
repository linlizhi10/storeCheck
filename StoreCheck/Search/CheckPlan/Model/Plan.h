//
//  Plan.h
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plan : NSObject

@property (nonatomic, copy) NSDate * date;
@property (nonatomic, copy) NSString * store;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * tips;
//object init
- (instancetype)initWithDate:(NSDate *)date
                       store:(NSString *)store
                        time:(NSString *)time
                        tips:(NSString *)tips;
//class init
+ (instancetype)PlanWithDate:(NSDate *)date
                       store:(NSString *)store
                        time:(NSString *)time
                        tips:(NSString *)tips;

@end
