//
//  ALCMineFamilyTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineFamilyTVC.h"
#import "ALCMineFamilyOneCell.h"
#import "ALCAddMineFamilyTwoVC.h"
#import "ALCMineJianMessageTVC.h"
@interface ALCMineFamilyTVC ()
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCMineFamilyTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"家庭联系人";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineFamilyOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"添加" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        ALCAddMineFamilyTwoVC * vc =[[ALCAddMineFamilyTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];


    self.dataArray = @[].mutableCopy;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        [self getData];
    }];

    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:user_getMyFamilyMember parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMineFamilyOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.isBlack = indexPath.row;
    cell.model = self.dataArray[indexPath.row];
    
    if (indexPath.row == 0 || indexPath.row + 1 == self.dataArray.count) {
        cell.lineV.hidden = YES;
    }else {
        cell.lineV.hidden = NO;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.isComeDP && self.sendPeopleNameIDBlock != nil) {
//        self.sendPeopleNameIDBlock(self.dataArray[indexPath.row].name,self.dataArray[indexPath.row].ID);
//        [self.navigationController popViewControllerAnimated:YES];
//    }

    ALCMineJianMessageTVC * vc =[[ALCMineJianMessageTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    ALMessageModel * mm = self.dataArray[indexPath.row];
    vc.familyMemberId = mm.ID;
    vc.type = mm.type;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
