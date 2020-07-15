//
//  ALCProjectDetailTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCProjectDetailTVC.h"
#import "ALCProjectDetailOneCell.h"
#import "ALCHospitalThreeCell.h"
#import "ALCProjectTVC.h"
#import "ALCOnLineProjectAppiontmentTVC.h"
#import "ALCHospitalHomeTVC.h"
@interface ALCProjectDetailTVC ()
@property(nonatomic,strong)ALCDorDetailHeadView *headV;
@property(nonatomic,strong)ALMessageModel *dataModel;
@end

@implementation ALCProjectDetailTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH + sstatusHeight);
    self.headV = [[ALCDorDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 254)];
    self.headV.backgroundColor = [UIColor redColor];
    self.headV.shanchangLB.hidden = YES;
    self.headV.nameLB.text = @"洗牙";
    self.headV.isProject = YES;
    self.headV.headBt.layer.cornerRadius = 5;
    self.headV.headBt.mj_x = ScreenW - 105;
    self.headV.headBt.mj_w = 90;
    self.headV.mj_w = 70;
    self.tableView.tableHeaderView = self.headV;
    @weakify(self);
    [[self.headV.addressBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.institutionId = self.dataModel.projectDetail.institution_id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];

    [self setNavigate];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCProjectDetailOneCell" bundle:nil] forCellReuseIdentifier:@"ALCProjectDetailOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalThreeCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalThreeCell"];
     [self.tableView registerClass:[ACLHeadOrFootView class] forHeaderFooterViewReuseIdentifier:@"head"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

    
}

- (void)setNavigate {
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, sstatusHeight + 2, 40, 40);
    [button setImage:[UIImage imageNamed:@"youfan"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
      @weakify(self);
      [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          
          @strongify(self);
          [self.navigationController popViewControllerAnimated:YES];
          
      }];
      [self.view addSubview:button];
    
//        UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
//        button1.frame = CGRectMake(ScreenW - 50, sstatusHeight + 2, 40,40);
//        [button1 setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
//        button1.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button1.layer.cornerRadius = 0;
//        button1.clipsToBounds = YES;
//        [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            
//        }];
//    [self.view addSubview:button1];
    
    
    UILabel * titelLB = [[UILabel alloc] initWithFrame:CGRectMake(100, sstatusHeight + 2, ScreenW - 200, 40)];
    titelLB.font = kFont(18);
    titelLB.textColor = WhiteColor;
    titelLB.text = @"项目详情";
    titelLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titelLB];
    
    
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"projectId"] = self.projectId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_getProjectDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.headV.model = self.dataModel.projectDetail;
             [self.headV.headBt sd_setBackgroundImageWithURL:[self.dataModel.projectDetail.picture getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
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
    if (self.dataModel == nil) {
        return 0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataModel.recommendProjectList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 130;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ALCProjectDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCProjectDetailOneCell" forIndexPath:indexPath];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataModel.projectDetail;
        return cell;
    }
     ALCHospitalThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalThreeCell" forIndexPath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.model = self.dataModel.recommendProjectList[indexPath.row];
     return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
           ALCProjectDetailTVC * vc =[[ALCProjectDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           vc.projectId = self.dataModel.recommendProjectList[indexPath.row].ID;
           vc.institutionId = self.dataModel.projectDetail.institution_id;
           [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        ALCOnLineProjectAppiontmentTVC * vc =[[ALCOnLineProjectAppiontmentTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dataModel = self.dataModel.projectDetail;
        vc.projectId = self.projectId;
        vc.institutionId = self.dataModel.projectDetail.institution_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ACLHeadOrFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];

    view.clipsToBounds = YES;
  
    view.backgroundColor = WhiteColor;
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ACLHeadOrFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
//    if (view == nil) {
//           view = [[ACLHeadOrFootView alloc] init];
//       }
    if (section == 0) {
          view.rightBt.hidden = YES;
          view.leftLB.text = @"项目服务";
      }else if (section == 1) {
          view.rightBt.hidden = NO;
          view.leftLB.text = @"推荐项目";
      }
    view.rightBt.tag = section;
    [view.rightBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    view.clipsToBounds = YES;
    view.backgroundColor = WhiteColor;
    return view;
}



 - (void)rightAction:(UIButton *)button {
     if (button.tag == 1) {
         ALCProjectTVC * vc =[[ALCProjectTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
         vc.hidesBottomBarWhenPushed = YES;
         vc.isR = YES;
         vc.institutionId = self.dataModel.projectDetail.institution_id;
         [self.navigationController pushViewController:vc animated:YES];
     }
     
 }



@end
