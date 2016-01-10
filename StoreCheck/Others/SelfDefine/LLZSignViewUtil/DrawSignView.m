//
//  DrawSignView.m
//  LLZSignView
//
//  Created by skunk  on 15/12/3.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "DrawSignView.h"
#import "LLZSignView.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define SystemFont(x) [UIFont systemFontOfSize:(x)]
#define iPhoneWidth  [UIScreen mainScreen].bounds.size.width
#define iPhoneHeight [UIScreen mainScreen].bounds.size.height

@interface DrawSignView ()

@property (nonatomic, strong) LLZSignView * signView;
@property (nonatomic, assign) BOOL buttonHiden;
@property (nonatomic, assign) BOOL widthHidden;

@end

//保存线条颜色
static NSMutableArray *colors;

@implementation DrawSignView
//get ,set method
@synthesize signCallBackBlock,cancelCallBackBlock;

- (id)init
{
    if (self = [super init]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.frame = CGRectMake(0, 64, iPhoneWidth, iPhoneHeight - 64);
    self.backgroundColor = [UIColor blackColor];
    CALayer *layer = self.layer;
    [layer setCornerRadius:15.0];
    layer.borderColor = [UIColor grayColor].CGColor;
    layer.borderWidth = 1;
    //content label
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"请在指定区域内签名";
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.frame = CGRectMake(0, 50, iPhoneWidth, 50);
    contentLabel.font = SystemFont(18);
    contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:contentLabel];
    //draw rect
    self.signView = [[LLZSignView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    self.signView.center = CGPointMake(contentLabel.center.x, self.signView.center.y);
    [self.signView setBackgroundColor:RGB(101, 129, 90)];
    [self addSubview:self.signView];
    
    CGFloat signViewY = CGRectGetMaxY(self.signView.frame) + 20;
    CGFloat signViewX = self.signView.frame.origin.x;
    //btns
    UIButton *confirmBtn = [UIButton new];
    confirmBtn.frame = CGRectMake(signViewX + 15, signViewY , 70, 40);
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor lightGrayColor]];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancelBtn = [UIButton new];
    cancelBtn.frame = CGRectMake(self.signView.center.x + 15, signViewY, 70, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    [self addSubview:cancelBtn];
    
}

- (void)confirmAction
{
    self.signCallBackBlock([self saveScreen]);
    [self removeFromSuperview];
    
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (UIImage *)saveScreen
{
    UIView *screenView = self.signView;
    UIGraphicsBeginImageContext(screenView.bounds.size);
    [screenView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
