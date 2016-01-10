//
//  Tools.h
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+ (NSString *)dateToString:(NSDate *)date;

+ (float)getDistance:(float)lat1 lng1:(float)lng1 lat2:(float)lat2 lng2:(float)lng2;

@end
