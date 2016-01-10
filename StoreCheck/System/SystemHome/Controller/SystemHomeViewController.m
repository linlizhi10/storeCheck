//
//  SystemHomeViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "SystemHomeViewController.h"
#import "MyFileViewController.h"
#import "ContentCollectionViewCell.h"
#import "UINavigationController+CustomAnimation.h"
#import "SystemSetViewController.h"
#import "Topic.h"
#import "LogInViewController.h"

@interface SystemHomeViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>

@property (nonatomic, copy) NSArray * topicArray;

@end

@implementation SystemHomeViewController

static NSString *collectionViewCellI = @"contentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"系统"];
    [self prepareData];
}

- (void)prepareData
{
    Topic *topic01 = [Topic topicWithImage:@"" title:@"我"];
    Topic *topic02 = [Topic topicWithImage:@"" title:@"更新"];
    Topic *topic03 = [Topic topicWithImage:@"" title:@"退出"];
    Topic *topic04 = [Topic topicWithImage:@"" title:@"系统设置"];
    self.topicArray = [NSArray arrayWithObjects:topic01,
                       topic02,
                       topic03,
                       topic04, nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
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
//            [self pushToViewContrller:[MyFileViewController class]];
        {
            MyFileViewController *myFile = [[MyFileViewController alloc] init];
            [self.navigationController pushViewController:myFile animated:YES];
            myFile.tabBarController.tabBar.hidden = YES;
//            [self.navigationController customPushViewController:myFile];
        }
            break;
        case 2:
        {
            Alert(@"确认退出当前账号？", self,1001);
        }
            break;
            case 3:
        {
            SystemSetViewController *systemSet = [[SystemSetViewController alloc] init];
            [self.navigationController pushViewController:systemSet animated:YES];
            systemSet.tabBarController.tabBar.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if ([UserDefaults boolForKey:@"checkIn"]) {
            Alert(@"请先离店", self,1002);
        }else{
            if (buttonIndex == 1) {
                NSLog(@"exit");
                [UserDefaults setObject:nil forKey:@"selectStore"];
                [UserDefaults setObject:nil forKey:@"user"];
                [UserDefaults setBool:NO forKey:@"checkIn"];
                LogInViewController *login = [[LogInViewController alloc] init];
                [self presentViewController:login animated:YES completion:nil];
            }else{
                NSLog(@"cancle");
            }
        }
 
    }else{
        NSLog(@"confirm");
    }
    
    }

@end
