//
//  ALCInquiryMessageTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCInquiryMessageTVC.h"
#import "ALCInquiryMessageCell.h"
#import "ALCSearchPeopleTVC.h"
#import "ALChatMessageTVC.h"
#import "ALCJianKangRiZhiDetailTVC.h"
@interface ALCInquiryMessageTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCInquiryMessageTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"问诊消息";
    if (self.isNewFriend) {
        self.navigationItem.title = @"新朋友";
        UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 44, 44)];
        [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [submitBtn setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
 

        [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    }
    
    [self.tableView registerClass:[ALCInquiryMessageCell class] forCellReuseIdentifier:@"cell"];

    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self getData];
    }];

    
}

- (void)getData {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    NSString * urlstr = [QYZJURLDefineTool user_inquiryMessageURL];
    if (self.isNewFriend) {
        urlstr = [QYZJURLDefineTool user_findSessionsURL];
    }
    
    [zkRequestTool networkingPOST:urlstr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if  (self.isNewFriend){
                 self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"sessions"]];
            }else {
                 self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
           
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
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCInquiryMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.isNewFirend = self.isNewFriend;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ALMessageModel * model = self.dataArray[indexPath.row];
    if  (self.isNewFriend) {
        ALCChooseJiuZhenRenTVC * vc =[[ALCChooseJiuZhenRenTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.toUserId = model.doctorId;
        vc.isLiaoTian = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ALCJianKangRiZhiDetailTVC * vc =[[ALCJianKangRiZhiDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = model.appiontmentId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

- (void)submitBtnClick:(UIButton *)button {
    

    
    ALCSearchPeopleTVC * vc =[[ALCSearchPeopleTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
