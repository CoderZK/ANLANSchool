//
//  ALCMineSearchTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineSearchTVC.h"
#import "ALCMineSeachCell.h"
#import "ALCHospitalListTVC.h"
#import "ALCDorListTVC.h"
#import "GuanZhuVC.h"
@interface ALCMineSearchTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *editBt;
@property (nonatomic , strong)UIView * headView;
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)ALCSearchView *searchTitleView;
@property(nonatomic,strong)ALCChooseJianKangVIew *view1,*view2,*view3;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)NSArray<NSString *> *dataArray;
@property(nonatomic,assign)BOOL isShowSearchV;
@property(nonatomic,strong)NSString *serachWord;

@end

@implementation ALCMineSearchTVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeadView];
    [self setheadVV];
    
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    self.isShowSearchV = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineSeachCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)getData {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"rangMode"] = @"1";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getRecentSearchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
            self.dataArray = responseObject[@"data"];
            [self setheadVV];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];

        
    }];
}

- (void)getDataList {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"keyword"] = self.serachWord;
    dict[@"rangMode"] = @"1";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_lookAfterSearchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.tableView.tableHeaderView = nil;
            self.isShowSearchV = NO;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


- (void)setHeadView {
    
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = NO;
    self.navigationItem.titleView = searchTitleView;
    @weakify(self);
    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length == 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
        [self setheadVV];
        self.isShowSearchV = YES;
        [self.tableView reloadData];
        
    }];
    self.navigationItem.titleView = searchTitleView;
    self.searchTitleView = searchTitleView;
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
    submitBtn.layer.cornerRadius = 22;
    submitBtn.layer.masksToBounds = YES;
    //      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"取消" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];
    
    
    
    
}


- (void)setheadVV {
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    self.headV.backgroundColor = WhiteColor;

    ALCChooseJianKangVIew * view1 = [[ALCChooseJianKangVIew alloc] init];
    [self.headV addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headV);
        make.height.equalTo(@(20));
    }];
    view1.rightBt.hidden = NO;
    [view1.rightBt setImage:[UIImage imageNamed:@"delect"] forState:UIControlStateNormal];
    [view1.rightBt addTarget:self action:@selector(delectAction) forControlEvents:UIControlEventTouchUpInside];
    self.view1 = view1;
    view1.isNODefalutSelect = YES;
    NSMutableArray<ALMessageModel *> * arrTwo = @[].mutableCopy;
    for (int i  = 0 ; i < self.dataArray.count; i++) {
        ALMessageModel * model = [[ALMessageModel alloc] init];
        model.name = self.dataArray[i];
        [arrTwo addObject:model];
    }
    view1.dataArray = arrTwo;
    view1.titleOneStr = @"最近搜过";
    view1.isShowTV = NO;
    view1.isOnlySelectOne = YES;
    view1.mj_h = view1.hh;
    [view1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(view1.hh));
    }];
    Weak(weakSelf);
    view1.didClickBlcok = ^(NSInteger index) {
        weakSelf.serachWord = self.dataArray[index];
        [weakSelf getDataList];
    };
    
    
