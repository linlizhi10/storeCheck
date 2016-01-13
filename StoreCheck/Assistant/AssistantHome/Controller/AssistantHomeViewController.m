//
//  AssistantHomeViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "AssistantHomeViewController.h"
#import "ContentCollectionViewCell.h"
#import "DataCommunicateViewController.h"
#import "NoticeViewController.h"
#import "Topic.h"
#import "Store.h"

@interface AssistantHomeViewController ()
@property (nonatomic, copy) NSArray * topicArray;
@end

@implementation AssistantHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self setCenterButton:@"辅助"];
//    [self.view addSubview:self.contentCollectionView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([UserDefaults objectForKey:@"selectStore"]) {
        Store *store = [self getStoreInfo];
        [self setLeftButton:store.storeName];
    }
}

- (void)prepareData
{
    Topic *topic01 = [Topic topicWithImage:@"transfer" title:@""];
    Topic *topic02 = [Topic topicWithImage:@"notify" title:@""];
    self.topicArray = [NSArray arrayWithObjects:topic01,
                       topic02, nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCell" forIndexPath:indexPath];
    Topic *topic = self.topicArray[indexPath.row];
    [cell fillCellWithTopic:topic];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self pushToViewContrller:[DataCommunicateViewController class]];
            break;
            case 1:
            [self pushToViewContrller:[NoticeViewController class]];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
