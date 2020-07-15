
//
//  ALCTuiJianWenZhangTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/1.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCTuiJianWenZhangTVC.h"
#import "ALCTuiJianArticleCell.h"
#import "ALCTiaoLiOneCell.h"
#import "ALCLookDetailTVC.h"
#import "ALCHospitalHomeTVC.h"
@interface ALCTuiJianWenZhangTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCTuiJianWenZhangTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"曾就诊机构";
    if (self.isWenZhang) {
        self.navigationItem.title = @"文章推荐";
    }
    
    
     [self.tableView registerNib:[UINib nibWithNibName:@"ALCTuiJianArticleCell" bundle:nil] forCellReuseIdentifier:@"ALCTuiJianArticleCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCTiaoLiOneCell" bundle:nil] forCellReuseIdentifier:@"ALCTiaoLiOneCell"];
           
         
    
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
 
}
- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"condition"] = @"3";
    if (self.isWenZhang) {
       dict[@"condition"] = @"2";
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_moreDataURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.isWenZhang) {
        ALCTuiJianArticleCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCTuiJianArticleCell" forIndexPath:indexPath];
           cell.model = self.dataArray[indexPath.row];
           return cell;
    }else {
        ALCTiaoLiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALCTiaoLiOneCell" forIndexPath:indexPath];
        cell.backV.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.backV.layer.shadowRadius = 0;
        cell.consLeft.constant = cell.consBottom.constant = cell.consRight.constant = cell.consTop.constant = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
        ALMessageModel * model = self.dataArray[indexPath.row];
                        
        cell.model = model;
        cell.rightLB.hidden = YES;
        return cell;
    }
    
   
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isWenZhang) {
        ALCLookDetailTVC * vc =[[ALCLookDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.institutionId = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
