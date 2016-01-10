//
//  RepairViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/25.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "RepairViewController.h"
#import "RepairListCell.h"
@interface RepairViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *repairListTable;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *repairAmount;
- (IBAction)addNewRepair:(id)sender;

@end

@implementation RepairViewController

static NSString *cellI = @"RepairListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    RegisterNib(cellI, self.repairListTable);
    [self setCenterButton:@"报修"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepairListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (IBAction)addNewRepair:(id)sender {
}
@end
