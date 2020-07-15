//
//  ALCJianKangRiZhiTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangRiZhiTVC.h"
#import "ALCJianKangRiZhiCell.h"
#import "ALCJianKangRiZhiDetailTVC.h"
#import "ALCJianKangRiZhiSecretOneTVC.h"
@interface ALCJianKangRiZhiTVC ()
@property(nonatomic,assign)NSInteger page;

@end

@implementation ALCJianKangRiZhiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康日志";
    
      UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
      submitBtn.layer.cornerRadius = 22;
      submitBtn.layer.masksToBounds = YES;
      //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
      
      [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
      submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
      [submitBtn setImage:[UIImage imageNamed:@"jkgl22"] forState:UIControlStateNormal];
      [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCJianKangRiZhiCell" bundle:nil] forCellReuseIdentifier:@"ALCJianKangRiZhiCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = WhiteColor;
    
    
    if (self.isComeMineMY) {
        [self.tableView reloadData];
    }else {
        self.page = 1;
        self.dataArray = @[].mutableCopy;
        [self getData];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self getData];
        }];
    }
    
    
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        self.page++;
//        [self getData];
//    }];
    
}

- (void)getData {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"page"] = @(self.page);
//    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findMyDoctorAppointmentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<ALMessageModel *>*arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
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
    return 109;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCJianKangRiZhiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCJianKangRiZhiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    ALCJianKangRiZhiDetailTVC * vc =[[ALCJianKangRiZhiDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}





- (void)submitBtnClick:(UIButton *)button {
    
    ALCJianKangRiZhiSecretOneTVC * vc =[[ALCJianKangRiZhiSecretOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.range = @"1";
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
