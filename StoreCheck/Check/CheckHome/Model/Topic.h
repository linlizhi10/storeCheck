//
//  Topic.h
//  StoreCheck
//
//  Created by skunk  on 15/11/23.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * title;

- (instancetype)initWithImage:(NSString *)image
                        title:(NSString *)title;
+ (instancetype)topicWithImage:(NSString *)image
                         title:(NSString *)title;

@end
