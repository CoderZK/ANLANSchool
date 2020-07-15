//
//  ALCTiZHongLineTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCTiZHongLineTVC.h"
#import "BezierCurveView.h"
#import "ACLHeightLineHeadView.h"
#import "ALCMineBodyRecordVC.h"
@interface ALCTiZHongLineTVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)ACLHeightLineHeadView *headV;
@property(nonatomic,strong)NSMutableArray<ALMessageModel *> *dataArray;
@end

@implementation ALCTiZHongLineTVC

- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self scrollViewDidScroll:self.tableView];
    
     [self getData];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_1"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    self.tableView.backgroundColor = self.view.backgroundColor = BackgroundColor;
    
    //    BezierCurveView * bezierV = [BezierCurveView initWithFrame:CGRectMake(15, 15, ScreenW - 30, 220)];
    //    bezierV.backgroundColor = WhiteColor;
    //    bezierV.dorwColor = GreenColor;
    //    [bezierV drawMoreLineChartViewWithTargerYNames:@[@"120",@"90",@"60",@"30"] targetXNames:@[@"3.29",@"3.30",@"3.31",@"4.1",@"4.2",@"4.3",@"今天"] whitTargetValues:@[@(50),@(60),@30,@90,@120,@80,@60] withMaxY:120];
    //    [self.view addSubview:bezierV];
    //
    if (self.type == 0) {
        self.navigationItem.title = @"步数";
    }else if (self.type == 1) {
        self.navigationItem.title = @"心率";
    }else if (self.type == 2) {
        self.navigationItem.title = @"体重";
    }else if (self.type == 3) {
        self.navigationItem.title = @"血压";
    }
    
    
    self.tableView.mj_y = -sstatusHeight - 44;
    self.tableView.mj_h = ScreenH + sstatusHeight;
    self.headV = [[ACLHeightLineHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    
    
    [self.headV.jiLuBt  addTarget:self action:@selector(juLuAction:) forControlEvents:UIControlEventTouchUpInside];
    self.headV.mj_h = self.headV.hh;
    self.headV.backgroundColor = WhiteColor;
    
    self.tableView.tableHeaderView = self.headV;
    
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

    
    
    
}

- (void)juLuAction:(UIButton *)button {
    
    ALCMineBodyRecordVC * vc =[[ALCMineBodyRecordVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = self.type;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)getData {
    
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    NSString * starTimeStr = @"";
    NSString * endTimeStr = @"";
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    
    NSDateFormatter * formatterTwo = [[NSDateFormatter alloc] init];
    [formatterTwo setDateFormat:@"yyyy-MM-dd"];
    formatterTwo.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString * ymd = [formatterTwo stringFromDate:[NSDate date]];
    NSString * nowStr = [NSString stringWithFormat:@"%@ 00:00:00",ymd];
    NSDate *nowDate = [formatter dateFromString:nowStr];
    
    
    NSDate * date =  [NSDate dateWithTimeInterval:(-6*24*3600) sinceDate:nowDate];;
    starTimeStr  = [formatter stringFromDate:date];
    NSDate * endDate = [NSDate dateWithTimeInterval:(24*3600-1) sinceDate:nowDate];;
    endTimeStr =  [formatter stringFromDate:endDate];
    
    dict[@"startDate"] = starTimeStr;
    dict[@"endDate"] = endTimeStr;
    
    NSString * url = [QYZJURLDefineTool user_findWeightRecordListURL];
    if (self.type == 1) {
        url = [QYZJURLDefineTool user_findRecordheartrateURL];
    }else if (self.type == 3) {
        url = [QYZJURLDefineTool user_findRecordBloodpressureURL];
    }else if (self.type == 0) {
        url = [QYZJURLDefineTool user_findRecordStepnumberURL];
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (self.type == 1) {
                self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"heartrate"]];
                
            }else if (self.type == 2) {
                self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                
            }else if (self.type == 3) {
                self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"bloodpressure"]];
            }else if (self.type == 0) {
                
                self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                
            }
            [self.headV.bezierV drawMoreLineChartViewWithTargerYNames:[self getDanWeiArr] targetXNames:[self getDaysArr] whitTargetValues:[self getDataArr] withMaxY:[[[self getDanWeiArr] firstObject] intValue] colors:@[[UIColor orangeColor],[UIColor purpleColor]]];
            
            [self settitaction];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)settitaction {
    
    
    if (self.type == 0) {
        
        self.headV.showNumber = 2;
        self.headV.leftTopLB.text = [NSString stringWithFormat:@"%d步",[[[self getnumberArr] firstObject] intValue]];
        self.headV.leftBottomLB.text = @"平均步数";
        self.headV.rightTopLB.text = [NSString stringWithFormat:@"%0.2f公里",[[[self getnumberArr] firstObject] floatValue] * 0.6/1000];
        self.headV.rightBottomLB.text = @"平均公里数";
        
        
    } else  if (self.type == 1) {
        
        self.headV.showNumber = 1;
        self.headV.centerTopLB.text = [NSString stringWithFormat:@"%d次/分",[[[self getnumberArr] firstObject] intValue]];
        self.headV.centerBottomLB.text = @"平均";
        
    }else if (self.type == 2) {
        
        self.headV.showNumber = 1;
        self.headV.centerTopLB.text = [NSString stringWithFormat:@"%@kg",[[self getnumberArr] firstObject]];
        self.headV.centerBottomLB.text = @"平均体重";
        
        
        
    }else if (self.type == 3) {
        
        
        self.headV.showNumber = 2;
        self.headV.leftTopLB.text = [NSString stringWithFormat:@"%@mmHg",[[self getnumberArr] firstObject]];
        self.headV.leftBottomLB.text = @"收缩压";
        self.headV.rightTopLB.text = [NSString stringWithFormat:@"%@mmHg",[[self getnumberArr] lastObject]];
        self.headV.rightBottomLB.text = @"舒张压";
        
        
    }
    
    
    
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


- (NSArray *)getDaysArr {
    
    NSMutableArray * arr = @[].mutableCopy;
    
    for (int i = 1 ; i < 7; i++) {
        NSDate * timeDate =  [NSDate dateWithTimeInterval:(-i*24*3600) sinceDate:[NSDate date]];;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:timeDate];
        int year1 = (int)[dateComponent year];
        int month1 = (int)[dateComponent month];
        int day1 = (int)[dateComponent day];
        [arr insertObject:[NSString stringWithFormat:@"%d.%d",month1,day1] atIndex:0];
    }
    [arr addObject:@"今天"];
    return arr;
}

