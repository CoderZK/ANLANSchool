//
//  ACLMineReferCell.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ACLMineReferCell.h"

@implementation ACLMineReferCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backV.layer.shadowOffset = CGSizeMake(0, 0);
    self.backV.layer.shadowRadius = 5;
    self.backV.layer.shadowOpacity = 0.08;
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setModel:(ALMessageModel *)model {
    _model = model;
    self.nameLB.text = [NSString stringWithFormat:@"咨询医生:%@",model.name];
    self.bNameLB.text = model.lastSessionTime;
    self.addressLB.text = model.institutionName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
