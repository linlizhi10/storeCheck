//
//  LLZUser.m
//  StoreCheck
//
//  Created by skunk  on 15/12/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZUser.h"

@implementation LLZUser

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
                    modifyTime:(NSString *)modifyTime
{
    if (self = [super init]) {
        self.userId = userId;
        self.userCode = userCode;
        self.userName = userName;
        self.loginName = loginName;
        self.loginPwd = loginPwd;
        self.duty = duty;
        self.contactNumber = contactNumber;
        self.remark = remark;
        self.orgId = orgId;
        self.useStatus = useStatus;
        self.modifyUserId = modifyUserId;
        self.modifyTime = modifyTime;
    }
    return self;
}

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
                    modifyTime:(NSString *)modifyTime
{
    return [[LLZUser alloc] initWithuserId:userId
                                  userCode:userCode
                                  userName:userName
                                 loginName:loginName
                                  loginPwd:loginPwd
                                      duty:duty
                             contactNumber:contactNumber
                                    remark:remark
                                     orgId:orgId
                                 useStatus:useStatus
                              modifyUserId:modifyUserId
                                modifyTime:modifyTime];
}

#pragma mark ########### encode for user decode ##########
//使用是archived到data ，userdefault存
//unarchiver 到实例对象
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
    [aCoder encodeObject:self.loginPwd forKey:@"loginPwd"];
    [aCoder encodeObject:self.duty forKey:@"duty"];
    [aCoder encodeObject:self.contactNumber forKey:@"contactNumber"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.orgId] forKey:@"orgId"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.useStatus] forKey:@"useStatus"];
    [aCoder encodeObject:self.modifyUserId forKey:@"modifyUserId"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
        self.loginPwd = [aDecoder decodeObjectForKey:@"loginPwd"];
        self.duty = [aDecoder decodeObjectForKey:@"duty"];
        self.contactNumber = [aDecoder decodeObjectForKey:@"contactNumber"];
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.orgId = [[aDecoder decodeObjectForKey:@"orgId"] intValue];
        self.useStatus = [[aDecoder decodeObjectForKey:@"useStatus"] intValue];
        self.modifyUserId = [aDecoder decodeObjectForKey:@"modifyUserId"];
        self.modifyTime = [aDecoder decodeObjectForKey:@"modifyTime"];

    }
    return self;
}

/*
 Department = "";
 Duty = "";
 EmpCode = 100690;
 EmpId = 20150721094210;
 EmpName = "\U8425\U8fd0\U68c0\U67e51900";
 EmpPhone = 64163597;
 LoginName = 10010;
 LoginPasswd = e10adc3949ba59abbe56e057f20f883e;
 MngrId = "";  //预留
 MngrRelaCode = "";  //预留
 ModifyDate = "2015-08-17T16:38:11";
 OptrId = 20150622184608;
 UseStatus = 0;
 */
+ (instancetype)parseUserDic:(NSDictionary *)dic
{
    NSString *department = @"";
    if (![dic[@"Department"] isEqual:[NSNull null]]) {
        department = [NSString stringWithFormat:@"%@",dic[@"Department"]];
    }
    NSString *duty = @"";
    if (![dic[@"Duty"] isEqual:[NSNull null]]) {
        duty = [NSString stringWithFormat:@"%@",dic[@"Duty"]];
    }
    NSString *userCode = @"";
    if (![dic[@"EmpCode"] isEqual:[NSNull null]]) {
        userCode = [NSString stringWithFormat:@"%@",dic[@"EmpCode"]];
    }
    NSString *userId = @"";
    if (![dic[@"EmpId"] isEqual:[NSNull null]]) {
        userId = [NSString stringWithFormat:@"%@",dic[@"EmpId"]];
    }
    NSString *userName = @"";
    if (![dic[@"EmpName"] isEqual:[NSNull null]]) {
        userName = [NSString stringWithFormat:@"%@",dic[@"EmpName"]];
    }
    NSString *telphone = @"";
    if (![dic[@"EmpPhone"] isEqual:[NSNull null]]) {
        telphone = [NSString stringWithFormat:@"%@",dic[@"EmpPhone"]];
    }
    NSString *loginName = @"";
    if (![dic[@"LoginName"] isEqual:[NSNull null]]) {
        loginName = [NSString stringWithFormat:@"%@",dic[@"LoginName"]];
    }
    NSString *loginPasswd = @"";
    if (![dic[@"LoginPasswd"] isEqual:[NSNull null]]) {
        loginPasswd = [NSString stringWithFormat:@"%@",dic[@"LoginPasswd"]];
    }
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
    }
    NSString *optrId = @"";
    if (![dic[@"OptrId"] isEqual:[NSNull null]]) {
        optrId = [NSString stringWithFormat:@"%@",dic[@"OptrId"]];
    }
    int useStatus = 0;
    if (![dic[@"UseStatus"] isEqual:[NSNull null]]) {
        useStatus = [dic[@"UseStatus"] intValue];
    }
    return [LLZUser userWithuserId:userId
                          userCode:userCode
                          userName:userName
                         loginName:loginName
                          loginPwd:loginPasswd
                              duty:duty
                     contactNumber:telphone
                            remark:@""
                             orgId:[optrId intValue]
                         useStatus:useStatus
                      modifyUserId:optrId
                        modifyTime:modifyDate];

}

@end
