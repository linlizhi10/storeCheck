//
//  DrawSignView.h
//  LLZSignView
//
//  Created by skunk  on 15/12/3.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SignCallBackBlock) (UIImage *);
typedef void(^CancelCallBackBlock) ();

@interface DrawSignView : UIView

@property (nonatomic, copy) SignCallBackBlock signCallBackBlock;
@property (nonatomic, copy) CancelCallBackBlock cancelCallBackBlock;

@end
