//
//  HomeVC.m
//  AnLanCustomers
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HomeVC.h"
#import "ALCLoginOneVC.h"
#import "ALCInquiryMessageTVC.h"
#import "ALCJianKangRiZhiTVC.h"
#import "ALCHomeHeadView.h"
#import "ALCHomeCell.h"
#import "BezierCurveView.h"
#import "ALCJianKangTiXingTVC.h"
#import "ALCDorListTVC.h"
#import "ALCJianKangRiZhiTVC.h"
#import "ALCMineBodyinformationTVC.h"
#import "ALCDorDetailOneTVC.h"
#import "ALCJianKangRiZhiDetailTVC.h"
#import "ALCTiZHongLineTVC.h"
#import "ALCJiGouTVC.h"
#import "ALCHospitalHomeTVC.h"
#import "ALCLookDetailTVC.h"
#import "ALCMineReferTVC.h"
#import "ALCTuiJianWenZhangTVC.h"
#import "ALCTiXingDetailTVC.h"
@interface HomeVC ()<UIScrollViewDelegate,XMCalendarViewDelegate,ALCHomeCellDelegate>
@property(nonatomic,strong)UIButton *editBt;
@property(nonatomic,strong)ALCHomeHeadView *headView;
//@property (nonatomic , strong) XMCalendarView * calendarView;
@property(nonatomic,strong)NSString *numberTep;
@property(nonatomic,strong)XMCalendarTool *XMTool;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;


@property(nonatomic,strong)ALMessageModel *dataModel;
@property(nonatomic,strong)ALMessageModel *lineDataModel;

@end

@implementation HomeVC

- (XMCalendarTool *)XMTool {
    if (_XMTool == nil) {
        _XMTool = [[XMCalendarTool alloc] init];
    }
    return _XMTool;
}


- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self scrollViewDidScroll:self.tableView];
    
    [self.tableView reloadData];
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    [self getData];
    [self getConfigion];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_1"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[JZTouchIDManager shareManager] openTouchId:NO];
    
    
    [self setHeadView];
    [self.tableView registerClass:[ALCHomeCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setheadViewVV];
    
    self.numberTep = @"";
    self.dataArray = @[].mutableCopy;
    
    //    [self getDisan];
    //    [self getDataWithAllMonth];
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self getLineChart];
        //       [self getDataWithAllMonth];
    }];


    [self getLineChart];
    
}

