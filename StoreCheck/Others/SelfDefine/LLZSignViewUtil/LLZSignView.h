//
//  LLZSignView.h
//  LLZSignView
//
//  Created by skunk  on 15/12/2.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLZSignView : UIView

- (void)addPA:(CGPoint)nPoint;
- (void)addLA;
- (void)revocation;
- (void)refrom;
- (void)clear;
- (void)setLineColor:(NSInteger)color;
- (void)setLineWidth:(NSInteger)width;

@end
