//
//  ALCAddCalendarView.h
//  AnLanBB
//
//  Created by zk on 2020/4/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCAddCalendarView : UIView
@property(nonatomic,strong)XMCalendarView *calendarV;
@property(nonatomic,strong)UIView *whiteV,*whiteTwoV,*blackView;
@property(nonatomic,strong)UIPickerView *pickView;
@property(nonatomic,strong)UIButton *chooseBt,*chaBt;
@property(nonatomic,strong)UIButton *leftOneBt,*leftTwoBt,*rightOnebt,*rightTwoBt;
@property(nonatomic,copy)void(^sendTimeBlock)(NSString * timeStr,BOOL isCancel);
- (void)diss;
- (void)show;

@end

NS_ASSUME_NONNULL_END
