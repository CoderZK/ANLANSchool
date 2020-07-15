//
//  ALCOnLineAppointmentTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCOnLineAppointmentTVC.h"
#import "ALCDorListCell.h"
#import "ALCHospitalDeatilTwoCell.h"
#import "ALCChooseAppointmentTimeTVC.h"
#import "ALCPayOrderVC.h"
#import "ALCMineFamilyTVC.h"
#import "ALCChooseJiuZhenRenTVC.h"
@interface ALCOnLineAppointmentTVC ()
@property(nonatomic,strong)NSString *timeStr,*schID;
@property(nonatomic,strong)NSString *name,*pID;
@end

@implementation ALCOnLineAppointmentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"在线预约";
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCDorListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"two"];
    
    
    [self setFootV];
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"立即预约" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        //        ALCPayOrderVC * vc =[[ALCPayOrderVC alloc] init];
        //        vc.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:vc animated:YES];
        
        [weakSelf appointmentDor];
        
        
    };
    [self.view addSubview:view];
    
    
}

- (void)appointmentDor {
    
    
    if (self.schID.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择预约时间"];
        return;
    }
    if (self.name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择就诊人员"];
        return;
    }
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"scheduleId"]  = self.schID;
    if ([self.timeStr containsString:@"上午"]) {
        dict[@"duration"] = @(1);
    }else {
        dict[@"duration"] = @(2);
    }
    dict[@"familyMemberId"] = self.pID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_onlineAppointmentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"预约成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ACLMineAppointVC * vc =[[ACLMineAppointVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.isPay = YES;
                [self.navigationController pushViewController:vc animated:YES];
            });
            
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 2) {
        return 50;
    }
    return 134;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ALCDorListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backV.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.backV.layer.shadowRadius = 0;
        cell.leftCons.constant = cell.bottomCOns.constant = cell.rightCons.constant = cell.topCons.constant = 0;
        cell.model = self.model;
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        cell.leftLB.font = kFont(14);
        cell.rightLB.mj_x = 110;
        cell.leftLB.mj_w = 95;
        cell.TF.hidden = YES;
        cell.rightLB.mj_w = ScreenW - 145;
        cell.rightLB.hidden = NO;
        
        if (indexPath.row == 1) {
            cell.leftLB.text = @"选择就诊人";
            cell.rightLB.text = self.name;
            cell.lineV.hidden = NO;
        }else {
            cell.lineV.hidden = YES;
            cell.leftLB.text = @"选择预约时间";
            cell.rightLB.text = self.timeStr;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        Weak(weakSelf);
        ALCChooseJiuZhenRenTVC * vc =[[ALCChooseJiuZhenRenTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.sendChoosePatientBlock = ^(NSString * _Nonnull name, NSString * _Nonnull pID) {
            weakSelf.name = name;
            weakSelf.pID = pID;
            [weakSelf.tableView reloadData];
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.row == 2) {
        ALCChooseAppointmentTimeTVC * vc =[[ALCChooseAppointmentTimeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.doctorId = self.dorID;
        Weak(weakSelf);
        vc.sendScheduleIdBlcok = ^(NSString * _Nonnull scheduleId, NSString * _Nonnull titelStr) {
            weakSelf.schID = scheduleId;
            weakSelf.timeStr = titelStr;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
