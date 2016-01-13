//
//  HomeContentViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "HomeContentViewController.h"
#import "ContentCollectionViewCell.h"

@interface HomeContentViewController ()


@end

@implementation HomeContentViewController

static NSString *collectionViewCellI = @"contentCell";
static NSString *cellName = @"ContentCollectionViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentCollectionView];
}
//get method
- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = iPhoneWidth / 2 - 10;
        _flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
    }
    
    return _flowLayout;
}

- (UICollectionView *)contentCollectionView
{
    if (!_contentCollectionView) {
        CGRect frame = CGRectMake(10, NavigationBarHeight, iPhoneWidth, iPhoneHeight - NavigationBarHeight - TabBarHeight);
        _contentCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.flowLayout];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        UINib *nibCell = [UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]];
        [_contentCollectionView registerNib:nibCell forCellWithReuseIdentifier:collectionViewCellI];
    }
    return _contentCollectionView;
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
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellI forIndexPath:indexPath];
    return cell;
}



@end
