//
//  ALCDorServerCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCDorServerCell.h"

@implementation ALCDorServerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    if ([model.appointmentCnt integerValue] == 0) {
        self.numberLB.text = @"暂无预约";
    }else {
        if ([model.appointmentCnt integerValue] > 10000) {
            self.numberLB.text = [NSString stringWithFormat:@"%0.1f万",[model.appointmentCnt integerValue]/10000.0];
        }else {
            self.numberLB.text = [NSString stringWithFormat:@"%@预约",model.appointmentCnt];
        }
    }
    
    
    if ([model.consultationCnt integerValue] == 0) {
           self.rightNumberLB.text = @"";
       }else {
           if ([model.consultationCnt integerValue] > 10000) {
               self.rightNumberLB.text = [NSString stringWithFormat:@"%0.1f万",[model.consultationCnt integerValue]/10000.0];
           }else {
               self.rightNumberLB.text = [NSString stringWithFormat:@"%@咨询",model.consultationCnt];
           }
       }
    
}

@end
