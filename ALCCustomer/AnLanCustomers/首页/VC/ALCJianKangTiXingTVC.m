


//
//  ALCJianKangTiXingTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangTiXingTVC.h"
#import "ALCJianKangTiXingHeadView.h"
#import "ALCJianKangTiXingHomeCell.h"
#import "ALCTiXingDetailTVC.h"
#import "ALCAddCalendarView.h"
@interface ALCJianKangTiXingTVC ()<UIScrollViewDelegate,ALCJianKangTiXingHomeCellDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ALCJianKangTiXingHeadView *headV;
@property(nonatomic,strong)UIButton *faBuBt,*calaerBt;
@property(nonatomic,strong)XMCalendarTool *XMTool;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *isFinshArr;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *isNOFinshArr;
@property(nonatomic,strong)NSDate *selectDate;
@property(nonatomic,strong)ALCAddCalendarView *addCalView;
@property(nonatomic,strong)NSString *timeStr;

@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UITextField *TF;

@property(nonatomic,strong)UIView *wwView;


@end

@implementation ALCJianKangTiXingTVC

- (UIView *)wwView {
    if (_wwView == nil) {
        _wwView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _wwView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [[UIApplication sharedApplication].keyWindow addSubview:_wwView];
        
        [_wwView addSubview:self.whiteView];
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, ScreenW, ScreenH - 100);
        [_wwView addSubview:button];
        [button addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        
        
        _wwView.hidden = YES;
    }
    return _wwView;
}

- (XMCalendarTool *)XMTool {
    if (_XMTool == nil) {
        _XMTool = [[XMCalendarTool alloc] init];
    }
    return _XMTool;
}

- addCalView {
    if (_addCalView == nil) {
        _addCalView = [[ALCAddCalendarView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    }
    return _addCalView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self scrollViewDidScroll:self.tableView];
    self.faBuBt.hidden = NO;
    
    
    [self getDataWithStarTime:nil  isAllMonth:YES];
    [self getDataWithStarTime:self.selectDate  isAllMonth:NO];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_1"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    self.faBuBt.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康提醒";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideShow:) name:UIKeyboardDidHideNotification object:nil];
    
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    //     manager.enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50;
    
    
    [self addPingLunView];
    
    [self setHeadV];
    self.dataArray = @[].mutableCopy;
    self.isFinshArr = @[].mutableCopy;
    self.isNOFinshArr = @[].mutableCopy;
    
    [self.tableView registerClass:[ALCJianKangTiXingHomeCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addFaTieView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataWithStarTime:nil isAllMonth:YES];
        [self getDataWithStarTime:self.selectDate  isAllMonth:NO];
    }];
    
    self.selectDate = [NSDate date];
    
    
    
    
}



