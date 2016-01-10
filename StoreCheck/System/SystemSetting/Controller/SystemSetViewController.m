//
//  SystemSetViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/12/28.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "SystemSetViewController.h"
#import "LLZSwitchCell.h"
#import "LLZButtonCell.h"

@interface SystemSetViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *systemSetTable;

@end

@implementation SystemSetViewController
static NSString *buttonCell = @"LLZButtonCell";
static NSString *switchCell = @"LLZSwitchCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"系统设置"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    RegisterNib(buttonCell, self.systemSetTable);
    UINib *nibN = [UINib nibWithNibName:switchCell bundle:[NSBundle mainBundle]];
    [self.systemSetTable registerNib:nibN forCellReuseIdentifier:switchCell];

}

- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
      LLZSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCell];
        __block LLZSwitchCell *ws = cell;
        cell.switchBlock = ^(){
            NSLog(@"wifionly is %d",ws.cellSwitch.on);
            [UserDefaults setBool:ws.cellSwitch.on forKey:@"wifiOnly"];
        };
        return cell;
    }else{
        LLZButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCell];
        cell.cellButton.backgroundColor = RGB(75, 216, 99);
        cell.cellButton.layer.cornerRadius = cell.cellButton.frame.size.height / 2;
        cell.buttonBlock = ^(){
            NSLog(@"upload picture");
        };
        return cell;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
