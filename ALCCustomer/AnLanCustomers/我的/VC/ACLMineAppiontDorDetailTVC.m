//
//  ACLMineAppiontDorDetailTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineAppiontDorDetailTVC.h"
#import "ALCMineAppionDorOneCell.h"
#import "ALCMineAppionDorTwoCell.h"
#import "ALCPayOrderVC.h"
#import "ALCProjectDetailTVC.h"
#import "ALCDorDetailOneTVC.h"
@interface ACLMineAppiontDorDetailTVC ()
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)KKKKFootView *VVV;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UIButton *footBt;
@end

@implementation ACLMineAppiontDorDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约医生详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineAppionDorOneCell" bundle:nil] forCellReuseIdentifier:@"cellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineAppionDorTwoCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WhiteColor;
    
    if (self.isHot) {
        self.navigationItem.title = @"预约项目详情";
    }
    

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
    
    NSString * urlStr = [QYZJURLDefineTool user_getMyDoctorAppointmentDetailURL];
    if (self.isHot) {//项目
        urlStr = [QYZJURLDefineTool user_getProjectAppointmentDetailURL];
    }
    dict[@"appointmentId"] = self.ID;
    dict[@"appointmentId"] = self.ID;
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
            [self setFootVWithStauts:self.dataModel.status];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)setFootVWithStauts:(NSInteger )status{
    
    UIView * view = [self.view viewWithTag:999];
    if (view != nil) {
        [view removeFromSuperview];
    }
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 60, ScreenW, 60)];
    if (sstatusHeight > 20) {
        self.footView.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 60 - 34, ScreenW, 60);
    }
    self.footView.tag = 999;
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.footView addSubview:backV];
    

    self.footBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 95, 12.5, 80, 35)];
    self.footBt.layer.cornerRadius  = 17.5;
    self.footBt.clipsToBounds = YES;
    [self.footBt setBackgroundImage:[UIImage imageNamed:@"gback"] forState:UIControlStateNormal];
    self.footBt.titleLabel.font = kFont(15);
    if (self.isHot) {
          //项目
        if (self.dataModel.payWay == 1) {
          
            if (self.dataModel.status == 1) {//线上
                [self.footBt setTitle:@"去支付" forState:UIControlStateNormal];
            }else if (self.dataModel.status == 2) {
                [self.footBt setTitle:@"申请退款" forState:UIControlStateNormal];
            }else if (self.dataModel.status == 3 || self.dataModel.status == 5 || self.dataModel.status == 9 || self.dataModel.status == 10) {
                 [self.footBt setTitle:@"再次预约" forState:UIControlStateNormal];
            }else {
                
                
                    self.footView.hidden = YES;
                    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
                   
                
            }
        }else if (self.dataModel.payWay == 2) {
            if (self.dataModel.status == 1) {//线上
                [self.footBt setTitle:@"取消预约" forState:UIControlStateNormal];
            }else if (self.dataModel.status == 2) {
                [self.footBt setTitle:@"申请退款" forState:UIControlStateNormal];
            }else if (self.dataModel.status == 3 || self.dataModel.status == 5 || self.dataModel.status == 9 || self.dataModel.status == 10) {
                 [self.footBt setTitle:@"再次预约" forState:UIControlStateNormal];
            }else {
                self.footView.hidden = YES;
                self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
            }
        }
        
        
        
    }else {
        if (self.dataModel.isCancel) {
            [self.footBt setTitle:@"再次预约" forState:UIControlStateNormal];
        }else {
           [self.footBt setTitle:@"取消预约" forState:UIControlStateNormal];
        }
    }
    [self.footView addSubview:self.footBt];
    [self.view addSubview:self.footView];
    
    [self.footBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    

    
//    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
//    if (sstatusHeight > 20) {
//        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
//    }
//
//    KKKKFootView * vv = [self.view viewWithTag:999];
//    if (vv == nil ) {
//        vv = [[PublicFuntionTool shareTool] createFootvWithTitle:@"取消" andImgaeName:@""];
//        Weak(weakSelf);
//        vv.footViewClickBlock = ^(UIButton *button) {
//
//            if([button.titleLabel.text isEqualToString:@"取消"]) {
//                 [weakSelf cancelAction];
//            }else {
//                [weakSelf payAction];
//            }

//
//        };
//        vv.tag = 999;
//        [self.view addSubview:vv];
//    }
//    if (status == 3) {
//        vv.titleStr = @"支付";
//    }
//
//    if (status == 1) {
//        [vv removeFromSuperview];
//        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
//    }
    
    
}
//点击按钮
- (void)action:(UIButton *)button {
    NSString * str = button.titleLabel.text;
   
        if ([str isEqualToString:@"取消预约"]) {
            [self cancelActionWithIsApplyFor:NO];
        }else if  ([str isEqualToString:@"去支付"]){
            [self payAction];
        }else if  ([str isEqualToString:@"再次预约"]){
            if (self.isHot) {
                ALCProjectDetailTVC * vc =[[ALCProjectDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.projectId = self.dataModel.projectId;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                ALCDorDetailOneTVC * vc =[[ALCDorDetailOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.doctorId = self.dataModel.doctorId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else if ([str isEqualToString:@"申请退款"]) {
            [self cancelActionWithIsApplyFor:YES];
        }
        
    
    
    
    
}

//取消订单操作
- (void)cancelActionWithIsApplyFor:(BOOL)isTuiKuan {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"appointmentProjectId"] = self.ID;
    dict[@"appointmentId"] = self.ID;
    NSString * url = [QYZJURLDefineTool user_cancelOnlineAppointmentURL];
    if (self.isHot) {
        url = [QYZJURLDefineTool user_cancelOnlineAppointmentProjectURL];
    }
    if (isTuiKuan) {
         url = [QYZJURLDefineTool user_applyForRefundURL];
    }
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if (isTuiKuan) {
                [SVProgressHUD showSuccessWithStatus:@"申请退款成功"];
            }else {
               [SVProgressHUD showSuccessWithStatus:@"取消订单成功"];
            }
            
            [self getData];
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)payAction {
    
    ALCPayOrderVC * vc =[[ALCPayOrderVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.innerOrderNo = self.dataModel.orderNo;
    vc.price = self.dataModel.price;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataModel == nil) {
        return 0;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 15 + 17*count + (count -1 ) * 15 + 15 + 1
    if (self.isHot) {
        if (indexPath.row == 0) {
            return 90;
        }else if (indexPath.row == 1) {
            return 15 + 17*4 + (4 -1 ) * 15 + 15 + 1 ;
        }else if (indexPath.row == 2){
            return 15 + 17*3 + (3 -1 ) * 15 + 15 + 1 ;
        }else {
            return 31+17;
        }
    }else {
        if (indexPath.row == 0) {
            return 90;
        }else if (indexPath.row == 1) {
            return 15 + 17*4 + (4 -1 ) * 15 + 15 + 1;
        }else if (indexPath.row == 2){
            return 15 + 17*2 + (2 -1 ) * 15 + 15 + 1 ;
        }else {
           return  31+17;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ALCMineAppionDorOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
        NSString * dd = @"上午";
        if ([self.dataModel.duration isEqualToString:@"2"]) {
            dd = @"下午";
        }
        cell.titleLB.text =[NSString stringWithFormat:@"%@  %@",self.dataModel.appointmentDate,dd];
        
//        @[@"",@"未支付",@"待完成",@"已完成",@"已取消",@"退款成功"];
        
         NSString * str = @"";
               
               if (self.dataModel.payWay == 1) {
                   if (self.dataModel.status == 1) {
                       str = @"未支付";
                   }else if (self.dataModel.status == 2) {
                       str = @"已预约";
                   }else if (self.dataModel.status == 3) {
                       str = @"已完成";
                   }else if (self.dataModel.status == 4) {
                       str = @"退款中";
                   }else if (self.dataModel.status == 5) {
                       str = @"已作废";
                   }else if (self.dataModel.status == 6) {
                       str = @"已退款";
                   }else if (self.dataModel.status == 7) {
                       str = @"退款中";
                   }else if (self.dataModel.status == 8) {
                       str = @"退款驳回";
                   }else if (self.dataModel.status == 9) {
                       str = @"已过期";
                   }else if (self.dataModel.status == 10) {
                       str = @"已取消";
                   }
               }else {
                   if (self.dataModel.status == 1) {
                       str = @"到店支付";
                   }else if (self.dataModel.status == 2) {
                       str = @"已预约";
                   }else if (self.dataModel.status == 3) {
                       str = @"已完成";
                   }else if (self.dataModel.status == 4) {
                       str = @"退款中";
                   }else if (self.dataModel.status == 5) {
                       str = @"已作废";
                   }else if (self.dataModel.status == 6) {
                       str = @"已退款";
                   }else if (self.dataModel.status == 7) {
                       str = @"退款中";
                   }else if (self.dataModel.status == 8) {
                       str = @"退款驳回";
                   }else if (self.dataModel.status == 9) {
                       str = @"已过期";
                   }else if (self.dataModel.status == 10) {
                       str = @"已取消";
                   }
               }

               cell.statusLB.text = str;
               
        if (!self.isHot) {
            if (self.dataModel.isCancel) {
                cell.statusLB.text = @"已取消";
            }else {
                cell.statusLB.text = @"已预约";
            }
        }
        
        return cell;
    }
    
    ALCMineAppionDorTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    if (indexPath.row == 1) {
        cell.LeftWithCons.constant = 80;
        cell.leftLB3.hidden = cell.leftLB4.hidden = cell.rightLB1.hidden = cell.rightLB2.hidden = cell.rightLB3.hidden = cell.rightLB4.hidden = NO;
        cell.leftLB5.hidden = cell.leftLB5.hidden = cell.rightLB6.hidden = cell.rightLB5.hidden = YES;
        
        if (self.isHot) {
            cell.leftLB1.text = @"就诊项目";
            cell.rightLB1.text = self.dataModel.projectName;
        }else {
            cell.leftLB1.text = @"就诊专家";
            cell.rightLB1.text = [NSString stringWithFormat:@"%@ (%@) %@",self.dataModel.doctorName,self.dataModel.level,self.dataModel.departmentName];;
        }
        
        cell.leftLB2.text = @"就诊医院";
        cell.leftLB3.text = @"就诊人";
        cell.leftLB4.text = @"手机号";
        
        cell.rightLB2.text = self.dataModel.institutionName;
        cell.rightLB3.text = self.dataModel.patientName;
        cell.rightLB4.text = self.dataModel.phone;
        
        return cell;
        
    }else {
        if (self.isHot) {
            if (indexPath.row == 2) {
                cell.LeftWithCons.constant = 80;
                cell.leftLB1.hidden = cell.leftLB2.hidden = cell.leftLB3.hidden  = cell.rightLB1.hidden = cell.rightLB2.hidden = cell.rightLB3.hidden =  NO;
       
                cell.leftLB4.hidden = cell.leftLB5.hidden = cell.leftLB6.hidden  = cell.rightLB4.hidden = cell.rightLB5.hidden = cell.rightLB6.hidden =  YES;
                
                cell.leftLB1.text = @"领号时间";
                cell.leftLB2.text = @"就诊地点";
                cell.leftLB3.text = @"门诊类型";

                
                cell.rightLB1.text = [self.dataModel createTime];
                cell.rightLB2.text = self.dataModel.address;
                cell.rightLB3.text = self.dataModel.departmentName;

            }else if (indexPath.row == 3) {
                cell.LeftWithCons.constant = ScreenW - 30;
                cell.leftLB3.hidden = cell.leftLB4.hidden = cell.leftLB5.hidden = cell.leftLB6.hidden = cell.rightLB1.hidden = cell.rightLB2.hidden = cell.rightLB3.hidden = cell.rightLB4.hidden = cell.rightLB5.hidden = cell.rightLB6.hidden = cell.leftLB2.hidden = YES;
                cell.leftLB1.textColor = cell.leftLB2.textColor = CharacterBlack100;
//                cell.leftLB1.text = [NSString stringWithFormat:@"微医订单号: %@",self.dataModel.orderNo];;
                cell.leftLB1.text = [NSString stringWithFormat:@"下单时间: %@",self.dataModel.createTime];
            }
            return cell;
            
        }else {
            if (indexPath.row == 2) {
                cell.LeftWithCons.constant = 80;
                cell.leftLB3.hidden = cell.leftLB4.hidden = cell.leftLB5.hidden = cell.leftLB6.hidden  = cell.rightLB3.hidden = cell.rightLB4.hidden = cell.rightLB5.hidden = cell.rightLB6.hidden = YES ;
                cell.leftLB4.textColor = cell.leftLB3.textColor = CharacterColor50;
                cell.leftLB1.text = @"诊断地点";
                cell.leftLB2.text = @"门诊类型";
                cell.rightLB1.text = self.dataModel.address;
                cell.rightLB2.text = self.dataModel.departmentName;
            }else if (indexPath.row == 3) {
                cell.LeftWithCons.constant = ScreenW - 30;
                cell.leftLB3.hidden = cell.leftLB4.hidden = cell.leftLB5.hidden = cell.leftLB6.hidden = cell.rightLB1.hidden = cell.rightLB2.hidden = cell.rightLB3.hidden = cell.rightLB4.hidden = cell.rightLB5.hidden = cell.rightLB6.hidden = cell.leftLB2.hidden = YES;
                cell.leftLB1.textColor = cell.leftLB2.textColor = CharacterBlack100;
//                cell.leftLB1.text = [NSString stringWithFormat:@"微医订单号: %@",self.dataModel.orderNo];;
                cell.leftLB1.text = [NSString stringWithFormat:@"下单时间: %@",self.dataModel.createTime];
                
            }
            
            return cell;
        }
    }
    
    
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
