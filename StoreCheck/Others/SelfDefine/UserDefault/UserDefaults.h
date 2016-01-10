//
//  UserDefaults.h
//  uuaha_new
//
//  Created by jetson  on 14-1-17.
//  Copyright (c) 2014年 jetson . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (void)setInteger:(NSInteger )value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setDouble:(double)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
+ (NSInteger)integerForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (double)doubleForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

@end
