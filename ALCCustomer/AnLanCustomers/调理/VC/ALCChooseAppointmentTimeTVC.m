//
//  ALCChooseAppointmentTimeTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChooseAppointmentTimeTVC.h"
#import "ALCChooseAppointmentTimeCell.h"
@interface ALCChooseAppointmentTimeTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCChooseAppointmentTimeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择预约时间";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCChooseAppointmentTimeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"doctorId"] = self.doctorId;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_findDoctorScheduleURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"schedules"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (void)setRightNavigationItem {
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"确认" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCChooseAppointmentTimeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALMessageModel * model = self.dataArray[indexPath.row];
    
    if (model.restCnt == 0) {
        return ;
    }else {
//        model.isSelect = !model.isSelect;
//        [self.tableView reloadData];
        NSString * str = @"上午";
        if ([model.duration isEqualToString:@"2"]) {
            str = @"下午";
        }
        NSString * ss = [NSString stringWithFormat:@"%@ %@",model.scheduleDate,str];
        if (self.sendScheduleIdBlcok != nil) {
            self.sendScheduleIdBlcok(model.scheduleId,ss);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    
}

@end
