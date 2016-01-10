//
//  Tools.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "Tools.h"
#define Pi 3.14159265
@implementation Tools

+ (NSString *)dateToString:(NSDate *)date
{
    return @"";
}

+ (float)getDistance:(float)lat1 lng1:(float)lng1 lat2:(float)lat2 lng2:(float)lng2
{
    //地球半径
    int r = 6378137;
    //角度转弧度
    float radLat1 = (lat1 * Pi) / 180;
    float radLat2 = (lat2 * Pi) / 180;
    float radLng1 = (lng1 * Pi) / 180;
    float radLng2 = (lng2 * Pi) / 180;
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*r;
    //精度
    s = round(s * 10000) / 10000;
    return round(s);
}


@end
