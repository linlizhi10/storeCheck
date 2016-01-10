//
//  HomeContentViewController.h
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeContentViewController : BaseViewController
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

@end
