//
//  CheckDetailsViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/20.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckDetailsViewController.h"
#import "DailyCheckViewController.h"
#import "LLZCheckItem.h"
#import "UIImage+Compress.h"
#import "ReasonChooseCell.h"
#import "LLZReason.h"
#import "LLZScore.h"
#import "Store.h"
#import "LLZUser.h"
#import "LLZImage.h"

@interface CheckDetailsViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView * reasonBackView;
@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong) UITableView * reasonTableView;
@property (nonatomic, strong) NSMutableArray * reasonArr;
@property (nonatomic, strong) NSMutableArray * selectReasonArr;
@property (nonatomic, strong) NSMutableArray * imageDataArr;

@end

@implementation CheckDetailsViewController

static NSString *cellI = @"ReasonChooseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectReasonArr = [[NSMutableArray alloc] init];
    self.imageDataArr = [[NSMutableArray alloc] init];
    LLZCheckItem *item = self.listArary[self.dealIndex];
    [self setDetailControllerWithData:item];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
}

- (void)test
{
    NSArray *arrI = [self.appD.dataM getImageInfo];
    for (LLZImage *image in arrI) {
        NSLog(@"image data is %ld",image.imageData.length);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)takePhotos:(id)sender {
    [self photoTapAction];
}

- (IBAction)reasonChooseAction:(id)sender {
    //clear
    if (self.selectReasonArr.count > 0) {
        [self.selectReasonArr removeAllObjects];
    }
    if (!self.reasonBackView) {
        //transparent view
        self.reasonBackView = [[UIView alloc] init];
        self.reasonBackView.frame = CGRectMake(0, 0, iPhoneWidth, iPhoneHeight);
        self.reasonBackView.backgroundColor = [UIColor blackColor];
        self.reasonBackView.alpha = 0.5;
        
    }
    [self.view addSubview:self.reasonBackView];
    
    if (!self.mainView) {
        //main View
        self.mainView = [[UIView alloc] init];
        [self.mainView setFrame:CGRectMake(10, 60, iPhoneWidth - 20, iPhoneHeight - 80)];
        self.mainView.backgroundColor = [UIColor blackColor];
        self.mainView.layer.borderWidth = 1.0f;
        self.mainView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    

    [self.view addSubview:self.mainView];
    //label
    UILabel *reasonLabel = [UILabel new];
    reasonLabel.text = @"请选择原因";
    [reasonLabel setTextColor:[UIColor whiteColor]];
    reasonLabel.backgroundColor = [UIColor blackColor];
    reasonLabel.textAlignment = NSTextAlignmentLeft;
    [reasonLabel setFrame:CGRectMake(10, 0, self.mainView.frame.size.width - 20, 40)];
    [reasonLabel setFont:[UIFont systemFontOfSize:16]];
    [self.mainView addSubview:reasonLabel];
    if (!self.reasonTableView) {
        //tableView
        self.reasonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.mainView.frame.size.width, self.mainView.frame.size.height - 100) style:UITableViewStylePlain];
        self.reasonTableView.delegate = self;
        self.reasonTableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:cellI bundle:[NSBundle mainBundle]];
        [self.reasonTableView registerNib:nib forCellReuseIdentifier:cellI];
        [self.mainView addSubview:self.reasonTableView];
    }else{
        [self.reasonTableView reloadData];
    }
    //tool view
    UIView *buttonBackView = [UIView new];
    CGFloat viewY = CGRectGetMaxY(self.reasonTableView.frame);
    [buttonBackView setFrame:CGRectMake(0, viewY, self.mainView.frame.size.width, 50)];
    buttonBackView.backgroundColor = [UIColor lightGrayColor];
    [self.mainView addSubview:buttonBackView];
    //button
    CGFloat buttonWidth = (iPhoneWidth - 30) / 2 - 5;
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmButton.frame = CGRectMake(5, 5, buttonWidth, 40);
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.backgroundColor = [UIColor whiteColor];
    [buttonBackView addSubview:confirmButton];
    //cancle
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.frame = CGRectMake(10 + buttonWidth, 5, buttonWidth, 40);
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.backgroundColor = [UIColor whiteColor];
    [buttonBackView addSubview:cancleButton];

}

