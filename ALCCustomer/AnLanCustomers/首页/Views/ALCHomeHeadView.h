//
//  ALCHomeHeadView.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCHomeHeadView : UIView
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIButton *headBt,*xunWenBt;
@property(nonatomic,strong)UILabel *weithLB,*BMILB,*nameLB;
@property(nonatomic,strong)UIView *whiteV,*lineV;
@property(nonatomic,strong)XMCalendarView *calendarV;
@property(nonatomic,strong)UIButton *moreBt;
@property(nonatomic,strong)UILabel *monthLB;
@property(nonatomic,strong)UIButton *gouBt;
//@property(nonatomic,strong)UIButton *godetailBt;
@property(nonatomic,strong)UILabel *tijianLB,*timeLB;

@property(nonatomic,assign)CGFloat hh;

@property(nonatomic,copy)void(^sendHomeBlockDate)(NSDate *selectDate);
@property(nonatomic,copy)void(^clickBlock)(ALMessageModel *model);

@property(nonatomic,strong)ALMessageModel *model;

@property(nonatomic,strong)ALMessageModel *headModel;


@end

NS_ASSUME_NONNULL_END
