//
//  ALCChooseJiuZhenRenTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/6/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCChooseJiuZhenRenTVC.h"
#import "ALCAddMineFamilyTwoVC.h"
@interface ALCChooseJiuZhenRenTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCChooseJiuZhenRenTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择就诊人";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.dataArray = @[].mutableCopy;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
        [self getData];
    }];

    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(0, 0, 50, 30);
       [button setTitle:@"添加" forState:UIControlStateNormal];
       
       button.titleLabel.font = [UIFont systemFontOfSize:14];
       [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       button.layer.cornerRadius = 0;
       button.clipsToBounds = YES;
       @weakify(self);
       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           ALCAddMineFamilyTwoVC * vc =[[ALCAddMineFamilyTwoVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
           
       }];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:user_choosePatient parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row].name;
    cell.textLabel.textColor = CharacterColor50;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALMessageModel * model = self.dataArray[indexPath.row];
    
    if (self.isLiaoTian) {
        ALChatMessageTVC* vc =[[ALChatMessageTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.toUserId = self.toUserId;
        vc.aimUserId = model.ID;
        vc.aimtype = model.type;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (self.sendChoosePatientBlock != nil) {
            if ([model.type isEqualToString:@"1"]) {
                self.sendChoosePatientBlock(model.name,@"");
            }else {
                self.sendChoosePatientBlock(model.name,model.ID);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
    
    
}


@end
