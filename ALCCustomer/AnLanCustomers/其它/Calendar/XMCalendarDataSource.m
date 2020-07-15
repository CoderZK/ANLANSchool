//
//  XMCalendarDataSource.m
//  日历
//
//  Created by RenXiangDong on 17/3/28.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//

#import "XMCalendarDataSource.h"

@implementation XMCalendarDataSource

- (NSMutableArray<XMCalendarModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSString *)topTitle {
    NSDate * date = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear;
    NSDateComponents *d = [cal components:unitFlags fromDate:date];
    NSInteger year = d.year;
    if (year == self.year) {
        return [NSString stringWithFormat:@"%ld月",(long)self.month];
    }
    return  [NSString stringWithFormat:@"%ld年%ld月",(long)self.year,(long)self.month];
}

@end
