//
//  ALCHospitalHomeTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHospitalHomeTVC.h"
#import "ALCHospitalOneCell.h"
#import "ALCTiaoLiTwoCell.h"
#import "ACLHeadOrFootView.h"
#import "ALCHospitalTwoCell.h"
#import "ALCHospitalThreeCell.h"
#import "ALCDorListTVC.h"
#import "ALCHospitalDetailTVC.h"
#import "ALCProjectTVC.h"
#import "ALCChooseAdministrativeTVC.h"
#import "ALCProjectDetailTVC.h"
@interface ALCHospitalHomeTVC ()<ALCHospitalTwoCellDelegate>
//@property(nonatomic,strong)NSArray  *dataArray;
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)UIButton *rightBt;
@end

@implementation ALCHospitalHomeTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isNoCollectBlock != nil && [self.rightBt.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        self.isNoCollectBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"医院主页";
    
//    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
//    submitBtn.layer.cornerRadius = 22;
//    submitBtn.layer.masksToBounds = YES;
//    //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    
//    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [submitBtn setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
//    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.rightBt = submitBtn;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalOneCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalOneCell"];
       [self.tableView registerNib:[UINib nibWithNibName:@"ALCTiaoLiTwoCell" bundle:nil] forCellReuseIdentifier:@"ALCTiaoLiTwoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalThreeCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalThreeCell"];
    [self.tableView registerClass:[ACLHeadOrFootView class] forHeaderFooterViewReuseIdentifier:@"head"];
    [self.tableView registerClass:[ALCHospitalTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"institutionId"] = self.institutionId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_getInstitutionIndexPageURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
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


//收藏操作
- (void)submitBtnClick:(UIButton *)button {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"institutionId"] = self.institutionId;
    NSString * str = [QYZJURLDefineTool user_delInstitutionCollectionURL];
    if ([button.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
        //未收藏
        str = [QYZJURLDefineTool user_collectInstitutionURL];
    }
    
    [zkRequestTool networkingPOST:str parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if ([button.currentImage isEqual:[UIImage imageNamed:@"jkgl48"]]) {
                //未收藏
                [SVProgressHUD showSuccessWithStatus:@"收藏医院成功"];
                [button setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消医院收藏成功"];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        return 1;
    }
    return self.dataModel.recommendProjectList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2){
        CGFloat space = 10;
           CGFloat ww = (ScreenW - 30-3*space)/4;
           NSInteger lines = self.dataModel.departmentList.count /4 + (self.dataModel.departmentList.count % 4 ==0?0:1);
        return ww* lines + lines * space + 10;
    }
    if (indexPath.section == 1) {
        return 125;
    }else if (indexPath.section == 0) {
        return 90;
    }
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 ) {
        ALCHospitalOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalOneCell" forIndexPath:indexPath];
        
        cell.rightLB.hidden = NO;
        cell.leftLBThree.textColor = cell.leftLBTwo.textColor = CharacterBlack100;
        cell.model = self.dataModel.info;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        ALCTiaoLiTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCTiaoLiTwoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.leftBt addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.centerBt addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBt addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 2) {
        ALCHospitalTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.dataArray = self.dataModel.departmentList;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else {
        ALCHospitalThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalThreeCell" forIndexPath:indexPath];
        cell.model = self.dataModel.recommendProjectList[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.01;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ACLHeadOrFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
//    if (view == nil) {
//        view = [[ACLHeadOrFootView alloc] init];
//    }
    view.clipsToBounds = YES;
  
    view.backgroundColor = WhiteColor;
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ACLHeadOrFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
//    if (view == nil) {
//           view = [[ACLHeadOrFootView alloc] init];
//       }
    if (section == 2) {
          view.rightBt.hidden = YES;
          view.leftLB.text = @"选择科室";
      }else if (section == 3) {
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
    if  (button.tag != 3) {
        return;
    }
    ALCProjectTVC * vc =[[ALCProjectTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.institutionId = self.institutionId;
    vc.isR = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        ALCHospitalDetailTVC * vc =[[ALCHospitalDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);
        vc.sendImageNameBlock = ^(NSString * _Nonnull imageName) {
            [weakSelf.rightBt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        };
//        self.dataModel.info.province_important_departmentList = [self getArrWithStrOne:@"省重点" strTwo:self.dataModel.info.provinceImportantDepartment];
//        self.dataModel.info.city_important_departmentList = [self getArrWithStrOne:@"市重点" strTwo:self.dataModel.info.cityImportantDepartment];
         vc.dataModel = self.dataModel.info;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3) {
        
        ALCProjectDetailTVC * vc =[[ALCProjectDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.projectId = self.dataModel.recommendProjectList[indexPath.row].ID;
        vc.institutionId = self.institutionId;
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

- (NSMutableArray <ALMessageModel *> *)getArrWithStrOne:(NSString *)strOne strTwo:(NSString *)strTwo {
    NSMutableArray * arr= @[].mutableCopy;
    for (int i = 0 ; i <  [strTwo componentsSeparatedByString:@","].count + 1; i++) {
        ALMessageModel * model = [[ALMessageModel alloc] init];
        if (i == 0) {
            model.name = strOne;
        }else {
            model.name = [strTwo componentsSeparatedByString:@","][i-1];
        }
        [arr addObject:model];
    }
    
    return arr;
}


- (void)clickCell:(UIButton *)button {
    if (button.tag == 100 || button.tag == 101) {
        //点击预约医生
        ALCChooseAdministrativeTVC * vc =[[ALCChooseAdministrativeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.hosID = self.institutionId;
        vc.departmentList = self.dataModel.departmentList;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 101) {
        //点击在线预约
   

    }else {
        //预约项目
        ALCProjectTVC * vc =[[ALCProjectTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.institutionId = self.institutionId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ------ 点击科室 ----

- (void)clickALCHospitalTwoCell:(ALCHospitalTwoCell *)cell withIndex:(NSInteger )index {
    
    
    ALCDorListTVC * vc =[[ALCDorListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isComeFromHospital = YES;
    vc.HosId = self.institutionId;
    vc.departId = self.dataModel.departmentList[index].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