- (NSArray *)getDataArr {
    
    NSMutableArray * arr = @[].mutableCopy;
    NSMutableArray * arrTwo = @[].mutableCopy;
    
    NSMutableArray * arrThree = @[].mutableCopy;
    NSMutableArray * arrForu = @[].mutableCopy;
    
    for (int i = 0 ; i < 7; i++) {
        NSDate * timeDate =  [NSDate dateWithTimeInterval:(-i*24*3600) sinceDate:[NSDate date]];;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:timeDate];
        int year1 = (int)[dateComponent year];
        int month1 = (int)[dateComponent month];
        int day1 = (int)[dateComponent day];
        [arrTwo insertObject:[NSString stringWithFormat:@"%d-%02d-%02d",year1,month1,day1] atIndex:0];
    }
    
    if (self.type == 3) {
        
        for (int i = 0 ; i < arrTwo.count; i++) {
            [arrThree addObject:@(0)];
            [arrForu addObject:@(0)];
            for (int j = 0 ; j<self.dataArray.count; j++) {
                if ([self.dataArray[j].record_date isEqualToString:arrTwo[i]]) {
                    [arrThree removeLastObject];
                    [arrThree addObject:@([self.dataArray[j].systolic intValue])];
                    
                    [arrForu removeLastObject];
                    [arrForu addObject:@([self.dataArray[j].diastolic intValue])];
                    
                    break;
                }
                
            }
        }
        return @[arrThree,arrForu];
    }else {
        
        for (int i = 0 ; i < arrTwo.count; i++) {
            [arr addObject:@(0)];
            for (int j = 0 ; j<self.dataArray.count; j++) {
                
                if (self.type == 0) {
                    if ([self.dataArray[j].record_date isEqualToString:arrTwo[i]]) {
                        [arr removeLastObject];
                        [arr addObject:@([self.dataArray[j].stepnumber intValue])];
                        break;
                    }
                } else  if (self.type == 1) {
                    
                    if ([self.dataArray[j].record_date isEqualToString:arrTwo[i]]) {
                        [arr removeLastObject];
                        [arr addObject:@([self.dataArray[j].average_rate intValue])];
                        break;
                    }
                    
                    
                }else if (self.type == 2) {
                    if ([self.dataArray[j].recordDate isEqualToString:arrTwo[i]]) {
                        [arr removeLastObject];
                        [arr addObject:@([self.dataArray[j].weight intValue])];
                        break;
                    }
                    
                }
                
            }
        }
        return @[arr];
    }
    
}

