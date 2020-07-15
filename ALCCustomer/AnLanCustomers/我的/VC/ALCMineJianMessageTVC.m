//
//  ALCMineJianMessageTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineJianMessageTVC.h"
#import "ALCMineJianMessageCell.h"
#import "ALCEditMineJianKangTVC.h"
@interface ALCMineJianMessageTVC ()
@property(nonatomic,strong)NSArray  *leftArr;
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)NSArray *arrOne,*arrTwo;
@end

@implementation ALCMineJianMessageTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基本健康信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineJianMessageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    self.leftArr = @[@"婚史:",@"生育",@"手术和外伤:",@"家族病史:",@"药物过敏:",@"食物和解除物过敏",@"个人习惯"];
    
    self.arrOne = @[@"",@"已婚",@"未婚",@"离异",@"丧偶"];
    self.arrTwo = @[@"",@"未生育",@"备孕期",@"怀孕期",@"已生育"];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenW - 60 - 15, sstatusHeight + 7, 60, 30);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.clipsToBounds = YES;
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);

        ALCEditMineJianKangTVC * vc =[[ALCEditMineJianKangTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dataModel = self.dataModel;
        vc.type = self.type;
        vc.familyMemberId = self.familyMemberId;
        [self.navigationController pushViewController:vc animated:YES];


    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
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
    if (![self.type isEqualToString:@"1"]) {
        //不是自己
       dict[@"familyMemberId"] = self.familyMemberId;
    }
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getHealthInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)setheadView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW- 20, 20)];
    lb.textColor = CharacterColor50;
    lb.font = kFont(14);
    [view addSubview:lb];
    lb.text = @"信息能供主治医生查看,请认证填写";
    
    self.tableView.tableHeaderView = view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMineJianMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = self.leftArr[indexPath.row];
    if (indexPath.row == 0) {
        
        NSString * str = @"未完善";
               if (self.dataModel.marriageStatus.length > 0) {
                   str = self.arrOne[[self.dataModel.marriageStatus integerValue]];
               }
        cell.contentLB.text = [NSString stringWithFormat:@"%@",str];
    }else if (indexPath.row == 1) {
        NSString * str2 = @"未完善";
         if (self.dataModel.birthStatus.length> 0) {
             str2 = self.arrTwo[[self.dataModel.birthStatus integerValue]];
         }
         cell.contentLB.text = [NSString stringWithFormat:@"%@",str2];
    }else if (indexPath.row == 2) {
        cell.contentLB.text = self.dataModel.operateHurt.length > 0 ? self.dataModel.operateHurt:@"未完善";
    }else if (indexPath.row == 3) {
        cell.contentLB.text = self.dataModel.familyHistory.length > 0 ? self.dataModel.familyHistory:@"未完善";
    }else if (indexPath.row == 4) {
        cell.contentLB.text = self.dataModel.drugAllergy.length > 0 ? self.dataModel.drugAllergy:@"未完善";
    }else if (indexPath.row == 5) {
        cell.contentLB.text = self.dataModel.otherAllergy.length > 0 ? self.dataModel.otherAllergy:@"未完善";
    }else if (indexPath.row == 6) {
        cell.contentLB.text = self.dataModel.habit.length > 0 ? self.dataModel.habit:@"未完善";
    }
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
