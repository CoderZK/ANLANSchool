//
//  XMCalendarView.h
//  日历
//
//  Created by RenXiangDong on 17/3/27.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "XMCalendarDataSource.h"
#import "XMCalendarDataSource.h"
#import "XMCalendarManager.h"

@protocol XMCalendarViewDelegate <NSObject>

- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel;

@end

@interface XMCalendarView : UIView
@property (assign , nonatomic) BOOL isToday,isSelctToday;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) XMCalendarDataSource *dataSourceModel;
@property (nonatomic, strong) XMCalendarManager *calendarManager;
@property (nonatomic, weak)id<XMCalendarViewDelegate>delegate;
@property (nonatomic, assign) BOOL isAddToCalendar;

@property(nonatomic,assign)BOOL isShowOneWeek;

@end
