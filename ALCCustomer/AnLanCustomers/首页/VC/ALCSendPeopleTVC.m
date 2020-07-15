//
//  ALCSendPeopleTVC.m
//  AnLanBB
//
//  Created by zk on 2020/3/31.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSendPeopleTVC.h"
#import "ALCSendPeopleCell.h"
@interface ALCSendPeopleTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray<QYZJUserModel *> *dataArray;
@property(nonatomic,strong)NSString *searchWord;
@property(nonatomic,assign)NSInteger page;
@end

@implementation ALCSendPeopleTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeadView];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCSendPeopleCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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
- (void)setHeadView {
    
    ALCSearchView * titleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 120, 44)];
    titleView.searchTF.delegate = self;
    titleView.isPush = NO;
    self.navigationItem.titleView = titleView;
    @weakify(self);
    //    [[titleView.clickBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //        @strongify(self);
    //
    //
    //    }];
    
    
    [[[titleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length > 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
        self.searchWord = x;
        self.page = 1;
        [self getData];
    }];
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 44, 44)];
    //    submitBtn.layer.cornerRadius = 22;
    //    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    
    [submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [[submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击发送
        [self sendAction];
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    
    
}

//发送
- (void)sendAction {
    
    NSMutableArray * arr = @[].mutableCopy;
    
    for (QYZJUserModel * model  in self.dataArray) {
        if (model.isSelect) {
            [arr addObject:model.baseId];
        }
    }
    if (arr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少选择一个人员发送"];
        return;
    }
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"calendarId"] = self.calendarId;
    dict[@"customerId"] = [arr componentsJoinedByString:@","];
//    [zkRequestTool networkingPOST:[QYZJURLDefineTool appB_sendCalendarToCustomerURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [SVProgressHUD dismiss];
//        if ([responseObject[@"key"] intValue]== 1) {
//
//            [SVProgressHUD showSuccessWithStatus:@"发送日程成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            });
//
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//
//    }];
    
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCSendPeopleCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    QYZJUserModel * model = self.dataArray[indexPath.row];
    if (model.isSelect) {
        cell.leftImgV.image = [UIImage imageNamed:@"jkgl23"];
    }else {
        cell.leftImgV.image = [UIImage imageNamed:@"jkgl24"];
    }
    [cell.headImgV sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:model.avatar]] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
    
    cell.phoneLB.text = model.phone;
    cell.nameLB.text = model.customerName;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     QYZJUserModel * model = self.dataArray[indexPath.row];
     model.isSelect = !model.isSelect;
    [self.tableView reloadData];
}


@end
