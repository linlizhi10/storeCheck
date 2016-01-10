//
//  LLZNotice.h
//  StoreCheck
//
//  Created by skunk  on 15/12/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZNotice : NSObject

@property (nonatomic, assign) NSInteger noticeId;
@property (nonatomic, copy) NSString * noticeTitle;
@property (nonatomic, copy) NSString * noticeDate;
@property (nonatomic, copy) NSString * noticeContent;
@property (nonatomic, assign) BOOL readFlag;

- (instancetype)initWithNoticeTitle:(NSString *)noticeTitle
                         noticeDate:(NSString *)noticeDate
                      noticeContent:(NSString *)noticeContent
                           readFlag:(BOOL)readFlag
                           noticeId:(NSInteger)noticeId;

+ (instancetype)noticeWithNoticeTitle:(NSString *)noticeTitle
                           noticeDate:(NSString *)noticeDate
                        noticeContent:(NSString *)noticeContent
                             readFlag:(BOOL)readFlag
                             noticeId:(NSInteger)noticeId;
@end
