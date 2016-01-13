//
//  AddProblemViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "AddProblemViewController.h"
#import "UIImage+Compress.h"
#import "LLZUser.h"
#import "Store.h"
#import "LLZQuestion.h"
#import "LLZCheckItem.h"

@interface AddProblemViewController ()
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * problemListArr;
@property (nonatomic, strong) UIView * problemListBackView;
@property (nonatomic, strong) UIView *clearView;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSString * imageName;

@end

@implementation AddProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName = @"";
    self.selectIndex = 0;
    [self setCenterButton:@"修改问题"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self dataPrepared];
}

- (void)dataPrepared
{
    self.problemListArr = [NSMutableArray arrayWithArray:[self.appD.dataM getProblemItem]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)chooseType:(id)sender {
    _clearView = [[UIView alloc] initWithFrame:self.view.bounds];
    _clearView.backgroundColor = [UIColor blackColor];
    _clearView.alpha = 0.5;
    [self.view addSubview:_clearView];
    if (!_problemListBackView) {
        _problemListBackView = [[UIView alloc] initWithFrame:CGRectMake(20, 70, iPhoneWidth - 40, iPhoneHeight - 110)];
        _problemListBackView.backgroundColor = [UIColor blackColor];
    }else{
        NSLog(@"exists");
    }
    [self.view addSubview:_problemListBackView];
    CGFloat tableViewHeight = _problemListBackView.frame.size.height;
    UITableView *problemTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - 40, tableViewHeight) style:UITableViewStylePlain];
    problemTable.delegate = self;
    problemTable.dataSource = self;
    problemTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.problemListArr.count == 0) {
        problemTable.hidden = YES;
    }else{
        problemTable.hidden = NO;
    }
    [_problemListBackView addSubview:problemTable];
}

- (IBAction)takePhoto:(id)sender {
    [self takePhotos];
}

- (IBAction)save:(id)sender {
    if (!self.problemPhoto.image) {
        [WToast showWithText:@"请先拍照" forToastType:2];
    }else{
        Store *store = [self getStoreInfo];
        LLZUser *user = [self getUserInfo];
        NSString *storeId = store.storeId;
        NSString *userId = user.userId;
        NSString *dateString = [self.dateFormatterOne stringFromDate:[NSDate date]];
        NSString *modifyDateString = [self.dateFormatterTwo stringFromDate:[NSDate date]];
        LLZQuestion *question = [LLZQuestion questionWithStoreId:storeId
                                                       photoDate:dateString
                                                          userId:userId
                                                          itemId:10
                                                    questionDesc:@""
                                                      imageFile1:self.imageName
                                                      imageFile2:self.imageName
                                                        isSolved:NO
                                                          sortNo:1
                                                      modifyTime:modifyDateString
                                                    modifyUserId:userId
                                                      tranStatus:10];
        [self.appD.dataM insertQuestion:question];
        }
}

- (void)takePhotos
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
    
    //name should contain storeId userId listId
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    NSString *storeId = store.storeId;
    NSString *userId = user.userId;
    NSString *listId = @"011";
    NSString *imageName = [NSString stringWithFormat:@"%@%@%@.jpg",storeId,userId,listId];
    BOOL writeFlag = [data writeToFile:ImagePath(imageName) atomically:YES];
    self.imageName = [NSString stringWithFormat:@"%@%@%@",storeId,userId,listId];
    NSLog(@"writeFlag is %d",writeFlag);
    self.problemPhoto.image = image;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.problemListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellI = @"cellP";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellI];
    };
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cell.frame) - 1, iPhoneWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    LLZCheckItem *item = self.problemListArr[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    [self.problemListBackView removeFromSuperview];
    [self.clearView removeFromSuperview];
    LLZCheckItem *item = self.problemListArr[indexPath.row];
    self.problemType.text = item.title;
}

@end
