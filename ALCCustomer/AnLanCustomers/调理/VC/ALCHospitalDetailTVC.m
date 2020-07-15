//
//  ALCHospitalDetailTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHospitalDetailTVC.h"
#import "ALCHospitalDeatilTwoCell.h"
#import "ALCHospitalDetailThreeCell.h"
#import "ALCHeadOrFootGreenView.h"
#import "ALCHospitalDetailOneCell.h"
#import "ALCHospitalDetailThreeCell.h"
@interface ALCHospitalDetailTVC ()
@property(nonatomic,strong)UIButton *rightBt;
@end

@implementation ALCHospitalDetailTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"institutionId"] = self.dataModel.ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getInstitutionDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            
            if (self.dataModel.isCollection) {
                [self.rightBt setImage:[UIImage imageNamed:@"jkgl47"] forState:UIControlStateNormal];
            }else {
                [self.rightBt setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
            }
            
            NSMutableArray<ALMessageModel *> * arrOne = @[].mutableCopy;
            NSArray * pArr = @[];
            if (self.dataModel.provinceImportantDepartment.length > 0) {
                pArr =  [self.dataModel.provinceImportantDepartment componentsSeparatedByString:@","];
            }
            for (int i = 0 ; i <=pArr.count; i++) {
                
                if (i == pArr.count) {
                    ALMessageModel * model = [[ALMessageModel alloc] init];
                    model.name = @"省重点";
                    [arrOne insertObject:model atIndex:0];
                }else {
                    ALMessageModel * model = [[ALMessageModel alloc] init];
                    model.name = pArr[i];
                    [arrOne addObject:model];
                }
            }
            self.dataModel.province_important_departmentList = arrOne;
            
            
            NSMutableArray<ALMessageModel *> * arrTwo = @[].mutableCopy;
            NSArray * cArr = @[];
            if (self.dataModel.cityImportantDepartment.length > 0) {
                cArr =  [self.dataModel.provinceImportantDepartment componentsSeparatedByString:@","];
            }
            for (int i = 0 ; i <=cArr.count; i++) {
                
                if (i == cArr.count) {
                    ALMessageModel * model = [[ALMessageModel alloc] init];
                    model.name = @"市重点";
                    [arrTwo insertObject:model atIndex:0];
                }else {
                    ALMessageModel * model = [[ALMessageModel alloc] init];
                    model.name = cArr[i];
                    [arrTwo addObject:model];
                }
            }
            self.dataModel.city_important_departmentList = arrTwo;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"医院概况";
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
    submitBtn.layer.cornerRadius = 22;
    submitBtn.layer.masksToBounds = YES;
    //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setImage:[UIImage imageNamed:@"jkgl48"] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    
    [self.tableView registerClass:[ALCHospitalDeatilTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalDetailOneCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalDetailOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCHospitalDetailThreeCell" bundle:nil] forCellReuseIdentifier:@"ALCHospitalDetailThreeCell"];
    [self.tableView registerClass:[ALCHeadOrFootGreenView class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    
    
    [self getData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 155.6;
    }else if (indexPath.section == 1) {
        
        
        if (indexPath.row == 0) {
            if (self.dataModel.provinceImportantDepartment.length == 0) {
                return 0;
            }else {
                return self.dataModel.province_important_departmentList[0].HHHHHH;
            }
        }else {
            if (self.dataModel.cityImportantDepartment.length == 0) {
                return 0;
            }else {
                return self.dataModel.city_important_departmentList[0].HHHHHH;
            }
        }
    }else {
        return self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        return 0.01;
    }
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
    
    if (section == 1) {
        
        view.leftLB.text = @"重点科室";
    }else if (section == 2) {
        
        view.leftLB.text = @"医院简介";
    }else if (section == 3) {
        view.leftLB.text = @"乘车路线";
    }
    view.clipsToBounds = YES;
    view.backgroundColor = WhiteColor;
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ALCHospitalDetailOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalDetailOneCell" forIndexPath:indexPath];
        cell.model = self.dataModel;
        [cell.daoHangBt addTarget:self action:@selector(daohangAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1) {
        ALCHospitalDeatilTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.dataArray = self.dataModel.province_important_departmentList;
        }else {
            cell.dataArray = self.dataModel.city_important_departmentList;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
        return cell;
    }else {
        ALCHospitalDetailThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ALCHospitalDetailThreeCell" forIndexPath:indexPath];
        if (indexPath.section == 2) {
            cell.leftLB.attributedText = [self.dataModel.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];
        }else {
            cell.leftLB.attributedText = [self.dataModel.route getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50];
        }
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)daohangAction {
    
    [self showMapNavigationViewWithName:self.dataModel.name];
    
}


- (void)showMapNavigationViewWithName:(NSString *)name{
    
    NSArray *appListArr = [self checkHasOwnApp];
    
    NSString *sheetTitle = [NSString stringWithFormat:@"导航到 %@",name];
    
    NSString *str0,*str1,*str2,*str3;
    str0 = str1 = str2 = str3 = @"";
    switch (appListArr.count) {
        case 1:
        {
            str0 = appListArr[0];
            break;
        }
        case 2:
        {
            str0 = appListArr[0];
            str1 = appListArr[1];
            break;
        }
        case 3:
        {
            str0 = appListArr[0];
            str1 = appListArr[1];
            str2 = appListArr[2];
            break;
        }
        case 4:
        {
            str0 = appListArr[0];
            str1 = appListArr[1];
            str2 = appListArr[2];
            str3 = appListArr[3];
            break;
        }
            
        default:
            break;
    }
    
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:sheetTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    UIAlertAction * action0 = [UIAlertAction actionWithTitle:str0 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self openUrlWithTitle:action.title];
    }];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:str1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openUrlWithTitle:action.title];
        
    }];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:str2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openUrlWithTitle:action.title];
        
    }];
    
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:str3 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openUrlWithTitle:action.title];
        
    }];
    [alertVC addAction:action];
    switch (appListArr.count) {
        case 1:
        {
            [alertVC addAction:action0];
            break;
        }
        case 2:
        {
            [alertVC addAction:action0];
            [alertVC addAction:action1];
            break;
        }
        case 3:
        {
            [alertVC addAction:action0];
            [alertVC addAction:action1];
            [alertVC addAction:action2];
            break;
        }
        case 4:
        {
            [alertVC addAction:action0];
            [alertVC addAction:action1];
            [alertVC addAction:action2];
            [alertVC addAction:action3];
            break;
        }
            
        default:
            break;
    }
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}


