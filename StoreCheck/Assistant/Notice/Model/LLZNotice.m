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

@end
