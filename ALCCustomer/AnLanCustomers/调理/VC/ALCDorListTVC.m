//
//  ALCDorListTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCDorListTVC.h"
#import "ALCDorListCell.h"
#import "ALCDorDetailOneTVC.h"
@interface ALCDorListTVC ()<UITextFieldDelegate>
@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSString *searchWord;
@end

@implementation ALCDorListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"医生列表";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCDorListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.isComeSearch || self.isComeHome) {
        
        self.navigationItem.title = @"医生列表";
        if (self.isComeHome) {
            self.navigationItem.title = @"医生推荐";
            self.page = 1;
                   self.dataArray = @[].mutableCopy;
                   [self getData];
                   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                       self.page = 1;
                       [self getData];
                   }];
        }
        [self.tableView reloadData];

    }else {
        [self setHeadView];
        
        self.page = 1;
        self.dataArray = @[].mutableCopy;
        [self getData];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self getData];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page++;
            [self getData];
        }];
        
    }
    
    
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"name"] = self.searchWord;
    
    NSString *url = [QYZJURLDefineTool app_findDoctorListURL];
    if (self.isComeFromHospital) {
        url = [QYZJURLDefineTool app_findDoctorUnderInstitutionURL];
        dict[@"institutionId"] = self.HosId;
        dict[@"departmentId"] = self.departId;
    }
    if(self.isComeHome) {
        url = [QYZJURLDefineTool user_moreDataURL];
        dict[@"condition"] = @"1";
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<ALMessageModel *>*arr = @[];
            if (self.isComeFromHospital) {
               arr =  [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            }else {
              arr =  [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
           
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


- (void)setHeadView {
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = NO;
    self.navigationItem.titleView = searchTitleView;
    @weakify(self);
//    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
//        @strongify(self);
//        if (value.length > 0) {
//            return YES;
//        }else {
//            return NO;
//        }
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"======\n%@",x);
//        self.searchWord = x;
//        self.page = 1;
//        [self getData];
//
//    }];
    self.navigationItem.titleView = searchTitleView;

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.page = 1;
    self.searchWord = textField.text;
    [self getData];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 154;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCDorListCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ALCDorDetailOneTVC * vc =[[ALCDorDetailOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.doctorId = self.dataArray[indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