//    ALCChooseJianKangVIew * view2 = [[ALCChooseJianKangVIew alloc] init];
//    self.view2 = view2;
//    [self.headV addSubview:view2];
//    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.headV);
//        make.top.equalTo(self.view1.mas_bottom).offset(0);
//        make.height.equalTo(@(20));
//    }];
//    view2.isNODefalutSelect = YES;
//    NSArray * arr2 = @[@"减肥",@"增肌",@"孕妇",@"美白",@"儿童成长",@"糖尿病",@"便秘"];
//    NSMutableArray<ALMessageModel *> * arrTwo2 = @[].mutableCopy;
//    for (int i  = 0 ; i < arr2.count; i++) {
//        ALMessageModel * model = [[ALMessageModel alloc] init];
//        model.name = arr2[i];
//        [arrTwo2 addObject:model];
//    }
//    view2.dataArray = arrTwo2;
//    view2.titleOneStr = @"推荐榜";
//    view2.isShowTV = NO;
//    view2.mj_h = view2.hh;
//
//    [view2 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(view2.hh));
//    }];
//
//
//    ALCChooseJianKangVIew * view3 = [[ALCChooseJianKangVIew alloc] init];
//    [self.headV addSubview:view3];
//    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.headV);
//        make.top.equalTo(self.view2.mas_bottom).offset(0);
//        make.height.equalTo(@(20));
//    }];
//    view3.isNODefalutSelect = YES;
//    self.view3 = view3;
//    NSArray * arr3 = @[@"米饭",@"鸡蛋",@"苹果",@"香蕉",@"白饭",@"馒头"];
//    NSMutableArray<ALMessageModel *> * arrTwo3 = @[].mutableCopy;
//    for (int i  = 0 ; i < arr3.count; i++) {
//        ALMessageModel * model = [[ALMessageModel alloc] init];
//        model.name = arr3[i];
//        [arrTwo3 addObject:model];
//    }
//    view3.dataArray = arrTwo3;
//    view3.titleOneStr = @"大家都在搜";
//    view3.isShowTV = NO;
//    view3.mj_h = view3.hh;
//
//    [view3 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(view3.hh));
//    }];
    
    self.view1.backVTwo.hidden = self.view2.backVTwo.hidden = self.view3.backVTwo.hidden = YES;
    self.view1.clipsToBounds = self.view2.clipsToBounds = self.view3.clipsToBounds = YES;
    self.headV.mj_h  = CGRectGetMaxY(view1.frame);
    self.tableView.tableHeaderView = self.headV;
    
    
    
    
    
}

- (void)delectAction{
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"rangModel"] = @"1";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_delRecentSearchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
               self.view1.dataArray = @[];
               [self.view1 mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.height.equalTo(@(self.view1.hh));
               }];
               
               //    self.view1.backgroundColor = [UIColor yellowColor];
               [self.headV layoutIfNeeded];
               [self.headV layoutSubviews];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
   
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self submitBtnClick:nil];
    self.serachWord = textField.text;
    [self getDataList];
    return YES;
}


- (void)submitBtnClick:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    //    self.page = 1;
    //    [self getData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isShowSearchV) {
        return 0;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.dataModel.institutionList.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else if (indexPath.row == 1){
        if (self.dataModel.doctorList.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }else {
        if (self.dataModel.articleList.count == 0) {
            return 0;
        }else {
            return 50;
        }
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMineSeachCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.clipsToBounds  = YES;
    if (indexPath.row == 0) {
        cell.leftLB.text = [NSString stringWithFormat:@"包含:%@ 的医院",self.serachWord];
        cell.rightLB.text = [NSString stringWithFormat:@"全国%ld条医院结果",self.dataModel.institutionList.count];
        cell.imgV.image = [UIImage imageNamed:@"ddoc"];
    }else if (indexPath.row == 1) {
        cell.leftLB.text = [NSString stringWithFormat:@"包含:%@ 的医生",self.serachWord];
        cell.rightLB.text = [NSString stringWithFormat:@"全国%ld条医生结果",self.dataModel.doctorList.count];
        cell.imgV.image = [UIImage imageNamed:@"hos"];
    }else {
        cell.leftLB.text = [NSString stringWithFormat:@"包含:%@ 的文章",self.serachWord];
        cell.rightLB.text = [NSString stringWithFormat:@"全国%ld条文章结果",self.dataModel.articleList.count];
        cell.imgV.image = [UIImage imageNamed:@"wenzhang"];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ALCHospitalListTVC * vc =[[ALCHospitalListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dataArray = self.dataModel.institutionList;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        ALCDorListTVC * vc =[[ALCDorListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isComeSearch = YES;
        vc.dataArray = self.dataModel.doctorList;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        GuanZhuVC * vc =[[GuanZhuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isSearch = YES;
        vc.dataArray = self.dataModel.articleList;
        [self.navigationController pushViewController:vc animated:YES];
        //
    }

}


@end
