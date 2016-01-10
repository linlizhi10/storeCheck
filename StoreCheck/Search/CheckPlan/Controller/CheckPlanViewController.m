//
//  CheckPlanViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckPlanViewController.h"
#import "CheckPlanCell.h"

@interface CheckPlanViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * planArray;

@end

@implementation CheckPlanViewController

static NSString *cellI = @"CheckPlanCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"巡店计划"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    RegisterNib(cellI, self.planTable);
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
    return self.planArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    Plan *plan = self.planArray[indexPath.item];
    
    [cell fillCellWithPlan:plan];;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)dateOrder:(id)sender {
}

- (IBAction)storeOrder:(id)sender {
}
@end