- (void)getDataWithStarTime:(NSDate *)starData  isAllMonth:(BOOL)isAllMonth{
    
    NSString * starTimeStr = @"";
    NSString * endTimeStr = @"";
    
    if (isAllMonth) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        NSDate * date = nil;
        if (starData == nil) {
            date = [self.XMTool getCurrentMonthFirstDate];
        }else {
            date = starData;
        }
        starTimeStr  = [formatter stringFromDate:date];
        NSDate * endDate = [NSDate dateWithTimeInterval:-1 sinceDate:[self.XMTool getNextMonthFirstDateWithDate:date]];
        endTimeStr =  [formatter stringFromDate:endDate];
        NSLog(@"%@",@"12334");
    }else {
        
        if (starData == nil) {
            starData = [NSDate date];
        }
        
        NSDateFormatter * formatterTwo = [[NSDateFormatter alloc] init];
        [formatterTwo setDateFormat:@"yyyy-MM-dd"];
        formatterTwo.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        NSString * ymd = [formatterTwo stringFromDate:starData];
        
        starTimeStr = [NSString stringWithFormat:@"%@ 00:00:00",ymd];
        endTimeStr =  [NSString stringWithFormat:@"%@ 23:59:59",ymd];
        
        
    }
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"startDate"] = starTimeStr;
    dict[@"endDate"] = endTimeStr;
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findUserBriefCalenderURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (isAllMonth) {
                
                self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                NSMutableArray * timeArr = @[].mutableCopy;
                for (ALMessageModel * model  in self.dataArray) {
                    if (model.scheduleDate.length >= 10) {
                        [timeArr addObject:[model.scheduleDate substringToIndex:10]];
                    }
                    
                }
                
                for (XMCalendarModel * dayModel in self.headV.calendarV.dataSourceModel.dataSource) {
                    NSDateFormatter * df = [[NSDateFormatter alloc]init];
                    [df setDateFormat:@"yyyy-MM-dd"];
                    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
                    
                    NSString * timeDateSourceStr = [df stringFromDate:dayModel.date];
                    if ([timeArr containsObject:timeDateSourceStr]) {
                        dayModel.isAllReady = YES;
                    }
                    
                }
                if (self.headV.calendarV.dataSourceModel.dataSource.count > 35 && self.headV.calendarV.dataSourceModel.dataSource[35].date != nil) {
                    self.headV.whiteV.mj_h = self.headV.calendarV.mj_h = 360;
                }else {
                    self.headV.whiteV.mj_h = self.headV.calendarV.mj_h = 320;
                }
                self.headV.mj_h = self.headV.hh;
                self.headV.calendarV.dataSourceModel = self.headV.calendarV.dataSourceModel;
                [self.headV.calendarV.collectionView reloadData];
                
            }else {
                [self.isNOFinshArr removeAllObjects];
                [self.isFinshArr removeAllObjects];
                for (ALMessageModel *  model  in  [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]) {
                    
                    if (model.scheduleDate.length >= 16) {
                        model.time = [model.remindTime substringWithRange:NSMakeRange(11, 5)];
                    }
                    if (model.isFinish) {
                        [self.isFinshArr addObject:model];
                    }else {
                        [self.isNOFinshArr addObject:model];
                    }
                }
                
                [self.tableView reloadData];
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


- (void)setHeadV{
    self.tableView.mj_y = -sstatusHeight - 44;
    self.tableView.mj_h = ScreenH + sstatusHeight + 44;
    self.headV = [[ALCJianKangTiXingHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    self.headV.centerDate = [NSDate date];
    self.headV.mj_h = self.headV.hh;
    
    Weak(weakSelf);
    self.headV.sendBlockDate = ^(NSDate * _Nonnull selectDate ,BOOL isAllMonth) {
        
        if (isAllMonth) {
            [weakSelf getDataWithStarTime:selectDate isAllMonth:YES];
        }else {
            weakSelf.selectDate = selectDate;
            [weakSelf getDataWithStarTime:selectDate isAllMonth:NO];
        }
        
        
        
    };
    self.tableView.tableHeaderView = self.headV;
}

- (void)addFaTieView {
    self.faBuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, ScreenH - 100-60, 60, 60)];
    [self.faBuBt setImage:[UIImage imageNamed:@"jkgl41"] forState:UIControlStateNormal];
    [[self.faBuBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //发帖
        [self.TF becomeFirstResponder];
        self.faBuBt.hidden = YES;
        self.wwView.hidden = NO;
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self.faBuBt];
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

- (void)addPingLunView {
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.mj_w = ScreenW ;
    self.whiteView.mj_h = 100;
    self.whiteView.mj_x = 0;
    [self.wwView addSubview:self.whiteView];
    self.whiteView.mj_y = ScreenH;
    
    self.TF = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30  , 30)];
    self.TF.font = kFont(14);
    self.TF.placeholder = @"想做点什么";
    self.TF.delegate = self;
    self.TF.returnKeyType = UIReturnKeySend;
    [self.whiteView addSubview:self.TF];
    
    UIButton * sendBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW -70, 10, 30, 30)];
    //    [sendBt setTitle:@"添加" forState:UIControlStateNormal];
    //    sendBt.titleLabel.font = kFont(14);
    [sendBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    [sendBt setImage:[UIImage imageNamed:@"jkgl44_sub"] forState:UIControlStateNormal];
    sendBt.layer.cornerRadius = 4;
    sendBt.clipsToBounds = YES;
    [sendBt addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0,50, ScreenW, 50)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:backV];
    backV.layer.cornerRadius = 3;
    backV.clipsToBounds = YES;
    [self.whiteView addSubview:backV];
    
    UIButton * calenderBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 200, 30)];
    [calenderBt setImage:[UIImage imageNamed:@"jkgl43"] forState:UIControlStateNormal];
    calenderBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [calenderBt addTarget:self action:@selector(calenderaction:) forControlEvents:UIControlEventTouchUpInside];
    calenderBt.titleLabel.font = kFont(14);
    [calenderBt setTitleColor:GreenColor forState:UIControlStateNormal];
    [backV addSubview:sendBt];
    [backV addSubview:calenderBt];
    self.calaerBt = calenderBt;
    
    
}


