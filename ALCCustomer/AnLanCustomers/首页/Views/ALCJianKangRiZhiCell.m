//
//  ALCJianKangRiZhiCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCJianKangRiZhiCell.h"

@implementation ALCJianKangRiZhiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backV.layer.shadowOffset = CGSizeMake(0, 0);
    self.backV.layer.shadowRadius = 5;
    self.backV.layer.shadowOpacity = 0.08;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.lineV.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    
    self.rightLB1.text = model.appointmentDate;
    self.rightLB2.text = model.doctorName;
}

@end
