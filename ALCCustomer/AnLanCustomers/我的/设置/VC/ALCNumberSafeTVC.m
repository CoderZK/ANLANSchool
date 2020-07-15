//
//  ALCNumberSafeTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCNumberSafeTVC.h"
#import "ALCSettingMiMaVC.h"
#import "QYZJChangePhoneVC.h"
@interface ALCNumberSafeTVC ()
@property(nonatomic,strong)NSArray *leftArr,*placeArr;
@end

@implementation ALCNumberSafeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号与安全";
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.leftArr = @[@[@"手机号",@"登录密码",@"指纹识别",@"人脸识别"],@[@"微信账号",@"QQ账号"]];
    self.placeArr = @[@[@"未绑定",@"未置设",@"未置设",@"未置设"],@[@"未绑定",@"未绑定"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.leftArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 10;
}


- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = BackgroundColor;
    }
    view.clipsToBounds = YES;
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftArr[indexPath.section][indexPath.row];
    cell.TF.placeholder = self.placeArr[indexPath.section][indexPath.row];
    cell.TF.textAlignment = NSTextAlignmentRight;
    cell.TF.userInteractionEnabled = NO;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //手机号
            QYZJChangePhoneVC * vc =[[QYZJChangePhoneVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            //密码登录
            ALCSettingMiMaVC * vc =[[ALCSettingMiMaVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            //指纹识别
        }else if (indexPath.row == 3) {
            //人脸识别
        }
    }else {
        
    }
}

@end
