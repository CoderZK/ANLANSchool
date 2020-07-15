//
//  ALCJianKangTiXingHeadView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCJianKangTiXingHeadView : UIView
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)XMCalendarView *calendarV;
@property(nonatomic,strong)UIButton *leftBt,*centerBt,*rightBt;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,assign)CGFloat hh;
@property(nonatomic,strong)NSDate *centerDate;

@property(nonatomic,copy)void(^sendBlockDate)(NSDate *selectDate, BOOL isAllMonth);

@end

NS_ASSUME_NONNULL_END
