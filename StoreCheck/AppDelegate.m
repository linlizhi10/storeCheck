//
//  AppDelegate.m
//  StoreCheck
//
//  Created by skunk  on 15/11/12.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "LogInViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "DataManagerT.h"
#import "LLZTddVersion.h"
#import "AFNetworkReachabilityManager.h"
#import "LLZParam.h"
#import "LLZNotice.h"
#import "Store.h"
#import "LLZReason.h"
#import "LLZPlan.h"

@interface AppDelegate ()
<BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
//map
@property (nonatomic, strong) BMKMapManager * mapManager;
@property (nonatomic, assign) BMKSearchErrorCode * searchCode;
@property (nonatomic, strong) BMKLocationService * locService;
@property (nonatomic, strong) BMKGeoCodeSearch * searcher;
//data
@property (nonatomic, strong) DataManagerT * dataMT;

@end

@implementation AppDelegate

static NSString *baiduKey = @"D8078f63dd5d02cb3980fd4b569a73ff";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    application.statusBarStyle = UIStatusBarStyleLightContent;
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [self initMapManager];
    [self initData];
    [self startMonitoringNetStatus];
    LogInViewController *login = [[LogInViewController alloc] init];
    self.window.rootViewController = login;
    return YES;
}

- (void)initData
{
    //test
//    [self copyData];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:ImagePath(nil)]) {
        [manager createDirectoryAtPath:ImagePath(nil) withIntermediateDirectories:YES attributes:nil error:nil];
    }
    _dataM = [DataManager shareDataManager];
    [self.dataM createStoreTable];
    [self.dataM createUserTable];
    [self.dataM dropMessageTable];
    [self.dataM createMessageTable];
    [self.dataM createSignStoreTable];
    [self.dataM createCheckItemTable];
    [self.dataM createTddVersionTable];
    [self.dataM createShopPlanTable];
    [self.dataM createQuestionTable];
    [self.dataM createParamTable];
    
    NSString *param = @"transfer_version.do";
    NSDictionary *dic = nil;
    if ([self.dataM getMaxTddVersion]) {
        LLZTddVersion *maxVersion = [self.dataM getMaxTddVersion];
        dic = @{@"itemId":maxVersion.itemId};
    }else{
        dic = @{@"itemId":[NSNull null]};
    }
    //tdd_version message
    [[HttpClient sharedClient] post:ServerParam(param) obj:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject is %@",responseObject);
        NSArray *arr = responseObject;
        if (arr.count > 0) {
            for (NSDictionary *dic in arr) {
                @try {
                    LLZTddVersion *tddVersion = [LLZTddVersion parseDic:dic];
                    [self.dataM insertTddVersion:tddVersion];
                    [self getDataFromServerWithTddVersion:tddVersion];

                }
                @catch (NSException *exception) {
                    LLZTddVersion *tddVersion = [LLZTddVersion tddVersionWithItemId:@"0"
                                                                          tableName:@""
                                                                         modifyDate:@""];
                    [self.dataM insertTddVersion:tddVersion];
                    [self getDataFromServerWithTddVersion:tddVersion];

                }
            }
        }else{
            NSLog(@"no need update");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getDataFromServerWithTddVersion:(LLZTddVersion *)tddVersion
{
    NSString *param = @"transfer_table.do";
    NSDictionary *dic = @{@"itemId":tddVersion.itemId,@"tabName":tddVersion.tableName,@"modifyDate":[NSNull null]};
    [[HttpClient sharedClient] post:ServerParam(param) obj:dic
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"table is %@ \n res is %@",tddVersion.tableName,responseObject);
                                
                                NSArray *arrDic = responseObject;
                                //param table
                                if ([tddVersion.tableName isEqualToString:@"Params"]) {
                                    for (NSDictionary *dic in arrDic) {
                                        LLZParam *param = [LLZParam parseWithDic:dic];
                                        [self.dataM insertParam:param];
                                    }
                                }else if ([tddVersion.tableName isEqualToString:@"Tbs_Message"]){
                                    //message table
                                    for (NSDictionary *dic in arrDic) {
                                        LLZNotice *notice = [LLZNotice parseNoticeDic:dic];
                                        [self.dataM insertMessage:notice];
                                    }
                                }else if ([tddVersion.tableName isEqualToString:@"TgmEmpStore"]){
                                    //
                                }else if ([tddVersion.tableName isEqualToString:@"TbbCorp"]){
                                    //store table
                                    for (NSDictionary *dic in arrDic) {
                                        Store *store = [Store parseStoreDic:dic];
                                        [self.dataM insertStore:store];
                                    }
                                    
                                }else if ([tddVersion.tableName isEqualToString:@"Tbs_Reason"]){
                                    for (NSDictionary *dic in arrDic) {
                                        LLZReason *reason = [LLZReason parseResonDic:dic];
                                        [self.dataM insertReason:reason];
                                    }
                                
                                }else if ([tddVersion.tableName isEqualToString:@"Tbs_ShopPlanList"]){
                                    for (NSDictionary *dic in arrDic) {
                                        LLZPlan *plan = [LLZPlan parsePlanDic:dic];
                                        
                                    }
                                
                                }else if ([tddVersion.tableName isEqualToString:@"TgmEmployee"]){
                                
                                }else if ([tddVersion.tableName isEqualToString:@"Tbs_CheckItem"]){
                                
                                }
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
}

- (void)copyData
{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:DocumentPath(@"StoreCheck.db")];
    if (!isExist) {
        NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:@"StoreCheckOriginal" ofType:@"db"];
        NSLog(@"backup is %@",backupDbPath);
        //通过nsfilemanager的复制属性，
        BOOL cp = [manager copyItemAtPath:backupDbPath toPath:DocumentPath(@"StoreCheck.db") error:nil];
        NSLog(@"cp is %d",cp);
    }
}

- (void)initMapManager
{
    _mapManager = [[BMKMapManager alloc] init];
    self.locationSuccess = YES;
    BOOL mapStart = [_mapManager start:baiduKey generalDelegate:self];
    if (!mapStart) {
        NSLog(@"start failed");
    }
    //set location
    else{
        _locService = [[BMKLocationService alloc] init];
        CLLocationDistance distance = 100.f;
        [BMKLocationService setLocationDistanceFilter:distance];
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
}

#pragma mark #################### map ####################
/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError
{
    NSLog(@"error code is %d",iError);
    self.locationSuccess = NO;

}

/**
 *返回授权验证错误
 *@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
 */
- (void)onGetPermissionState:(int)iError
{
    NSLog(@"error code is %d",iError);
    self.locationSuccess = NO;

}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"userlocation is %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.locationSuccess = YES;
    self.latitude = userLocation.location.coordinate.latitude;
    self.longitude = userLocation.location.coordinate.longitude;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)startMonitoringNetStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                self.netStatus = 1;
                break;
                case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"not reachable");
                self.netStatus = 0;
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"wwan");
                self.netStatus = 2;
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
