//
//  ALCDorDetailTwoTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCDorDetailTwoTVC.h"
#import "ALCDorDetailHeadView.h"
#import "ALCHospitalDetailThreeCell.h"
#import "TongYongTwoCell.h"
#import "ALCHospitalHomeTVC.h"
@interface ALCDorDetailTwoTVC ()
@property(nonatomic,strong)ALCDorDetailHeadView *headV;
@property(nonatomic,strong)UIButton *rightBt;
@end

@implementation ALCDorDetailTwoTVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    if ([self.rightBt.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        if (self.sendImageNameBlock != nil) {
            self.sendImageNameBlock(@"jkgl48");
        }
    }else {
        if (self.sendImageNameBlock != nil) {
            self.sendImageNameBlock(@"jkgl47");
        }
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+ sstatusHeight);
    self.headV = [[ALCDorDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 189)];
    self.headV.clipsToBounds = YES;
    self.tableView.tableHeaderView = self.headV;
    
    @weakify(self);
    [[self.headV.addressBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
             @strongify(self);
             
             ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.institutionId = self.dataModel.institution_id;
                [self.navigationController pushViewController:vc animated:YES];
             
         }];
    
    
    [self setNavigate];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalDetailThreeCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalDetailThreeCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ALCHeadOrFootGreenView class] forHeaderFooterViewReuseIdentifier:@"head"];
    self.headV.model = self.dataModel;
    
     [self.headV.headBt sd_setBackgroundImageWithURL:[self.dataModel.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
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
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:button1];
    
    
    UILabel * titelLB = [[UILabel alloc] initWithFrame:CGRectMake(100, sstatusHeight + 2, ScreenW - 200, 40)];
    titelLB.font = kFont(18);
    titelLB.textColor = WhiteColor;
    titelLB.text = @"医生信息";
    titelLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titelLB];
    
    if (self.dataModel.isCollection) {
        [self.rightBt setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
    }else {
        [self.rightBt setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
    }
    
    
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
                [SVProgressHUD showSuccessWithStatus:@"收藏医生成功"];
                [button setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消医生收藏成功"];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <2) {
        return UITableViewAutomaticDimension;
    }
    return 50;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ALCHeadOrFootGreenView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    //    if (view == nil) {
    //        view = [[ACLHeadOrFootView alloc] init];
    //    }
    view.clipsToBounds = YES;
    
    view.backgroundColor = WhiteColor;
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ALCHeadOrFootGreenView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    
    if (section == 0) {
        
        view.leftLB.text = @"擅长疾病";
    }else if (section == 1) {
        
        view.leftLB.text = @"个人简介";
    }else if (section == 2) {
        view.leftLB.text = @"职业点";
    }
    view.clipsToBounds = YES;
    view.backgroundColor = WhiteColor;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.attributedText =  [self.dataModel.institutionName getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];;
        cell.leftLB.font = kFont(14);
        cell.leftLB.mj_x = 15;
        cell.leftLB.mj_w = ScreenW - 70;
        cell.TF.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        ALCHospitalDetailThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalDetailThreeCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.leftLB.attributedText =  [self.dataModel.goodArea getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];;
        }else {
            cell.leftLB.attributedText =  [self.dataModel.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