// 键盘已经出现
- (void)keyboardDidShow:(NSNotification *)notification {
    
    self.wwView.hidden = NO;
    NSDictionary * userInfo = notification.userInfo;
    NSValue * value =[userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGRect bounds =[value CGRectValue];
    
    self.whiteView.mj_y = ScreenH - bounds.size.height - 100 ;
    
}

// 键盘已经隐藏
- (void)keyboardDidHideShow:(NSNotification *)notification {
    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    CGFloat keyboardHeight = keyboardFrame.origin.y;
    if (sstatusHeight > 20) {
        self.whiteView.mj_y = ScreenH - 100  - 34 ;
    }else {
        self.whiteView.mj_y = ScreenH - 100  ;
    }
    
    
}

- (void)diss {
    [self.TF resignFirstResponder];
    
    self.wwView.hidden = YES;
    self.faBuBt.hidden = NO;
}

- (void)calenderaction:(UIButton *)button {
    [self.addCalView show];
    [self.TF resignFirstResponder];
    Weak(weakSelf);
    self.addCalView.sendTimeBlock = ^(NSString * _Nonnull timeStr,BOOL isCancel) {
        weakSelf.wwView.hidden = NO;
        if (isCancel) {
            weakSelf.wwView.hidden = NO;
            weakSelf.faBuBt.hidden = YES;
        }else {
            weakSelf.timeStr = timeStr;
            [weakSelf.calaerBt setTitle:timeStr forState:UIControlStateNormal];
        }
        
    };
    
}
//点击日历
- (void)picAction:(UIButton *)button {
    
    [self.addCalView show];
    //    [self addPict];
    
}

//点击添加
- (void)sendAction:(UIButton *)button {
    
    if (self.TF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [self textFieldShouldReturn:self.TF];
    
}


//点击发送
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self addCalaer];
    
    return YES;
}

- (void)addCalaer {
    
    if (!isDidLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSDateFormatter * formatterTwo = [[NSDateFormatter alloc] init];
    [formatterTwo setDateFormat:@"yyyy-MM-dd"];
    formatterTwo.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString * ymd = [formatterTwo stringFromDate:[NSDate date]];
    dict[@"scheduleDate"] =  [NSString stringWithFormat:@"%@ 00:00:00",ymd];
    dict[@"remindTime"] = self.timeStr;
    
    dict[@"content"] = self.TF.text;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_doCalenderRecordURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加日历成功"];
            self.wwView.hidden = YES;
            self.faBuBt.hidden = NO;
            [self.TF resignFirstResponder];
            [self getDataWithStarTime:nil  isAllMonth:YES];
            [self getDataWithStarTime:self.selectDate isAllMonth:NO];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.isNOFinshArr.count > 0) {
            return 20+40 + 47 * self.isNOFinshArr.count;
        }else {
            return 0;
        }
    }else {
        if (self.isFinshArr.count > 0) {
            return 20+40 + 47 * self.isFinshArr.count;
        }else {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCJianKangTiXingHomeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    cell.isFinish = indexPath.row;
    if (indexPath.row ==0 ) {
        cell.dataArray = self.isNOFinshArr;
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MM月dd日"];
        NSString * str  = [df stringFromDate:self.selectDate];
        cell.titleStr = [NSString stringWithFormat:@"%@",str];
    }else {
        cell.dataArray = self.isFinshArr;
        cell.titleStr = @"已发送";
    }
    
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (void)didClickALCJianKangTiXingHomeCell:(ALCJianKangTiXingHomeCell *)cell withIndex:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        
        if (index >= 10000) {
            //点击的是操作
            
            [self optionActionWithinID:self.isNOFinshArr[index - 10000].ID];
            
        }else {
            //跳转到详情
//            ALCTiXingDetailTVC * vc =[[ALCTiXingDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.dataModel = self.isNOFinshArr[index];
//            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }else  {
        if (index >= 10000) {
            //点击的是操作
            
            [self optionActionWithinID:self.isFinshArr[index - 10000].ID];
            
        }else {
            
            //跳转到详情
            ALCTiXingDetailTVC * vc =[[ALCTiXingDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.dataModel = self.isFinshArr[index];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }
    
}

- (void)optionActionWithinID:(NSString *)ID {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"calenderId"] = ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_markCalenderURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [self getDataWithStarTime:self.selectDate isAllMonth:NO];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


@end


