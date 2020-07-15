//
//  ALCSettingTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSettingTVC.h"
#import "QYZJSettingCell.h"
#import "Clear.h"
#import "ALCAboutJKVC.h"
#import "ALCAddressTVC.h"
#import "ALCNumberSafeTVC.h"
#import "ALCEditMineZiLiaoVC.h"
@interface ALCSettingTVC ()
@property(nonatomic,strong)NSArray *leftArr;
@end

@implementation ALCSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
     self.leftArr = @[@"个人资料",@"收获地址管理",@"账号与安全",@"关于健康管理",@"清除缓存"];
    
    if (isDidLogin) {
        [self setFootV];
    }
 
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }

    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"退出登录" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
           [weakSelf outLoginActio:button];
    };
    [self.view addSubview:view];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.leftArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }else if (indexPath.row == 1 || indexPath.row == 2) {
        return 0;
    }
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text  = self.leftArr[indexPath.row];
    cell.lineV.hidden = NO;
    cell.rightLB.text = @"";
    cell.switchBt.hidden = YES;
    cell.jianTouImgV.hidden = NO;
    if (indexPath.row + 1 == [self.leftArr count]) {
        cell.lineV.hidden = YES;
    }
    
    if (indexPath.row == 0) {
//        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:self.dataModel.head_img]] placeholderImage:[UIImage imageNamed:@"963"] options:SDWebImageRetryFailed];
        cell.headImg.layer.cornerRadius = 25;
        cell.headImg.clipsToBounds = YES;
    }else if (indexPath.row == 4) {
        cell.rightLB.text = [NSString stringWithFormat:@"%0.1fM",[Clear folderSizeAtPath]];
    }
    cell.clipsToBounds = YES;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //个人资料
        ALCEditMineZiLiaoVC * vc =[[ALCEditMineZiLiaoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.row == 1) {
        //收获地址
        ALCAddressTVC * vc =[[ALCAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2) {
        //账号安全
        ALCNumberSafeTVC * vc =[[ALCNumberSafeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        
        ALCAboutJKVC * vc =[[ALCAboutJKVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 4){
        [Clear cleanCache:^{
            [tableView reloadData];
        }];
    }
    
    
}

//退出登录
- (void)outLoginActio:(UIButton *)button {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_logoutURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [zkSignleTool shareTool].session_token = nil;
            [zkSignleTool shareTool].isLogin = NO;
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"result"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
//    [SVProgressHUD show];
//    NSMutableDictionary * dict = @{}.mutableCopy;
//    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_app_logoutURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        [SVProgressHUD dismiss];
//        if ([responseObject[@"key"] intValue]== 1) {
//            [zkSignleTool shareTool].session_token = nil;
//            [zkSignleTool shareTool].isLogin = NO;
//            [self.navigationController popToRootViewControllerAnimated:NO];
//            TabBarController * tab = (TabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//            tab.selectedIndex = 0;
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"jkgl1"]];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//
//    }];
    
    
}

@end
