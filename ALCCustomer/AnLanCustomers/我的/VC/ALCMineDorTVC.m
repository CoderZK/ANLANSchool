//
//  ALCMineDorTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCMineDorTVC.h"
#import "ALCMineDorCell.h"
#import "ALCDorDetailOneTVC.h"
@interface ALCMineDorTVC ()
@property(nonatomic,strong)ALCMineDorterView *headV;
@end

@implementation ALCMineDorTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.navigationItem.title = @"我的医生";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCMineDorCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    NSMutableArray<ALMessageModel *> * titelArr = @[].mutableCopy;
    for (int i = 0 ; i < self.allDataArr.count; i++) {
        NSDictionary * dict = self.allDataArr[i];
        [titelArr addObjectsFromArray:[ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"info"]]];
        if (i== 0) {
            self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"doctors"]];
            [self.tableView reloadData];
        }
        
    }
    for (ALMessageModel *mm  in titelArr) {
        if (mm.name.length == 0) {
            mm.name = mm.nickname;
        }
    }
    self.headV = [[ALCMineDorterView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    self.headV.dataArray = titelArr;
    self.headV.mj_h = self.headV.hh;
    self.headV.isNOCanSelectAll = YES;
    self.tableView.tableHeaderView = self.headV;
    Weak(weakSelf);
    self.headV.selectBlock = ^(NSInteger selectIndex) {
        NSDictionary * dict = weakSelf.allDataArr[selectIndex];
        weakSelf.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"doctors"]];
        [weakSelf.tableView reloadData];
    };
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = BackgroundColor;
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCMineDorCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.lianXiBt.tag = indexPath.row;
    [cell.lianXiBt addTarget:self action:@selector(lianxiAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ALCDorDetailOneTVC * vc =[[ALCDorDetailOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.doctorId = self.dataArray[indexPath.row].doctorId;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)lianxiAction:(UIButton *)button {

    ALCChooseJiuZhenRenTVC * vc =[[ALCChooseJiuZhenRenTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    ALMessageModel * model = self.dataArray[button.tag];
    vc.hidesBottomBarWhenPushed = YES;
    vc.toUserId = model.doctorId;
    vc.isLiaoTian = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
