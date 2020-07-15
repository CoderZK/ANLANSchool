//
//  ALCHomeHeadView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHomeHeadView.h"

@interface ALCHomeHeadView()<XMCalendarViewDelegate>

@end

@implementation ALCHomeHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 240+sstatusHeight + 44)];
        self.imgV.image = [UIImage imageNamed:@"jkgl03"];
        [self addSubview:self.imgV];
        self.imgV.contentMode = UIViewContentModeScaleToFill;
        
        self.backgroundColor = WhiteColor;
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(15, sstatusHeight + 44 + 20, 50, 50)];
        self.headBt.layer.cornerRadius = 25;
        self.headBt.clipsToBounds = YES;
        self.headBt.layer.borderColor = WhiteColor.CGColor;
        self.headBt.layer.borderWidth = 1;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMinY(self.headBt.frame), 150, 50)];
        self.nameLB.font = kFont(14);
        self.nameLB.textColor = WhiteColor;
        self.nameLB.text = @"1432365477945";
        [self addSubview:self.nameLB];
        
        self.xunWenBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 90, CGRectGetMinY(self.headBt.frame) + 12.5, 90, 25)];
        [self addSubview:self.xunWenBt];
        [self.xunWenBt setTitle:@"快速咨询" forState:UIControlStateNormal];
        self.xunWenBt.titleLabel.font = kFont(14);
        //        [self.xunWenBt setBackgroundImage:[UIImage imageNamed:@"backg"] forState:UIControlStateNormal];
        self.xunWenBt.backgroundColor  = [UIColor colorWithWhite:1 alpha:0.2];
        
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.xunWenBt.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(12.5, 12.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = self.xunWenBt.bounds;
        
        maskLayer.path = maskPath.CGPath;
        self.xunWenBt.layer.mask =  maskLayer;
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headBt.frame) +20, ScreenW/2, 16)];
        lb.textColor = WhiteColor;
        lb.text = @"体重(kg)";
        lb.font = kFont(13);
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
        
        self.weithLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb.frame) +5, ScreenW/2, 18)];
        self.weithLB.font = kFont(15);
        self.weithLB.textColor = WhiteColor;
        self.weithLB.textAlignment = NSTextAlignmentCenter;
        self.weithLB.text = @"50.3";
        [self addSubview:self.weithLB];
        
        
        UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/2, CGRectGetMaxY(self.headBt.frame) +20, ScreenW/2, 16)];
        lb1.textColor = WhiteColor;
        lb1.text = @"BMI";
        lb1.font = kFont(13);
        lb1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb1];
        
        self.BMILB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/2, CGRectGetMaxY(lb.frame) +5, ScreenW/2, 18)];
        self.BMILB.font = kFont(15);
        self.BMILB.textColor = WhiteColor;
        self.BMILB.textAlignment = NSTextAlignmentCenter;
        self.BMILB.text = @"24.5";
        [self addSubview:self.BMILB];
        
        // 160 日历的开始
        // 灰色背景图 结束 240
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(15, 160+sstatusHeight + 44, ScreenW - 30, 158)];
        self.whiteV.backgroundColor = WhiteColor;
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.layer.shadowColor = [UIColor blackColor].CGColor;
        self.whiteV.layer.shadowOffset = CGSizeMake(0, 0);
        self.whiteV.layer.shadowRadius = 5;
        self.whiteV.layer.shadowOpacity = 0.08;
        [self addSubview:self.whiteV];
        
        self.monthLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW- 30-30-50, 15)];
        self.monthLB.font =[UIFont systemFontOfSize:15 weight:0.2];
        self.monthLB.textColor = CharacterColor50;
        NSInteger month = [[[XMCalendarTool alloc] init] getMonthIndate:[NSDate date]];
        self.monthLB.text = [NSString stringWithFormat:@"健康提醒·%ld月",month];
        [self.whiteV addSubview:self.monthLB];
        
        self.moreBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW-30 - 145, 5, 130, 40)];
        [self.moreBt setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        self.moreBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.whiteV addSubview:self.moreBt];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 44.4, ScreenW - 30, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backV];
        

        
        self.hh = CGRectGetMaxY(self.whiteV.frame) + 10;
        self.calendarV = [[XMCalendarView alloc] initWithFrame:CGRectMake(0, 45 , ScreenW-30 , 98)];
        self.calendarV.isAddToCalendar = NO;
        self.calendarV.isShowOneWeek = YES;
        self.calendarV.delegate = self;
        [self.whiteV addSubview:self.calendarV];
        
        self.gouBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 143+15, 20, 20)];
        [self.gouBt setBackgroundImage:[UIImage imageNamed:@"jkgl35"] forState:UIControlStateNormal];
        
        
        
        [self.whiteV addSubview:self.gouBt];
        self.tijianLB  = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMinY(self.gouBt.frame), ScreenW- 30-15-25 -100, 20)];
        self.tijianLB.textColor = CharacterColor50;
        self.tijianLB.attributedText = [@"有个体检(李鹏)" getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor50 textColorTwo:CharacterBlack100 nsrange:NSMakeRange(4, @"有个体检(李鹏)".length - 4)];
        [self.whiteV addSubview:self.tijianLB];
        
        
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW- 30-100, CGRectGetMinY(self.gouBt.frame), 85, 20)];
        self.timeLB.font =kFont(13);
        self.timeLB.textColor = CharacterBlack100;
        self.timeLB.text = @"17:20";
        self.timeLB.textAlignment = NSTextAlignmentRight;
        [self.whiteV addSubview:self.timeLB];
        
        
