//
//  XMCalendarManager.h
//  日历
//
//  Created by RenXiangDong on 17/3/28.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMCalendarDataSource.h"

@interface XMCalendarManager : NSObject

- (NSIndexPath *)currentDayIndexPath;

- (XMCalendarDataSource *)currentMonth;

- (XMCalendarDataSource *)nextMonth;

- (XMCalendarDataSource *)preMonth;

- (XMCalendarDataSource *)nextYear;

- (XMCalendarDataSource *)preYear;


@property (nonatomic, strong) NSDate *firstDate;//所选月份第一天
@property (nonatomic, assign) NSInteger firstDayWeak;//第一天所在的星期数


@end
