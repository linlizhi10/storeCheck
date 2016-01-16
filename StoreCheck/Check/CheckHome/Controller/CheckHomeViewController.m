//
//  CheckHomeViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckHomeViewController.h"
#import "ContentCollectionViewCell.h"
#import "CheckInViewController.h"
#import "DailyCheckViewController.h"
#import "ProblemListViewController.h"
#import "ListAdjustViewController.h"
#import "NewStoreCheckViewController.h"
#import "RepairViewController.h"
#import "CheckOutViewController.h"
#import "Topic.h"
#import "Store.h"

@interface CheckHomeViewController ()

@property (nonatomic, copy) NSArray * topicArray;

@end

@implementation CheckHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"巡店"];
    [self preparedData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([UserDefaults objectForKey:@"selectStore"]) {
        Store *store = [self getStoreInfo];
        [self setLeftButton:store.storeName];
    }
}
- (void)preparedData
{
    Topic *topic01 = [Topic topicWithImage:@"signin.png" title:@""];
    Topic *topic02 = [Topic topicWithImage:@"signout.png" title:@""];
    Topic *topic03 = [Topic topicWithImage:@"check.png" title:@""];
    Topic *topic04 = [Topic topicWithImage:@"camera.png" title:@""];
    Topic *topic05 = [Topic topicWithImage:@"questions.png" title:@""];
    Topic *topic06 = [Topic topicWithImage:@"install.png" title:@""];
    Topic *topic07 = [Topic topicWithImage:@"repairs.png" title:@""];
    self.topicArray = [NSArray arrayWithObjects:topic01,
                       topic02,
                       topic03,
                       topic04,
                       topic05,
                       topic06,
                       topic07, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
            //check in
        case 0:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                Alert(@"您已入店", self,100001);
                return;
            }else{
            [self pushToViewContrller:[CheckInViewController class]];
            }
        }
            break;
            //check out
            case 1:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                [self pushToViewContrller:[CheckOutViewController class]];

            }else{
                Alert(@"请先入店", self,100002);
            }
        }
            break;
            //daily check
            case 2:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                [self pushToViewContrller:[DailyCheckViewController class]];
                
            }else{
                Alert(@"请先入店", self,100003);
            }
        }
            break;
            //list adjust
            case 3:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                [self pushToViewContrller:[ListAdjustViewController class]];
                
            }else{
                Alert(@"请先入店", self,100004);
            }
        };
            break;
            //problem list
            case 4:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                [self pushToViewContrller:[ProblemListViewController class]];
                
            }else{
                Alert(@"请先入店", self,100005);
            }
        };
            break;
            //new store check
            case 5:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                [self pushToViewContrller:[NewStoreCheckViewController class]];
                
            }else{
                Alert(@"请先入店", self,100006);
            }
        };
            break;
            //repair
            case 6:
        {
            if ([UserDefaults boolForKey:@"checkIn"]) {
                [self pushToViewContrller:[RepairViewController class]];
                
            }else{
                Alert(@"请先入店", self,100007);
            }
        };
            break;
        default:
            break;
    }
}



@end
