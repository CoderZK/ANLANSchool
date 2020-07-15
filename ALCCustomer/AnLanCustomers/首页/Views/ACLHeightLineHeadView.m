//
//  ACLHeightLineHeadView.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLHeightLineHeadView.h"

@implementation ACLHeightLineHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 170 +sstatusHeight + 44)];
        self.imgV.image = [UIImage imageNamed:@"jkgl03"];
        [self addSubview:self.imgV];
        self.imgV.contentMode = UIViewContentModeScaleToFill;
        
        
        UIView * whiteV = [[UIView alloc] initWithFrame:CGRectMake(15, sstatusHeight + 44, ScreenW - 30, 220+50)];
        whiteV.backgroundColor = WhiteColor;
        whiteV.layer.cornerRadius = 5;
        whiteV.layer.shadowColor = [UIColor blackColor].CGColor;
        whiteV.layer.shadowOffset = CGSizeMake(0, 0);
        whiteV.layer.shadowRadius = 5;
        whiteV.layer.shadowOpacity = 0.08;
        [self addSubview:whiteV];
        
        
        self.titelLB = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - 30 -200)/2, 15, 200, 25)];
        self.titelLB.font = kFont(13);
        self.titelLB.backgroundColor = BackgroundColor;
        self.titelLB.layer.cornerRadius = 12.5;
        self.titelLB.textColor = CharacterColor50;
        self.titelLB.clipsToBounds = YES;
        self.titelLB.textAlignment = NSTextAlignmentCenter;
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        NSString * tt = [formatter stringFromDate:[NSDate date]];
        self.titelLB.text = [NSString stringWithFormat:@"%@-今天",tt];
        [whiteV addSubview:self.titelLB];
        
        BezierCurveView * bezierV = [[BezierCurveView alloc] initWithFrame:CGRectMake(0, 50 , ScreenW - 30, 220)];
        bezierV.backgroundColor = WhiteColor;
        bezierV.dorwColor = GreenColor;
        //        [bezierV drawMoreLineChartViewWithTargerYNames:@[@"120",@"90",@"60",@"30"] targetXNames:@[@"3.29",@"3.30",@"3.31",@"4.1",@"4.2",@"4.3",@"今天"] whitTargetValues:@[@[@(50),@(60),@30,@90,@120,@80,@60],@[@(20),@(80),@30,@50,@30,@70,@30]] withMaxY:120 colors:@[[UIColor orangeColor],[UIColor purpleColor]]];
        [whiteV addSubview:bezierV];
        self.bezierV = bezierV;
        
        self.leftTopLB = [[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(whiteV.frame) + 15, 120, 17)];
        self.leftTopLB.font = kFont(14);
        self.leftTopLB.textAlignment = NSTextAlignmentCenter;
        self.leftTopLB.textColor = CharacterColor50;
        self.leftTopLB.text = @"--次/分";
        [self addSubview:self.leftTopLB];
        
        self.leftBottomLB = [[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(self.leftTopLB.frame) + 5, 120, 17)];
        self.leftBottomLB.font = kFont(14);
        self.leftBottomLB.textAlignment = NSTextAlignmentCenter;
        self.leftBottomLB.textColor = CharacterBlack100;
        self.leftBottomLB.text = @"最高";
        [self addSubview:self.leftBottomLB];
        
        
        self.centerTopLB = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW/2 - 60),CGRectGetMaxY(whiteV.frame) + 15, 120, 17)];
        self.centerTopLB.font = kFont(14);
        self.centerTopLB.textAlignment = NSTextAlignmentCenter;
        self.centerTopLB.textColor = CharacterColor50;
        self.centerTopLB.text = @"--次/分";
        [self addSubview:self.centerTopLB];
        
        self.centerBottomLB = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW/2 - 60),CGRectGetMaxY(self.leftTopLB.frame) + 5, 120, 17)];
        self.centerBottomLB.font = kFont(14);
        self.centerBottomLB.textAlignment = NSTextAlignmentCenter;
        self.centerBottomLB.textColor = CharacterBlack100;
        self.centerBottomLB.text = @"最高";
        [self addSubview:self.centerBottomLB];
        
        
        self.rightTopLB = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - 135 ),CGRectGetMaxY(whiteV.frame) + 15, 120, 17)];
        self.rightTopLB.font = kFont(14);
        self.rightTopLB.textAlignment = NSTextAlignmentCenter;
        self.rightTopLB.textColor = CharacterColor50;
        self.rightTopLB.text = @"--次/分";
        [self addSubview:self.rightTopLB];
        
        self.rightBottomLB = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - 135),CGRectGetMaxY(self.leftTopLB.frame) + 5, 120, 17)];
        self.rightBottomLB.font = kFont(14);
        self.rightBottomLB.textAlignment = NSTextAlignmentCenter;
        self.rightBottomLB.textColor = CharacterBlack100;
        self.rightBottomLB.text = @"最高";
        [self addSubview:self.rightBottomLB];
        
        
        self.jiLuBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2-75, CGRectGetMaxY(self.centerBottomLB.frame) + 20, 150, 40)];
        [self.jiLuBt setTitle:@"手动记录" forState:UIControlStateNormal];
        [self.jiLuBt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.jiLuBt setTitleColor:GreenColor forState:UIControlStateNormal];
        self.jiLuBt.titleLabel.font = kFont(14);
        self.jiLuBt.layer.borderColor = GreenColor.CGColor;
        self.jiLuBt.layer.borderWidth = 0.6;
        self.jiLuBt.layer.cornerRadius = 20;
        self.jiLuBt.clipsToBounds = YES;
        [self addSubview:self.jiLuBt];
        
        self.hh = CGRectGetMaxY(self.jiLuBt.frame) + 20;
        
    }
    return self;
}

- (void)setShowNumber:(NSInteger)showNumber {
    _showNumber = showNumber;
    if (showNumber == 0) {
        
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.centerBottomLB.hidden= self.centerTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = YES;
    }else if (showNumber == 1) {
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = YES;
        self.centerBottomLB.hidden= self.centerTopLB.hidden = NO;
    }else if (showNumber == 2) {
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = NO;
        self.centerBottomLB.hidden= self.centerTopLB.hidden = YES;
    }else if (showNumber == 3) {
        
        self.leftBottomLB.hidden = self.leftTopLB.hidden = self.rightTopLB.hidden = self.rightBottomLB.hidden = NO;
        self.centerBottomLB.hidden= self.centerTopLB.hidden = NO;
        
    }
}




@end
