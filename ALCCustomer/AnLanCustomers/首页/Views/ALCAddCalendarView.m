//
//  ALCAddCalendarView.m
//  AnLanBB
//
//  Created by zk on 2020/4/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCAddCalendarView.h"

@interface ALCAddCalendarView()<XMCalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSString *hourTimeStr,*mStr;
@property(nonatomic,strong)NSString *timeDateStr;
@property(nonatomic,strong)NSDate *centerDate;
@property(nonatomic,strong)UILabel *timeLB;

@end

@implementation ALCAddCalendarView

- (UIView *)blackView {
    if (_blackView == nil) {
        _blackView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        UIButton * bb = [[UIButton alloc] initWithFrame:self.bounds];
        [_blackView addSubview:bb];
        [bb addTarget:self action:@selector(dissTwo) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat hh = 50+320 + 50 +60 - 100;
        self.whiteTwoV = [[UIView alloc] initWithFrame:CGRectMake(35, (ScreenH - hh)/2-10, ScreenW - 70, hh)];
        self.whiteTwoV.backgroundColor = WhiteColor;
        self.whiteTwoV.layer.cornerRadius = 5;
        self.whiteTwoV.clipsToBounds = YES;
        [_blackView addSubview:self.whiteTwoV];
        
        
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.whiteTwoV.mj_w - 20, 30)];
        lb.textColor = CharacterColor50;
        lb.font = kFont(16);
        lb.textAlignment = NSTextAlignmentCenter;
        [self.whiteTwoV addSubview:lb];
        lb.text = @"选择时间";
        
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(15, 50, self.whiteTwoV.mj_w - 30, self.whiteTwoV.mj_h - 110)];
        self.pickView.delegate = self;
        self.pickView.dataSource= self;
        [self.whiteTwoV addSubview:self.pickView];
        [self.pickView reloadAllComponents];
        
        
        self.leftTwoBt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.pickView.frame) + 10, 60, 40)];
        self.leftTwoBt.titleLabel.font = kFont(14);
        [self.leftTwoBt setTitleColor:GreenColor forState:UIControlStateNormal];
        [self.leftTwoBt setTitle:@"取消" forState:UIControlStateNormal];
        self.leftTwoBt.tag = 104;
        [self.leftTwoBt addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteTwoV addSubview:self.leftTwoBt];
        
        self.rightTwoBt = [[UIButton alloc] initWithFrame:CGRectMake(self.whiteTwoV.mj_w - 15- 60, CGRectGetMaxY(self.pickView.frame) + 10, 60, 40)];
        self.rightTwoBt.titleLabel.font = kFont(14);
        [self.rightTwoBt setTitleColor:GreenColor forState:UIControlStateNormal];
        [self.rightTwoBt setTitle:@"确定" forState:UIControlStateNormal];
        self.rightTwoBt.tag = 105;
        [self.rightTwoBt addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteTwoV addSubview:self.rightTwoBt];
        
        
        
    }
    
    
    
    return _blackView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 24;
    }else {
        return 60;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%02d",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.hourTimeStr = [NSString stringWithFormat:@"%02d",row];
    }else {
        self.mStr = [NSString stringWithFormat:@"%02d",row];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        UIButton * bb = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:bb];
        [bb addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat hh = 50+320 + 40 + 50 +60;
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(15, (ScreenH - hh)/2-10, ScreenW - 30, hh)];
        self.whiteV.backgroundColor = WhiteColor;
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        [self addSubview:self.whiteV];
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 , self.whiteV.mj_w - 20, 30)];
        lb.textColor = CharacterColor50;
        lb.font = kFont(14);
        lb.textAlignment = NSTextAlignmentCenter;
