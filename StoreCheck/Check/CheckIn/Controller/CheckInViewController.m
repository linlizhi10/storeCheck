//
//  CheckInViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/13.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckInViewController.h"
#import "CheckHomeViewController.h"
#import "StoreListCell.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import "Store.h"
#import "LLZAction.h"
#import "LLZUser.h"
#import <BaiduMapAPI/BMapKit.h>

@interface CheckInViewController ()
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) DataManager * dataM;
@property (nonatomic, strong) NSArray * aroundStoreArr;
@property (weak, nonatomic) IBOutlet UITextField *storeSearch;
@property (weak, nonatomic) IBOutlet UITextField *aroundSearch;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITableView *storeListTableView;

- (IBAction)searchAction:(id)sender;
- (IBAction)confirmAction:(id)sender;

@end

@implementation CheckInViewController

static NSString *cellI = @"StoreListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"入店"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    self.aroundSearch.keyboardType = UIKeyboardTypeNumberPad;
    self.dataM = [DataManager shareDataManager];
    
    if (!self.appD.locationSuccess) {
        self.appD.latitude = 31.177277;
        self.appD.longitude = 121.427922;
    }else{
        NSLog(@"location success");
    }
    
    self.aroundStoreArr = [self.dataM getAroudStoreWithLatitude:self.appD.latitude longitude:self.appD.longitude];
    //set tableview
    [self.storeListTableView setBackgroundColor:[UIColor clearColor]];
    [self.storeListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    RegisterNib(cellI, self.storeListTableView);

}

- (NSArray *)datafilter:(NSArray *)storeArr
{
    self.appD.latitude = 31.177277;
    self.appD.longitude = 121.427922;
    NSMutableArray *arrm = [[NSMutableArray alloc] init];
    for (Store *store in storeArr) {
        BOOL ptInCircle = BMKCircleContainsCoordinate(CLLocationCoordinate2DMake(store.Latitude, store.longitude), CLLocationCoordinate2DMake(self.appD.latitude, self.appD.longitude), [self.aroundSearch.text doubleValue] * 1000);
        NSLog(@"ptInCircle is %d",ptInCircle);
        if (ptInCircle) {
            [arrm addObject:store];
        }
    }
    return arrm;
//    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(store.Latitude, store.longitude);
//    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
//    NSDictionary *testDic = BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_COMMON);
//    //转换GPS坐标至百度坐标(加密后的坐标)
//    testDic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
//    //解密加密后的坐标字典
//    CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(testDic);
        //判断点与圆位置关系的示例代码如下：
//    BOOL ptInCircle = BMKCircleContainsCoordinate(CLLocationCoordinate2DMake(store.Latitude, store.longitude), CLLocationCoordinate2DMake(self.appD.latitude, self.appD.longitude), [self.aroundSearch.text doubleValue]);
    
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
    return self.aroundStoreArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    Store *store = self.aroundStoreArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillCellWithStore:store];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row + 1;
    Alert(@"确认入店", self,201);

}

- (IBAction)searchAction:(id)sender {
    [self.storeSearch resignFirstResponder];
    self.aroundStoreArr = [self.appD.dataM searchStoreByKeyWord:self.storeSearch.text];
    [self.storeListTableView reloadData];
}

- (IBAction)confirmAction:(id)sender {
    [self.aroundSearch resignFirstResponder];
    NSArray *arr = [self.appD.dataM getStore];
    self.aroundStoreArr = [self datafilter:arr];
    [self.storeListTableView reloadData];
}

#pragma mark #################### alert ####################

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        Store *store = self.aroundStoreArr[self.selectedIndex - 1];
        /**
         save many model
         */
        //     NSMutableArray *dataA = [[NSMutableArray alloc]init];
        //     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        //     [dataA addObject:data];
        //     [[NSUserDefaults standardUserDefaults] setObject:dataA forKey:@"VersionModel"];
        //     [[NSUserDefaults standardUserDefaults] synchronize];
        
        //入店写入
        if ([UserDefaults objectForKey:@"user"]) {
            LLZUser *user = [self getUserInfo];
            NSString *signTime = [self.dateFormatterTwo stringFromDate:[NSDate date]];
            LLZAction *action = [LLZAction actionWithTransStatus:0
                                                        userName:user.userName
                                                          userId:user.userId
                                                       storeName:store.storeName
                                                       storeCode:store.storeId
                                                          remark:@"入店"
                                                        signTime:signTime
                                                        signName:nil];
                //test
            [self.appD.dataM insertAction:action];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:store];
            [UserDefaults setValue:data forKey:@"selectStore"];
            [UserDefaults setBool:YES forKey:@"checkIn"];
            [UserDefaults setValue:signTime forKey:@"checkInTime"];
            
        }else{
            NSLog(@"not login");
        }
        
        //time count start
        [self startTimeCountWithTimeString:nil];
        
        //pop to last viewcontroller
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[CheckHomeViewController class]]) {
                CheckHomeViewController *homeVC = (CheckHomeViewController *)vc;
                [self.navigationController popToViewController:homeVC animated:YES];
                [homeVC setLeftButton:store.storeName];
            }
        }
    }else{
        self.selectedIndex = 0;
    }
}

@end
