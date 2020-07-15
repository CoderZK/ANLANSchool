//
//  ACLMineAppointCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineAppointCell.h"

@implementation ACLMineAppointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backV.layer.shadowOffset = CGSizeMake(0, 0);
    self.backV.layer.shadowRadius = 5;
    self.backV.layer.shadowOpacity = 0.08;
    self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    [self.headBt sd_setBackgroundImageWithURL:[model.picture getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    
//    NSArray * arr = @[@"",@"未支付",@"待完成",@"已完成",@"已取消",@"退款成功"];
//    self.statusLB.text = arr[model.status];
    if (self.isDoc){
        [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
        self.nameLB.text = [NSString stringWithFormat:@"%@ %@",model.doctorName,model.level];
        self.addressLB.text = [NSString stringWithFormat:@"%@ %@",model.institutionName,model.departmentName];
        self.moneyLB.hidden = YES;
        NSString * dd = @"上午";
        if ([model.duration isEqualToString:@"2"]) {
            dd = @"下午";
        }
        if (model.isCancel) {
            self.statusLB.text = @"已取消";
        }else {
            self.statusLB.text = @"已预约";
        }
        self.bNameLB.text = [NSString stringWithFormat:@"就诊人:%@ %@ %@",model.patientName,model.appointmentDate,dd];
        self.imgV.image = [UIImage imageNamed:@"jkgl135"];
    }else {
        self.moneyLB.hidden = NO;
        self.nameLB.text = model.name;
        self.addressLB.text = [NSString stringWithFormat:@"%@ 分钟",model.duration];
        self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",model.price];
         self.bNameLB.text = [NSString stringWithFormat:@"就诊人:%@ %@",model.patientName,model.appointmentDate];
        self.imgV.image = [UIImage imageNamed:@"jkgl134"];
        
        NSString * str = @"";
        
        if (model.payWay == 1) {
            if (model.status == 1) {
                str = @"未支付";
            }else if (model.status == 2) {
                str = @"已预约";
            }else if (model.status == 3) {
                str = @"已完成";
            }else if (model.status == 4) {
                str = @"退款中";
            }else if (model.status == 5) {
                str = @"已作废";
            }else if (model.status == 6) {
                str = @"已退款";
            }else if (model.status == 7) {
                str = @"退款中";
            }else if (model.status == 8) {
                str = @"退款驳回";
            }else if (model.status == 9) {
                str = @"已过期";
            }else if (model.status == 10) {
                str = @"已取消";
            }
        }else {
            if (model.status == 1) {
                str = @"到店支付";
            }else if (model.status == 2) {
                str = @"已预约";
            }else if (model.status == 3) {
                str = @"已完成";
            }else if (model.status == 4) {
                str = @"退款中";
            }else if (model.status == 5) {
                str = @"已作废";
            }else if (model.status == 6) {
                str = @"已退款";
            }else if (model.status == 7) {
                str = @"退款中";
            }else if (model.status == 8) {
                str = @"退款驳回";
            }else if (model.status == 9) {
                str = @"已过期";
            }else if (model.status == 10) {
                str = @"已取消";
            }
        }
        
        self.statusLB.text = str;
        
    }
    
    
}

@end