- (void)confirmButtonAction:(UIButton *)sender
{
    [self.reasonBackView removeFromSuperview];
    [self.mainView removeFromSuperview];
    //打分项
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    LLZCheckItem *item = self.listArary[self.dealIndex];
    NSMutableString *reasonCodeMStr = [NSMutableString stringWithString:@""];
    NSMutableString *reasonContentMStr = [NSMutableString stringWithString:@""];
    for (int i = 0; i < self.selectReasonArr.count; i ++) {
        LLZReason *reason = self.selectReasonArr[i];
        NSString *codeStr = @"";
        NSString *contentStr = @"";
        if (i == self.selectReasonArr.count - 1) {
            codeStr = [NSString stringWithFormat:@"%@",reason.reasonCode];
            contentStr = [NSString stringWithFormat:@"%@",reason.reasonDesc];
        }else{
            codeStr = [NSString stringWithFormat:@"%@,",reason.reasonCode];
            contentStr = [NSString stringWithFormat:@"%@,",reason.reasonDesc];
        }
        [reasonCodeMStr appendString:codeStr];
        [reasonContentMStr appendString:contentStr];
    }
    NSLog(@"reasonCodeMStr is %@",reasonCodeMStr);
    
    LLZScore *score = [LLZScore scoreWithScoreId:0
                                         storeId:store.storeId
                                          userId:user.userId
                                       checkDate:@"2015-12-23"
                                       checkType:10
                                          itemId:(int)item.itemId
                                      reasonCode:reasonCodeMStr
                                   reasonContent:reasonContentMStr
                                           score:[self.itemScore.text intValue]
                                      imageFile1:NULL
                                      imageFile2:NULL
                                      modifyTime:@"2016-01-04"
                                      tranStatus:0];
    BOOL insertS = [self.appD.dataM insertScore:score];
    if (insertS) {
        self.checkedCount += 1;
        self.uncheckedCount -= 1;
        self.scoreString += [self.itemScore.text intValue];
        [self setSubMessage];
    }else
    {
        NSString *dateString = [self.dateFormatterOne stringFromDate:[NSDate date]];
        self.scoreString = [self.appD.dataM scoreAmountWithStore:[self getStoreInfo]
                                         user:[self getUserInfo]
                                         date:dateString];
        self.score.text = [NSString stringWithFormat:@"%d",self.scoreString];
    }

    
}

- (void)cancleButtonAction:(UIButton *)sender
{
    [self.reasonBackView removeFromSuperview];
    [self.mainView removeFromSuperview];
}

- (IBAction)prePageAction:(id)sender {
    [self.pageTextFiled resignFirstResponder];
    self.pageTextFiled.text = @"";
    if (self.dealIndex != 0) {
        self.dealIndex --;
        LLZCheckItem *item = self.listArary[self.dealIndex];
        NSLog(@"item content is %@",item.title);
        [self setDetailControllerWithData:item];
    }
}

- (IBAction)nextPageAction:(id)sender {
    [self.pageTextFiled resignFirstResponder];
    self.pageTextFiled.text = @"";
    if (self.dealIndex < self.listArary.count - 1) {
        self.dealIndex ++;
        LLZCheckItem *item = self.listArary[self.dealIndex];
        NSLog(@"item content is %@",item.title);
        [self setDetailControllerWithData:item];
    }
   
}

- (IBAction)gotoAction:(id)sender {
    
    [self.pageTextFiled resignFirstResponder];
    if (![self.pageTextFiled.text isEqualToString:@""]) {
        int index = [self.pageTextFiled.text intValue];
        if (index < 1 ) {
            [WToast showWithText:@"请输入有效数字" forToastType:2];
        }else
        {
            if (index > self.totalCount) {
                [WToast showWithText:@"请输入有效数字" forToastType:2];
            }else
            {
                //跳转
                if (index == self.dealIndex) {
                    NSLog(@"this is the page");
                }else{
                    self.dealIndex = index - 1;
                    LLZCheckItem *item = self.listArary[self.dealIndex];
                    NSLog(@"item is %@,index is %ld",item.title,self.dealIndex);
                    [self setDetailControllerWithData:item];
                }
            }
        }
    }
    self.pageTextFiled.text = @"";
}

#pragma mark - photo

- (void)photoTapAction {
    if ([self.pageTextFiled isEditing]) {
        [self.pageTextFiled resignFirstResponder];
    }
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"相册"
                                              otherButtonTitles:@"拍照", nil];
    [sheet dismissWithClickedButtonIndex:2 animated:YES];
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            NSLog(@"相册");
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"相册不可用"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:nil];
                [alert show];
            }else{
                [self pickImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
                
            }
            
            break;
        case 1:
            NSLog(@"相机");
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不支持相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }else
            {
                [self pickImageWithType:UIImagePickerControllerSourceTypeCamera];
            }
            break;
            
            
        default:
            
            break;
    }
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
    self.detailImage.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self imageDeal:selectedImage];
}

#pragma mark - reload view

