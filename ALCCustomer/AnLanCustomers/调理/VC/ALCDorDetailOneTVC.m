//
//  ALCDorDetailOneTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCDorDetailOneTVC.h"
#import "ALCDorDetailHeadView.h"
#import "ALCDorDetailTwoTVC.h"
#import "ALCDorListCell.h"
#import "ALCDorServerCell.h"
#import "ALCDorDetailOneTVC.h"
#import "ALCOnLineAppointmentTVC.h"
#import "ALCHospitalHomeTVC.h"
@interface ALCDorDetailOneTVC ()
@property(nonatomic,strong)ALCDorDetailHeadView *headV;
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)UIButton *rightBt;
@property(nonatomic,strong)UIButton *footBt;
@end

@implementation ALCDorDetailOneTVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    
    if (self.isNoCollectBlock != nil && [self.rightBt.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        self.isNoCollectBlock();
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addFootV];
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight - 60 );
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight - 60 -34 );
        self.footBt.mj_y = ScreenH - 60 -34;
    }
    self.headV = [[ALCDorDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 301)];
    self.headV.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headV;
    @weakify(self);
    [[self.headV.addressBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        
    }];
    [[self.headV.dorMeBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        ALCDorDetailTwoTVC * vc =[[ALCDorDetailTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.doctorId = self.doctorId;
        Weak(weakSelf);
        vc.sendImageNameBlock = ^(NSString * _Nonnull imageName) {
            [weakSelf.rightBt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        };
        vc.dataModel = self.dataModel.info;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [[self.headV.addressBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           
           ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
              vc.hidesBottomBarWhenPushed = YES;
              vc.institutionId = self.dataModel.info.institution_id;
              [self.navigationController pushViewController:vc animated:YES];
           
       }];
    
    
    [self setNavigate];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCDorServerCell" bundle:nil] forCellReuseIdentifier:@"ALCDorServerCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCDorListCell" bundle:nil] forCellReuseIdentifier:@"ALCDorListCell"];
    [self.tableView registerClass:[ACLHeadOrFootView class] forHeaderFooterViewReuseIdentifier:@"head"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
    }];
    
    
    
}
- (void)addFootV {
    
    self.footBt  = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenH - 60, ScreenW, 60)];
    [self.view addSubview:self.footBt];
    [self.footBt setImage:[UIImage imageNamed:@"jkgl50"] forState:UIControlStateNormal];
    self.footBt.backgroundColor  = RGB(230, 230, 230);
    [self.footBt setTitle:@"在线咨询" forState:UIControlStateNormal];
    self.footBt.titleLabel.font = kFont(16);
    [self.footBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    @weakify(self);
    [[self.footBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        ALCChooseJiuZhenRenTVC* vc =[[ALCChooseJiuZhenRenTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.toUserId = self.doctorId;
            vc.isLiaoTian = YES;
            [self.navigationController pushViewController:vc animated:YES];
    }];
    
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"doctorId"] = self.doctorId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getDoctorIndexPageURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.headV.model = self.dataModel.info;
            self.headV.mj_h = self.dataModel.info.HHHHHH;
            self.tableView.tableHeaderView = self.headV;
            [self.headV.headBt sd_setBackgroundImageWithURL:[self.dataModel.info.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
            if (self.dataModel.info.isCollection) {
                [self.rightBt setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [self.rightBt setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
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
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(ScreenW - 50, sstatusHeight + 2, 40,40);
    [button1 setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBt = button1;
    button1.layer.cornerRadius = 0;
    button1.clipsToBounds = YES;
    
    [self.view addSubview:button1];
    
    
    UILabel * titelLB = [[UILabel alloc] initWithFrame:CGRectMake(100, sstatusHeight + 2, ScreenW - 200, 40)];
    titelLB.font = kFont(18);
    titelLB.textColor = WhiteColor;
    titelLB.text = @"教师详情";
    titelLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titelLB];
    
}

//收藏操作
- (void)submitBtnClick:(UIButton *)button {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"doctorId"] = self.doctorId;
    NSString * str = [QYZJURLDefineTool user_delDoctorCollectionURL];
    if ([button.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        //未收藏
        str = [QYZJURLDefineTool user_collectDoctorURL];
    }
    
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if ([button.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
                //未收藏
                [SVProgressHUD showSuccessWithStatus:@"收藏教师成功"];
                [button setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消教师收藏成功"];
                [button setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataModel.recommendDoctorList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 0;
    }
    return 154;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
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
        view.leftLB.text = @"教师服务";
    }else if (section == 1) {
        view.rightBt.hidden = NO;
        view.leftLB.text = @"教师推荐";
    }
    view.clipsToBounds = YES;
    view.backgroundColor = WhiteColor;
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        ALCDorServerCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCDorServerCell" forIndexPath:indexPath];
        [cell.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataModel.info;
        cell.clipsToBounds = YES;
        return cell;
    }else {
        ALCDorListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCDorListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataModel.recommendDoctorList[indexPath.row];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        ALCDorDetailOneTVC * vc =[[ALCDorDetailOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.doctorId = self.dataModel.recommendDoctorList[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-  (void)clickAction:(UIButton *)button {
    if(button.tag == 100) {
        
        if (!self.dataModel.info.isAppointment) {
            [SVProgressHUD showErrorWithStatus:@"此教师不可预约"];
            return;
        }
        
        ALCOnLineAppointmentTVC * vc =[[ALCOnLineAppointmentTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dorID = self.doctorId;
        vc.institutionId = self.dataModel.info.institution_id;
        vc.model = self.dataModel.info;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (!self.dataModel.info.isConsultation) {
            [SVProgressHUD showErrorWithStatus:@"此教师不可在线咨询"];
            return;
        }
        ALCChooseJiuZhenRenTVC* vc =[[ALCChooseJiuZhenRenTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.toUserId = self.doctorId;
        vc.isLiaoTian = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
