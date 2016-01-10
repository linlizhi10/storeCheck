//
//  NSString+MD5String.m
//  StoreCheck
//
//  Created by skunk  on 15/12/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "NSString+MD5String.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5String)

- (NSString *)getMd5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result ); // This is the md5 call
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
    

}

- (NSDate *)stringToDate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:self];
    return date;
}

@end
