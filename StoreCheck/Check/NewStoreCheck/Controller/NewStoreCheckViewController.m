//
//  NewStoreCheckViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/24.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "NewStoreCheckViewController.h"
#import "NewCheckListCell.h"
#import "NewCheckItem.h"    //replace by LLZCheckItem.h
#import "LLZCheckItem.h"
#import "UIImage+Compress.h"
#import "Store.h"
#import "LLZUser.h"
#import "LLZImage.h"

@interface NewStoreCheckViewController ()
<UITableViewDataSource,UITableViewDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray * itemArray;
@property (nonatomic, assign) NSInteger selectItem;
@property (nonatomic, copy) NSString * imageFile;

@end

@implementation NewStoreCheckViewController

static NSString *cellI = @"NewCheckListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageFile = @"";
    [self setCenterButton:@"新店检查"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    Store *store = [self getStoreInfo];
    self.storeName.text = [NSString stringWithFormat:@"%@(%@)",
                           [store.storeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
                           store.storeAddress];

    self.selectItem = 0;
    [self prepareData];
    RegisterNib(cellI, self.checkListTable);

}

- (void)prepareData
{
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    self.itemArray = [NSMutableArray arrayWithArray:
                      [self.appD.dataM getNewStoreCheckItemWithStoreId:store.storeId
                                                                userId:user.userId]];
    
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
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewCheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewCheckItem *item = self.itemArray[indexPath.item];
    cell.takePhotoBlock = ^(void){
        self.selectItem = indexPath.row;
        [self takePhoto];
        item.imageFile = self.imageFile;
        [self.checkListTable reloadData];
    };
    [cell fillCellWithItem:item andIndex:indexPath.item + 1];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (void)takePhoto
{
  
    NSLog(@"相机");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不支持相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else
    {
        [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
    }
    
}

- (void)pickImageWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = type;
    picker.allowsEditing = NO;
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
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    LLZCheckItem *item = self.itemArray[self.selectItem];
    //name should contain storeId userId listId
    NSString *storeId = store.storeId;
    NSString *userId = user.userId;
    NSString *listId = [NSString stringWithFormat:@"%ld",item.itemId];
    NSString *imageName = [NSString stringWithFormat:@"%@%@%@.jpg",storeId,userId,listId];
    BOOL writeFlag = [data writeToFile:ImagePath(imageName) atomically:YES];
    NSLog(@"writeFlag is %d",writeFlag);
    self.imageFile = [NSString stringWithFormat:@"%@%@%@",storeId,userId,listId];
    NSString *imageDate = [self.dateFormatterOne stringFromDate:[NSDate date]];
    NSString *modifyTime = [self.dateFormatterTwo stringFromDate:[NSDate date]];
    LLZImage *imageItem = [LLZImage imageWithStoreId:storeId
                                          userId:userId
                                       imageDate:imageDate
                                       imageType:40
                                          itemId:item.itemId
                                       imageDesc:@""
                                       imageData:nil
                                        imagPath:imageName
                                      modifyTime:modifyTime
                                      tranStatus:0];
    [self.appD.dataM insertImageItem:imageItem];
}

@end
