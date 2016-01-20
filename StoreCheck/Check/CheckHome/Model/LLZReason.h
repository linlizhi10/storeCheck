//
//  LLZReason.h
//  StoreCheck
//
//  Created by skunk  on 15/12/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZReason : NSObject
@property (nonatomic, assign) NSInteger reasonId;
@property (nonatomic, copy) NSString * reasonCode;
@property (nonatomic, copy) NSString * reasonDesc;
@property (nonatomic, copy) NSString *createUserId;
@property (nonatomic, copy) NSString * modifyTime;
@property (nonatomic, assign) int useStatus;
//for cell ,默认为no
//@property (nonatomic, assign) BOOL selectStatus;

- (instancetype)initWithReasonId:(NSInteger)reasonId
                      reasonCode:(NSString *)reasonCode
                      reasonDesc:(NSString *)reasonDesc
                    createUserId:(NSString *)createUserId
                      modifyTime:(NSString *)modifyTime
                       useStatus:(int)useStatus;

+ (instancetype)reasonWithReasonId:(NSInteger)reasonId
                        reasonCode:(NSString *)reasonCode
                        reasonDesc:(NSString *)reasonDesc
                      createUserId:(NSString *)createUserId
                        modifyTime:(NSString *)modifyTime
                         useStatus:(int)useStatus;
@end
