//
//  ALCJianKangTiXingHeadView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangTiXingHeadView.h"

@interface ALCJianKangTiXingHeadView()<XMCalendarViewDelegate>

@end

@implementation ALCJianKangTiXingHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 210+sstatusHeight + 44)];
        self.imgV.image = [UIImage imageNamed:@"jkgl03"];
        [self addSubview:self.imgV];
        self.imgV.contentMode = UIViewContentModeScaleToFill;
        
        // 160 日历的开始
        // 灰色背景图 结束 240
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(15, 50+sstatusHeight + 44, ScreenW - 30, 360)];
        self.whiteV.backgroundColor = WhiteColor;
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.layer.shadowColor = [UIColor blackColor].CGColor;
        self.whiteV.layer.shadowOffset = CGSizeMake(0, 0);
        self.whiteV.layer.shadowRadius = 5;
        self.whiteV.layer.shadowOpacity = 0.08;
        [self addSubview:self.whiteV];
        
        
        
        
        self.hh = CGRectGetMaxY(self.whiteV.frame) + 10;
        self.calendarV = [[XMCalendarView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW-30 , 360)];
        self.calendarV.isAddToCalendar = NO;
        self.calendarV.layer.cornerRadius = 5;
        self.calendarV.clipsToBounds = YES;
        self.calendarV.delegate = self;
        [self.whiteV addSubview:self.calendarV];
        
        UISwipeGestureRecognizer * leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        [self.calendarV addGestureRecognizer:leftSwipeGestureRecognizer];
        UISwipeGestureRecognizer * rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self.calendarV addGestureRecognizer:leftSwipeGestureRecognizer];
        [self.calendarV addGestureRecognizer:rightSwipeGestureRecognizer];

        
        
        
        NSInteger month = [[[XMCalendarTool alloc] init] getMonthIndate:[NSDate date]];
        NSInteger year = [[[XMCalendarTool alloc] init] getYearInDate: [NSDate date]];
        NSString * yearTwo = [[NSString stringWithFormat:@"%ld",(long)year] substringWithRange:NSMakeRange([NSString stringWithFormat:@"%ld",(long)year].length - 1, 1)];
        NSInteger yearTh  = year;
        if (month == 12) {
            yearTh = year+1;
        }
        self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44 + 10, 120, 30)];
        [self.leftBt setTitleColor:CharacterBack150 forState:UIControlStateNormal];
        self.leftBt.titleLabel.font= kFont(14);
        self.leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
       
        
        [self.leftBt setTitle:[NSString stringWithFormat:@"%@年%ld月",yearTwo,(long)month] forState:UIControlStateNormal];
        [self addSubview:self.leftBt];
        self.leftBt.tag = 100;
        [self.leftBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 120, sstatusHeight + 44 + 10, 120, 30)];
        [self.rightBt setTitleColor:CharacterBack150 forState:UIControlStateNormal];
        self.rightBt.titleLabel.font= kFont(14);
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        
        
        [self.rightBt setTitle:[NSString stringWithFormat:@"%ld年",yearTh] forState:UIControlStateNormal];
        [self addSubview:self.rightBt];
        self.rightBt.tag = 101;
        [self.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.centerBt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 120)/2, sstatusHeight + 44 + 10, 120, 30)];
        [self.centerBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.centerBt.titleLabel.font= kFont(14);
        
        
        [self.centerBt setTitle:[NSString stringWithFormat:@"%ld年%ld月",year,month] forState:UIControlStateNormal];
        [self addSubview:self.centerBt];
        
        self.backgroundColor = WhiteColor;
    }
    return self;
}

- (void)setCenterDate:(NSDate *)centerDate {
    _centerDate = centerDate;
    
//    NSInteger month = [[[XMCalendarTool alloc] init] getMonthIndate:centerDate];
//    NSInteger year = [[[XMCalendarTool alloc] init] getYearInDate: centerDate];
//    NSString * yearTwo = [[NSString stringWithFormat:@"%ld",(long)year] substringWithRange:NSMakeRange([NSString stringWithFormat:@"%ld",(long)year].length - 1, 1)];
//    NSInteger yearTh  = year;
//    if (month == 12) {
//         yearTh = year+1;
//    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    
    NSDate * preDate = [[[XMCalendarTool alloc] init] getPreMonthFirstDateWithDate:centerDate];
    NSDate * nextDate =  [[[XMCalendarTool alloc] init] getNextMonthFirstDateWithDate:centerDate];

    
    [self.leftBt setTitle:[NSString stringWithFormat:@"%@",[formatter stringFromDate:preDate]] forState:UIControlStateNormal];
    [self.rightBt setTitle:[NSString stringWithFormat:@"%@",[formatter stringFromDate:nextDate]] forState:UIControlStateNormal];
    [self.centerBt setTitle:[NSString stringWithFormat:@"%@",[formatter stringFromDate:centerDate]] forState:UIControlStateNormal];
    
    
}

- (CGFloat)hh {
    if (self.calendarV.dataSourceModel.dataSource.count > 35 && self.calendarV.dataSourceModel.dataSource[35].date != nil) {
        self.whiteV.mj_h = 360;
        self.calendarV.mj_h = 360;
    }else {
       self.whiteV.mj_h = 320;
        self.calendarV.mj_h = 320;
    }
    return CGRectGetMaxY(self.whiteV.frame) + 10;
}


- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel {
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
//    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString * day = [df stringFromDate:calendarModel.date];
    //选中日期

    if (self.sendBlockDate != nil) {
        self.sendBlockDate(calendarModel.date,NO);
    }
    
}

- (void)action:(UIButton *)button {
    [self changeDataWithType:button.tag];
}

// 100 向钱 // 101 向后
- (void)changeDataWithType:(NSInteger )type {
    if (type == 100) {
        XMCalendarManager * manager = self.calendarV.calendarManager;
        XMCalendarDataSource * dd = [manager preMonth];
        self.calendarV.dataSourceModel = dd;
        self.centerDate = [[[XMCalendarTool alloc] init] getPreMonthFirstDateWithDate:self.centerDate];
        if (self.sendBlockDate != nil) {
            self.sendBlockDate(self.centerDate,YES);
        }
    }else {
        XMCalendarManager * manager = self.calendarV.calendarManager;
        XMCalendarDataSource * dd = [manager nextMonth];
        self.calendarV.dataSourceModel = dd;
        self.centerDate =  [[[XMCalendarTool alloc] init] getNextMonthFirstDateWithDate:self.centerDate];
        if (self.sendBlockDate != nil) {
            self.sendBlockDate(self.centerDate,YES);
        }
    }
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)swipeshand {
    if (swipeshand.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self changeDataWithType:101];
    }else if (swipeshand.direction == UISwipeGestureRecognizerDirectionRight) {
        [self changeDataWithType:100];
    }
    
    
}


@end
