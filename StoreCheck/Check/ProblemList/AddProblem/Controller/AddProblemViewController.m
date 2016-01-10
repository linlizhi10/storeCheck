//
//  AddProblemViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "AddProblemViewController.h"
#import "UIImage+Compress.h"

@interface AddProblemViewController ()
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation AddProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"修改问题"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)chooseType:(id)sender {
    
}
- (IBAction)takePhoto:(id)sender {
    [self takePhotos];
}

- (IBAction)save:(id)sender {
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
    NSString *storeId = @"101";
    NSString *userId = @"11";
    NSString *listId = @"011";
    NSString *imageName = [NSString stringWithFormat:@"%@%@%@.png",storeId,userId,listId];
    BOOL writeFlag = [data writeToFile:ImagePath(imageName) atomically:YES];
    NSLog(@"writeFlag is %d",writeFlag);
}

@end
