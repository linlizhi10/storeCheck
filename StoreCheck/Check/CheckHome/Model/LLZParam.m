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

@end
