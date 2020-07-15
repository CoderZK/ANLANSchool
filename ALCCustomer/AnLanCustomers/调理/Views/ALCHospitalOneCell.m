//
//  ALCHospitalOneCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCHospitalOneCell.h"

@implementation ALCHospitalOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 4;
    self.imgV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;

    [self.imgV sd_setImageWithURL:[model.pictures getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.leftLB.text = model.name;
    
    NSString *str = @"";
    NSString *strTwo = @"";
    NSString *strTh = @"";
    if (model.doctorAppointmentCnt > 10000) {
        str = [NSString stringWithFormat:@"%0.1f万",model.doctorAppointmentCnt/10000.0];
    }else {
        str = [NSString stringWithFormat:@"%ld",model.doctorAppointmentCnt];
    }
    
    if (model.doctorConsultationCnt > 10000) {
        strTwo = [NSString stringWithFormat:@"%0.1f万",model.doctorConsultationCnt/10000.0];
    }else {
        strTwo = [NSString stringWithFormat:@"%ld",model.doctorConsultationCnt];
    }
    
      if (model.projectAppointmentCnt > 10000) {
           strTh = [NSString stringWithFormat:@"%0.1f万",model.projectAppointmentCnt/10000.0];
       }else {
           strTh = [NSString stringWithFormat:@"%ld",model.projectAppointmentCnt];
       }
    
    self.leftLBTwo.text = [NSString stringWithFormat:@"医生: 预约量%@·咨询量%@",str,strTwo];
    self.leftLBThree.text = [NSString stringWithFormat:@"项目: 预约量%@",strTh];
}


@end
