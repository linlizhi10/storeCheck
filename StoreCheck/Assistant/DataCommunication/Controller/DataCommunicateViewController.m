//
//  DataCommunicateViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/30.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "DataCommunicateViewController.h"
#import "ContentCollectionViewCell.h"
#import "Topic.h"

@interface DataCommunicateViewController ()

@property (nonatomic, copy) NSArray * topicArray;

@end

@implementation DataCommunicateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"数据通讯"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self dataPrepared];
    [self.view addSubview:self.contentCollectionView];
}

- (void)dataPrepared
{
    Topic *topic01 = [Topic topicWithImage:@"datadownload" title:@""];
    Topic *topic02 = [Topic topicWithImage:@"dataupload" title:@""];
    self.topicArray = [NSArray arrayWithObjects:topic01,
                       topic02,nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
            
            break;
            
        default:
            break;
    }
}

@end
