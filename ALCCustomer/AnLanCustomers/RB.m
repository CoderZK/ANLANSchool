//
//  RB.m
//  AnLanCustomers
//
//  Created by zk on 2020/5/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "RB.h"

@implementation RB

//- (void)getDisan {
//    HealthKitManage *manage = [HealthKitManage shareInstance];
//    [manage authorizeHealthKit:^(BOOL success, NSError *error) {
//
//        if (success) {
//
//            [manage getStepCount:^(double value, NSError *error) {
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //在此处可以获取步数 ---- value
//                    NSLog(@"%f",value);
//                    self.numberTep = [NSString stringWithFormat:@"%0.0f/10000",value];
//                    [self.tableView reloadData];
//                });
//
//            }];
//        }
//        else {
//            NSLog(@"fail");
//        }
//    }];
//
//}

//- (void)getDataWithAllMonth{
//
//    NSString * starTimeStr = @"";
//    NSString * endTimeStr = @"";
//
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
//
//    NSDateFormatter * formatterTwo = [[NSDateFormatter alloc] init];
//    [formatterTwo setDateFormat:@"yyyy-MM-dd"];
//    formatterTwo.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
//    NSString * ymd = [formatterTwo stringFromDate:[NSDate date]];
//    NSString * nowStr = [NSString stringWithFormat:@"%@ 00:00:00",ymd];
//    NSDate *nowDate = [formatter dateFromString:nowStr];
//
//
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//       NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
//    comps = [calendar components:unitFlags fromDate:[NSDate date]];
//    NSInteger week = [comps weekday]; // 周日-周六 0-6
//
//    //周六 周日 周一
//    // 0   1   2
//    double xiangQ = 0;
//    double xiangH = 0;
//    if (week == 0) {
//        xiangQ = 6 * 3600 * 24;
//        xiangH = 3600 * 24-1;
//    }else if (week == 1) {
//        xiangQ = 0;
//        xiangH = 7* 3600 * 24-1;
//    }else {
//        xiangQ = (week - 1) * 3600*24;
//        xiangH = (8 - week) *  3600*24 -1;
//    }
//
//    NSDate * date =  [NSDate dateWithTimeInterval:(-xiangQ) sinceDate:nowDate];;
//    starTimeStr  = [formatter stringFromDate:date];
//    NSDate * endDate = [NSDate dateWithTimeInterval:xiangH sinceDate:nowDate];;
//    endTimeStr =  [formatter stringFromDate:endDate];
//
//
//    [SVProgressHUD show];
//    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"startDate"] = starTimeStr;
//    dict[@"endDate"] = endTimeStr;
//
//    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_findUserBriefCalenderURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [SVProgressHUD dismiss];
//        if ([responseObject[@"key"] intValue]== 1) {
//
//
//                self.dataArray = [ALMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//                NSMutableArray * timeArr = @[].mutableCopy;
//                for (ALMessageModel * model  in self.dataArray) {
//                    if (model.scheduleDate.length >= 10) {
//                        [timeArr addObject:[model.scheduleDate substringToIndex:10]];
//                    }
//
//                }
//
//            self.headView.model = [self getModelWithTimeStr:[formatterTwo stringFromDate:[NSDate date]]];
//            self.headView.mj_h = self.headView.hh;
//            self.tableView.tableHeaderView = self.headView;
//
//                for (XMCalendarModel * dayModel in self.headView.calendarV.dataSourceModel.dataSource) {
//                    NSDateFormatter * df = [[NSDateFormatter alloc]init];
//                    [df setDateFormat:@"yyyy-MM-dd"];
//                    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
//
//                    NSString * timeDateSourceStr = [df stringFromDate:dayModel.date];
//                    if ([timeArr containsObject:timeDateSourceStr]) {
//                        dayModel.isAllReady = YES;
//                    }
//                }
//                self.headView.calendarV.dataSourceModel = self.headView.calendarV.dataSourceModel;
//                [self.headView.calendarV.collectionView reloadData];
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
//
//
//
//}


@end
