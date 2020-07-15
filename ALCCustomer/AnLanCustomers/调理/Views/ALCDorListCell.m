//
//  ALCDorListCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCDorListCell.h"

@implementation ALCDorListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backV.layer.shadowOffset = CGSizeMake(0, 0);
    self.backV.layer.shadowRadius = 5;
    self.backV.layer.shadowOpacity = 0.08;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.headBt.layer.cornerRadius = 25;
    self.headBt.clipsToBounds = YES;
    
    self.typeLB1.layer.cornerRadius = self.typeLB2.layer.cornerRadius = 3;
    self.typeLB1.clipsToBounds = self.typeLB2.clipsToBounds = YES;
    
    self.typeLB4.layer.cornerRadius = self.typeLB5.layer.cornerRadius = self.typeLB6.layer.cornerRadius = 10;
    self.typeLB4.clipsToBounds = self.typeLB5.clipsToBounds = self.typeLB6.clipsToBounds = YES;
    self.typeLB4.backgroundColor = self.typeLB5.backgroundColor = self.typeLB6.backgroundColor = BackgroundColor;
    
    self.lineV.hidden = YES;
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    self.nameLB.text = model.name;
    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameTwoLB.text = model.level;
    self.addressLB.text = model.institutionName;
    self.typeLB3.text = model.departmentName;
    self.yuyueLB.text = [NSString stringWithFormat:@"预约量: %@",model.appointmentCnt];
    if ([model.appointmentCnt integerValue] > 10000) {
        self.yuyueLB.text = [NSString stringWithFormat:@"预约量: %0.1f万",[model.appointmentCnt integerValue]/10000.0];
    }
    self.zixuanLB.text = [NSString stringWithFormat:@"咨询量: %@",model.consultationCnt];
    if ([model.consultationCnt integerValue] > 10000) {
        self.zixuanLB.text = [NSString stringWithFormat:@"咨询量: %0.1f万",[model.consultationCnt integerValue]/10000.0];
    }
    
    NSArray * arr = [model.goodArea componentsSeparatedByString:@","];
    self.typeLB4.hidden = self.typeLB5.hidden = self.typeLB6.hidden = YES;
    if (arr.count == 1) {
        self.typeLB4.hidden = NO;
        self.typeLB4.text = arr[0];
        self.typeCons4.constant = [arr[0] getWidhtWithFontSize:13] + 10;
        
    }else if (arr.count == 2) {
        
        self.typeLB4.hidden = NO;
        self.typeLB4.text = arr[0];
        self.typeCons4.constant = [arr[0] getWidhtWithFontSize:13] + 10;
        
        self.typeLB5.hidden = NO;
        self.typeLB5.text = arr[1];
        self.typeCons4.constant = [arr[1] getWidhtWithFontSize:13] + 10;
        
        
    }else {
        self.typeLB4.hidden = NO;
        self.typeLB4.text = arr[0];
        self.typeCons4.constant = [arr[0] getWidhtWithFontSize:13] + 10;
        
        self.typeLB5.hidden = NO;
        self.typeLB5.text = arr[1];
        self.typeCons5.constant = [arr[1] getWidhtWithFontSize:13] + 10;
        
        self.typeLB6.hidden = NO;
        self.typeLB6.text = arr[2];
        self.typeCons6.constant = [arr[2] getWidhtWithFontSize:13] + 10;
    }
    
    if (model.isAppointment) {
        self.appCons.constant = 10;
        self.appConsW.constant = 60;
        self.typeLB1.hidden = NO;
    }else {
        self.appCons.constant = 0;
        self.appConsW.constant = 0;
        self.typeLB1.hidden = YES;
    }
    if (model.isConsultation) {
        self.typeLB2.hidden = NO;
    }else {
        self.typeLB2.hidden = YES;
    }
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
