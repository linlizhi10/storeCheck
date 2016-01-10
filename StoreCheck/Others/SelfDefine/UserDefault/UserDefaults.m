//
//  UserDefaults.m
//  uuaha_new
//
//  Created by jetson  on 14-1-17.
//  Copyright (c) 2014年 jetson . All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults


+(void)setInteger:(NSInteger )value forKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
	[userDefaults synchronize];
}
+ (void)setFloat:(float)value forKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
	[userDefaults synchronize];
}
+ (void)setDouble:(double)value forKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
	[userDefaults synchronize];
}
+ (void)setBool:(BOOL)value forKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
	[userDefaults synchronize];
}
+ (void)setValue:(id)value forKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setValue:value forKey:key];
	[userDefaults synchronize];
}

+ (void)setObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:object forKey:key];
    [user synchronize];
}







//get
+ (id)objectForKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return  [userDefaults objectForKey:key];

}
+ (NSString *)stringForKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return  [userDefaults stringForKey:key];
}

+ (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//   NSString *value = [userDefaults valueForKey:key];
    //NSLog(@"key is %@",key);
    id obj = [userDefaults valueForKey:key];
    
    //NSLog(@"obj is %@",obj);
    /*
    NSString *value= [[userDefaults valueForKey:key] stringValue];
    return
    */
    if (![obj isKindOfClass:[NSString class]]) {
        NSString *value= [[userDefaults valueForKey:key] stringValue];
        return value.length>0?value:defaultValue;
    }
    return obj;
    
    
}

+ (NSInteger)integerForKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return  [userDefaults integerForKey:key];
}
+(float)floatForKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return  [userDefaults floatForKey:key];
}
+(double)doubleForKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return  [userDefaults doubleForKey:key];
}
+(BOOL)boolForKey:(NSString *)key{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return  [userDefaults boolForKey:key];
}



@end
