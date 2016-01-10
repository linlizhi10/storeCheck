//
//  LLZSignView.m
//  LLZSignView
//
//  Created by skunk  on 15/12/2.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LLZSignView.h"

@implementation LLZSignView

//保存线条颜色
static NSMutableArray *colorArray;
//保存被移除的线条颜色
static NSMutableArray *deleColorArray;
//每次触摸结束前经过的点，形成线的点数组
static NSMutableArray *pointArray;
//每次触摸结束后的线数组
static NSMutableArray *lineArray;
//删除的线的数组，方便重做时取出来
static NSMutableArray *deleArray;
//线条宽度的数组
static float lineWidthArray[10] = {2.0,10.0,12.0,14.0,16.0,20.0,22.0,24.0,26.0,28.0};
//删除线条时删除的线条宽度储存的数组
static NSMutableArray *deleWidthArray;
//正常存储的线条宽度的数组
static NSMutableArray *WidthArray;
//确定颜色的值，将颜色计数的值存到数组里默认为0，即为绿色
static int colorCount;
//确定宽度的值，将宽度计数的值存到数组里默认为0，即为10
static int widthCount;
//保存颜色的数组
static NSMutableArray *colors;

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化颜色数组，将用到的颜色存储到数组里
        colors = [[NSMutableArray alloc]initWithObjects:[UIColor blackColor],[UIColor greenColor],[UIColor blueColor],[UIColor redColor],[UIColor blackColor],[UIColor whiteColor], nil];
        WidthArray = [[NSMutableArray alloc] init];
        deleWidthArray = [[NSMutableArray alloc] init];
        pointArray = [[NSMutableArray alloc] init];
        lineArray = [[NSMutableArray alloc] init];
        deleArray = [[NSMutableArray alloc] init];
        colorArray = [[NSMutableArray alloc] init];
        deleColorArray = [[NSMutableArray alloc] init];
        //颜色和宽度默认都取当前数组第0位为默认值
        colorCount = 0;
        widthCount = 0;
        // Initialization code

    }
    return self;
}
- (void)setLineWidth:(NSInteger)width
{
    widthCount = (int)width;
}

- (void)setLineColor:(NSInteger)color
{
    colorCount = (int)color;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0f);
    //线条拐角样式，设置为平滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //线条开始样式，设置为平滑
    CGContextSetLineCap(context, kCGLineCapRound);
    //查看lineArray数组里是否有线条，有就将之前画的重绘，没有只画当前线条
    NSLog(@"linearray is %p",lineArray);

    if ([lineArray count] > 0) {
        for (int i = 0; i < [lineArray count]; i++) {
            NSArray *array = [NSArray arrayWithArray:[lineArray objectAtIndex:i]];
            if ([array count] > 0) {
                CGContextBeginPath(context);
                CGPoint myStartPoint = CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                for (int j = 0; j < [array count] - 1; j++) {
                    CGPoint myEndPoint = CGPointFromString([array objectAtIndex:j + 1]);
                    CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
                    
                }
                //获取colorArray数组里的要绘制线条的颜色
                NSNumber *num = [colorArray objectAtIndex:i];
                int count = [num intValue];
                UIColor *lineColor = [colors objectAtIndex:count];
                //获取widthArray数组里的要绘制线条的宽度
                NSNumber *wid = [WidthArray objectAtIndex:i];
                int widthc = [wid intValue];
                float width = lineWidthArray[widthc];
                //设置线条的颜色，要取uicolor得cgcolor
                CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
                CGContextSetLineWidth(context, width);
                //保存自己画的
                CGContextStrokePath(context);
                
            }
            
        }
        
    }
    //画当前的线
    if ([pointArray count] > 0) {
        CGContextBeginPath(context);
        CGPoint myStartPoint = CGPointFromString([pointArray objectAtIndex:0]);
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        
        for (int j = 0; j < [pointArray count] - 1; j++) {
            CGPoint myEndPoint = CGPointFromString(pointArray[j + 1]);
            CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
        }
        UIColor *lineColor = [colors objectAtIndex:colorCount];
        float width = lineWidthArray[widthCount];
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
    }
}
////touch 结束前将获取到的点，放到pointArray里
//- (void)addPA:(CGPoint)nPoint
//{
//    NSString *sPoint = NSStringFromCGPoint(nPoint);
//    [pointArray addObject:sPoint];
//}
//touch end时 将已经绘制的线条的颜色，宽度，线条线路报存到数组里
- (void)addLA
{
    NSNumber *wid = [[NSNumber alloc] initWithInt:widthCount];
    NSNumber *num = [[NSNumber alloc] initWithInt:colorCount];
    [colorArray addObject:num];
    [WidthArray addObject:wid];
    NSArray *array = [NSArray arrayWithArray:pointArray];
    [lineArray addObject:array];
    NSLog(@"------linearray is %p",lineArray);
    pointArray = [[NSMutableArray alloc] init];
    [self setNeedsDisplay];
}

static CGPoint beginPoint;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addLA];
    NSLog(@"touches end first view");
}
//电话呼入等事件取消时发出
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches cancelled");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self];
    NSString *sPoint = NSStringFromCGPoint(beginPoint);
    [pointArray addObject:sPoint];
    [self setNeedsDisplay];
}

- (void)revocation
{
    if ([lineArray count]) {
        [deleArray addObject:[lineArray lastObject]];
        [lineArray removeLastObject];
    }
    if ([colorArray count]) {
        [deleArray addObject:[colorArray lastObject]];
        [colorArray removeLastObject];
    }
    if ([WidthArray count]) {
        [deleArray addObject:[WidthArray lastObject]];
        [WidthArray removeLastObject];
    }
    //界面重绘方法
    [self setNeedsDisplay];
}
//将删除线条数组里的信息，移动到当前数组，在主界面重绘
- (void)refrom
{
    if ([deleArray count]) {
        [lineArray addObject:[deleArray lastObject]];
        [deleArray removeLastObject];
    }
    if ([deleColorArray count]) {
        [colorArray addObject:[deleColorArray lastObject]];
        [deleColorArray removeLastObject];
    }
    if ([deleWidthArray count]) {
        [WidthArray addObject:[deleWidthArray lastObject]];
        [deleWidthArray removeLastObject];
    }
    [self setNeedsDisplay];
}

- (void)clear
{
    //移除所有信息并重绘
    widthCount = 0;
    [deleArray removeAllObjects];
    [deleWidthArray removeAllObjects];
    [deleColorArray removeAllObjects];
    [colorArray removeAllObjects];
    [lineArray removeAllObjects];
    [pointArray removeAllObjects];
    [WidthArray removeAllObjects];
    [self setNeedsDisplay];
    //清屏以后可以重绘，有些问题
}
@end
