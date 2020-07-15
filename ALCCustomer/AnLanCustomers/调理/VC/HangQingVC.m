//
//  HangQingVC.m
//  AnLanCustomers
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HangQingVC.h"
#import "ALCMineSearchTVC.h"
#import "ALCTiaoLiOneCell.h"
#import "ALCHospitalHomeTVC.h"
#import "ALCCityListVC.h"
#import "ALCSearchHospitalView.h"
#import "QYZJLocationTool.h"
@interface HangQingVC ()<UITextFieldDelegate,HHYSearchHeadViewDelegate>
@property(nonatomic,strong)HHYSearchHeadView *searchV;
@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)UIButton *editBt;
@property(nonatomic,strong)NSString *prnvinceStr,*cityStr,*searchWord,*prnviceID,*cityID;
@property(nonatomic,assign)NSInteger sortType; // 必须（1距离 2医生预约量 3项目预约量）
@property(nonatomic,assign)NSInteger sort; //（1默认顺序（由近及远、由多到少）2反序）
@property(nonatomic,strong)NSString *typeId;//类型
@property(nonatomic,strong)NSString *levelId;//医院等级
@property(nonatomic,strong)ALCSearchHospitalView *showSearchV;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *typeArr,*levelArr;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel*> *dataArray;
@property(nonatomic,strong)QYZJLocationTool *tool;
@property(nonatomic,assign)CGFloat latitude , longitude;
@end

@implementation HangQingVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.showSearchV diss];
}

- (ALCSearchHospitalView *)showSearchV {
    if (_showSearchV == nil) {
        _showSearchV = [[ALCSearchHospitalView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44 + 50 , ScreenW, ScreenH -(sstatusHeight + 44 + 50) )];
    }
    return _showSearchV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0,  50 , ScreenW, ScreenH - (50));
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchV = [[HHYSearchHeadView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW  , 50)];
    self.searchV.delegate = self;
    self.searchV.backgroundColor = BackgroundColor;
    [self.view addSubview:self.searchV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCTiaoLiOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.backgroundColor = WhiteColor;
    
    self.levelArr = @[].mutableCopy;
    self.typeArr = @[].mutableCopy;
    
    [self setHeadView];
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    [self getDataWithType:1];
    [self getDataWithType:2];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
        [self getDataWithType:1];
        [self getDataWithType:2];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
    
    self.tool = [[QYZJLocationTool alloc] init];
    [self.tool locationAction];
    Weak(weakSelf);
    self.tool.locationBlock = ^(NSString * _Nonnull cityStr, NSString * _Nonnull cityID,NSString * procince , CGFloat latitude ,CGFloat longitude) {
        weakSelf.latitude = latitude;
        weakSelf.longitude = longitude;
        [weakSelf getData];
    };
    
    
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    dict[@"province"] = self.prnvinceStr;
    dict[@"city"] = self.cityStr;
    dict[@"typeId"] = self.typeId;
    dict[@"levelId"] = self.levelId;
    dict[@"sort"] = @(1);
    dict[@"sortType"] = @(self.sortType);
    dict[@"name"] = self.searchWord;
    dict[@"longitude"] = @(self.longitude);
    dict[@"latitude"] = @(self.latitude);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findInstitutionListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<ALMessageModel *>*arr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


- (void)getDataWithType:(NSInteger )type {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @(type);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findInstitutionDictionaryURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if(type == 1) {
                self.typeArr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                
            }else {
                self.levelArr = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}



- (void)setHeadView {
    
    ALCSearchView * titleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70, 44)];
    titleView.searchTF.delegate = self;
    titleView.isPush = YES;
    self.navigationItem.titleView = titleView;
    @weakify(self);
    [[titleView.clickBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        ALCMineSearchTVC * vc =[[ALCMineSearchTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = 3;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 44, 44)];
    //    submitBtn.layer.cornerRadius = 22;
    //    submitBtn.layer.masksToBounds = YES;
    //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCTiaoLiOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ALMessageModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.institutionId = self.dataArray[indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}


- (void)tiao {
    
    self.searchV.leftStr = @"北京市";
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self submitBtnClick:nil];
    return YES;
}


- (void)submitBtnClick:(UIButton *)button {
    
    //    self.page = 1;
    //    [self getData];
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    ACLMineMessageTVC * vc =[[ACLMineMessageTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)didClickIndex:(NSInteger)index withIsShow:(BOOL)isShow {
    
    
    
    if (index == 0) {
        ALCCityListVC * vc =[[ALCCityListVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [self.searchV cancel];
        Weak(weakSelf);
        vc.cityBlock = ^(NSString * _Nonnull provinceStr, NSString * _Nonnull cityStr, NSString * _Nonnull proviceId, NSString * _Nonnull cityId) {
            weakSelf.prnvinceStr = provinceStr;
            weakSelf.cityStr = cityStr;
            weakSelf.cityID = cityId;
            weakSelf.prnviceID = proviceId;
            weakSelf.page = 1;
            [weakSelf getData];
            weakSelf.searchV.leftStr = cityStr;
        };

    }else if (index == 1){
        
        if (isShow == NO) {
            [self.showSearchV diss];
            
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.showSearchV];
        [self.showSearchV showWithType:1];
        Weak(weakSelf);
        self.showSearchV.ConfirmBlock = ^(NSInteger row, NSString * _Nonnull hospitalStr, NSString * _Nonnull levelStr,BOOL isDiss) {
            if (isDiss) {
                [weakSelf.searchV cancel];
            }else {
                weakSelf.sortType = row+1;
                weakSelf.page = 1;
                [weakSelf getData];
                [weakSelf.searchV cancel];
            }
            
        };
        
        
    }else {
        
        if (isShow==NO) {
            [self.showSearchV diss];
        }
        self.showSearchV.typeArr = self.typeArr;
        self.showSearchV.levelArr = self.levelArr;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.showSearchV];
        [self.showSearchV showWithType:2];
        Weak(weakSelf);
        self.showSearchV.ConfirmBlock = ^(NSInteger row, NSString * _Nonnull hospitalStr, NSString * _Nonnull levelStr,BOOL isDiss) {
            if (isDiss) {
                [weakSelf.searchV cancel];
            }else {
                weakSelf.typeId = hospitalStr;
                weakSelf.levelId = levelStr;
                weakSelf.page = 1;
                [weakSelf getData];
                [weakSelf.searchV cancel];
            }
        };
        
    }
    
    
    
}

@end
