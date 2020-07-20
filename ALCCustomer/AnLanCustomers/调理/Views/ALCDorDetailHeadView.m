//
//  ALCDorDetailHeadView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCDorDetailHeadView.h"

@implementation ALCDorDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
       
        
        UIImageView * imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        imageV.image = [UIImage imageNamed:@"jkgl80"];
        imageV.userInteractionEnabled = YES;
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];

        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 200, 25)];
        self.nameLB.textColor = WhiteColor;
        self.nameLB.font = [UIFont systemFontOfSize:18 weight:0.2];
        self.nameLB.text = @"熊建新";
        [self addSubview:self.nameLB];
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 95, CGRectGetMinY(self.nameLB.frame), 80, 80)];
        self.headBt.layer.cornerRadius = 40;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        
        
        self.keshiLB1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameLB.frame) + 10 , 200, 17)];
        self.keshiLB1.textColor = WhiteColor;
        self.keshiLB1.font = kFont(14);
        self.keshiLB1.text = @"主任教师 小儿呼吸科";
        [self addSubview:self.keshiLB1];
        
        
        self.addressBt = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.keshiLB1.frame) + 10 , 200, 17)];
        self.addressBt.titleLabel.textColor = WhiteColor;
        self.addressBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.addressBt.titleLabel.font = kFont(14);
        [self.addressBt setTitle:@"常州学校 >" forState:UIControlStateNormal];
        [self addSubview:self.addressBt];
        
        //169
        
         self.yuYueLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.addressBt.frame) + 30 , 200, 20)];
          self.yuYueLB.textColor = WhiteColor;
          self.yuYueLB.font = kFont(17);
          self.yuYueLB.text = @"9459预约  暂无咨询量";
          [self addSubview:self.yuYueLB];
        
        self.LB1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.yuYueLB.frame) + 15 , 200, 20)];
        self.LB1.textColor = WhiteColor;
        self.LB1.font = kFont(16);
        self.LB1.text = @"擅长";
        [self addSubview:self.LB1];
        
          self.shanchangLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.LB1.frame) + 5 , ScreenW - 30, 17)];
          self.shanchangLB.textColor = WhiteColor;
          self.shanchangLB.font = kFont(14);
          self.shanchangLB.text = @"擅长: 小儿慢性咳嗽,儿童咳嗽";
          [self addSubview:self.shanchangLB];
        
        
        self.LB2 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.shanchangLB.frame) + 15 , 200, 20)];
        self.LB2.textColor = WhiteColor;
        self.LB2.font = kFont(16);
        self.LB2.text = @"个人简介";
        [self addSubview:self.LB2];
        
        self.jianJieDesLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.LB2.frame) + 5 , ScreenW - 30, 17)];
                 self.jianJieDesLB.textColor = WhiteColor;
                 self.jianJieDesLB.font = kFont(14);
        self.jianJieDesLB.numberOfLines = 0;
                 self.jianJieDesLB.text = @"擅长: 小儿慢性咳嗽,儿童咳嗽";
                 [self addSubview:self.jianJieDesLB];
        
//        self.dorMeBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 200, CGRectGetMaxY(self.shanchangLB.frame) + 15 , 185, 17)];
//        self.dorMeBt.titleLabel.textColor = WhiteColor;
//        self.dorMeBt.titleLabel.font = kFont(14);
//        self.dorMeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [self.dorMeBt setTitle:@"教师信息 >" forState:UIControlStateNormal];
//        [self addSubview:self.dorMeBt];
        
        //164
        
        
    }
    
    return self;
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    self.nameLB.text = model.name;
    self.keshiLB1.text = [NSString stringWithFormat:@"%@ %@",model.level,model.departmentName];
    NSString * str = model.appointmentCnt;
    if ([model.appointmentCnt integerValue] > 10000) {
        str = [NSString stringWithFormat:@"%0.1f万",[model.appointmentCnt integerValue]/10000.0];
    }
    [self.addressBt setTitle:[NSString stringWithFormat:@"%@ >",model.institutionName] forState:UIControlStateNormal];
    NSString * strT = model.consultationCnt;
       if ([model.consultationCnt integerValue] > 10000) {
           strT = [NSString stringWithFormat:@"%0.1f万",[model.consultationCnt integerValue]/10000.0];
       }
    self.yuYueLB.text = [NSString stringWithFormat:@"%@咨询",strT];
    
//    self.ziXunLB.text = [NSString stringWithFormat:@"%@咨询",strT];
    self.shanchangLB.text = [NSString stringWithFormat:@"%@",model.goodArea];
    
    self.jianJieDesLB.attributedText = [model.des getMutableAttributeStringWithFont:14 lineSpace:3 textColor:WhiteColor];
    self.jianJieDesLB.mj_h = [model.des getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 30];
    
    
    
    [self.headBt sd_setBackgroundImageWithURL:[model.pic getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    if (self.isProject) {
        
        self.keshiLB1.text = [NSString stringWithFormat:@"%@分钟 %@",model.duration,model.departmentName];
        self.ziXunLB.hidden = YES;
        self.yuYueLB.text = [NSString stringWithFormat:@"%@预约",str];
    }
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[model.picture getFirstPicStr]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
    model.HHHHHH = CGRectGetMaxY(self.jianJieDesLB.frame) + 30;
}

@end
