//
//  ListAdjustViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ListAdjustViewController.h"
#import "ListAdjustCell.h"
#import "CompareViewController.h"
#import "Store.h"
#import "LLZUser.h"

@interface ListAdjustViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UITableView *listAdjustTable;
@property (nonatomic, strong) NSMutableArray * photoArr;

@end

@implementation ListAdjustViewController

static NSString *cellI = @"ListAdjustCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setCenterButton:@"陈列调整"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    RegisterNib(cellI, self.listAdjustTable);
    Store *store = [self getStoreInfo];
    self.storeLabel.text = [NSString stringWithFormat:@"%@(%@)",[store.storeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],store.storeAddress];
    [self dataPreapared];
}

- (void)dataPreapared
{
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    self.photoArr = [NSMutableArray arrayWithArray:[self.appD.dataM getPhotoWithStoreId:store.storeId userId:user.userId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListAdjustCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LLZPhoto *photo = self.photoArr[indexPath.row];
    //test
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell fillCellWithPhoto:photo];
    });
    
    __block ListAdjustCell *ws = cell;
    cell.compareBlock = ^(UIImage *beforeImage,UIImage *afterImage){
        CompareViewController *compare = [[CompareViewController alloc] init];
        compare.beforeImage = ws.beforeImage.image;
        compare.afterImage = ws.afterImage.image;
        [self.navigationController pushViewController:compare animated:YES];
        
//        [self pushToViewContrller:[CompareViewController class]];
    };
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



@end
