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
    LogInViewController *login = [[LogInViewController alloc] init];
    self.window.rootViewController = login;
    return YES;
}

- (void)initData
{
    //test
    [self copyData];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:ImagePath(nil)]) {
        [manager createDirectoryAtPath:ImagePath(nil) withIntermediateDirectories:YES attributes:nil error:nil];
    }
    _dataM = [DataManager shareDataManager];
    [self.dataM deleteTddVersion];
    
    [self.dataM createStoreTable];
    [self.dataM createUserTable];
    [self.dataM createMessageTable];
    [self.dataM createSignStoreTable];
    [self.dataM createCheckItemTable];
    [self.dataM createTddVersionTable];
   
    NSString *param = @"transfer_version.do";
    [[HttpClient sharedClient] post:ServerParam(param) obj:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = responseObject;
        for (NSDictionary *dic in arr) {
            LLZTddVersion *tddVersion = [LLZTddVersion parseDic:dic];
            [self.dataM insertTddVersion:tddVersion];
            [self getDataFromServerWithTddVersion:tddVersion];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getDataFromServerWithTddVersion:(LLZTddVersion *)tddVersion
{
    NSString *param = @"transfer_version.do";
    NSDictionary *dic = @{@"itemId":tddVersion.itemId};
    [[HttpClient sharedClient] post:ServerParam(param) obj:dic
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"tddname is %@\ndata is %@",tddVersion.tableName,responseObject);
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
    self.locationSuccess = YES;

}

/**
 *返回授权验证错误
 *@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
 */
- (void)onGetPermissionState:(int)iError
{
    NSLog(@"error code is %d",iError);
    self.locationSuccess = YES;

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

@end
