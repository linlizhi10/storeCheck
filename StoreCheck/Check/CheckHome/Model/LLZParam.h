//
//  LLZParam.h
//  StoreCheck
//
//  Created by skunk  on 16/1/18.
//  Copyright (c) 2016年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLZParam : NSObject

@property (nonatomic, assign) int paramId;
@property (nonatomic, copy) NSString * paramContent;
@property (nonatomic, copy) NSString * paramDescription;

- (instancetype)initWithParamId:(int)paramId
                   paramContent:(NSString *)paramContent
               paramDescription:(NSString *)paramDescription;
+ (instancetype)paramWithParamId:(int)paramId
                    paramContent:(NSString *)paramContent
                paramDescription:(NSString *)paramDescription;
+ (instancetype)parseWithDic:(NSDictionary *)dic;

@end