//        self.godetailBt = [[UIButton alloc] initWithFrame:CGRectMake(0,143+10, ScreenW, 30)];
//        [self.whiteV addSubview:self.godetailBt];
        
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(self.gouBt.frame)-5, ScreenW - 30, 30)];
        [self.whiteV addSubview:bt];
        [bt addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
//        self.whiteV.clipsToBounds = YES;
//        self.clipsToBounds = YES;
//        self.whiteV.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    self.clipsToBounds = NO;
    if (model == nil) {
        self.whiteV.mj_h = 143+15;
        self.calendarV.mj_h = 98;
        self.calendarV.mj_y = 45;
        self.hh = 160+sstatusHeight + 44 + 143+15;
        self.gouBt.hidden = self.tijianLB.hidden = self.timeLB.hidden = YES;
        return;
    }else {
        self.whiteV.mj_h = 206;
        self.hh = 160+sstatusHeight + 44 + 206;
        self.gouBt.hidden = self.tijianLB.hidden = self.timeLB.hidden = NO;
        
    }
    if (model.isFinish) {
       
        [self.gouBt setBackgroundImage:[UIImage imageNamed:@"jkgl42"] forState:UIControlStateNormal];
        self.timeLB.textColor = self.tijianLB.textColor = CharacterBack150;
    }else {
        self.timeLB.textColor = self.tijianLB.textColor = CharacterColor50;
        [self.gouBt setBackgroundImage:[UIImage imageNamed:@"jkgl34"] forState:UIControlStateNormal];
    }
    self.tijianLB.text = model.content;
    self.timeLB.text =  model.time;
   
    
    
    
    
}

- (void)setHeadModel:(ALMessageModel *)headModel {
    _headModel = headModel;
    [self.headBt sd_setBackgroundImageWithURL:[headModel.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = headModel.nickname;
    self.weithLB.text = [NSString stringWithFormat:@"%0.2f",[headModel.weight floatValue]];
    if ([headModel.weight floatValue] == 0) {
        self.weithLB.text = @"";
    }
    self.BMILB.text = headModel.bmi;
    
}

- (void)clickAction {
    if (self.clickBlock != nil) {
        self.clickBlock(self.model);
    }
}

- (void)xmCalendarSelectCalendarModel:(XMCalendarModel *)calendarModel {
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
//    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString * day = [df stringFromDate:calendarModel.date];
    //选中日期

    if (self.sendHomeBlockDate != nil) {
        self.sendHomeBlockDate(calendarModel.date);
    }
    
}

@end
