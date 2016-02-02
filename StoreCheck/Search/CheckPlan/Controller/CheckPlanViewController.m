//
//  CheckPlanViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/27.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "CheckPlanViewController.h"
#import "CheckPlanCell.h"
#import "LLZUser.h"
#import "LLZPlan.h"

@interface CheckPlanViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * planArray;
@property (nonatomic, assign) BOOL dateOrder;

@end

@implementation CheckPlanViewController

static NSString *cellI = @"CheckPlanCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"巡店计划"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self dataPrepare];
    RegisterNib(cellI, self.planTable);
    self.planTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dataPrepare
{
    self.dateOrder = YES;
    LLZUser *user = [self getUserInfo];
    //test
    self.planArray = [NSMutableArray arrayWithArray:[self.appD.dataM getCheckPlanOrderByDateByUserId:user.userId]];
    for (LLZPlan *plan in self.planArray) {
        NSLog(@"plan.date is %@",plan.checkTime);
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
    return self.planArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    LLZPlan *plan = self.planArray[indexPath.item];
    
    [cell fillCellWithPlan:plan];;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)dateOrder:(id)sender {
    if (self.dateOrder) {
        return;
    }else{
        self.dateOrder = YES;
        LLZUser *user = [self getUserInfo];
        self.planArray = [NSMutableArray arrayWithArray:[self.appD.dataM getCheckPlanOrderByDateByUserId:user.userId]];
        [self.planTable reloadData];
    }
}

- (IBAction)storeOrder:(id)sender {
    if (self.dateOrder) {
        self.dateOrder = NO;
        LLZUser *user = [self getUserInfo];
        self.planArray = [NSMutableArray arrayWithArray:[self.appD.dataM getCheckPlanOrderByStoreIdByUserId:user.userId]];
        [self.planTable reloadData];
    }else
    {
        return;
    }
}
@end
