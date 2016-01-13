//
//  SearchHomeViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "SearchHomeViewController.h"
#import "ContentCollectionViewCell.h"
#import "CheckPlanViewController.h"
#import "CheckReportViewController.h"
#import "PhotoCheckViewController.h"
#import "Topic.h"
#import "Store.h"

@interface SearchHomeViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy) NSArray * topicArray;

@end

@implementation SearchHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"查询"];
//    [self.view addSubview:self.contentCollectionView];
    [self prepareData];
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
    Topic *topic01 = [Topic topicWithImage:@"storeplan" title:@""];
    Topic *topic02 = [Topic topicWithImage:@"report" title:@""];
    Topic *topic03 = [Topic topicWithImage:@"photolist" title:@""];
    self.topicArray = [NSArray arrayWithObjects:topic01,
                       topic02,
                       topic03, nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topicArray.count;
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
    switch (indexPath.item) {
        case 0:
            [self pushToViewContrller:[CheckPlanViewController class]];
            break;
            case 1:
            [self pushToViewContrller:[CheckReportViewController class]];
            break;
            case 2:
            [self pushToViewContrller:[PhotoCheckViewController class]];
            break;
        default:
            break;
    }
}


@end
