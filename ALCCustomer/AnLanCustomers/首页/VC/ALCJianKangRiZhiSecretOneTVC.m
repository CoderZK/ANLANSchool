//
//  ALCJianKangRiZhiSecretOneTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangRiZhiSecretOneTVC.h"
#import "ALCJianKangRiZhiSecretCell.h"
#import "ALCMineAllAppiontmentDocTVC.h"
@interface ALCJianKangRiZhiSecretOneTVC ()
@property(nonatomic,strong)NSArray *leftArrOne,*leftArrTwo;
@property(nonatomic,assign)NSInteger selectRow;
@property(nonatomic,strong)NSString *selectStr;
@property(nonatomic,strong)NSString *selectIdsStr;
@property(nonatomic,strong)ALMessageModel *dataModel;
@end

@implementation ALCJianKangRiZhiSecretOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.selectRow = 0;
    self.leftArrOne = @[@"公开",@"私密",@"部分人可见"];
    self.leftArrTwo = @[@"所有医生可见",@"仅自己可见",@"选中的人可见"];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCJianKangRiZhiSecretCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title = @"谁可以看";
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenW - 60 - 15, sstatusHeight + 7, 60, 30);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ggback"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);

        [self confirmAction];


    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    

    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self getData];
    }];

    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"range"] = self.range;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getVoiceDetailPrivacyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.selectRow = [self.dataModel.type intValue] -1;
            NSMutableArray * arr = @[].mutableCopy;
            for (ALMessageModel * model in self.dataModel.doctors) {
                [arr addObject:model.name];
            }
            self.selectStr = [arr componentsJoinedByString:@","];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



- (void)confirmAction {
    if (self.selectRow == 2) {
        
        if (self.selectIdsStr.length == 0 && self.selectStr.length > 0) {
            return;
        }
        
        if (self.selectIdsStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请至少选择一个人"];
            return;
        }
    }else {
        
    }
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @(self.selectRow+1);
    dict[@"doctorIds"] = self.selectIdsStr;
    dict[@"range"] = self.range;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_setVoiceDetailPrivacyURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"日志隐私设置成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArrOne.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCJianKangRiZhiSecretCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == self.selectRow) {
        cell.imgV.image = [UIImage imageNamed:@"jkgl23"];
    }else {
        cell.imgV.image = [UIImage imageNamed:@"jkgl24"];
    }
    cell.leftLB1.text = self.leftArrOne[indexPath.row];
    cell.leftLB2.text = self.leftArrTwo[indexPath.row];
    if (indexPath.row == 2 && self.selectStr.length != 0 ) {
        cell.leftLB2.text = self.selectStr;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectRow = indexPath.row;
    [self.tableView reloadData];
    
    if (indexPath.row == 2) {
        ALCMineAllAppiontmentDocTVC * vc =[[ALCMineAllAppiontmentDocTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);
        vc.sendFriendsBlock = ^(NSString * _Nonnull nickNameStr, NSString * _Nonnull idStr) {
            weakSelf.selectStr = nickNameStr;
            weakSelf.selectIdsStr = idStr;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
