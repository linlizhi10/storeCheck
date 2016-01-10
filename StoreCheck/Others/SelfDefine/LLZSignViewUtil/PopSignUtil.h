//
//  PopSignUtil.h
//  LLZSignView
//
//  Created by skunk  on 15/12/3.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawSignView.h"

@interface PopSignUtil : UIView

+ (void)getSignWithVC:(UIViewController *)VC ok:(SignCallBackBlock)signCallBackBlock;

@end
