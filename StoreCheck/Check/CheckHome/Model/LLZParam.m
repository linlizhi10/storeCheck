//
//  LLZParam.m
//  StoreCheck
//
//  Created by skunk  on 16/1/18.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import "LLZParam.h"

@implementation LLZParam

- (instancetype)initWithParamId:(int)paramId
                   paramContent:(NSString *)paramContent
               paramDescription:(NSString *)paramDescription
{
    if (self = [super init]) {
        self.paramId = paramId;
        self.paramContent = paramContent;
        self.paramDescription = paramDescription;
    }
    return self;
}

+ (instancetype)paramWithParamId:(int)paramId
                    paramContent:(NSString *)paramContent
                paramDescription:(NSString *)paramDescription
{
    return [[LLZParam alloc] initWithParamId:paramId
                                paramContent:paramContent
                            paramDescription:paramDescription];
}

+ (instancetype)parseWithDic:(NSDictionary *)dic
{
    
    NSString *modifyDate = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyDate = [NSString stringWithFormat:@"%@",dic[@"ModifyDate"]];
    }
    NSString *modifyUserId = @"";
    if (![dic[@"ModifyDate"] isEqual:[NSNull null]]) {
        modifyUserId = [NSString stringWithFormat:@"%@",dic[@"ModifyEmpId"]];;
    }
    NSString *description = @"";
    if (![dic[@"descripton"] isEqual:[NSNull null]]) {
        description = [NSString stringWithFormat:@"%@",dic[@"descripton"]];

    }
    int paramId = 0;
    if (![dic[@"id"] isEqual:[NSNull null]]) {
        paramId = [dic[@"id"] intValue];
    }
    NSString *paramContent = @"";
    if (![dic[@"param"] isEqual:[NSNull null]]) {
        paramContent = [NSString stringWithFormat:@"%@",dic[@"param"]];
    }
    return [[LLZParam alloc] initWithParamId:paramId
                                paramContent:paramContent
                            paramDescription:description];
}

@end
