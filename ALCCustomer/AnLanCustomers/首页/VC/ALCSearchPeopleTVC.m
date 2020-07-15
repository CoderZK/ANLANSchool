//
//  ALCSearchPeopleTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSearchPeopleTVC.h"
#import "ALCInquiryMessageCell.h"
@interface ALCSearchPeopleTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *editBt;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *searchArray;
@property(nonatomic,assign)BOOL isSearch;
@end

@implementation ALCSearchPeopleTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeadView];
    
  
    
    [self.tableView registerClass:[ALCInquiryMessageCell class] forCellReuseIdentifier:@"cell"];

        self.tableView.backgroundColor = WhiteColor;
    
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
        self.isSearch = NO;
        [self.searchArray removeAllObjects];
        [self.tableView reloadData];
    }];
    self.navigationItem.titleView = searchTitleView;
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];
    

    self.dataArray = @[].mutableCopy;
    self.searchArray = @[].mutableCopy;
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
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_searchDoctorsURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"doctors"]];
            
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        return self.searchArray.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    ALCInquiryMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.rightBt.hidden = NO;
    cell.timeLB.hidden = YES;
    if (self.isSearch) {
        ALMessageModel * model = self.searchArray[indexPath.row];
         cell.headBt.redV.hidden = model.is_read;
        [cell.headBt.button sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
        cell.nameLB.text = [NSString stringWithFormat:@"%@",model.phone];
        cell.desLB.text = [NSString stringWithFormat:@"%@",model.name];
        cell.headBt.redV.hidden = YES;
    }else {
        ALMessageModel * model = self.dataArray[indexPath.row];
        cell.headBt.redV.hidden = YES;
        [cell.headBt.button sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
        cell.nameLB.text = [NSString stringWithFormat:@"%@",model.phone];
        cell.desLB.text = [NSString stringWithFormat:@"%@",model.name];
    }
     
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALMessageModel * model = [[ALMessageModel alloc] init];
    if (self.isSearch) {
        model = self.searchArray[indexPath.row];
    }else {
        model = self.dataArray[indexPath.row];
    }

    ALCChooseJiuZhenRenTVC * vc =[[ALCChooseJiuZhenRenTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.toUserId = model.ID;
    vc.isLiaoTian = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)submitBtnClick:(UIButton *)button {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.isSearch = YES;
    
    [self getsetArrWithStr:textField.text];
    return YES;
}

- (void)getsetArrWithStr:(NSString *)str {
    [self.searchArray removeAllObjects];
    for (ALMessageModel * model  in self.dataArray) {
        if ([model.phone containsString:str]) {
            [self.searchArray addObject:model];
        }
    }
    [self.tableView reloadData];
    
}

@end
