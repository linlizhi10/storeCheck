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
#import "LLZCheckItem.h"
#import "ListAdjustModel.h"
#import "UIImage+Compress.h"

@interface ListAdjustViewController ()
<UITableViewDelegate,UITableViewDataSource,
UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UITableView *listAdjustTable;
@property (nonatomic, strong) NSMutableArray * photoArr;
@property (nonatomic, assign) NSInteger dealIndex;
@property (nonatomic, assign) NSInteger imageType;
@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) LLZUser *user;

@end

@implementation ListAdjustViewController

static NSString *cellI = @"ListAdjustCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dealIndex = 0;
    self.imageType = 0;
    [self  setCenterButton:@"陈列调整"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    RegisterNib(cellI, self.listAdjustTable);
    _store = [self getStoreInfo];
    _user  = [self getUserInfo];
    self.storeLabel.text = [NSString stringWithFormat:@"%@(%@)",[_store.storeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],_store.storeAddress];
    [self dataPreapared];
}

- (void)dataPreapared
{
    self.photoArr = [[NSMutableArray alloc] init];
    NSArray *arrayItem = [self.appD.dataM getListAdjustItem];
    for (LLZCheckItem *item in arrayItem) {
        LLZPhoto *photo = [self.appD.dataM getPhotoWithStoreId:_store.storeId userId:_user.userId itemId:item.itemId];
        ListAdjustModel *adjust = [ListAdjustModel adjustWithItem:item photo:photo];
        [self.photoArr addObject:adjust];
    }
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
    ListAdjustModel *adjust = self.photoArr[indexPath.row];
    //test
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell fillCellWithPhoto:adjust];
    });
    
    __block ListAdjustCell *ws = cell;
    cell.compareBlock = ^(UIImage *beforeImage,UIImage *afterImage){
        CompareViewController *compare = [[CompareViewController alloc] init];
        compare.beforeImage = ws.beforeImage.image;
        compare.afterImage = ws.afterImage.image;
        [self.navigationController pushViewController:compare animated:YES];
        
        //        [self pushToViewContrller:[CompareViewController class]];
    };
    NSString *itemId = [NSString stringWithFormat:@"%ld",adjust.item.itemId];
    cell.beforeBlock = ^(void){
        self.dealIndex = indexPath.row;
        self.imageType = 1; //before
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不支持相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else
        {
            [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
        }
    };
    cell.afterBlock = ^(){
        self.dealIndex = indexPath.row;
        self.imageType = 2; //after
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不支持相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else
        {
            [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
        }
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

- (void)pickImageWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = type;
    picker.allowsEditing = YES;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self imageDeal:selectedImage];
}

- (void)imageDeal:(UIImage *)image
{
    UIImage *newImage = [UIImage imageWithImageSimple:image];
    NSData *data = UIImagePNGRepresentation(newImage);
    
    //name should contain storeId userId listId
    ListAdjustModel *listAdjust = self.photoArr[self.dealIndex];
    LLZCheckItem *item = listAdjust.item;
    NSString *storeId = _store.storeId;
    NSString *userId = _user.userId;
    NSString *itemId = [NSString stringWithFormat:@"%ld",item.itemId];
    NSString *imageFile = [NSString stringWithFormat:@"%@%@%@%ld",storeId,userId,itemId,self.imageType];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",imageFile];
    BOOL writeFlag = [data writeToFile:ImagePath(imageName) atomically:YES];
    NSLog(@"writeFlag is %d-----path is %@",writeFlag,ImagePath(imageName));
    NSDate *date = [NSDate date];
    NSString *imageDate = [self.dateFormatterOne stringFromDate:date];
    NSString *modifyTime = [self.dateFormatterTwo stringFromDate:date];
    LLZPhoto *photo = [LLZPhoto photoWithStoreId:storeId
                                          userId:userId
                                       photoDate:imageDate
                                       checkType:20
                                          itemId:item.itemId
                                       itemTitle:item.title
                                      imageFile1:nil
                                      imageFile2:nil
                                      modifyTime:modifyTime
                                      tranStatus:0];
    if (self.imageType == 1) {
        photo.imageFile1 = imageFile;
        photo.imageFile2 = nil;
    }else{
        photo.imageFile2 = imageFile;
        photo.imageFile1 = nil;
    }
    [self.appD.dataM insertPhoto:photo];
    
}

@end