//        NSArray * arr = @[@"",@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
//        NSInteger  month = [[XMCalendarTool alloc] getMonthIndate:[NSDate date]];
//        lb.text = [NSString stringWithFormat:@"日期 · %@",arr[month]];
        self.timeLB = lb;
        [self.whiteV addSubview:lb];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.6, self.whiteV.mj_w, 0.4)];
        backV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backV];
        
        
        self.calendarV = [[XMCalendarView alloc] initWithFrame:CGRectMake(0, 50 , ScreenW-30 , 360)];
        self.calendarV.isAddToCalendar = NO;
        self.calendarV.layer.cornerRadius = 5;
        self.calendarV.clipsToBounds = YES;
        self.calendarV.delegate = self;
        self.calendarV.backgroundColor = [UIColor redColor];
        [self.whiteV addSubview:self.calendarV];
        
        UISwipeGestureRecognizer * leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
               [self.calendarV addGestureRecognizer:leftSwipeGestureRecognizer];
               UISwipeGestureRecognizer * rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
               leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
               rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
               [self.calendarV addGestureRecognizer:leftSwipeGestureRecognizer];
               [self.calendarV addGestureRecognizer:rightSwipeGestureRecognizer];
        
        
        self.chooseBt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.calendarV.frame) + 5, 250, 30)];
        self.chooseBt.titleLabel.font = kFont(14);
        [self.chooseBt setTitleColor:CharacterBack150 forState:UIControlStateNormal];
        [self.chooseBt setTitleColor:GreenColor forState:UIControlStateSelected];
        [self.chooseBt setTitle:@"设置时间" forState:UIControlStateNormal];
        [self.chooseBt setImage:[UIImage imageNamed:@"clock1"] forState:UIControlStateNormal];
        [self.chooseBt setImage:[UIImage imageNamed:@"clock2"] forState:UIControlStateSelected];
        [self.whiteV addSubview:self.chooseBt];
        self.chooseBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.chooseBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        self.chooseBt.tag = 100;
        [self.chooseBt addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.chaBt = [[UIButton alloc] initWithFrame:CGRectMake(self.whiteV.mj_w - 30- 10, CGRectGetMinY(self.chooseBt.frame), 30, 30)];
        [self.chaBt setImage:[UIImage imageNamed:@"gcha"] forState:UIControlStateNormal];
        [self.whiteV addSubview:self.chaBt];
        self.chaBt.tag = 101;
        [self.chaBt addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chooseBt.frame) + 10 , self.whiteV.mj_w, 0.4)];
        backVTwo.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backVTwo];
        
        self.leftOneBt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backVTwo.frame) + 10, 60, 40)];
        self.leftOneBt.titleLabel.font = kFont(14);
        [self.leftOneBt setTitleColor:GreenColor forState:UIControlStateNormal];
        [self.leftOneBt setTitle:@"取消" forState:UIControlStateNormal];
        self.leftOneBt.tag = 102;
        [self.leftOneBt addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:self.leftOneBt];
        
        self.rightOnebt = [[UIButton alloc] initWithFrame:CGRectMake(self.whiteV.mj_w - 15- 60, CGRectGetMaxY(backVTwo.frame) + 10, 60, 40)];
        self.rightOnebt.titleLabel.font = kFont(14);
        [self.rightOnebt setTitleColor:GreenColor forState:UIControlStateNormal];
        [self.rightOnebt setTitle:@"确定" forState:UIControlStateNormal];
        self.rightOnebt.tag = 103;
        [self.rightOnebt addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:self.rightOnebt];
        
        
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        self.timeDateStr = [formatter stringFromDate:[NSDate date]];
      
        self.centerDate = [NSDate date];
    }
    return self;
}


- (void)showTwoView {
    
    self.hourTimeStr = self.mStr = @"00";
    [[UIApplication sharedApplication].keyWindow addSubview:self.blackView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }];
    
}

- (void)chooseAction:(UIButton *)button {
    if (button.tag == 100) {
        //点击选择时间
        [self showTwoView];
    }else if (button.tag == 101) {
        //点击叉
        self.chooseBt.selected = NO;
        self.chaBt.hidden = YES;
        
    }else if (button.tag == 102) {
        //点击取消
        if (self.sendTimeBlock != nil) {
         self.sendTimeBlock(@"",YES);
        }
        [self diss];

    }else if (button.tag == 103) {
        //点击确定
        if (self.hourTimeStr.length + self.mStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择设置的时间"];
            return;
        }else {
            
            NSString * time = [NSString stringWithFormat:@"%@ %@:%@:00",self.timeDateStr,self.hourTimeStr,self.mStr];
            if (self.sendTimeBlock != nil) {
             self.sendTimeBlock(time,NO);
            }
            [self diss];
            
        }
        
    }else if (button.tag == 104) {
        //点击取消
        [self dissTwo];
        self.hourTimeStr = @"";
        self.mStr = @"";
        self.chooseBt.selected = NO;
        self.chaBt.hidden = YES;
        
    }else if (button.tag == 105) {
        //点击确定
        
        [self dissTwo];
        self.chooseBt.selected = YES;
        self.chaBt.hidden = NO;
        [self.chooseBt setTitle:[NSString stringWithFormat:@"%@:%@",self.hourTimeStr,self.mStr] forState:UIControlStateSelected];
        
    }
    
    
}

- (void)diss {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dissTwo {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    } completion:^(BOOL finished) {
        [self.blackView removeFromSuperview];
    }];
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
    
}


- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel {
   NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    self.timeDateStr = [formatter stringFromDate:calendarModel.date];
    
}


- (void)handleSwipes:(UISwipeGestureRecognizer *)swipeshand {
    if (swipeshand.direction == UISwipeGestureRecognizerDirectionLeft) {
        XMCalendarManager * manager = self.calendarV.calendarManager;
        XMCalendarDataSource * dd = [manager nextMonth];
        self.calendarV.dataSourceModel = dd;
        self.centerDate =  [[[XMCalendarTool alloc] init] getNextMonthFirstDateWithDate:self.centerDate];
      
        
        
    }else if (swipeshand.direction == UISwipeGestureRecognizerDirectionRight) {
       
        XMCalendarManager * manager = self.calendarV.calendarManager;
        XMCalendarDataSource * dd = [manager preMonth];
        self.calendarV.dataSourceModel = dd;
        self.centerDate = [[[XMCalendarTool alloc] init] getPreMonthFirstDateWithDate:self.centerDate];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.calendarV.collectionView reloadData];
        });
        
    }
    
   
    
    
}

- (void)setCenterDate:(NSDate *)centerDate {
    _centerDate = centerDate;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    self.timeLB.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_centerDate]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarV.collectionView reloadData];
    });
    
}




@end