- (void)setDetailControllerWithData:(LLZCheckItem *)itemContent
{
    NSArray *arrReason = [itemContent.reasonCode componentsSeparatedByString:@","];
    self.reasonArr = [NSMutableArray arrayWithArray:[self.appD.dataM getResaonByReasonCodeArray:arrReason]];
    [self.reasonTableView reloadData];
    for (NSString *code in arrReason) {
        NSLog(@"code is %@",code);
    }
    
    [self setCenterButton:itemContent.title];
    self.itemScore.text = [NSString stringWithFormat:@"%d",itemContent.score];
    self.itemContentT.text = itemContent.content;
    
    self.detailImage.image = nil;
    if (self.imageDataArr.count > 0) {
        for (LLZImage *image in self.imageDataArr) {
            if (image.itemId == itemContent.itemId) {
                self.detailImage.image = [UIImage imageWithData:image.imageData];
            }
        }
    }
    [self setSubMessage];
}

- (void)setSubMessage
{
    self.amountCheckItems.text = [NSString stringWithFormat:@"%d",self.totalCount];
    self.checkedItems.text = [NSString stringWithFormat:@"%d",self.checkedCount];
    self.uncheckedItems.text = [NSString stringWithFormat:@"%d",self.uncheckedCount];
    self.score.text = [NSString stringWithFormat:@"%d",self.scoreString];
}

- (void)imageDeal:(UIImage *)image
{
    UIImage *newImage = [UIImage imageWithImageSimple:image];
    NSData *data = UIImagePNGRepresentation(newImage);
    
    //name should contain storeId userId listId
    Store *store = [self getStoreInfo];
    LLZUser *user = [self getUserInfo];
    LLZCheckItem *item = self.listArary[self.dealIndex];
    NSString *storeId = store.storeId;
    NSString *userId = user.userId;
    NSString *itemId = [NSString stringWithFormat:@"%d",item.itemId];
    NSString *imageFile = [NSString stringWithFormat:@"%@%@%@",storeId,userId,itemId];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",imageFile];
    BOOL writeFlag = [data writeToFile:ImagePath(imageName) atomically:YES];
    NSLog(@"writeFlag is %d-----path is %@",writeFlag,ImagePath(imageName));
    NSDate *date = [NSDate date];
    NSString *imageDate = [self.dateFormatterOne stringFromDate:date];
    NSString *modifyTime = [self.dateFormatterTwo stringFromDate:date];
    LLZImage *lImage = [LLZImage imageWithStoreId:storeId
                                           userId:userId
                                        imageDate:imageDate
                                        imageType:item.checkType
                                           itemId:item.itemId
                                        imageDesc:@""
                                        imageData:data
                                         imagPath:imageFile
                                       modifyTime:modifyTime
                                       tranStatus:0];
    [self.appD.dataM insertImageItem:lImage];
    [self.imageDataArr addObject:lImage];
    
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reasonArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReasonChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LLZReason *reason = self.reasonArr[indexPath.row];
    NSLog(@"reason desc is %@",reason.reasonDesc);
    [cell fillCellWithReason:reason];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReasonChooseCell *cell = (ReasonChooseCell *)[self.reasonTableView cellForRowAtIndexPath:indexPath];
    
    if (cell.imageStatus == NO) {
        cell.selectFlagImage.image = [UIImage imageNamed:@"select_yes"];
        cell.imageStatus = YES;
        LLZReason *reason = self.reasonArr[indexPath.row];
        [self.selectReasonArr addObject:reason];
    }else
    {
        cell.selectFlagImage.image = [UIImage imageNamed:@"select_no"];
        cell.imageStatus = NO;
        LLZReason *reason = self.reasonArr[indexPath.row];
        [self.selectReasonArr removeObject:reason];

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)zeroButtonAction:(id)sender {
    
    self.itemScore.text = @"0";
    
}

- (IBAction)addAction:(id)sender {
    LLZCheckItem *item = self.listArary[self.dealIndex];
    int scoreMax = item.score;
    if ([self.itemScore.text intValue] < scoreMax) {
        self.itemScore.text = [NSString stringWithFormat:@"%d",([self.itemScore.text intValue] + 1)];
    }
}

- (IBAction)fullScoreAction:(id)sender {
    LLZCheckItem *item = self.listArary[self.dealIndex];
    self.itemScore.text = [NSString stringWithFormat:@"%d",item.score];
}

- (IBAction)decreaceAction:(id)sender {
    if ([self.itemScore.text intValue] >= 1) {
        self.itemScore.text = [NSString stringWithFormat:@"%d",([self.itemScore.text intValue] - 1)];
    }
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[DailyCheckViewController class]]) {
            DailyCheckViewController *dailyVC = (DailyCheckViewController *)vc;
            [dailyVC prepareData];
        }
    }
}

@end
