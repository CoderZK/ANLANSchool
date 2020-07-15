//
//  ALCJianKangDangAnTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangDangAnTVC.h"
#import "ACLJianKangOneCell.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "ALCMineDorTVC.h"
#import "ALCMineJianKangDangAnHeadView.h"
#import "ALCHomeCell.h"
#import "ALCJianKangRiZhiTVC.h"
#import "ALCJianKangRiZhiDetailTVC.h"
#import "ALCEditMineJianKangTVC.h"
#import "ALCMineJianMessageTVC.h"
@interface ALCJianKangDangAnTVC ()<SDCycleScrollViewDelegate,ALCHomeCellDelegate>
@property(nonatomic,strong)ALCMineJianKangDangAnHeadView *headView;
@property(nonatomic,strong)UILabel *nameLB,*sexLB,*numberLB;
@property(nonatomic,strong)UIView *headViewTwo;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataDocArray;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataAppArray;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray *allDataArray;
@property(nonatomic,assign)NSInteger pageSelect;
@end

@implementation ALCJianKangDangAnTVC

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self scrollViewDidScroll:self.tableView];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_1"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康档案";
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView registerClass:[ALCHomeCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataAppArray = @[].mutableCopy;
    self.dataDocArray = @[].mutableCopy;
    self.dataArray = @[].mutableCopy;
    self.allDataArray = @[].mutableCopy;
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
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_getMyDoctorURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.allDataArray = responseObject[@"data"];
            [self.dataArray removeAllObjects];
            for (int i = 0;i< self.allDataArray.count;i++) {
                NSDictionary * dict = self.allDataArray[i];
                if ([[NSString stringWithFormat:@"%@",[dict[@"info"] firstObject][@"id"]] isEqualToString:self.model.ID]) {
                    self.dataDocArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"doctors"]];
                    self.dataAppArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"doctorAppoints"]];;
                    
                    self.pageSelect = i;
                }
               [self.dataArray addObjectsFromArray:[ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"info"]]];
            }
            
            [self setheadViewVV];
            [self.tableView reloadData];

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)setheadViewVV{
    
    self.tableView.mj_y = -sstatusHeight - 44;
    self.tableView.mj_h = ScreenH + sstatusHeight + 44;
    
    self.headView = [[ALCMineJianKangDangAnHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 180+ sstatusHeight + 44)];
    self.tableView.tableHeaderView = self.headView;
   
    @weakify(self);
    [[self.headView.peopleBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.dataDocArray.count > 0) {
            ALCMineDorTVC * vc =[[ALCMineDorTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.allDataArr = self.allDataArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    Weak(weakSelf);
    self.headView.buttonClickBlock = ^(NSInteger index) {
        ALCMineJianMessageTVC * vc =[[ALCMineJianMessageTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        ALMessageModel * mm =weakSelf.dataArray[index];
        vc.familyMemberId = mm.ID;
        vc.type = mm.type;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    self.headView.dataDocArray = self.dataDocArray;
    self.headView.dataArray = self.dataArray;
    
    self.headView.scrollView.contentOffset = CGPointMake(self.pageSelect * ScreenW, 0);
    self.headView.pageControl.currentPage = self.pageSelect;

    self.headView.scrollBlock = ^(NSInteger index) {
        
        ALMessageModel * selectModel = weakSelf.dataArray[index];

        for (int i = 0;i< weakSelf.allDataArray.count;i++) {
            NSDictionary * dict = weakSelf.allDataArray[i];
            if ([[NSString stringWithFormat:@"%@",[dict[@"info"] firstObject][@"id"]] isEqualToString:selectModel.ID]) {
                weakSelf.dataDocArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"doctors"]];
                weakSelf.dataAppArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"doctorAppoints"]];;
                [weakSelf.dataArray addObjectsFromArray:[ALMessageModel mj_objectArrayWithKeyValuesArray:dict[@"info"]]];
                weakSelf.headView.dataDocArray = weakSelf.dataDocArray;
                [weakSelf.tableView reloadData];
            }
           
        }
        
        
    };
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataAppArray.count > 0) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 20+45 + self.dataAppArray.count*79;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCHomeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"123456";
    cell.typeCell = 1;
//    cell.isHiddenMoreImagV = YES;
    cell.titleStr = @"健康日志";
    cell.dataArray = self.dataAppArray;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    CGFloat HH = 130 ;
    
    CGFloat offsetY = point.y;
    
    CGFloat alpha = (offsetY + 64) / HH > 1.0f ? 1 : ((offsetY + 64)/ HH);
    
    if (point.y <= -64) {
        
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else {
        
        UIImage * img = [PublicFuntionTool  imageWithColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1"]] colorWithAlphaComponent:alpha]];
        
        [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
    }
    
}

#pragma mark ---- 点击cell -----
- (void)didClickALCHomeCell:(ALCHomeCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (isClickHead) {
       
            ALCJianKangRiZhiTVC * vc =[[ALCJianKangRiZhiTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isComeMineMY = YES;
            vc.dataArray = self.dataAppArray;
            [self.navigationController pushViewController:vc animated:YES];
       
    }else {
        
            ALCJianKangRiZhiDetailTVC * vc =[[ALCJianKangRiZhiDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataAppArray[index].ID;
            [self.navigationController pushViewController:vc animated:YES];
       
    }
    
    
}




@end
