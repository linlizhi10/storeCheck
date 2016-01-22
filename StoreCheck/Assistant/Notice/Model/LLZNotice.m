//
//  LLZNotice.m
//  StoreCheck
//
//  Created by skunk  on 15/12/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZNotice.h"

@implementation LLZNotice

- (instancetype)initWithNoticeTitle:(NSString *)noticeTitle
                         noticeDate:(NSString *)noticeDate
                      noticeContent:(NSString *)noticeContent
                           readFlag:(BOOL)readFlag
                           noticeId:(NSInteger)noticeId
{
    if (self = [super init]) {
        self.noticeId = noticeId;
        self.noticeTitle = noticeTitle;
        self.noticeDate = noticeDate;
        self.noticeContent = noticeContent;
        self.readFlag = readFlag;
    }
    return self;
}

+ (instancetype)noticeWithNoticeTitle:(NSString *)noticeTitle
                           noticeDate:(NSString *)noticeDate
                        noticeContent:(NSString *)noticeContent
                             readFlag:(BOOL)readFlag
                             noticeId:(NSInteger)noticeId
{
    return [[LLZNotice alloc] initWithNoticeTitle:noticeTitle
                                       noticeDate:noticeDate
                                    noticeContent:noticeContent
                                         readFlag:readFlag
                                         noticeId:noticeId];
    
}

+ (instancetype)parseNoticeDic:(NSDictionary *)dic
{
    NSString *noticeTitle = @"";
    if (![dic[@"MessTitle"] isEqual:[NSNull null]]) {
        noticeTitle = [NSString stringWithFormat:@"%@",dic[@"MessTitle"]];
    }
    
    NSString *createTime = @"";
    if (![dic[@"CreateTime"] isEqual:[NSNull null]]) {
        createTime = [NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
    }
    
    NSString *createUserId = @"";
    if (![dic[@"CreateEmpId"] isEqual:[NSNull null]]) {
        createUserId = [NSString stringWithFormat:@"%@",dic[@"CreateEmpId"]];
    }
    NSString *noticeContent = @"";
    if (![dic[@"MessContent"] isEqual:[NSNull null]]) {
        noticeContent = [NSString stringWithFormat:@"%@",dic[@"MessContent"]];
    }
   
    NSInteger noticeId = 0;
    if (![dic[@"MessId"] isEqual:[NSNull null]]) {
        noticeId = [dic[@"MessId"] integerValue];
    }
    
    int messageType = 0;
    if (![dic[@"MessType"] isEqual:[NSNull null]]) {
        messageType = [dic[@"MessType"] intValue];
    }
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
    }
    int status= 0;
    if (![dic[@"Status"] isEqual:[NSNull null]]) {
        status = [dic[@"Status"] intValue];
    }
    
    return [[LLZNotice alloc] initWithNoticeTitle:noticeTitle
                                       noticeDate:modifyDate
                                    noticeContent:noticeContent
                                         readFlag:NO
                                         noticeId:noticeId];
}

@end