- (void)openUrlWithTitle:(NSString *)str {
    if ([str isEqualToString:@"百度地图"]) {
        //百度
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/navi?location=%f,%f&coord_type=gcj02",self.dataModel.latitude,self.dataModel.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        NSURL *r = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:r];
        //        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving",self.latNow, self.lngNow,[self.lte doubleValue],[self.lng doubleValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        
        //        NSURL *r = [NSURL URLWithString:urlString];
        //
        //        [[UIApplication sharedApplication] openURL:r];
    }else if ([str isEqualToString:@"高德地图"]) {
        //高德
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=applicationName&lat=%f&lon=%f&dev=0&style=2",self.dataModel.latitude,self.dataModel.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *r = [NSURL URLWithString:urlString];
        
        [[UIApplication sharedApplication] openURL:r];
    }else if ([str isEqualToString:@"腾讯地图"]) {
        
        //         NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=%f,%f&tocoord=%f,%f&policy=1",self.latNow, self.lngNow,[self.lte doubleValue],[self.lng doubleValue]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //腾讯
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=%f,%f",self.dataModel.latitude,self.dataModel.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *r = [NSURL URLWithString:urlString];
        
        [[UIApplication sharedApplication] openURL:r];
    }else if ([str isEqualToString:@"苹果地图"]) {
        
        NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?q=医院&sll=%f,%f&z=10&t=s",self.dataModel.latitude,self.dataModel.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *r = [NSURL URLWithString:urlString];
        
        [[UIApplication sharedApplication] openURL:r];
        
        
    }
    
    
}


- (NSArray *)checkHasOwnApp{
    
    NSArray *mapSchemeArr =@[@"iosamap://",@"baidumap://map/",@"qqmap://"];
    
    
    
//    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果地图",nil];
    
    NSMutableArray *appListArr = @[].mutableCopy;
    
    for (int i =0; i < [mapSchemeArr count]; i++) {
        
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
                       if (i ==0) {
                           [appListArr addObject:@"高德地图"];
                       }else if (i == 1){
                           [appListArr addObject:@"百度地图"];
                       }else if (i == 2){
                           [appListArr addObject:@"腾讯地图"];
                       }else if (i == 3){
                           
                       }
                       
                   }
        
        
//        if (@available(iOS 10.0, *)) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]] options:@{} completionHandler:^(BOOL success) {
//                
//                if  (success) {
//                    if (i ==0) {
//                        [appListArr addObject:@"高德地图"];
//                    }else if (i == 1){
//                        [appListArr addObject:@"百度地图"];
//                    }else if (i == 2){
//                        [appListArr addObject:@"腾讯地图"];
//                    }else if (i == 3){
//                        
//                    }
//                }
//                
//            }];
//        } else {
//           
//        }

    }
    
    
    
    return appListArr;
    
}




//收藏操作
- (void)submitBtnClick:(UIButton *)button {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"institutionId"] = self.dataModel.ID;
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
                [SVProgressHUD showSuccessWithStatus:@"取消医院收藏"];
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



@end
