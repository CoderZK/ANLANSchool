//
//  ALCOnLineProjectAppiontmentTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCOnLineProjectAppiontmentTVC.h"
#import "ALCHospitalThreeCell.h"
#import "ALCPayOrderVC.h"
#import "ALCChooseAppointmentTimeTVC.h"
#import "ALCChooseJiuZhenRenTVC.h"
@interface ALCOnLineProjectAppiontmentTVC ()<zkPickViewDelelgate>
@property(nonatomic,strong)UIButton *leftBt,*rightBt;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,assign)NSInteger duration;
@property(nonatomic,strong)NSString *name,*pID;
@end

@implementation ALCOnLineProjectAppiontmentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"在线预约";
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalThreeCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalThreeCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"two"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.duration = 1;
    [self setFootV];
    [self addTableviewFootV];
    
}

- (void)addTableviewFootV {
    
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    footV.backgroundColor = WhiteColor;
    UILabel * LB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 20)];
    LB.text = @"支付方式";
    LB.textColor = CharacterColor50;
    LB.font = kFont(14);
    [footV addSubview:LB];
    
    UIButton * leftBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LB.frame) + 10, 10, 120, 30)];
    [leftBt setTitle:@"线上付款" forState:UIControlStateNormal];
    [leftBt setImage:[UIImage imageNamed:@"jkgl132"] forState:UIControlStateNormal];
    [leftBt setImage:[UIImage imageNamed:@"jkgl133"] forState:UIControlStateSelected];
    [leftBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    leftBt.titleLabel.font = kFont(14);
    leftBt.tag = 100;
    leftBt.selected = YES;
    [leftBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    [footV addSubview:leftBt];
    self.leftBt = leftBt;
    [leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * rightBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftBt.frame) + 10, 10, 120, 30)];
    [rightBt setTitle:@"到店付款" forState:UIControlStateNormal];
    [rightBt setImage:[UIImage imageNamed:@"jkgl132"] forState:UIControlStateNormal];
    [rightBt setImage:[UIImage imageNamed:@"jkgl133"] forState:UIControlStateSelected];
    [rightBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    rightBt.titleLabel.font = kFont(14);
    rightBt.tag = 101;
    [rightBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    [footV addSubview:rightBt];
    self.rightBt = rightBt;
    [rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footV;
    
}

- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        self.leftBt.selected = YES;
        self.rightBt.selected = NO;
    }else {
        self.leftBt.selected = NO;
        self.rightBt.selected = YES;
    }
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"立即预约" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        
        if (weakSelf.leftBt.selected) {
            //线上支付
            
            if (self.timeStr.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择预约时间"];
                return;
            }
            
            ALCPayOrderVC * vc =[[ALCPayOrderVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.projiectID = self.projectId;
            vc.duration = self.duration;
            vc.price = self.dataModel.price;
            vc.appointmentDate = self.timeStr;
            if (![[zkSignleTool shareTool].session_uid isEqualToString:self.pID]) {
                vc.familyMemberId = self.pID;
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
            //            [weakSelf appiontmentProjectWithType:1];
            
        }else {
            //线下支付du
            [weakSelf appiontmentProjectWithType:2];
            
        }
        
        
        
    };
    [self.view addSubview:view];
}


- (void)appiontmentProjectWithType:(NSInteger)type {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    if (self.timeStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择预约时间"];
        return;
    }
    if (self.name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择就诊人员"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"projectId"] = self.projectId;
    dict[@"appointmentDate"] = self.timeStr;
    dict[@"duration"] = @(self.duration);
    dict[@"payWay"] = @(type);
    dict[@"payType"] = @(type);
    dict[@"familyMemberId"] = self.pID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_doProjectAppointmentURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ALCHospitalThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalThreeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataModel;
        cell.leftCons.constant = cell.bottomCons.constant = cell.rightCons.constant =cell.topCons.constant = YES;
        cell.backV.backgroundColor = WhiteColor;
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
            cell.leftLB.text = @"选择预约时间";
            NSArray * arr = @[@"",@"上午",@"下午"];
            if (self.timeStr.length > 0) {
                cell.rightLB.text = [NSString stringWithFormat:@"%@ %@",self.timeStr,arr[self.duration]];
            }else {
                cell.rightLB.text = @"";
            }
            
            cell.lineV.hidden = YES;
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
        
        
        
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.rightStr = @"下一步";
        selectTimeV.isCanSelectOld = NO;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            weakSelf.timeStr = timeStr;
            zkPickView * picker = [[zkPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = weakSelf;
            picker.arrayType = titleArray;
            picker.array = @[@"上午",@"下午"].mutableCopy;
            picker.selectLb.text = @"";
            [picker show];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }
    
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    self.duration = leftIndex+1;
    
    [self.tableView reloadData];
    
}



@end
