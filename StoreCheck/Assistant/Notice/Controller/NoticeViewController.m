//
//  NoticeViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "NoticeViewController.h"
#import "LLZNotice.h"

@interface NoticeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *unReadMessageCount;
@property (nonatomic, assign) NSInteger noticeIndex;
@property (nonatomic, assign) NSInteger unReadCount;
@property (nonatomic, copy) NSArray * noticeArr;
@property (weak, nonatomic) IBOutlet UILabel *noticeTitle;
@property (weak, nonatomic) IBOutlet UILabel *noticeDate;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noticeIndex = 0;
    self.unReadCount = 0;
    [self setCenterButton:@"公告"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self dataPrepared];
    [self setNoticeViewWithNotice:self.noticeArr[self.noticeIndex]];
}

- (void)dataPrepared
{
    self.noticeArr = [self.appD.dataM getNotice];
    NSArray *arr = [self.appD.dataM getUnreadNotice];
    self.unReadCount = arr.count;
    self.unReadMessageCount.text = [NSString stringWithFormat:@"您有%ld条消息未读",self.unReadCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.noticeContentTextView.contentOffset = CGPointMake(0, 0);
}

- (void)setNoticeViewWithNotice:(LLZNotice *)notice
{
    self.noticeTitle.text = notice.noticeTitle;
    self.noticeDate.text = notice.noticeDate;
    self.noticeContentTextView.text = notice.noticeContent;
    self.noticeContentTextView.contentOffset = CGPointMake(0, 0);
    if (notice.readFlag) {
        self.readFlag.image = [UIImage imageNamed:@"select_yes"];
    }else{
        self.readFlag.image = [UIImage imageNamed:@"select_no"];
    }
}

- (IBAction)preMessage:(id)sender {
    if (self.noticeIndex > 0) {
        self.noticeIndex --;
    }else
    {
        self.noticeIndex = 0;
    }
    [self setNoticeViewWithNotice:self.noticeArr[self.noticeIndex]];
}

- (IBAction)nextMessage:(id)sender {
    if (self.noticeIndex < self.noticeArr.count - 1) {
        self.noticeIndex ++;
    }else{
        self.noticeIndex = self.noticeArr.count - 1;
    }
    [self setNoticeViewWithNotice:self.noticeArr[self.noticeIndex]];
}

- (IBAction)readFlagChanged:(id)sender {
    
    LLZNotice *notice = self.noticeArr[self.noticeIndex];
    if (notice.readFlag == NO) {
        self.readFlag.image = [UIImage imageNamed:@"select_yes"];
        notice.readFlag = YES;
        [self.appD.dataM updateNoticeReadStatus:notice];
        self.unReadCount -= 1;
    }else{
        self.readFlag.image = [UIImage imageNamed:@"select_no"];
        notice.readFlag = NO;
        [self.appD.dataM updateNoticeReadStatus:notice];
        self.unReadCount += 1;
    }
    self.unReadMessageCount.text = [NSString stringWithFormat:@"您有%ld条消息未读",self.unReadCount];
}
@end
