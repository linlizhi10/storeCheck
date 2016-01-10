//
//  DailyCheckViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/19.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "DailyCheckViewController.h"
#import "LLZCheckItem.h"
#import "CheckListCell.h"
#import "CheckDetailsViewController.h"
#import "NSString+MD5String.h"
#import "Store.h"

@interface DailyCheckViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalCheckCount;

@property (weak, nonatomic) IBOutlet UILabel *checkedAmount;
@property (weak, nonatomic) IBOutlet UILabel *uncheckedAmount;
@property (weak, nonatomic) IBOutlet UILabel *scoreAmount;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UITableView *checkListTable;
@property (nonatomic, strong) NSMutableArray * listArray;

@end

@implementation DailyCheckViewController

static NSString *cellI = @"CheckListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"日常巡店"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    Store *store = [self getStoreInfo];
    self.storeName.text = [NSString stringWithFormat:@"%@(%@)",[store.storeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],store.storeAddress];
    [self prepareData];
    RegisterNib(cellI, self.checkListTable);
    self.checkListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.checkListTable.backgroundColor = [UIColor clearColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData
{
    NSString *dateString = @"2015-12-23";
    NSDate *date = [dateString stringToDate];
    NSLog(@"date is %@",date);
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    
    self.totalCount = [self.appD.dataM totalItemCount];
    self.checkedCount = [self.appD.dataM checkedItemCountWithStore:store user:user date:dateString];
    self.uncheckedCount = self.totalCount - self.checkedCount;
    self.score = [self.appD.dataM scoreAmountWithStore:store user:user date:dateString];
    self.totalCheckCount.text = [NSString stringWithFormat:@"%d",self.totalCount];
    self.checkedAmount.text = [NSString stringWithFormat:@"%d",self.checkedCount];
    self.uncheckedAmount.text = [NSString stringWithFormat:@"%d",self.uncheckedCount];
    self.scoreAmount.text = [NSString stringWithFormat:@"%d",self.score];
    
    self.listArray = [NSMutableArray arrayWithArray:[self.appD.dataM getDailyCheckItem]];

}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LLZCheckItem *item = self.listArray[indexPath.row];
    [cell.score setHidden:YES];
    [cell fillCellWithItem:item index:indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckDetailsViewController *checkDetails = [[CheckDetailsViewController alloc] init];
    [self.navigationController pushViewController:checkDetails animated:YES];
    LLZCheckItem *item = self.listArray[indexPath.row];
    checkDetails.titleName = item.title;
    checkDetails.dealIndex = indexPath.item;
    checkDetails.listArary = self.listArray;
    checkDetails.totalCount = self.totalCount;
    checkDetails.checkedCount = self.checkedCount;
    checkDetails.uncheckedCount = self.uncheckedCount;
    checkDetails.scoreString = self.score;
    self.hidesBottomBarWhenPushed = YES;
}


@end