- (NSArray *)getDanWeiArr {
    NSMutableArray * arr = @[].mutableCopy;
    CGFloat max = 0;
    for (int i = 0 ; i <self.dataArray.count; i++) {
        if (self.type == 3) {
            if (max <[self.dataArray[i].diastolic floatValue]) {
                max = [self.dataArray[i].diastolic floatValue];
            }
        }else if (self.type == 2) {
            if (max <[self.dataArray[i].weight floatValue]) {
                max = [self.dataArray[i].weight floatValue];
            }
        }else if (self.type == 1){
            if (max <[self.dataArray[i].average_rate floatValue]) {
                max = [self.dataArray[i].average_rate floatValue];
            }
        }else if (self.type == 0) {
            if (max <[self.dataArray[i].stepnumber floatValue]) {
                max = [self.dataArray[i].stepnumber floatValue];
            }
        }
        
    }
    
    if (max == 0) {
        return @[@"120",@"90",@"60",@"30"];
    }
    int mmm = 0;
    if ((int)max % 40 == 0) {
        mmm =  (int)max;
    }else {
        mmm = (int)max + 40 - (int)max%40;
    }
    return @[[NSString stringWithFormat:@"%d",mmm],[NSString stringWithFormat:@"%d",(mmm/4)*3],[NSString stringWithFormat:@"%d",(mmm/4) * 2],[NSString stringWithFormat:@"%d",mmm/4]];
}

- (NSArray *)getnumberArr {
    
    CGFloat a1 = 0.0;
    CGFloat a2 = 0.0;
    CGFloat all = 0.0;
    CGFloat all2 = 0.0;
    for (int i  = 0 ; i < self.dataArray.count; i++) {
        
        if (self.type == 0) {
            all = all + [self.dataArray[i].stepnumber floatValue];
        } else  if (self.type == 1) {
            all = all + [self.dataArray[i].average_rate floatValue];
        }else if (self.type == 2) {
            all = all + [self.dataArray[i].weight floatValue];
        }else if (self.type == 3) {
            all = all + [self.dataArray[i].systolic floatValue];
            all2 = all2 + [self.dataArray[i].diastolic floatValue];
        }
        
        
    }
    a1 = all / self.dataArray.count;
    a2 = all2 / self.dataArray.count;
    
    
    
    if (self.type == 0) {
        return @[[NSString stringWithFormat:@"%0.1f",all==0 ? 0:a1]];
    } else if (self.type == 1) {
        return @[[NSString stringWithFormat:@"%0.1f",all==0 ? 0:a1]];
    }else if (self.type == 2) {
        return @[[NSString stringWithFormat:@"%0.1f",all==0 ? 0:a1]];
    }else if (self.type == 3) {
        return @[[NSString stringWithFormat:@"%0.1f",all==0 ? 0:a1],[NSString stringWithFormat:@"%0.1f",all==0 ? 0:a2]];
    }else {
        return @[@0];
    }
    
}

@end