- (void)getConfigion {
    
    [zkRequestTool networkingPOST:appB_productStatus parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            if  ([responseObject[@"data"] integerValue] == 0) {
                [zkSignleTool shareTool].isUp = YES;
            }else {
                [zkSignleTool shareTool].isUp = NO;
            }
            
            
            
        }else {
           
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
    
}


- (void)getLineChart {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:user_lineChart parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.lineDataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}

- (void)getData {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findIndexDataURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            self.dataModel = [ALMessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.headView.headModel = self.dataModel.userInfo;
            
            self.dataArray = self.dataModel.calenderSchedule;
            NSMutableArray * timeArr = @[].mutableCopy;
            for (ALMessageModel * model  in self.dataArray) {
                if (model.scheduleDate.length >= 10) {
                    [timeArr addObject:[model.scheduleDate substringToIndex:10]];
                }
                
            }
            NSDateFormatter * formatterTwo = [[NSDateFormatter alloc] init];
            [formatterTwo setDateFormat:@"yyyy-MM-dd"];
            formatterTwo.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
            self.headView.model = [self getModelWithTimeStr:[formatterTwo stringFromDate:[NSDate date]]];
            self.headView.mj_h = self.headView.hh;
            self.tableView.tableHeaderView = self.headView;
            
            for (XMCalendarModel * dayModel in self.headView.calendarV.dataSourceModel.dataSource) {
                NSDateFormatter * df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"yyyy-MM-dd"];
                df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
                
                NSString * timeDateSourceStr = [df stringFromDate:dayModel.date];
                if ([timeArr containsObject:timeDateSourceStr]) {
                    dayModel.isAllReady = YES;
                }else {
                    dayModel.isAllReady = NO;
                }
            }
            self.headView.calendarV.dataSourceModel = self.headView.calendarV.dataSourceModel;
            [self.headView.calendarV.collectionView reloadData];
            
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
    self.tableView.mj_h = ScreenH + sstatusHeight;
    self.headView = [[ALCHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    self.headView.clipsToBounds = YES;
    self.headView.calendarV.delegate = self;
    
    @weakify(self);
    [[self.headView.moreBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        ALCJianKangTiXingTVC * vc =[[ALCJianKangTiXingTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    Weak(weakSelf);
    self.headView.clickBlock = ^(ALMessageModel * _Nonnull model) {
        ALCTiXingDetailTVC * vc =[[ALCTiXingDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dataModel = model;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };

    
    [[self.headView.xunWenBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        if (self.dataModel.userInfo.consult == 0) {
            self.tabBarController.selectedIndex = 1;
        }else {
            //我的咨询
            ALCMineReferTVC * vc =[[ALCMineReferTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    self.tableView.tableHeaderView = self.headView;
}


- (void)setHeadView {
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 70, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = YES;
    self.navigationItem.titleView = searchTitleView;
    
//    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
//        @strongify(self);
//        if (value.length > 0) {
//            return YES;
//        }else {
//            return NO;
//        }
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"======\n%@",x);
//    }];
    
    @weakify(self);
    [[searchTitleView.clickBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           ALCMineSearchTVC * vc =[[ALCMineSearchTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
           
       }];
    
    
    
    self.navigationItem.titleView = searchTitleView;
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 44, 44)];
    //    submitBtn.layer.cornerRadius = 22;
    //    submitBtn.layer.masksToBounds = YES;
    // [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [submitBtn showViewWithColor:[UIColor redColor]];
    
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.editBt = submitBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataModel == nil) {
        return 0;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //健康信息
        return 20+45 + 4*80;
    }else if (indexPath.row == 1) {
        //健康日志
        if (self.dataModel.doctorAppointment.count == 0) {
            return 0;
        }
        return 20+45 + self.dataModel.doctorAppointment.count*79;
    }else if (indexPath.row == 2) {
        //推荐医生
        if (self.dataModel.recommendDoctorList.count == 0) {
            return 0;
        }
        
        return 20+45 + self.dataModel.recommendDoctorList.count* 134;
    }else if (indexPath.row == 3) {
        //曾经就诊机构
        if (self.dataModel.appoinmentHistory.count == 0) {
            return 0;
        }
        return 20+45+self.dataModel.appoinmentHistory.count*90;
    }else if (indexPath.row == 4){
        if (self.dataModel.articleList.count == 0) {
            return 0;
        }
        return 20+45 + self.dataModel.articleList.count * 90;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCHomeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"123456";
    cell.typeCell = indexPath.row;
    if (indexPath.row == 0 ) {
        cell.titleStr = @"身体数据";
        cell.dataArray = @[@"",@"",@"",@""].mutableCopy;
        cell.model = self.dataModel.healthdata;
        cell.lineDateModel = self.lineDataModel;
    }else if (indexPath.row == 1) {
        cell.titleStr = @"健康日志";
        cell.dataArray = self.dataModel.doctorAppointment;
    }else  if (indexPath.row == 2){
        cell.titleStr = @"推荐医生";
        cell.dataArray = self.dataModel.recommendDoctorList;
    }else  if (indexPath.row == 3){
        cell.titleStr = @"曾经就诊机构";
        cell.dataArray = self.dataModel.appoinmentHistory;
    }else  if (indexPath.row == 4){
        cell.titleStr = @"推荐文章";
        cell.dataArray = self.dataModel.articleList;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.clipsToBounds = YES;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    //    ALCInquiryMessageTVC * vc =[[ALCInquiryMessageTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    ALCJianKangRiZhiTVC * vc =[[ALCJianKangRiZhiTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)submitBtnClick:(UIButton *)button {
    
    
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    ACLMineMessageTVC * vc =[[ACLMineMessageTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

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
    //0@"身体数据";1@"健康日志";2@"推荐医生";3@"曾经就诊机构";4@"推荐文章";
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (isClickHead) {
        if (indexPath.row == 0) {
            
            ALCMineBodyinformationTVC * vc =[[ALCMineBodyinformationTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            ALCJianKangRiZhiTVC * vc =[[ALCJianKangRiZhiTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2){
            ALCDorListTVC * vc =[[ALCDorListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isComeHome = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
           ALCTuiJianWenZhangTVC * vc =[[ALCTuiJianWenZhangTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
           vc.hidesBottomBarWhenPushed = YES;
           vc.isWenZhang = NO;
           [self.navigationController pushViewController:vc animated:YES];
//            self.tabBarController.selectedIndex = 1;
        }else if (indexPath.row == 4) {
            
            ALCTuiJianWenZhangTVC * vc =[[ALCTuiJianWenZhangTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isWenZhang = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else {
        if (indexPath.row == 0) {
            
            ALCTiZHongLineTVC * vc =[[ALCTiZHongLineTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.type = index;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 1) {
            ALCJianKangRiZhiDetailTVC * vc =[[ALCJianKangRiZhiDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataModel.doctorAppointment[index].ID;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2){
            ALCDorDetailOneTVC * vc =[[ALCDorDetailOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.doctorId = self.dataModel.recommendDoctorList[index].ID;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
            ALCHospitalHomeTVC * vc =[[ALCHospitalHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.institutionId = self.dataModel.appoinmentHistory[index].ID;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row == 4) {
            
            ALCLookDetailTVC * vc =[[ALCLookDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataModel.articleList[index].ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    
}


- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel {
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * day = [df stringFromDate:calendarModel.date];
    //选中日期
    NSLog(@"day----\n%@",day);
    self.headView.model = [self getModelWithTimeStr:day];
    self.headView.mj_h = self.headView.hh;
    self.tableView.tableHeaderView = self.headView;
}

- (ALMessageModel *)getModelWithTimeStr:(NSString *)timeStr {
    
    for (ALMessageModel * model  in self.dataArray) {
        if (model.scheduleDate.length >= 10) {
            if ([[model.scheduleDate substringToIndex:10] isEqualToString:timeStr]) {
                return model;
            }
        }
    }
    return nil;
}

@end
