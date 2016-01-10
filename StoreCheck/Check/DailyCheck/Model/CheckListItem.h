//
//  checkListModel.h
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListItem : NSObject

@property (nonatomic, copy) NSString * checkItemId;
@property (nonatomic, copy) NSString * checkItemContent;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSArray * scoreListArray;
@property (nonatomic, copy) NSArray * reasonArray;
@property (nonatomic, strong) NSMutableArray * choosedReasonArray;
@property (nonatomic, copy) NSString * imagePath;
@property (nonatomic, assign) BOOL showScoreFlag;

- (instancetype)initWithCheckItemId:(NSString *)itemId
                   checkItemContent:(NSString *)itemContent
                              score:(NSInteger)score
                     scoreListArray:(NSArray *)listArray
                    reasonArray:(NSArray *)reasonArray
                 choosedReasonArray:(NSMutableArray *)choosedReasonArray
                          imagePath:(NSString *)imagePath
                      showScoreFlag:(BOOL)flag;

+ (instancetype)listItemWithCheckItemId:(NSString *)itemId
                       checkItemContent:(NSString *)itemContent
                                  score:(NSInteger)score
                         scoreListArray:(NSArray *)listArray
                            reasonArray:(NSArray *)reasonArray
                     choosedReasonArray:(NSMutableArray *)choosedReasonArray
                              imagePath:(NSString *)imagePath
                          showScoreFlag:(BOOL)flag;

+ (instancetype)listItemWithCheckItemId:(NSString *)itemId
                       checkItemContent:(NSString *)itemContent
                         scoreListArray:(NSArray *)listArray
                            reasonArray:(NSArray *)reasonArray
                     choosedReasonArray:(NSMutableArray *)choosedReasonArray
                              imagePath:(NSString *)imagePath;

@end
