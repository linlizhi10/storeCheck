//
//  checkListModel.m
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckListItem.h"

@implementation CheckListItem

- (instancetype)initWithCheckItemId:(NSString *)itemId
                   checkItemContent:(NSString *)itemContent
                              score:(NSInteger)score
                     scoreListArray:(NSArray *)listArray
                    reasonArray:(NSArray *)reasonArray
                 choosedReasonArray:(NSMutableArray *)choosedReasonArray
                          imagePath:(NSString *)imagePath
                      showScoreFlag:(BOOL)flag
{
    if (self = [super init]) {
        self.checkItemId = itemId;
        self.checkItemContent = itemContent;
        self.score = score;
        self.scoreListArray = listArray;
        self.reasonArray = reasonArray;
        self.choosedReasonArray = choosedReasonArray;
        self.imagePath = imagePath;
        self.showScoreFlag = flag;
    }
    return self;
}


+ (instancetype)listItemWithCheckItemId:(NSString *)itemId
                       checkItemContent:(NSString *)itemContent
                                  score:(NSInteger)score
                         scoreListArray:(NSArray *)listArray
                            reasonArray:(NSArray *)reasonArray
                     choosedReasonArray:(NSMutableArray *)choosedReasonArray
                              imagePath:(NSString *)imagePath
                          showScoreFlag:(BOOL)flag
{
    return [[CheckListItem alloc] initWithCheckItemId:itemId
                                     checkItemContent:itemContent
                                                score:score
                                       scoreListArray:listArray
                                          reasonArray:reasonArray
                                   choosedReasonArray:choosedReasonArray
                                            imagePath:imagePath
                                        showScoreFlag:flag];
}

+ (instancetype)listItemWithCheckItemId:(NSString *)itemId
                       checkItemContent:(NSString *)itemContent
                         scoreListArray:(NSArray *)listArray
                            reasonArray:(NSArray *)reasonArray
                     choosedReasonArray:(NSMutableArray *)choosedReasonArray
                              imagePath:(NSString *)imagePath
{
    return [[CheckListItem alloc] initWithCheckItemId:itemId
                                     checkItemContent:itemContent
                                                score:0
                                       scoreListArray:listArray
                                          reasonArray:reasonArray
                                   choosedReasonArray:choosedReasonArray
                                            imagePath:imagePath
                                        showScoreFlag:NO];
}

@end
