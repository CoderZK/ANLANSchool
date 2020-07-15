//
//  ALCMineBodyinformationTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineBodyinformationTVC.h"
#import "ALCMineBodyinformationcell.h"
#import "ALCTiZHongLineTVC.h"
#import "ALCMineBodyRecordVC.h"
#import "ALCJingQiBodyRecordTVC.h"
#import "ALCJianKangRiZhiSecretOneTVC.h"
@interface ALCMineBodyinformationTVC ()
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation ALCMineBodyinformationTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身体数据";
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineBodyinformationcell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    self.titleArr = @[@"心率",@"体重",@"血压",@"经期"];
    
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
    submitBtn.layer.cornerRadius = 22;
    submitBtn.layer.masksToBounds = YES;
    //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setImage:[UIImage imageNamed:@"jkgl22"] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    
}

- (void)submitBtnClick:(UIButton *)button {
    
    ALCJianKangRiZhiSecretOneTVC * vc =[[ALCJianKangRiZhiSecretOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.range = @"2";
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)getData {
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_healthDataURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            NSLog(@"%d",self.dataModel.weightData == nil);
            
            NSLog(@"%@",@"7896");
            
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ){
        return 0.01;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW , 40)];
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, ScreenW-20, 20)];
        bt.tag = 100;
        //        bt.backgroundColor = [UIColor clearColor];
        bt.titleLabel.font = kFont(14);
        [bt setTitle:@"为以下健康卡片添加数据" forState:UIControlStateNormal];
        [bt setTitleColor:CharacterBlack100 forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"jkgl20"] forState:UIControlStateNormal];
        [bt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [view addSubview:bt];
        view.backgroundColor  = [UIColor whiteColor];
    }
    view.clipsToBounds = YES;
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==  0) {
        return 1;
    }
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMineBodyinformationcell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.moreLB.hidden = cell.moreImgV.hidden =  NO;
    if (indexPath.section == 0) {
        if (self.dataModel.stepnumberData == nil) {
            cell.showNumber = 0;
        }else {
            cell.showNumber = 2;
            cell.leftTopLB.text = [NSString stringWithFormat:@"%@步",self.dataModel.stepnumberData.stepnumber];
            cell.leftBottomLB.text = @"今日步数";
            
            cell.rightTopLB.text = [NSString stringWithFormat:@"%0.2f公里",[self.dataModel.stepnumberData.stepnumber floatValue] * 0.6/1000];
            
        }
        cell.moreBt.tag = -1;
        cell.jiluBt.tag = 99;
        [cell.moreBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jiluBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        cell.titleLB.text = self.titleArr[indexPath.row];
        
//        cell.showNumber = 0;
//        return cell;
        
        if (indexPath.row == 0) {
            if (self.dataModel.heartrate == nil) {
                cell.showNumber = 0;
            }else {
                cell.showNumber = 1;
                cell.centerTopLB.text = [NSString stringWithFormat:@"%@次/分",self.dataModel.heartrate.averageRate];
                cell.centerBottomLB.text = @"平均";
            }
        }else if (indexPath.row == 1) {
            
            if (self.dataModel.weightData == nil) {
                cell.showNumber = 0;
            }else {
                cell.showNumber = 1;
                cell.centerTopLB.text = [NSString stringWithFormat:@"%@kg",self.dataModel.weightData.weight];
                cell.centerBottomLB.text = @"最新体重";
                
            }
            
        }else if (indexPath.row == 2) {
            
            if (self.dataModel.bloodpressure == nil) {
                cell.showNumber = 0;
            }else {
                cell.showNumber = 2;
                cell.leftTopLB.text = [NSString stringWithFormat:@"%@mmHg",self.dataModel.bloodpressure.systolic];
                cell.leftBottomLB.text = @"收缩压";
                cell.rightTopLB.text = [NSString stringWithFormat:@"%@mmHg",self.dataModel.bloodpressure.diastolic];
                cell.rightBottomLB.text = @"舒张压";
            }
            
        }else if (indexPath.row == 3) {
//            cell.moreLB.hidden = cell.moreImgV.hidden = YES;
            if (self.dataModel.menstrual == nil) {
                cell.showNumber = 0;
            }else {
                cell.showNumber = 3;
                cell.leftTopLB.text = [NSString stringWithFormat:@"%@",self.dataModel.menstrual.lastday];
                cell.leftBottomLB.text = @"最后日期";
                cell.centerTopLB.text = [NSString stringWithFormat:@"%@天",self.dataModel.menstrual.length];
                cell.centerBottomLB.text = @"持续";
                cell.rightTopLB.text = [NSString stringWithFormat:@"%@天",self.dataModel.menstrual.period];
                cell.rightBottomLB.text = @"周期";
            }
        }
        
        cell.moreBt.tag = indexPath.row;
        cell.jiluBt.tag = 100+indexPath.row;
        [cell.moreBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jiluBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}

//
- (void)clickAction:(UIButton *)button {
    if (button.tag >= 99) {
        //点击记录
        if (button.tag == 103) {
            ALCJingQiBodyRecordTVC * vc =[[ALCJingQiBodyRecordTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            ALCMineBodyRecordVC * vc =[[ALCMineBodyRecordVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.type = button.tag - 99;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else {
        //点击更多
        
        if (button.tag == 3) {
            
            ALCJingQiBodyRecordTVC * vc =[[ALCJingQiBodyRecordTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            return;
        }
        
        ALCTiZHongLineTVC * vc =[[ALCTiZHongLineTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = button.tag + 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row != 3) {
        ALCTiZHongLineTVC * vc =[[ALCTiZHongLineTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = indexPath.row +1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 0) {
        ALCTiZHongLineTVC * vc =[[ALCTiZHongLineTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
@end
