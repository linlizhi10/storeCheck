//
//  MyFileViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "MyFileViewController.h"
#import "Topic.h"
#import "PersonalInformationViewController.h"
#import "ContentCollectionViewCell.h"
#import "ChangeInformationViewController.h"
#import "ChangePasswordViewController.h"

@interface MyFileViewController ()
@property (nonatomic, copy) NSArray * topicArray;
@end

@implementation MyFileViewController

static NSString *collectionViewCellI = @"contentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"我的信息"];
    [self prepareData];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];

}

- (void)prepareData
{
    Topic *topic01 = [Topic topicWithImage:@"mydata" title:@""];
    Topic *topic02 = [Topic topicWithImage:@"changedata" title:@""];
    Topic *topic03 = [Topic topicWithImage:@"changepwd" title:@""];
    self.topicArray = [NSArray arrayWithObjects:topic01,
                       topic02,
                       topic03,nil];
    
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
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellI forIndexPath:indexPath];
    Topic *topic = self.topicArray[indexPath.item];
    [cell fillCellWithTopic:topic];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item) {
        case 0:
            [self pushToViewContrller:[PersonalInformationViewController class]];
            break;
            case 1:
            [self pushToViewContrller:[ChangeInformationViewController class]];
            break;
            case 2:
            [self pushToViewContrller:[ChangePasswordViewController class]];
            break;
        default:
            break;
    }
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

@end
