//
//  LLZUser.h
//  StoreCheck
//
//  Created by skunk  on 15/12/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZUser : NSObject<NSCoding>
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * userCode;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * loginName;
@property (nonatomic, copy) NSString * loginPwd;
@property (nonatomic, copy) NSString * duty;
@property (nonatomic, copy) NSString * contactNumber;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, assign) int orgId;
@property (nonatomic, assign) int useStatus;
@property (nonatomic, assign) NSString *modifyUserId;
@property (nonatomic, strong) NSString * modifyTime;

- (instancetype)initWithuserId:(NSString *)userId
                      userCode:(NSString *)userCode
                      userName:(NSString *)userName
                     loginName:(NSString *)loginName
                      loginPwd:(NSString *)loginPwd
                          duty:(NSString *)duty
                 contactNumber:(NSString *)contactNumber
                        remark:(NSString *)remark
                           orgId:(int)orgId
                     useStatus:(int)useStatus
                  modifyUserId:(NSString *)modifyUserId
                    modifyTime:(NSString *)modifyTime;

+ (instancetype)userWithuserId:(NSString *)userId
                      userCode:(NSString *)userCode
                      userName:(NSString *)userName
                     loginName:(NSString *)loginName
                      loginPwd:(NSString *)loginPwd
                          duty:(NSString *)duty
                 contactNumber:(NSString *)contactNumber
                        remark:(NSString *)remark
                         orgId:(int)orgId
                     useStatus:(int)useStatus
                  modifyUserId:(NSString *)modifyUserId
                    modifyTime:(NSString *)modifyTime;


@end
