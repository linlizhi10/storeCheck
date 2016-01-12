//
//  ProblemListViewController.m
//  StoreCheck
//
//  Created by skunk  on 15/11/23.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "ProblemListViewController.h"
#import "ProblemListCell.h"
#import "AddProblemViewController.h"
#import "Store.h"

@interface ProblemListViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *problemAmount;
@property (weak, nonatomic) IBOutlet UILabel *unsolvedProblemAmount;
@property (weak, nonatomic) IBOutlet UITableView *problemListTable;
- (IBAction)addNewProblem:(id)sender;

@end

@implementation ProblemListViewController

static NSString *cellI = @"ProblemListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCenterButton:@"问题列表"];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    Store *store = [self getStoreInfo];
    self.storeName.text = [NSString stringWithFormat:@"%@(%@)",
                           [store.storeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
                           store.storeAddress];
    RegisterNib(cellI, self.problemListTable);
/*
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] init];
    NSString *str01 = @"123";
    NSString *str02 = @"456";
    [aStr appendAttributedString:[[NSAttributedString alloc] initWithString:str01 attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]];
    [aStr appendAttributedString:[[NSAttributedString alloc] initWithString:str02 attributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}]];
    test.attributedText = aStr;
    [self.view addSubview:test];
 */
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
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellI];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)addNewProblem:(id)sender {
    [self pushToViewContrller:[AddProblemViewController class]];
}

@end
